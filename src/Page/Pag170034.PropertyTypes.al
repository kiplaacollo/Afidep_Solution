Page 170034 "Property Types"
{
    PageType = List;
    SourceTable = "Property Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Rec.Code)
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

