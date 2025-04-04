Page 50125 "Report Q3"
{
    PageType = ListPart;
    SourceTable = "Report Q3";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Key Activities"; Rec."Key Activities")
                {
                    ApplicationArea = Basic;
                    Caption = 'List key activities for this quarter';
                }
                field("Activity status"; Rec."Activity status")
                {
                    ApplicationArea = Basic;
                    Caption = 'Activity status';
                }
                field("Any Variation"; Rec."Any Variation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Please explain any variation from planned activities for this quarter';
                }
                field("Key Deliverables"; Rec."Key Deliverables")
                {
                    ApplicationArea = Basic;
                    Caption = 'Please described key deliverables achieved this quarter';
                }
                field("Key Outcomes"; Rec."Key Outcomes")
                {
                    ApplicationArea = Basic;
                    Caption = 'Please described key outcomes achieved this quarter';
                }
                field("Planned Activities"; Rec."Planned Activities")
                {
                    ApplicationArea = Basic;
                    Caption = 'Please highlight planned activities for the next quarter';
                }
                field("Key Challenges Faced"; Rec."Key Challenges Faced")
                {
                    ApplicationArea = Basic;
                    Caption = 'Please describe the key challenges faced in this quarter and mitigation actions';
                }
                field("Opportunities Identified"; Rec."Opportunities Identified")
                {
                    ApplicationArea = Basic;
                    Caption = 'Please highlight any opportunities identified this quarter';
                }
                field("Lessons Learnt"; Rec."Lessons Learnt")
                {
                    ApplicationArea = Basic;
                    Caption = 'Please highlight any lessons learnt';
                }
                field("Commmunications Outputs"; Rec."Commmunications Outputs")
                {
                    ApplicationArea = Basic;
                    Caption = 'Commmunications outputs related to the project activities in this quarter';
                }

            }
        }
    }

    actions
    {
    }
}

