Page 50041 "Project Goals"
{
    PageType = ListPart;
    SourceTable = "Project Goals";
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Goal Summary"; Rec."Goal Summary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Overall goal of the project / Impact';
                }
                field(Indicator; Rec.Indicator)
                {
                    ApplicationArea = Basic;
                    Caption = 'How will you know that you have succeded? (Key Performance Indicators)';
                }
                field("Means of Verification"; Rec."Means of Verification")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Risks/Assumptions"; Rec."Risks/Assumptions")
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

