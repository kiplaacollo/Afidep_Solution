Page 170098 "HR Disciplinary Actions"
{
    PageType = List;
    SourceTable = "HR Disciplinary Actions";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Action Code"; Rec."Action Code")
                {
                    ApplicationArea = Basic;
                }
                field(Instance; Rec.Instance)
                {
                    ApplicationArea = Basic;
                }
                field("Recommended Action"; Rec."Recommended Action")
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

