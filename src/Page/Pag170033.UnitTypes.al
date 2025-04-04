Page 170033 "Unit Types"
{
    PageType = List;
    SourceTable = "Unit Types";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Unit Code";Rec."Unit Code")
                {
                    ApplicationArea = Basic;
                }
                field("Unit Type";Rec."Unit Type")
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

