Page 50113 "Personal Development"
{
    PageType = ListPart;
    SourceTable = "Personal Development ";
    UsageCategory = Tasks;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No."; Rec."Appraisal No.")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Visible = false;
                }
                // field("Project Code"; Rec."Project Code")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;
                // }

                field("Areas to develop"; Rec."Areas to develop")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Development activities"; Rec."Development activities")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Resources required"; Rec."Resources required")
                {
                    ApplicationArea = Basic;
                }
                field("Targets and Timelines"; Rec."Targets and Timelines")
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

