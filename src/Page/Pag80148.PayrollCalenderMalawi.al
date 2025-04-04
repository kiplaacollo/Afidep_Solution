Page 80148 "Payroll CalenderMalawi"
{
    DeleteAllowed = false;
    //Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Payroll CalenderMalawi";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date Opened"; Rec."Date Opened")
                {
                    ApplicationArea = Basic;
                }
                field("Period Name"; Rec."Period Name")
                {
                    ApplicationArea = Basic;
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = Basic;
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code"; Rec."Branch Code") { }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                    Caption = 'Kenya Currency Factor';
                    Visible = false;
                }
                field("Malawi Currency Code"; Rec."Malawi Currency Code")
                {

                }
                field("Tax Paid"; Rec."Tax Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Paid(LCY)"; Rec."Tax Paid(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Basic Pay Paid"; Rec."Basic Pay Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Basic Pay Paid(LCY)"; Rec."Basic Pay Paid(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Close Period")
            {
                ApplicationArea = Basic;
                Image = ClosePeriod;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll CalenderMalawi";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_Malawi";
                begin
                    PayrollCalender.Reset;
                    PayrollCalender.SetRange(PayrollCalender.Closed, false);
                    // PayrollCalender.SetRange("Branch Code", PayrollCalender."Branch Code");
                    if PayrollCalender.FindLast then begin
                        "Payroll Period" := PayrollCalender."Date Opened";
                        "Period Name" := PayrollCalender."Period Name";
                        ok := Confirm('Close Payroll Period[' + "Period Name" + ']? Please Note that Once a period has been closed it can NOT be opened.\' +
                            'It is assumed that you have PAID out this month salaries.\' + 'Continue?', false);
                        if ok then begin
                            Clear(PayrollManager);
                            PayrollManager.ClosePayrollPeriod("Payroll Period");
                            Message('Payroll Period Closed Successfully. The New Period has been Created');
                        end else begin
                            Message('You have selected NOT to Close the period');
                        end;
                    end;
                end;
            }
        }
    }

    var
        ok: Boolean;
}

