Page 50019 "Key Competencies "
{
    PageType = ListPart;
    SourceTable = "Staff Values";
    // UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Value; Rec.Value)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Improvement Require"; Rec."Improvement Require")
                {
                    ApplicationArea = Basic;
                }
                field(Average; Rec.Average)
                {
                    ApplicationArea = Basic;
                }
                field(Good; Rec.Good)
                {
                    ApplicationArea = Basic;
                }
                field(Excellent; Rec.Excellent)
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

