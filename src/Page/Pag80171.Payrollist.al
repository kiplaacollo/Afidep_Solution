page 80171 "Payroll card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Payroll;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Payroll Period."; Rec."Payroll Period.")
                {
                    ApplicationArea = All;

                }
                field("Payroll Date"; Rec."Payroll Date")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Process Payroll")
            {
                ApplicationArea = Basic;
                Caption = 'Process Payroll';
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Allowprocessing;

                trigger OnAction()
                begin
                    PayrollCalender.RESET;
                    PayrollCalender.SETRANGE(PayrollCalender.Closed, FALSE);
                    IF PayrollCalender.FINDFIRST THEN BEGIN
                        "Payroll Period" := PayrollCalender."Date Opened";
                    END;
                    IF "Payroll Period" = 0D THEN
                        ERROR('No Open Payroll Period');

                    PayrollEmp.RESET;
                    PayrollEmp.SETRANGE(PayrollEmp.Status, PayrollEmp.Status::Active);
                    //PayrollEmp.SETRANGE(PayrollEmp."Contract Type",PayrollEmp."Contract Type"::"Full Time");
                    PayrollEmp.SETRANGE(PayrollEmp."Suspend Pay", FALSE);
                    IF PayrollEmp.FINDSET THEN BEGIN
                        ProgressWindow.OPEN('Processing Salary for Employee No. #1#######');
                        REPEAT
                            // PayrollEmp.TESTFIELD(PayrollEmp."Posting Group");
                            PayrollEmp.TESTFIELD(PayrollEmp."Joining Date");


                            //First Remove Any transactions for this Month
                            RemoveTrans(PayrollEmp."No.", "Payroll Period");
                            //End Remove Transactions
                            IF PayrollEmp."Joining Date" <> 0D THEN BEGIN
                                PayrollManager.ProcessPayroll(PayrollEmp."No.", "Payroll Period", 'SALARY', PayrollEmp."Basic Pay", PayrollEmp."Basic Pay(LCY)",
                                                              PayrollEmp."Currency Code", PayrollEmp."Currency Factor", PayrollEmp."Joining Date", PayrollEmp."Date of Leaving",
                                                              FALSE, PayrollEmp."Global Dimension 1", PayrollEmp."Global Dimension 2", '', PayrollEmp."Pays PAYE", PayrollEmp."Pays NHIF",
                                                              PayrollEmp."Pays NSSF", PayrollEmp.GetsPayeRelief, PayrollEmp.GetsPayeBenefit, PayrollEmp.Secondary, PayrollEmp.PayeBenefitPercent);
                                ProgressWindow.UPDATE(1, PayrollEmp."No." + ':' + PayrollEmp."Full Name");
                            END;
                        UNTIL PayrollEmp.NEXT = 0;
                    END;



                    ProgressWindow.CLOSE;
                    MESSAGE('Payroll processing completed successfully.');

                end;
            }
            action("Mark As Processed")
            {
                ApplicationArea = Basic;
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Allowprocessing;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    IF CONFIRM('Are you sure you Want to mark payroll as proccessed?', TRUE, FALSE) = TRUE THEN BEGIN
                        rec.Processed := TRUE;
                        rec.MODIFY(true);
                    END;
                end;
            }

            action("Send A&pproval Request")
            {
                ApplicationArea = Basic;
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    rec.TESTFIELD(Status, rec.Status::Open);

                    varrvariant := Rec;

                    IF CustomApprovalsCodeunit.CheckApprovalsWorkflowEnabled(varrvariant) THEN
                        CustomApprovalsCodeunit.OnSendDocForApproval(varrvariant);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."Document No");
                    IF ApprovalEntry.FINDSET THEN BEGIN
                        REPEAT
                            ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                            ApprovalEntry.MODIFY;
                        UNTIL ApprovalEntry.NEXT = 0;
                    END;
                    rec.Status := rec.Status::Open;
                    Rec.MODIFY(true);
                end;
            }
            action("Approvals")
            {
                ApplicationArea = Basic;
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document No.", Rec."Document No");
                    // ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                    PAGE.RUN(658, ApprovalEntry);
                end;
            }
        }
        area(reporting)
        {
            action("Payroll Summary")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Payroll Summary P_AU";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("Department payroll Summary")
            {
                ApplicationArea = Basic;
                Caption = 'Department payroll Summary';
                Image = "Report";
                Visible = false;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report 50060;

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("Detailed Payroll Summary")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report 17301;

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("Company Payroll Summary")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Caption = 'Payroll Control Account';
                Visible = false;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Company Payroll Summary_AU";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("Varience Payroll Summary")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Caption = 'Varience Report';
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "USD Varience Payroll Summary";
            }
            action("Deductions Summary")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Deductions Summary_AU";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("Earnings Summary")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Payments Summary_AU";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("PAYE Schedule")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Paye Schedule_AU";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("SHIF Schedule")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "SHIF Schedule Ver1";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("NSSF Schedule")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "NSSF Schedule_AU";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("BANK Schedule")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Visible = false;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Bank Schedule_AU";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("Pension Report")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Pension Report_AU";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("Housing Levy Schedule")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Housing Levy Report_AU";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action(P9)
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report P9Report;

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
        }
    }


    var
        PayrollEmp: Record "Payroll Employee_AU";
        ProgressWindow: Dialog;
        PayrollManager: Codeunit "Payroll Management_AU";
        "Payroll Period": Date;
        PayrollCalender: Record "Payroll Calender_AU";
        PayrollMonthlyTrans: Record "Payroll Monthly Trans_AU";
        PayrollEmployeeDed: Record "Payroll Employee Deductions_AU";
        PayrollEmployerDed: Record "Payroll Employer Deductions_AU";
        UserSetup: Record "User Setup";
        CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
        varrvariant: Variant;
        ApprovalEntry: Record "Approval Entry";
        Allowprocessing: Boolean;

    local procedure RemoveTrans(EmpNo: Code[20]; PayrollPeriod: Date)
    begin
        //Remove Monthly Transactions
        PayrollMonthlyTrans.Reset;
        PayrollMonthlyTrans.SetRange(PayrollMonthlyTrans."No.", EmpNo);
        PayrollMonthlyTrans.SetRange(PayrollMonthlyTrans."Period Month", Date2dmy(PayrollPeriod, 2));
        PayrollMonthlyTrans.SetRange(PayrollMonthlyTrans."Period Year", Date2dmy(PayrollPeriod, 3));
        if PayrollMonthlyTrans.FindSet then
            PayrollMonthlyTrans.DeleteAll;

        //Remove Employee Deductions
        //Remove Employer Deductions
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Allowprocessing := false;
        if rec.Status = rec.Status::Approved
        then begin
            Allowprocessing := true;
        end;
    end;

}