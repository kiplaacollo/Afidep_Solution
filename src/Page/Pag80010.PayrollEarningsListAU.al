Page 80010 "Payroll Earnings List_AU"
{
    CardPageID = "Payroll Earnings Card_AU";
    PageType = List;
    SourceTable = "Payroll Transaction Code_AU";
    SourceTableView = where("Transaction Type" = const(Income));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive housing Leavy"; Rec."Inclusive housing Leavy")
                {
                    Caption = 'Inclusive housing Leavy Calculation';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."transaction type"::Income;
    end;
}

