Page 50053 "Travel Other Details"
{
    PageType = ListPart;
    SourceTable = "Purchase Line";
    // SourceTableView = where("Line Type"=const("Budget Notes"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(date; Rec.date)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
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

