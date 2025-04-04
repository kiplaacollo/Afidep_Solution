Page 50121 "Payroll Employee Malawi"
{
    CardPageID = "Payroll Employee Card_AU";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Payroll Employee_AU";
    SourceTableView = where("Global Dimension 1" = const('MALAWI'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic;
                }
                field(Firstname; Rec.Firstname)
                {
                    ApplicationArea = Basic;
                }
                field(Lastname; Rec.Lastname)
                {
                    ApplicationArea = Basic;
                }
                field("Joining Date"; Rec."Joining Date")
                {
                    ApplicationArea = Basic;
                }
                field("<Employee Status>"; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Status';
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1"; Rec."Global Dimension 1")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Outlook)
            {
            }
            systempart(Control10; Notes)
            {
            }
            systempart(Control11; MyNotes)
            {
            }
            systempart(Control12; Links)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Process Payroll")
            {
                ApplicationArea = Basic;
                Image = Allocations;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    PayrollCalender.Reset;
                    PayrollCalender.SetRange(PayrollCalender.Closed, false);
                    if PayrollCalender.FindFirst then begin
                        "Payroll Period" := PayrollCalender."Date Opened";
                    end;
                    if "Payroll Period" = 0D then
                        Error('No Open Payroll Period');

                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp.Status, PayrollEmp.Status::Active);
                    PayrollEmp.SetRange(PayrollEmp."Suspend Pay", false);
                    if PayrollEmp.FindSet then begin
                        ProgressWindow.Open('Processing Salary for Employee No. #1#######');
                        repeat
                            PayrollEmp.TestField(PayrollEmp."Posting Group");
                            PayrollEmp.TestField(PayrollEmp."Joining Date");
                            PayrollEmp.TestField(PayrollEmp."Basic Pay");
                            /*PayrollEmp.TESTFIELD(PayrollEmp."PIN No");
                            PayrollEmp.TESTFIELD(PayrollEmp."NHIF No");
                            PayrollEmp.TESTFIELD(PayrollEmp."NSSF No");*/

                            //First Remove Any transactions for this Month
                            RemoveTrans(PayrollEmp."No.", "Payroll Period");
                            //End Remove Transactions
                            if PayrollEmp."Joining Date" <> 0D then begin
                                PayrollManager.ProcessPayroll(PayrollEmp."No.", "Payroll Period", PayrollEmp."Posting Group", PayrollEmp."Basic Pay", PayrollEmp."Basic Pay(LCY)",
                                                              PayrollEmp."Currency Code", PayrollEmp."Currency Factor", PayrollEmp."Joining Date", PayrollEmp."Date of Leaving",
                                                              false, PayrollEmp."Global Dimension 1", PayrollEmp."Global Dimension 2", '', PayrollEmp."Pays PAYE", PayrollEmp."Pays NHIF",
                                                              PayrollEmp."Pays NSSF", PayrollEmp.GetsPayeRelief, PayrollEmp.GetsPayeBenefit, PayrollEmp.Secondary, PayrollEmp.PayeBenefitPercent);
                                ProgressWindow.Update(1, PayrollEmp."No." + ':' + PayrollEmp."Full Name");
                            end;
                        until PayrollEmp.Next = 0;
                    end;
                    ProgressWindow.Close;
                    Message('Payroll processing completed successfully.');

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

    trigger OnOpenPage()
    begin
        //     Banch := '';
        //     PayrollVisible := false;
        //     HrEmployees.Reset();
        //     HrEmployees.SetRange("Employee UserID", UserId);
        //     if HrEmployees.FindFirst() then begin
        //         Banch := HrEmployees."Global Dimension 1 Code";
        //     end;
        //     Rec.SetRange("Global Dimension 1", Banch);


        //     Employee.Reset();
        //     Employee.SetRange("Global Dimension 1", Banch);
        //     if Employee.FindFirst() then begin
        //         PayrollVisible := true;
        //     end;
    end;

    trigger OnInit()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."View Malawi Payroll" then
                Error(PemissionDenied);
        end else begin
            Error(UserNotFound, UserId);
        end;
    end;

    var
        Employee: Record "Payroll Employee_AU";
        UserSetup: Record "User Setup";
        UserNotFound: label 'User Setup %1 not found.';
        PemissionDenied: label 'User Account is not Setup for Payroll Use. Contact System Administrator.';
        PayrollEmp: Record "Payroll Employee_AU";
        ProgressWindow: Dialog;
        PayrollManager: Codeunit "Payroll Management_AU";
        "Payroll Period": Date;
        PayrollCalender: Record "Payroll Calender_AU";
        PayrollMonthlyTrans: Record "Payroll Monthly Trans_AU";
        PayrollEmployeeDed: Record "Payroll Employee Deductions_AU";
        PayrollEmployerDed: Record "Payroll Employer Deductions_AU";
        HrEmployees: Record "HR Employees";
        PayrollVisible: Boolean;
        Banch: Code[300];

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
}

