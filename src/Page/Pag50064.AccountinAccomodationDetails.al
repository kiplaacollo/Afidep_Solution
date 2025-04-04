Page 50064 "Accountin Accomodation Details"
{
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = where("Line Type"=const(Activity));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(dateFrom;Rec.dateFrom)
                {
                    ApplicationArea = Basic;
                }
                field(dateTo;Rec.dateTo)
                {
                    ApplicationArea = Basic;
                }
                field(accomodtionCatered;Rec.accomodtionCatered)
                {
                    ApplicationArea = Basic;
                }
                field(locationOfStay;Rec.locationOfStay)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(noOfDays;Rec.noOfDays)
                {
                    ApplicationArea = Basic;
                }
                field(Total;Rec."Travel Line Total")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Spent";Rec."Amount Spent")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Rec."Cash Refund":=0;
                        if Rec."Amount Spent"<Rec."Line Amount" then
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

