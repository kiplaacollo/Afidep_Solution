Page 50118 "Workplan List"
{
    PageType = List;
    SourceTable = WorkPlan;
    UsageCategory = Lists;
    ApplicationArea = ALL;
    CardPageId = "Work Plan Card";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Project Code"; Rec."Project Code")
                {
                }
                field("Project Description"; Rec."Project Description")
                {
                }
                field("Workplan Code"; Rec."Workplan Code")
                {
                }
                field("Workplan Descption"; Rec."Workplan Descption")
                {
                }


            }
        }
    }

    actions
    {
    }
}

