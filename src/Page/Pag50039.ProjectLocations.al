Page 50039 "Project Locations"
{
    PageType = ListPart;
    SourceTable = "Project Locations";
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Location';
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

