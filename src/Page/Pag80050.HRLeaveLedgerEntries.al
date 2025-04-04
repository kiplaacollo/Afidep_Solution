Page 80050 "HR Leave Ledger Entries"
{
    Caption = 'Leave Ledger Entries';
    DataCaptionFields = "Leave Period";
    Editable = false;
    PageType = List;
    SourceTable = "HR Leave Ledger Entries";
    // SourceTableView = where("Leave Period" = filter('2025'));


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ApplicationArea = Basic;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Entry Type"; Rec."Leave Entry Type")
                {
                    ApplicationArea = Basic;
                }
                field("No. of days"; Rec."No. of days")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Posting Description"; Rec."Leave Posting Description")
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
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    RunObject = Page "Default Dimension Where-Used";
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                ApplicationArea = Basic;
                Caption = '&Navigate';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run;
                end;
            }
        }
    }

    var
        Navigate: Page Navigate;
}

