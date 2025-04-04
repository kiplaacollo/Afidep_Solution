page 80173 "Payroll M card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payroll M";

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
                                                              PayrollEmp."Pays NSSF", PayrollEmp.GetsPayeRelief, PayrollEmp.GetsPayeBenefit, PayrollEmp.Secondary, PayrollEmp.PayeBenefitPercent,
                                                              PayrollEmp."Pension %-Employer", PayrollEmp."Pension Administrative Fee", PayrollEmp."VAT Administrative Fee", PayrollEmp."Group Life Assuarance");
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
                    ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", Rec."Document No");
                    //ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
                    PAGE.RUN(658, ApprovalEntry);
                end;
            }
        }
        area(reporting)
        {
            action("Payroll Summary Kenya")
            {
                ApplicationArea = Basic;
                Visible = false;
                Caption = 'Payroll Summary Kenya';
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
            action("Payroll Summary Kenya Usd")
            {
                ApplicationArea = Basic;
                Visible = false;
                Caption = 'Payroll Summary Kenya Usd';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Payroll Summary P_AU Usd";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("Update currency factor")
            {
                ApplicationArea = Basic;
                Visible = false;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report 50097;

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("Payroll Summary Malawi")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Payroll Summary P_M";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll CalenderMalawi";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManagerM: Codeunit "Payroll Management_Malawi";
                begin
                end;
            }

            action("Detailed Payroll Summary")
            {
                ApplicationArea = Basic;
                Visible = false;
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
            action("Detailed Payroll Summary Malawi")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report 17309;

                trigger OnAction()
                var
                    PayrollCalenderM: Record "Payroll CalenderMalawi";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManagerM: Codeunit "Payroll Management_Malawi";
                begin
                end;
            }
            action("Company Payroll Summary")
            {
                ApplicationArea = Basic;
                Visible = false;
                Image = "Report";
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
            action("Deductions Summary Kenya")
            {
                ApplicationArea = Basic;
                Visible = false;
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
            action("Deductions Summary Malawi")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Deductions Summary_AU Malawi";

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
                Visible = false;
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
                Visible = false;
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
            action("NHIF Schedule")
            {
                ApplicationArea = Basic;
                Visible = false;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "NHIF Schedule_AU";

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
                Visible = false;
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
            action("HELB Schedule")
            {
                ApplicationArea = Basic;
                Visible = false;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Helb Schedule Ver1";
            }
            action("Housing Levy Schedule")
            {
                ApplicationArea = Basic;
                Visible = false;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Housing Levy Report_AU";
            }
            action("SACCO Schedule")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Amref Sacco Schedule Ver1";
            }
            action("BANK Schedule")
            {
                ApplicationArea = Basic;
                Visible = false;
                Image = "Report";
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
            action("PENSION SCHEDULE")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Malawi Pension";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("Group Life SCHEDULE")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Group Life Insurance";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
            action("Variance Report")
            {
                ApplicationArea = Basic;
                // Visible = false;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Malawi Varience Summary";

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
        PayrollManager: Codeunit "Payroll Management_Malawi";
        "Payroll Period": Date;
        PayrollCalender: Record "Payroll CalenderMalawi";
        PayrollMonthlyTrans: Record "Payroll Monthly Trans_Malawi";
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