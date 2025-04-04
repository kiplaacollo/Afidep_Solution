Page 170035 "Lease Durations"
{
    PageType = List;
    SourceTable = "Duration Types";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Duration Code";Rec."Duration Code")
                {
                    ApplicationArea = Basic;
                }
                field("Duration Details";Rec."Duration Details")
                {
                    ApplicationArea = Basic;
                }
                field(Duration;Rec.Duration)
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

