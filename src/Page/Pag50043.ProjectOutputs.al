Page 50043 "Project Outputs"
{
    PageType = ListPart;
    SourceTable = "Project Outputs";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Output Summary";Rec."Output Summary")
                {
                    ApplicationArea = Basic;
                }
                field(Indicator;Rec.Indicator)
                {
                    ApplicationArea = Basic;
                }
                field("Means of Verification";Rec."Means of Verification")
                {
                    ApplicationArea = Basic;
                }
                field("Risks/Assumptions";Rec."Risks/Assumptions")
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

