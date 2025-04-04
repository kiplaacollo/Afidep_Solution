Page 50052 "Travel Meals Details"
{
    PageType = ListPart;
    SourceTable = "Purchase Line";
    //SourceTableView = where("Line Type"=const("Budget Info"));

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
                field("location.";Rec."location.")
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
                field(noOfDays;Rec.noOfDays)
                {
                    ApplicationArea = Basic;
                }
                field(Total;Rec."Travel Line Total")
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

