Page 50117 "Work Plan Card"
{
    PageType = Card;
    SourceTable = WorkPlan;
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            group(General)
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
                    Caption = 'Workplan Description';
                }

            }
            part(Control9; "Activities List")
            {
                SubPageLink = "Workplan Code" = field("Workplan Code");
            }
        }
    }

    actions
    {
    }
}

