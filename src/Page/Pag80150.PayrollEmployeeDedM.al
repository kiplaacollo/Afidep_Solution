Page 80150 "Payroll Employee DedM"
{
    PageType = ListPart;
    SourceTable = "Payroll Employee Trans_Malawi";
    SourceTableView = where("Transaction Type" = const(Deduction));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                    TableRelation = "Payroll Transaction Code_AU"."Transaction Code" where("Transaction Type" = const(Deduction));
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Pension Formula"; Rec."Pension Formula")
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }

                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Balance(LCY)"; Rec."Balance(LCY)")
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
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Number"; Rec."Loan Number")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        PayrollCalender.Reset;
        PayrollCalender.SetRange(PayrollCalender.Closed, false);
        if PayrollCalender.Find('-') then
            OpenPeriod := PayrollCalender."Date Opened";

        Rec.SetRange("Payroll Period", OpenPeriod)
    end;

    var
        PayrollCalender: Record "Payroll CalenderMalawi";
        OpenPeriod: Date;
}

