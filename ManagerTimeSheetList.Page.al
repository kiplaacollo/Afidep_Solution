Page 17436 "Manager Time Sheet List Custom"
{
    Caption = 'Manager Time Sheet List Custom';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
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
                field("Owner User ID"; Rec."Owner User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Open Exists"; Rec."Open Exists")
                {
                    ApplicationArea = Basic;
                    DrillDown = false;
                }
                field("Submitted Exists"; Rec."Submitted Exists")
                {
                    ApplicationArea = Basic;
                    DrillDown = false;
                }
                field("Rejected Exists"; Rec."Rejected Exists")
                {
                    ApplicationArea = Basic;
                    DrillDown = false;
                }
                field("Approved Exists"; Rec."Approved Exists")
                {
                    ApplicationArea = Basic;
                    DrillDown = false;
                }
                field("Posted Exists"; Rec."Posted Exists")
                {
                    ApplicationArea = Basic;
                    DrillDown = false;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                    DrillDown = false;
                }
                field("Type Filter"; Rec."Type Filter")
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
                action("Posting E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting E&ntries';
                    Image = PostingEntries;
                    RunObject = Page "Time Sheet Posting Entries";
                    RunPageLink = "Time Sheet No." = field("No.");
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then
            CurrPage.Editable := UserSetup."Time Sheet Admin.";
        TimeSheetMgt.FilterTimeSheets(Rec, Rec.FieldNo("Approver User ID"));
    end;

    var
        UserSetup: Record "User Setup";
        TimeSheetMgt: Codeunit "Time Sheet Management";


    procedure EditTimeSheet()
    var
        TimeSheetLine: Record "Time Sheet Line";
    begin
        TimeSheetMgt.SetTimeSheetNo(Rec."No.", TimeSheetLine);
        Page.Run(Page::"Manager Time Sheet", TimeSheetLine);
    end;
}

