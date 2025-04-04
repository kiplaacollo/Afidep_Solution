Page 80094 "HR Documents"
{
    PageType = List;
    SourceTable = "HR Documents";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Attachments)
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page Documents;
                    RunPageLink = "Doc No."=field(Code);
                }
            }
        }
    }
}

