Page 80086 "Notice Board"
{
    PageType = Card;
    RefreshOnActivate = false;
    SourceTable = "Notice Board";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date of Announcement";Rec."Date of Announcement")
                {
                    ApplicationArea = Basic;
                }
                field("Department Announcing";Rec."Department Announcing")
                {
                    ApplicationArea = Basic;
                }
                field(Announcement;Rec.Announcement)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        Rec.Reset;
        if not Rec.Get then begin
          Rec.Init;
          Rec.Insert;
        end;
    end;
}

