Page 17438 "Time Sheet Custom"
{
    AutoSplitKey = true;
    Caption = 'Time Sheet Customers';
    DataCaptionFields = "Time Sheet No.";
    PageType = Worksheet;
    ApplicationArea = all;

    PromotedActionCategories = 'New,Process,Report,Navigate,Lines';
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Time Sheet Line";

    layout
    {
        area(content)
        {
            group(Control26)
            {
                field(CurrTimeSheetNo; CurrTimeSheetNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Time Sheet No';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CurrPage.SaveRecord;
                        TimeSheetMgt.LookupOwnerTimeSheet(CurrTimeSheetNo, Rec, TimeSheetHeader);
                        UpdateControls;
                    end;

                    trigger OnValidate()
                    begin
                        TimeSheetHeader.Reset;
                        TimeSheetMgt.FilterTimeSheets(TimeSheetHeader, TimeSheetHeader.FieldNo("Owner User ID"));
                        TimeSheetMgt.CheckTimeSheetNo(TimeSheetHeader, CurrTimeSheetNo);
                        CurrPage.SaveRecord;
                        TimeSheetMgt.SetTimeSheetNo(CurrTimeSheetNo, Rec);
                        UpdateControls;
                    end;
                }
                field(ResourceNo; TimeSheetHeader."Resource No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Resource No.';
                    Editable = false;
                }
                field(ApproverUserID; TimeSheetHeader."Approver User ID")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approver User ID';
                    Editable = false;
                    Visible = false;
                }
                field(StartingDate; TimeSheetHeader."Starting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Starting Date';
                    Editable = false;
                }
                field(EndingDate; TimeSheetHeader."Ending Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ending Date';
                    Editable = false;
                }
            }
            repeater(Control1)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = AllowEdit;

                    trigger OnValidate()
                    begin
                        OnAfterGetCurrRecord;
                        CurrPage.Update(true);
                    end;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = Basic;
                    Editable = AllowEdit;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                    end;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = Basic;
                    Editable = AllowEdit;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = AllowEdit;

                    trigger OnAssistEdit()
                    begin
                        if Rec."Line No." = 0 then
                            exit;

                        Rec.ShowLineDetails(false);
                        CurrPage.Update(false);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                    end;
                }
                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {
                    ApplicationArea = Basic;
                    Editable = AllowEdit;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                    end;
                }
                field(Chargeable; Rec.Chargeable)
                {
                    ApplicationArea = Basic;
                    Editable = AllowEdit;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                    end;
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = Basic;
                    Editable = AllowEdit;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                    end;
                }
                field("Service Order No."; Rec."Service Order No.")
                {
                    ApplicationArea = Basic;
                    Editable = AllowEdit;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                    end;
                }
                field("Assembly Order No."; Rec."Assembly Order No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Field1; CellData[1])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[1];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(1);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field2; CellData[2])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[2];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(2);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field3; CellData[3])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[3];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(3);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field4; CellData[4])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[4];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(4);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field5; CellData[5])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[5];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(5);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field6; CellData[6])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[6];
                    Editable = AllowEdit;
                    Visible = true;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(6);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field7; CellData[7])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[7];
                    Editable = AllowEdit;
                    Visible = true;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(7);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field8; CellData[8])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[8];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(8);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field9; CellData[9])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[9];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(9);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field10; CellData[10])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[10];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(10);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field11; CellData[11])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[11];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(11);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field12; CellData[12])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[12];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(12);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field13; CellData[13])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[13];
                    Editable = AllowEdit;
                    Visible = true;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(13);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field14; CellData[14])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[14];
                    Editable = AllowEdit;
                    Visible = true;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(14);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field15; CellData[15])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[15];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(15);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field16; CellData[16])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[16];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(16);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field17; CellData[17])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[17];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(17);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field18; CellData[18])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[18];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(18);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field19; CellData[19])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[19];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(19);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field20; CellData[20])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[20];
                    Editable = AllowEdit;
                    Visible = true;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(20);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field21; CellData[21])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[21];
                    Editable = AllowEdit;
                    Visible = true;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(21);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field22; CellData[22])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[22];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(22);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field23; CellData[23])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[23];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(23);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field24; CellData[24])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[24];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(24);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field25; CellData[25])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[25];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(25);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field26; CellData[26])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[26];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(26);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field27; CellData[27])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[27];
                    Editable = AllowEdit;
                    Visible = true;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(27);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field28; CellData[28])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[28];
                    Editable = AllowEdit;
                    Visible = true;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(28);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field29; CellData[29])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[29];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(29);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field30; CellData[30])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[30];
                    Editable = AllowEdit;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(30);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field31; CellData[31])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[31];
                    Editable = AllowEdit;
                    Visible = true;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(31);
                        CellDataOnAfterValidate;
                    end;
                }
                field(Field32; CellData[32])
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    CaptionClass = '3,' + ColumnCaption[32];
                    Editable = AllowEdit;
                    Visible = true;
                    Width = 6;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        ValidateQuantity(32);
                        CellDataOnAfterValidate;
                    end;
                }
                field("Total Quantity"; Rec."Total Quantity")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total';
                    DrillDown = false;
                    Visible = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(TimeSheetStatusFactBox; "Time Sheet Status FactBox")
            {
                Caption = 'Time Sheet Status';
            }
            part(ActualSchedSummaryFactBox; "Actual/Sched. Summary FactBox")
            {
                Caption = 'Actual/Scheduled Summary';
                Visible = true;
            }
            part(ActivityDetailsFactBox; "Activity Details FactBox")
            {
                Caption = 'Activity Details';
                SubPageLink = "Time Sheet No." = field("Time Sheet No."),
                              "Line No." = field("Line No.");
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
                action("Time Sheet Allocation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Time Sheet Allocation';
                    Image = Allocate;

                    trigger OnAction()
                    begin
                        TimeAllocation;
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
                        Rec.ShowLineDetails(false);
                    end;
                }
            }
            group(Comments)
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
                    RunPageLink = "No." = field("Time Sheet No."),
                                  "Time Sheet Line No." = const(0);
                }
                action(Comments_Line)
                {
                    ApplicationArea = Basic;
                    Caption = '&Line Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Time Sheet Comment Sheet";
                    RunPageLink = "No." = field("Time Sheet No."),
                                  "Time Sheet Line No." = field("Line No.");
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Submit)
                {
                    ApplicationArea = Basic;
                    Caption = '&Submit';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Submit;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic;
                    Caption = '&Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Reopen;
                    end;
                }
                separator(Action28)
                {
                }
                action(CopyLinesFromPrevTS)
                {
                    ApplicationArea = Basic;
                    Caption = '&Copy lines from previous time sheet';
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        QtyToBeCopied: Integer;
                    begin
                        QtyToBeCopied := TimeSheetMgt.CalcPrevTimeSheetLines(TimeSheetHeader);
                        if QtyToBeCopied = 0 then
                            Message(Text004)
                        else
                            if Confirm(Text009, true, QtyToBeCopied) then
                                TimeSheetMgt.CopyPrevTimeSheetLines(TimeSheetHeader);
                    end;
                }
                action(CreateLinesFromJobPlanning)
                {
                    ApplicationArea = Basic;
                    Caption = 'Create lines from &job planning';
                    Image = CreateLinesFromJob;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        QtyToBeCreated: Integer;
                    begin
                        QtyToBeCreated := TimeSheetMgt.CalcLinesFromJobPlanning(TimeSheetHeader);
                        if QtyToBeCreated = 0 then
                            Message(Text003)
                        else
                            if Confirm(Text010, true, QtyToBeCreated) then
                                TimeSheetMgt.CreateLinesFromJobPlanning(TimeSheetHeader);
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
            CurrTimeSheetNo := TimeSheetHeader.FindLastTimeSheetNo(TimeSheetHeader.FieldNo("Owner User ID"));

        TimeSheetMgt.SetTimeSheetNo(CurrTimeSheetNo, Rec);
        UpdateControls;
    end;

    var
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetDetail: Record "Time Sheet Detail";
        ColumnRecords: array[25000] of Record Date;
        TimeSheetMgt: Codeunit "Time Sheet Management";
        TimeSheetApprovalMgt: Codeunit "Time Sheet Approval Management";
        NoOfColumns: Integer;
        CellData: array[25000] of Decimal;
        ColumnCaption: array[25000] of Text[1024];
        CurrTimeSheetNo: Code[20];
        SetWanted: Option Previous,Next;
        Text001: label 'The type of time sheet line cannot be empty.';
        Text003: label 'Could not find job planning lines.';
        Text004: label 'There are no time sheet lines to copy.';
        Text009: label 'Do you want to copy lines from previous timesheet (%1)?';
        Text010: label 'Do you want to create lines from job planning (%1)?';
        AllowEdit: Boolean;


    procedure SetColumns()
    var
        Calendar: Record Date;
    begin
        Clear(ColumnCaption);
        Clear(ColumnRecords);
        Clear(Calendar);
        Clear(NoOfColumns);

        TimeSheetHeader.Get(CurrTimeSheetNo);
        Calendar.SetRange("Period Type", Calendar."period type"::Date);
        Calendar.SetRange("Period Start", TimeSheetHeader."Starting Date", TimeSheetHeader."Ending Date");
        if Calendar.FindSet then
            repeat
                NoOfColumns += 1;
                ColumnRecords[NoOfColumns]."Period Start" := Calendar."Period Start";
                ColumnCaption[NoOfColumns] := TimeSheetMgt.FormatDate(Calendar."Period Start", 1);
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
        AllowEdit := Rec.Status in [Rec.Status::Open, Rec.Status::Rejected];
    end;


    procedure ValidateQuantity(ColumnNo: Integer)
    begin
        if (CellData[ColumnNo] <> 0) and (Rec.Type = Rec.Type::" ") then
            Error(Text001);

        if TimeSheetDetail.Get(
             Rec."Time Sheet No.",
             Rec."Line No.",
             ColumnRecords[ColumnNo]."Period Start")
        then begin
            if CellData[ColumnNo] <> TimeSheetDetail.Quantity then
                TestTimeSheetLineStatus;

            if CellData[ColumnNo] = 0 then
                TimeSheetDetail.Delete
            else begin
                TimeSheetDetail.Quantity := CellData[ColumnNo];
                TimeSheetDetail.Modify(true);
            end;
        end else begin
            if CellData[ColumnNo] <> 0 then
                TestTimeSheetLineStatus;

            TimeSheetDetail.Init;
            TimeSheetDetail.CopyFromTimeSheetLine(Rec);
            TimeSheetDetail.Date := ColumnRecords[ColumnNo]."Period Start";
            TimeSheetDetail.Quantity := CellData[ColumnNo];
            TimeSheetDetail.Insert(true);
        end;
    end;


    procedure Process("Action": Option "Submit Selected","Submit All","Reopen Selected","Reopen All")
    var
        TimeSheetLine: Record "Time Sheet Line";
        ActionType: Option Submit,Reopen;
    begin
        CurrPage.SaveRecord;
        case Action of
            Action::"Submit All":
                FilterAllLines(TimeSheetLine, Actiontype::Submit);
            Action::"Reopen All":
                FilterAllLines(TimeSheetLine, Actiontype::Reopen);
            else
                CurrPage.SetSelectionFilter(TimeSheetLine);
        end;
        if TimeSheetLine.FindSet then
            repeat
                case Action of
                    Action::"Submit Selected",
                  Action::"Submit All":
                        TimeSheetApprovalMgt.Submit(TimeSheetLine);
                    Action::"Reopen Selected",
                  Action::"Reopen All":
                        TimeSheetApprovalMgt.ReopenSubmitted(TimeSheetLine);
                end;
            until TimeSheetLine.Next = 0;
        CurrPage.Update(true);
    end;


    procedure CellDataOnAfterValidate()
    begin
        UpdateFactBoxes;
        Rec.CalcFields("Total Quantity");
    end;


    procedure FindTimeSheet(Which: Option Prev,Next)
    begin
        CurrTimeSheetNo := TimeSheetMgt.FindTimeSheet(TimeSheetHeader, Which);
        TimeSheetMgt.SetTimeSheetNo(CurrTimeSheetNo, Rec);
        UpdateControls;
    end;


    procedure UpdateFactBoxes()
    begin
        CurrPage.ActualSchedSummaryFactBox.Page.UpdateData(TimeSheetHeader);
        //CurrPage.TimeSheetStatusFactBox.Page.UpdateData(TimeSheetHeader);
        if Rec."Line No." = 0 then
            CurrPage.ActivityDetailsFactBox.Page.SetEmptyLine;
    end;


    procedure UpdateControls()
    begin
        SetColumns;
        UpdateFactBoxes;
        CurrPage.Update(false);
    end;


    procedure TestTimeSheetLineStatus()
    var
        TimeSheetLine: Record "Time Sheet Line";
    begin
        TimeSheetLine.Get(Rec."Time Sheet No.", Rec."Line No.");
        TimeSheetLine.TestStatus;
    end;


    procedure Submit()
    var
        "Action": Option "Submit Selected","Submit All","Reopen Selected","Reopen All";
        ActionType: Option Submit,Reopen;
    begin
        case ShowDialog(Actiontype::Submit) of
            1:
                Process(Action::"Submit All");
            2:
                Process(Action::"Submit Selected");
        end;
    end;


    procedure Reopen()
    var
        ActionType: Option Submit,Reopen;
        "Action": Option "Submit Selected","Submit All","Reopen Selected","Reopen All";
    begin
        case ShowDialog(Actiontype::Reopen) of
            1:
                Process(Action::"Reopen All");
            2:
                Process(Action::"Reopen Selected");
        end;
    end;


    procedure TimeAllocation()
    var
        TimeSheetAllocation: Page "Time Sheet Allocation";
        AllocatedQty: array[7] of Decimal;
    begin
        Rec.TestField(Posted, true);
        Rec.CalcFields("Total Quantity");
        TimeSheetAllocation.InitParameters(Rec."Time Sheet No.", Rec."Line No.", Rec."Total Quantity");
        if TimeSheetAllocation.RunModal = Action::OK then begin
            TimeSheetAllocation.GetAllocation(AllocatedQty);
            TimeSheetMgt.UpdateTimeAllocation(Rec, AllocatedQty);
        end;
    end;


    procedure GetDialogText(ActionType: Option Submit,Reopen): Text[100]
    var
        TimeSheetLine: Record "Time Sheet Line";
    begin
        FilterAllLines(TimeSheetLine, ActionType);
        exit(TimeSheetApprovalMgt.GetTimeSheetDialogText(ActionType, TimeSheetLine.Count));
    end;


    procedure FilterAllLines(var TimeSheetLine: Record "Time Sheet Line"; ActionType: Option Submit,Reopen)
    begin
        TimeSheetLine.SetRange("Time Sheet No.", CurrTimeSheetNo);
        TimeSheetLine.CopyFilters(Rec);
        TimeSheetLine.FilterGroup(2);
        TimeSheetLine.SetFilter(Type, '<>%1', TimeSheetLine.Type::" ");
        TimeSheetLine.FilterGroup(0);
        case ActionType of
            Actiontype::Submit:
                TimeSheetLine.SetFilter(Status, '%1|%2', TimeSheetLine.Status::Open, TimeSheetLine.Status::Rejected);
            Actiontype::Reopen:
                TimeSheetLine.SetRange(Status, TimeSheetLine.Status::Submitted);
        end;
    end;

    local procedure ShowDialog(ActionType: Option Submit,Reopen): Integer
    begin
        exit(StrMenu(GetDialogText(ActionType), 1, TimeSheetApprovalMgt.GetTimeSheetDialogInstruction(ActionType)));
    end;
}

