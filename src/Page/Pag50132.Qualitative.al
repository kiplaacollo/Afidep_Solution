Page 50132 "Qualitative Indicators"
{
    PageType = ListPart;
    SourceTable = "Qualitative Indicators";

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

                field("Data Source/Reporting projects"; Rec."Data Source/Reporting projects")
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

