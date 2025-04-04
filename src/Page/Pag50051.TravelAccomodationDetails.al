Page 50051 "Travel Accomodation Details"
{
    PageType = ListPart;
    SourceTable = "Purchase Line";
   // SourceTableView = where("Line Type"=const(Activity));

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
            }
        }
    }

    actions
    {
    }
}

