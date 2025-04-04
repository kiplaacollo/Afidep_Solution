Page 50044 "Project Activities"
{
    PageType = ListPart;
    SourceTable = "Project Activities";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Activity Summary";Rec."Activity Summary")
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

