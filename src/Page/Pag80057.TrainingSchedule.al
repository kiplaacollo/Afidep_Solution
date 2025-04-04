Page 80057 "Training Schedule"
{
    PageType = List;
    SourceTable = "Training Schedule";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Year;Rec.Year)
                {
                    ApplicationArea = Basic;
                }
                field(Facilitator;Rec.Facilitator)
                {
                    ApplicationArea = Basic;
                }
                field("Department/Organization";Rec."Department/Organization")
                {
                    ApplicationArea = Basic;
                }
                field(Topic;Rec.Topic)
                {
                    ApplicationArea = Basic;
                }
                field("Total Cost";Rec."Total Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled date";Rec."Scheduled date")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Staff trained";Rec."No. of Staff trained")
                {
                    ApplicationArea = Basic;
                }
                field("Evidence of training";Rec."Evidence of training")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Updated By";Rec."Updated By")
                {
                    ApplicationArea = Basic;
                }
                field("Updated On";Rec."Updated On")
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

