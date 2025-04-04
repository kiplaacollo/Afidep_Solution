Page 80012 "Payroll Deductions List_AU"
{
    CardPageID = "Payroll Deductions Card_AU";
    PageType = List;
    SourceTable = "Payroll Transaction Code_AU";
    SourceTableView = where("Transaction Type"=const(Deduction));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code";Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Name";Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Taxable;Rec.Taxable)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
          Rec."Transaction Type":=Rec."transaction type"::Deduction;
    end;
}

