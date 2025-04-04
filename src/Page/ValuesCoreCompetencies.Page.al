Page 17329 "Values Core Competencies"
{
    PageType = ListPart;
    SourceTable = "HR Appraisal Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No";Rec."Line No")
                {
                    ApplicationArea = Basic;
                    Visible = false ;
                }
                field("Appraisal No";Rec."Appraisal No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Appraisal Period";Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Employee No";Rec."Employee No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Values/core competence";Rec."Values/core competence")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Assessment vs";Rec."Appraisal Assessment vs")
                {
                    ApplicationArea = Basic;
                    Caption = 'Appraisal Assessment';
                }
                field("Score vs";Rec."Score vs")
                {
                    ApplicationArea = Basic;
                    Caption = 'Score';
                }
                field(Comments;Rec.Comments)
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

