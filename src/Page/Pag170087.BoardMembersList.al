Page 170087 "Board Members List"
{
    PageType = List;
    SourceTable = "Board Members";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Member ID No"; Rec."Member ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Telephone"; Rec."Member Telephone")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("View Board Statement")
                {
                    ApplicationArea = Basic;
                    Image = SuggestPayment;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        // Board.RESET;
                        // Board.SETRANGE(Board."Board Member No",No);
                        // IF Board.FINDFIRST THEN
                        // REPORT.RUN(51525862,TRUE,TRUE,Board);
                    end;
                }
            }
        }
    }
}

