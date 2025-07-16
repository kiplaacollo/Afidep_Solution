Page 50133 "Peer Review"
{
    PageType = ListPart;
    SourceTable = "Project Peer Review";

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Peer Review"; Rec."Peer Review")
                {
                    ApplicationArea = Basic;
                    RowSpan = 300;
                }
                field(Q1; Rec.Q1)
                {
                    ApplicationArea = Basic;
                }
                field(Q2; Rec.Q2)
                {
                    ApplicationArea = Basic;
                }
                field(Q3; Rec.Q3)
                {
                    ApplicationArea = Basic;
                }
                field(Q4; Rec.Q4)
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

