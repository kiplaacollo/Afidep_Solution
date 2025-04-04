Page 80044 "HR Leave Batches"
{
    PageType = List;
    SourceTable = "HR Leave Journal Batch";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(Name;Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Description";Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                }
                field(Type;Rec.Type)
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

