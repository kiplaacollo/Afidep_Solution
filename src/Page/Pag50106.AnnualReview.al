Page 50106 "Annual Review"
{
    PageType = ListPart;
    SourceTable = "Appraissal Lines WP";
    UsageCategory = Tasks;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Header No"; Rec."Header No")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Visible = false;
                }
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                field(Objectives; Rec.Objectives)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Key Performance Indicator"; Rec."Key Performance Indicator")
                {
                    ApplicationArea = Basic;
                    Caption = 'Key Performance Indicators (KPIs)';
                    Editable = true;
                }
                field("Agreed Performance Targets"; Rec."Agreed Performance Targets")
                {
                    ApplicationArea = Basic;
                    Caption = 'Key Deliverables and timelines';
                    Visible = false;

                }
                field("Actual Achievement"; Rec."Actual Achievement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Achievements';
                }
                field("Appraisee Rating"; Rec."Appraisee Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Appraiser Rating"; Rec."Appraiser Rating")
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

