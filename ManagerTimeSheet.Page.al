Page 17435 "Manager Time Sheet Custom"
{
    AutoSplitKey = true;
    Caption = 'Manager Time Sheet Custom';
    DataCaptionFields = "Time Sheet No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Navigate,Show';
    SaveValues = true;
    SourceTable = "Time Sheet Line";

    layout
    {
        area(content)
        {
            group(Control26)
            {
                field(CurrTimeSheetNo;CurrTimeSheetNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Time Sheet No';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CurrPage.SaveRecord;
                        TimeSheetMgt.LookupApproverTimeSheet(CurrTimeSheetNo,Rec,TimeSheetHeader);
                        UpdateControls;
                    end;

                    trigger OnValidate()
                    begin
                        TimeSheetHeader.Reset;
                        TimeSheetMgt.FilterTimeSheets(TimeSheetHeader,TimeSheetHeader.FieldNo("Approver User ID"));
                        TimeSheetMgt.CheckTimeSheetNo(TimeSheetHeader,CurrTimeSheetNo);
                        CurrPage.SaveRecord;
                        TimeSheetMgt.SetTimeSheetNo(CurrTimeSheetNo,Rec);
                        UpdateControls;
                    end;
                }
                field(ResourceNo;TimeSheetHeader."Resource No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Resource No.';
                    Editable = false;
                }
                field(ApproverUserID;TimeSheetHeader."Approver User ID")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approver User ID';
                    Editable = false;
                }
                field(StartingDate;TimeSheetHeader."Starting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Starting Date';
                    Editable = false;
                }
                field(EndingDate;TimeSheetHeader."Ending Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ending Date';
                    Editable = false;
                }
            }
            repeater(Control1)
            {
                field(Type;Rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Job No.";Rec."Job No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Job Task No.";Rec."Job Task No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        Rec.ShowLineDetails(true);
                        CurrPage.Update;
                    end;
                }
                field("Cause of Absence Code";Rec."Cause of Absence Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Chargeable;Rec.Chargeable)
                {
                    ApplicationArea = Basic;
                    Editable = ChargeableAllowEdit;
                    Visible = false;
                }
                field("Work Type Code";Rec."Work Type Code")
                {
                    ApplicationArea = Basic;
                    Editable = WorkTypeCodeAllowEdit;
                    Visible = false;
                }
                field("Service Order No.";Rec."Service Order No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Assembly Order No.";Rec."Assembly Order No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Posted;Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Field1;CellData[1])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[1];
                    Editable = false;
                    Width = 6;
                }
                field(Field2;CellData[2])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[2];
                    Editable = false;
                    Width = 6;
                }
                field(Field3;CellData[3])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[3];
                    Editable = false;
                    Width = 6;
                }
                field(Field4;CellData[4])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[4];
                    Editable = false;
                    Width = 6;
                }
                field(Field5;CellData[5])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[5];
                    Editable = false;
                    Width = 6;
                }
                field(Field6;CellData[6])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[6];
                    Editable = false;
                    Visible = true;
                    Width = 6;
                }
                field(Field7;CellData[7])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[7];
                    Editable = false;
                    Visible = true;
                    Width = 6;
                }
                field(Field8;CellData[8])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[8];
                    Editable = false;
                    Width = 6;
                }
                field(Field9;CellData[9])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[9];
                    Editable = false;
                    Width = 6;
                }
                field(Field10;CellData[10])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[10];
                    Editable = false;
                    Width = 6;
                }
                field(Field11;CellData[11])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[11];
                    Editable = false;
                    Width = 6;
                }
                field(Field12;CellData[12])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[12];
                    Editable = false;
                    Width = 6;
                }
                field(Field13;CellData[13])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[13];
                    Editable = false;
                    Visible = true;
                    Width = 6;
                }
                field(Field14;CellData[14])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[14];
                    Editable = false;
                    Visible = true;
                    Width = 6;
                }
                field(Field15;CellData[15])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[15];
                    Editable = false;
                    Width = 6;
                }
                field(Field16;CellData[16])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[16];
                    Editable = false;
                    Width = 6;
                }
                field(Field17;CellData[17])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[17];
                    Editable = false;
                    Width = 6;
                }
                field(Field18;CellData[18])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[18];
                    Editable = false;
                    Width = 6;
                }
                field(Field19;CellData[19])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[19];
                    Editable = false;
                    Width = 6;
                }
                field(Field20;CellData[20])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[20];
                    Editable = false;
                    Visible = true;
                    Width = 6;
                }
                field(Field21;CellData[21])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[21];
                    Editable = false;
                    Visible = true;
                    Width = 6;
                }
                field(Field22;CellData[22])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[22];
                    Editable = false;
                    Width = 6;
                }
                field(Field23;CellData[23])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[23];
                    Editable = false;
                    Width = 6;
                }
                field(Field24;CellData[24])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[24];
                    Editable = false;
                    Width = 6;
                }
                field(Field25;CellData[25])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[25];
                    Editable = false;
                    Width = 6;
                }
                field(Field26;CellData[26])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[26];
                    Editable = false;
                    Width = 6;
                }
                field(Field27;CellData[27])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[27];
                    Editable = false;
                    Visible = true;
                    Width = 6;
                }
                field(Field28;CellData[28])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[28];
                    Editable = false;
                    Visible = true;
                    Width = 6;
                }
                field(Field29;CellData[29])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[29];
                    Editable = false;
                    Width = 6;
                }
                field(Field30;CellData[30])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[30];
                    Editable = false;
                    Width = 6;
                }
                field(Field31;CellData[31])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[31];
                    Editable = false;
                    Visible = true;
                    Width = 6;
                }
                field(Field32;CellData[32])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[32];
                    Editable = false;
                    Visible = true;
                    Width = 6;
                }
                field("Total Quantity";Rec."Total Quantity")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total';
                    DrillDown = false;
                    Visible = true;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(TimeSheetStatusFactBox;"Time Sheet Status FactBox")
            {
                Caption = 'Time Sheet Status';
            }
            part(ActualSchedSummaryFactBox;"Actual/Sched. Summary FactBox")
            {
                Caption = 'Actual/Scheduled Summary';
                Visible = true;
            }
            part(ActivityDetailsFactBox;"Activity Details FactBox")
            {
                Caption = 'Activity Details';
                SubPageLink = "Time Sheet No."=field("Time Sheet No."),
                              "Line No."=field("Line No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Time Sheet")
            {
                Caption = '&Time Sheet';
                Image = Timesheet;
                action(PreviousPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = '&Previous Period';
                    Image = PreviousSet;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+PgUp';

                    trigger OnAction()
                    begin
                        FindTimeSheet(Setwanted::Previous);
                    end;
                }
                action(NextPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = '&Next Period';
                    Image = NextSet;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+PgDn';

                    trigger OnAction()
                    begin
                        FindTimeSheet(Setwanted::Next);
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("Posting E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting E&ntries';
                    Image = PostingEntries;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        TimeSheetMgt.ShowPostingEntries(Rec."Time Sheet No.",Rec."Line No.");
                    end;
                }
                action("Activity &Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Activity &Details';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        Rec.ShowLineDetails(true);
                    end;
                }
            }
            group("Co&mments")
            {
                Caption = 'Co&mments';
                Image = ViewComments;
                action("&Time Sheet Comments")
                {
                    ApplicationArea = Basic;
                    Caption = '&Time Sheet Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Time Sheet Comment Sheet";
                    RunPageLink = "No."=field("Time Sheet No."),
                                  "Time Sheet Line No."=const(0);
                }
                action(Comments_Line)
                {
                    ApplicationArea = Basic;
                    Caption = '&Line Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Time Sheet Comment Sheet";
                    RunPageLink = "No."=field("Time Sheet No."),
                                  "Time Sheet Line No."=field("Line No.");
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = '&Approve';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    begin
                        Approve;
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = '&Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Reject;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Reopen;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        if Rec."Time Sheet No." <> '' then
          CurrTimeSheetNo := Rec."Time Sheet No."
        else
          CurrTimeSheetNo := TimeSheetHeader.FindLastTimeSheetNo(TimeSheetHeader.FieldNo("Approver User ID"));

        TimeSheetMgt.SetTimeSheetNo(CurrTimeSheetNo,Rec);
        UpdateControls;
    end;

    var
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetDetail: Record "Time Sheet Detail";
        ColumnRecords: array [32] of Record Date;
        TimeSheetMgt: Codeunit "Time Sheet Management";
        TimeSheetApprovalMgt: Codeunit "Time Sheet Approval Management";
        NoOfColumns: Integer;
        CellData: array [32] of Decimal;
        ColumnCaption: array [32] of Text[1024];
        CurrTimeSheetNo: Code[20];
        SetWanted: Option Previous,Next;
        WorkTypeCodeAllowEdit: Boolean;
        ChargeableAllowEdit: Boolean;


    procedure SetColumns()
    var
        Calendar: Record Date;
    begin
        Clear(ColumnCaption);
        Clear(ColumnRecords);
        Clear(Calendar);
        Clear(NoOfColumns);

        TimeSheetHeader.Get(CurrTimeSheetNo);
        Calendar.SetRange("Period Type",Calendar."period type"::Date);
        Calendar.SetRange("Period Start",TimeSheetHeader."Starting Date",TimeSheetHeader."Ending Date");
        if Calendar.FindSet then
          repeat
            NoOfColumns += 1;
            ColumnRecords[NoOfColumns]."Period Start" := Calendar."Period Start";
            ColumnCaption[NoOfColumns] := TimeSheetMgt.FormatDate(Calendar."Period Start",1);
          until Calendar.Next = 0;
    end;

    local procedure OnAfterGetCurrRecord()
    var
        i: Integer;
    begin
        i := 0;
        while i < NoOfColumns do begin
          i := i + 1;
          if (Rec."Line No." <> 0) and TimeSheetDetail.Get(
               Rec."Time Sheet No.",
               Rec."Line No.",
               ColumnRecords[i]."Period Start")
          then
            CellData[i] := TimeSheetDetail.Quantity
          else
            CellData[i] := 0;
        end;
        UpdateFactBoxes;
        WorkTypeCodeAllowEdit := Rec.GetAllowEdit(Rec.FieldNo("Work Type Code"),true);
        ChargeableAllowEdit := Rec.GetAllowEdit(Rec.FieldNo(Chargeable),true);
    end;


    procedure FindTimeSheet(Which: Option Prev,Next)
    begin
        CurrTimeSheetNo := TimeSheetMgt.FindTimeSheet(TimeSheetHeader,Which);
        TimeSheetMgt.SetTimeSheetNo(CurrTimeSheetNo,Rec);
        UpdateControls;
    end;


    procedure UpdateFactBoxes()
    begin
        CurrPage.ActualSchedSummaryFactBox.Page.UpdateData(TimeSheetHeader);
        CurrPage.TimeSheetStatusFactBox.Page.UpdateData(TimeSheetHeader);
        if Rec."Line No." = 0 then
          CurrPage.ActivityDetailsFactBox.Page.SetEmptyLine;
    end;


    procedure UpdateControls()
    begin
        SetColumns;
        UpdateFactBoxes;
        CurrPage.Update(false);
    end;


    procedure Process("Action": Option "Approve Selected","Approve All","Reopen Selected","Reopen All","Reject Selected","Reject All")
    var
        TimeSheetLine: Record "Time Sheet Line";
        ActionType: Option Approve,Reopen,Reject;
    begin
        CurrPage.SaveRecord;
        case Action of
          Action::"Approve All",
          Action::"Reject All":
            FilterAllLines(TimeSheetLine,Actiontype::Approve);
          Action::"Reopen All":
            FilterAllLines(TimeSheetLine,Actiontype::Reopen);
          else
            CurrPage.SetSelectionFilter(TimeSheetLine);
        end;
        if TimeSheetLine.FindSet then
          repeat
            case Action of
              Action::"Approve Selected",
              Action::"Approve All":
                TimeSheetApprovalMgt.Approve(TimeSheetLine);
              Action::"Reopen Selected",
              Action::"Reopen All":
                TimeSheetApprovalMgt.ReopenApproved(TimeSheetLine);
              Action::"Reject Selected",
              Action::"Reject All":
                TimeSheetApprovalMgt.Reject(TimeSheetLine);
            end;
          until TimeSheetLine.Next = 0;
        CurrPage.Update(false);
    end;


    procedure Approve()
    var
        "Action": Option "Approve Selected","Approve All","Reopen Selected","Reopen All","Reject Selected","Reject All";
        ActionType: Option Approve,Reopen,Reject;
    begin
        case ShowDialog(Actiontype::Approve) of
          1:
            Process(Action::"Approve All");
          2:
            Process(Action::"Approve Selected");
        end;
    end;


    procedure Reopen()
    var
        ActionType: Option Approve,Reopen,Reject;
        "Action": Option "Approve Selected","Approve All","Reopen Selected","Reopen All","Reject Selected","Reject All";
    begin
        case ShowDialog(Actiontype::Reopen) of
          1:
            Process(Action::"Reopen All");
          2:
            Process(Action::"Reopen Selected");
        end;
    end;


    procedure Reject()
    var
        ActionType: Option Approve,Reopen,Reject;
        "Action": Option "Approve Selected","Approve All","Reopen Selected","Reopen All","Reject Selected","Reject All";
    begin
        case ShowDialog(Actiontype::Reject) of
          1:
            Process(Action::"Reject All");
          2:
            Process(Action::"Reject Selected");
        end;
    end;


    procedure GetDialogText(ActionType: Option Approve,Reopen,Reject): Text[100]
    var
        TimeSheetLine: Record "Time Sheet Line";
    begin
        FilterAllLines(TimeSheetLine,ActionType);
        exit(TimeSheetApprovalMgt.GetManagerTimeSheetDialogText(ActionType,TimeSheetLine.Count));
    end;


    procedure FilterAllLines(var TimeSheetLine: Record "Time Sheet Line";ActionType: Option Approve,Reopen,Reject)
    begin
        TimeSheetLine.SetRange("Time Sheet No.",CurrTimeSheetNo);
        TimeSheetLine.CopyFilters(Rec);
        TimeSheetLine.FilterGroup(2);
        TimeSheetLine.SetFilter(Type,'<>%1',TimeSheetLine.Type::" ");
        TimeSheetLine.FilterGroup(0);
        case ActionType of
          Actiontype::Approve,
          Actiontype::Reject:
            TimeSheetLine.SetRange(Status,TimeSheetLine.Status::Submitted);
          Actiontype::Reopen:
            TimeSheetLine.SetRange(Status,TimeSheetLine.Status::Approved);
        end;
    end;

    local procedure ShowDialog(ActionType: Option Approve,Reopen,Reject): Integer
    begin
        exit(StrMenu(GetDialogText(ActionType),1,TimeSheetApprovalMgt.GetManagerTimeSheetDialogInstruction(ActionType)));
    end;
}

