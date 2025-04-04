Page 50022 "Leave Planner"
{
    PageType = List;
    SourceTable = "Leave Planner";
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field("No of Days"; Rec."No of Days")
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

