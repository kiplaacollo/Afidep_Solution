Page 80046 "HR Job Requirement Lines"
{
    PageType = List;
    SourceTable = "HR Job Requirements";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Qualification Type";Rec."Qualification Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Qualification Code";Rec."Qualification Code")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Qualification Description";Rec."Qualification Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field(Priority;Rec.Priority)
                {
                    ApplicationArea = Basic;
                }
                field("Desired Score";Rec."Desired Score")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Total (Stage)Desired Score";Rec."Total (Stage)Desired Score")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Mandatory;Rec.Mandatory)
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

