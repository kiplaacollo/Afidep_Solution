Page 17434 "Time Sheet List Custom"
{
    Caption = 'Time Sheet List Custom';
    InsertAllowed = true;
    ModifyAllowed = false;
    ApplicationArea = all;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Time Sheet Header";
    SourceTableView = sorting("Resource No.", "Starting Date");

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = Basic;
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
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
            action("&Edit Time Sheet")
            {
                ApplicationArea = Basic;
                Caption = '&Edit Time Sheet';
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Return';

                trigger OnAction()
                begin
                    EditTimeSheet;
                end;
            }
        }
        area(navigation)
        {
            group("&Time Sheet")
            {
                Caption = '&Time Sheet';
                Image = Timesheet;
                action(Comments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Time Sheet Comment Sheet";
                    RunPageLink = "No." = field("No."),
                                  "Time Sheet Line No." = const(0);
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then
            CurrPage.Editable := UserSetup."Time Sheet Admin.";
        TimeSheetMgt.FilterTimeSheets(Rec, Rec.FieldNo("Owner User ID"));
    end;

    var
        UserSetup: Record "User Setup";
        TimeSheetMgt: Codeunit "Time Sheet Management";


    procedure EditTimeSheet()
    var
        TimeSheetLine: Record "Time Sheet Line";
    begin
        TimeSheetMgt.SetTimeSheetNo(Rec."No.", TimeSheetLine);
        Page.Run(Page::"Time Sheet", TimeSheetLine);
    end;
}

