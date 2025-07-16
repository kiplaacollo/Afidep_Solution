Page 50131 "Quantitative Indicators"
{
    PageType = ListPart;
    SourceTable = "Quantitative Indicators";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Indicator; Rec.Indicator)
                {
                    ApplicationArea = Basic;
                    // Caption = 'Objective No.';
                }
                field("Indicator Level"; Rec."Indicator Level")
                {
                    ApplicationArea = Basic;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(Baseline; Rec.Baseline)
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
                field("Actual Cummulative"; Rec."Actual Cummulative")
                {
                    ApplicationArea = Basic;
                }
                field("Annual Target"; Rec."Annual Target")
                {
                    ApplicationArea = Basic;
                }
                field("Data Source"; Rec."Data Source")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
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

