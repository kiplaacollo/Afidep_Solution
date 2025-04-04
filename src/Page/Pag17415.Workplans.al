page 17415 Workplans
{
    ApplicationArea = All;
    Caption = 'Workplans';
    PageType = List;
    SourceTable = WorkPlan;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Project Code"; Rec."Project Code") { }
                field("Project Description"; Rec."Project Description") { }
                field("Workplan Code"; Rec."Workplan Code") { }
                field("Workplan Descption"; Rec."Workplan Descption") { }
            }
        }
    }
}
