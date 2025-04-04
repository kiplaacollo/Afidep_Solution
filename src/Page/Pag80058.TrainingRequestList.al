Page 80058 "Training Request List"
{
    CardPageID = "Training Request Card.";
    PageType = List;
    SourceTable = "Training Requests";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code";Rec."Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name";Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Training Need";Rec."Training Need")
                {
                    ApplicationArea = Basic;
                }
                field("Details of Training";Rec."Details of Training")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

