Page 170029 "Property List"
{
    CardPageID = "Property Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Property Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("Property Name";Rec."Property Name")
                {
                    ApplicationArea = Basic;
                }
                field("Property Location";Rec."Property Location")
                {
                    ApplicationArea = Basic;
                }
                field("Property Type";Rec."Property Type")
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

