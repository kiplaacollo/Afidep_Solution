Page 170074 "Mass Update Lines"
{
    PageType = List;
    SourceTable = "Mass Unit Update Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Ammenity;Rec.Ammenity)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
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

