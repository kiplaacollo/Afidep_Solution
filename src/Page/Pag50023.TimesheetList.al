Page 50023 "Timesheet List"
{
    CardPageID = "Timesheet Header";
    PageType = List;
    SourceTable = "TE Time Sheet1";
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
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

