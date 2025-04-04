Page 50119 "Activities List"
{
    PageType = ListPart;
    SourceTable = Activities;
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Activity Code"; Rec."Activity Code")
                {
                }
                field("Activity Description"; Rec."Activity Description")
                {
                }
                field("Workplan Code"; Rec."Workplan Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

