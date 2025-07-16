Page 50129 "Objective 3"
{
    PageType = ListPart;
    SourceTable = "Objective 3";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Objective No.';
                }
                field("Project Objecive / Outcome"; Rec."Project Objecive / Outcome")
                {
                    ApplicationArea = Basic;
                    Caption = 'Activity No:';
                }
                field(Responsible; Rec.Responsible)
                {
                    ApplicationArea = Basic;
                }
                field("Anticipated Outcomes"; Rec."Anticipated Outcomes")
                {
                    ApplicationArea = Basic;
                }
                field("Key Deliverables"; Rec."Key Deliverables")
                {
                    ApplicationArea = Basic;
                }

            }
            repeater(Group1)
            {
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic;
                }
                field(Q1; Rec.Q1)
                {
                    ApplicationArea = Basic;
                }
                field(Q2; Rec.Q2)
                {
                    ApplicationArea = Basic;
                }
                field(Q3; Rec.Q3)
                {
                    ApplicationArea = Basic;
                }
                field(Q4; Rec.Q4)
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

