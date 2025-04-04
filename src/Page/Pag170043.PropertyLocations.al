Page 170043 "Property Locations"
{
    PageType = List;
    SourceTable = "Property Locations";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Location;Rec.Location)
                {
                    ApplicationArea = Basic;
                }
                field("Location Description";Rec."Location Description")
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

