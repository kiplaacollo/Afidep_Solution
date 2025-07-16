Page 50042 "Project Outcomes"
{
    PageType = ListPart;
    SourceTable = "Project Outcomes";
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Activities by Objective"; Rec."Activities by Objective")
                {
                    ApplicationArea = Basic;
                    Caption = 'Activities by Objective / Outcomes';
                }
                field("Reports Deadline"; Rec."Reports Deadline")
                {
                    ApplicationArea = Basic;
                }
            }
            //     field(Responsible; Rec.Responsible)
            //     {
            //         ApplicationArea = Basic;
            //     }

            //     field("Outcomes Summary"; Rec."Outcomes Summary")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Anticipated Outcomes';
            //     }
            //     field(Indicator; Rec.Indicator)
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Key Deliverables';
            //     }
            // }
            // group(Year1)
            // {
            //     field(Q1; Rec.Q1)
            //     {
            //         ApplicationArea = Basic;
            //     }

            //     field(Q2; Rec.Q2)
            //     {
            //         ApplicationArea = Basic;
            //     }
            //     field(Q3; Rec.Q3)
            //     {
            //         ApplicationArea = Basic;
            //     }
            //     field(Q4; Rec.Q4)
            //     {
            //         ApplicationArea = Basic;
            //     }

            // }

            // group(Year2)
            // {
            //     field(Q1Y2; Rec.Q1)
            //     {
            //         ApplicationArea = Basic;
            //     }

            //     field(Q2Y2; Rec.Q2)
            //     {
            //         ApplicationArea = Basic;
            //     }
            //     field(Q3Y2; Rec.Q3)
            //     {
            //         ApplicationArea = Basic;
            //     }
            //     field(Q4Y2; Rec.Q4)
            //     {
            //         ApplicationArea = Basic;
            //     }

            // }
            // group(Year3)
            // {
            //     field(Q1Y3; Rec.Q1)
            //     {
            //         ApplicationArea = Basic;
            //     }

            //     field(Q2Y3; Rec.Q2)
            //     {
            //         ApplicationArea = Basic;
            //     }
            //     field(Q3Y3; Rec.Q3)
            //     {
            //         ApplicationArea = Basic;
            //     }
            //     field(Q4Y3; Rec.Q4)
            //     {
            //         ApplicationArea = Basic;
            //     }

        }

    }
    // }
    // }

    actions
    {
    }
}

