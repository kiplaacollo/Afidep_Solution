page 17450 Tender
{
    PageType = ListPart;
    SourceTable = "Tender Committee";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."Staff  No.")
                {

                }
                field("Member Name"; Rec."Member Name")
                {
                }
                field(Position; Rec.Position)
                {
                }
                field(Signature; Rec.Signature)
                {

                }
            }
        }
    }

    actions
    {
    }
}

