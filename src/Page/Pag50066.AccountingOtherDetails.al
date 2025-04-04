Page 50066 "Accounting Other Details"
{
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = where("Line Type"=const("Budget Notes"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(date;Rec.date)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount Spent";Rec."Amount Spent")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Rec."Cash Refund":=0;
                        if Rec."Amount Spent"< Rec."Line Amount" then
                          Rec."Cash Refund":=Rec."Line Amount"-Rec."Amount Spent";
                    end;
                }
                field("Cash Refund";Rec."Cash Refund")
                {
                    ApplicationArea = Basic;
                }
                field("Cash Refund  Account";Rec."Cash Refund  Account")
                {
                    ApplicationArea = Basic;
                }
                field("Expense Account";Rec."Expense Account")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

