Page 50013 "Appraisal Lines Targets"
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
                }
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = Basic;
                }

                field(Objectives; Rec.Objectives)
                {
                    ApplicationArea = Basic;
                }
                field("Key Performance Indicator"; Rec."Key Performance Indicator")
                {
                    ApplicationArea = Basic;
                    Caption = 'Key Performance Indicators (KPIs)';
                }
                field("Agreed Performance Targets"; Rec."Agreed Performance Targets")
                {
                    ApplicationArea = Basic;
                    Caption = 'Key Deliverables and timelines';

                }

            }
        }
    }

    actions
    {

    }
}

