codeunit 50021 "AU Timesheet Mgt"
{

    Permissions = TableData "Time Sheet Posting Entry" = ri,
                  TableData "Job Planning Line" = r,
                  TableData Employee = r;

    trigger OnRun()
    begin
    end;

    var
        Text001: Label 'Mon,Tue,Wed,Thu,Fri,Sat,Sun';
        Text002: Label '%1 is already defined as Time Sheet Owner User ID for Resource No. %2 with type %3.', Comment = 'User1 is already defined as Resources for Resource No. LIFT with type Machine.';
        Text003: Label 'Time Sheet Header %1 is not found.', Comment = 'Time Sheet Header Archive 10 is not found.';
        Text004: Label 'cannot be greater than %1 %2.', Comment = '%1 - Quantity, %2 - Unit of measure. Example: Quantity cannot be greater than 8 HOUR.';
        Text005: Label 'Time Sheet Header Archive %1 is not found.', Comment = 'Time Sheet Header Archive 10 is not found.';
        NoLinesToCopyErr: Label 'There are no time sheet lines to copy.';
        CopyLinesQst: Label 'Do you want to copy lines from the previous time sheet (%1)?', Comment = '%1 - number';
        JobPlanningLinesNotFoundErr: Label 'Could not find job planning lines.';
        CreateLinesQst: Label 'Do you want to create lines from job planning (%1)?', Comment = '%1 - number';
        PageDataCaptionTxt: Label '%1 (%2)', Comment = '%1 - start date, %2 - Description,';

#if not CLEAN22
    [Obsolete('Remove old time sheet experience.', '22.0')]
    procedure TimeSheetV2Enabled() Result: Boolean
    var
        ResourcesSetup: Record "Resources Setup";
    begin
        if ResourcesSetup.Get() then
            Result := ResourcesSetup."Use New Time Sheet Experience";

        OnAfterTimeSheetV2Enabled(Result);
    end;

    internal procedure GetTimeSheetV2FeatureKey(): Text[50]
    begin
        exit('NewTimeSheetExperience');
    end;
#endif

    procedure FilterTimeSheets(var TimeSheetHeader: Record "Time Sheet Header"; FieldNo: Integer)
    var
        UserSetup: Record "User Setup";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeFilterTimeSheets(TimeSheetHeader, FieldNo, IsHandled);
        If IsHandled then
            exit;

        if UserSetup.Get(UserId) then;
        if not UserSetup."Time Sheet Admin." then begin
            TimeSheetHeader.FilterGroup(2);
            case FieldNo of
                TimeSheetHeader.FieldNo("Owner User ID"):
                    TimeSheetHeader.SetRange("Owner User ID", UserId);
                TimeSheetHeader.FieldNo("Approver User ID"):
                    TimeSheetHeader.SetRange("Approver User ID", UserId);
            end;
            TimeSheetHeader.FilterGroup(0);
        end;
    end;

    procedure FilterAllTimeSheetLines(var TimeSheetLine: Record "Time Sheet Line"; ActionType: Option Submit,ReopenSubmitted,Approve,ReopenApproved,Reject)
    begin
        TimeSheetLine.FilterGroup(2);
        TimeSheetLine.SetFilter(Type, '<>%1', TimeSheetLine.Type::" ");
        TimeSheetLine.FilterGroup(0);
        case ActionType of
            ActionType::Submit:
                TimeSheetLine.SetRange(Status, TimeSheetLine.Status::Open);
            ActionType::ReopenSubmitted:
                TimeSheetLine.SetFilter(Status, '%1|%2', TimeSheetLine.Status::Submitted, TimeSheetLine.Status::Rejected);
            ActionType::Reject,
            ActionType::Approve:
                TimeSheetLine.SetRange(Status, TimeSheetLine.Status::Submitted);
            ActionType::ReopenApproved:
                TimeSheetLine.SetFilter(Status, '%1|%2', TimeSheetLine.Status::Approved, TimeSheetLine.Status::Rejected);
        end;

        OnAfterFilterAllLines(TimeSheetLine, ActionType);
    end;

    procedure CheckTimeSheetNo(var TimeSheetHeader: Record "Time Sheet Header"; TimeSheetNo: Code[20])
    begin
        TimeSheetHeader.SetRange("No.", TimeSheetNo);
        if TimeSheetHeader.IsEmpty() then
            Error(Text003, TimeSheetNo);
    end;

    procedure SetTimeSheetNo(TimeSheetNo: Code[20]; var TimeSheetLine: Record "Time Sheet Line")
    begin
        TimeSheetLine.FilterGroup(2);
        TimeSheetLine.SetRange("Time Sheet No.", TimeSheetNo);
        TimeSheetLine.FilterGroup(0);
        TimeSheetLine."Time Sheet No." := TimeSheetNo;
    end;

    procedure LookupOwnerTimeSheet(var TimeSheetNo: Code[20]; var TimeSheetLine: Record "Time Sheet Line"; var TimeSheetHeader: Record "Time Sheet Header")
    var
        TimeSheetList: Page "Time Sheet List";
    begin
        Commit();
        if TimeSheetNo <> '' then begin
            TimeSheetHeader.Get(TimeSheetNo);
            TimeSheetList.SetRecord(TimeSheetHeader);
        end;

        TimeSheetList.LookupMode := true;
        if TimeSheetList.RunModal() = ACTION::LookupOK then begin
            TimeSheetList.GetRecord(TimeSheetHeader);
            TimeSheetNo := TimeSheetHeader."No.";
            SetTimeSheetNo(TimeSheetNo, TimeSheetLine);
        end;
    end;

    procedure LookupApproverTimeSheet(var TimeSheetNo: Code[20]; var TimeSheetLine: Record "Time Sheet Line"; var TimeSheetHeader: Record "Time Sheet Header")
    var
        ManagerTimeSheetList: Page "Manager Time Sheet List";
    begin
        Commit();
        if TimeSheetNo <> '' then begin
            TimeSheetHeader.Get(TimeSheetNo);
            ManagerTimeSheetList.SetRecord(TimeSheetHeader);
        end;

        ManagerTimeSheetList.LookupMode := true;
        if ManagerTimeSheetList.RunModal() = ACTION::LookupOK then begin
            ManagerTimeSheetList.GetRecord(TimeSheetHeader);
            TimeSheetNo := TimeSheetHeader."No.";
            SetTimeSheetNo(TimeSheetNo, TimeSheetLine);
        end;
    end;

    procedure FormatDate(Date: Date; DOWFormatType: Option Full,Short): Text[30]
    begin
        case DOWFormatType of
            DOWFormatType::Full:
                exit(StrSubstNo('%1 %2', Date2DMY(Date, 1), Format(Date, 0, '<Weekday Text>')));
            DOWFormatType::Short:
                exit(StrSubstNo('%1 %2', Date2DMY(Date, 1), SelectStr(Date2DWY(Date, 1), Text001)));
        end;
    end;

    procedure CheckAccPeriod(Date: Date)
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        if AccountingPeriod.IsEmpty() then
            exit;
        AccountingPeriod.SetFilter("Starting Date", '..%1', Date);
        AccountingPeriod.FindLast();
        AccountingPeriod.TestField(Closed, false);
    end;

    procedure CheckResourceTimeSheetOwner(TimeSheetOwnerUserID: Code[50]; CurrResourceNo: Code[20])
    var
        Resource: Record Resource;
    begin
        Resource.Reset();
        Resource.SetFilter("No.", '<>%1', CurrResourceNo);
        Resource.SetRange(Type, Resource.Type::Person);
        Resource.SetRange("Time Sheet Owner User ID", TimeSheetOwnerUserID);
        if Resource.FindFirst() then
            Error(
              Text002,
              TimeSheetOwnerUserID,
              Resource."No.",
              Resource.Type);
    end;

    procedure CalcStatusFactBoxData(var TimeSheetHeader: Record "Time Sheet Header"; var OpenQty: Decimal; var SubmittedQty: Decimal; var RejectedQty: Decimal; var ApprovedQty: Decimal; var PostedQty: Decimal; var TotalQuantity: Decimal)
    var
        Status: Enum "Time Sheet Status";
    begin
        TotalQuantity := 0;
        TimeSheetHeader.SetRange("Date Filter", TimeSheetHeader."Starting Date", TimeSheetHeader."Ending Date");
        OnCalcStatusFactBoxDataOnAfterTimeSheetHeaderSetFilters(TimeSheetHeader);
        OpenQty := TimeSheetHeader.CalcQtyWithStatus(Status::Open);

        SubmittedQty := TimeSheetHeader.CalcQtyWithStatus(Status::Submitted);

        RejectedQty := TimeSheetHeader.CalcQtyWithStatus(Status::Rejected);

        ApprovedQty := TimeSheetHeader.CalcQtyWithStatus(Status::Approved);

        TimeSheetHeader.SetRange("Status Filter");
        TimeSheetHeader.CalcFields(Quantity);
        TimeSheetHeader.CalcFields("Posted Quantity");
        TotalQuantity := TimeSheetHeader.Quantity;
        PostedQty := TimeSheetHeader."Posted Quantity";
    end;

    procedure CalcActSchedFactBoxData(TimeSheetHeader: Record "Time Sheet Header"; var DateDescription: array[32] of Text[30]; var DateQuantity: array[32] of Text[30]; var TotalQtyText: Text[30]; var TotalPresenceQty: Decimal; var AbsenceQty: Decimal)
    var
        Resource: Record Resource;
        Calendar: Record Date;
        TotalSchedQty: Decimal;
        i: Integer;
    begin
        TotalPresenceQty := 0;
        if Resource.Get(TimeSheetHeader."Resource No.") then begin
            Calendar.SetRange("Period Type", Calendar."Period Type"::Date);
            Calendar.SetRange("Period Start", TimeSheetHeader."Starting Date", TimeSheetHeader."Ending Date");
            if Calendar.FindSet() then
                repeat
                    i += 1;
                    DateDescription[i] := FormatDate(Calendar."Period Start", 0);
                    OnCalcActSchedFactBoxDataOnAfterSetDateDescription(TimeSheetHeader, Calendar, DateDescription[i]);
                    TimeSheetHeader.SetRange("Date Filter", Calendar."Period Start");
                    OnCalcActSchedFactBoxDataOnAfterTimeSheetHeaderSetFilters(TimeSheetHeader, Calendar);
                    TimeSheetHeader.CalcFields(Quantity);
                    Resource.SetRange("Date Filter", Calendar."Period Start");
                    OnCalcActSchedFactBoxDataOnBeforeResouceCalcFields(Resource, Calendar);
                    Resource.CalcFields(Capacity);
                    DateQuantity[i] := FormatActualSched(TimeSheetHeader.Quantity, Resource.Capacity);
                    TotalPresenceQty += TimeSheetHeader.Quantity;
                    TotalSchedQty += Resource.Capacity;
                until Calendar.Next() = 0;
            TotalQtyText := FormatActualSched(TotalPresenceQty, TotalSchedQty);
            TimeSheetHeader.SetRange("Type Filter", TimeSheetHeader."Type Filter"::Absence);
            TimeSheetHeader.SetRange("Date Filter", TimeSheetHeader."Starting Date", TimeSheetHeader."Ending Date");
            TimeSheetHeader.CalcFields(Quantity);
            AbsenceQty := TimeSheetHeader.Quantity;
        end;

        OnAfterCalcActSchedFactBoxData(TimeSheetHeader, TotalQtyText, TotalPresenceQty, AbsenceQty);
    end;

    procedure FormatActualSched(ActualQty: Decimal; ScheduledQty: Decimal): Text[30]
    begin
        exit(
          Format(ActualQty, 0, '<Precision,2:2><Standard Format,0>') + '/' + Format(ScheduledQty, 0, '<Precision,2:2><Standard Format,0>'));
    end;

    procedure FilterTimeSheetsArchive(var TimeSheetHeaderArchive: Record "Time Sheet Header Archive"; FieldNo: Integer)
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then;
        if not UserSetup."Time Sheet Admin." then begin
            TimeSheetHeaderArchive.FilterGroup(2);
            case FieldNo of
                TimeSheetHeaderArchive.FieldNo("Owner User ID"):
                    TimeSheetHeaderArchive.SetRange("Owner User ID", UserId);
                TimeSheetHeaderArchive.FieldNo("Approver User ID"):
                    TimeSheetHeaderArchive.SetRange("Approver User ID", UserId);
            end;
            TimeSheetHeaderArchive.FilterGroup(0);
        end;
    end;

    procedure CheckTimeSheetArchiveNo(var TimeSheetHeaderArchive: Record "Time Sheet Header Archive"; TimeSheetNo: Code[20])
    begin
        TimeSheetHeaderArchive.SetRange("No.", TimeSheetNo);
        if TimeSheetHeaderArchive.IsEmpty() then
            Error(Text005, TimeSheetNo);
    end;

    procedure GetTimeSheetDataCaption(TimeSheetHeader: Record "Time Sheet Header"): Text
    begin
        if TimeSheetHeader.Description = '' then
            exit(Format(TimeSheetHeader."Starting Date", 0, 4));

        exit(StrSubstNo(PageDataCaptionTxt, Format(TimeSheetHeader."Starting Date", 0, 4), TimeSheetHeader.Description));
    end;

    procedure SetTimeSheetArchiveNo(TimeSheetNo: Code[20]; var TimeSheetLineArchive: Record "Time Sheet Line Archive")
    begin
        TimeSheetLineArchive.FilterGroup(2);
        TimeSheetLineArchive.SetRange("Time Sheet No.", TimeSheetNo);
        TimeSheetLineArchive.FilterGroup(0);
        TimeSheetLineArchive."Time Sheet No." := TimeSheetNo;
    end;

    procedure LookupOwnerTimeSheetArchive(var TimeSheetNo: Code[20]; var TimeSheetLineArchive: Record "Time Sheet Line Archive"; var TimeSheetHeaderArchive: Record "Time Sheet Header Archive")
    var
        TimeSheetArchiveList: Page "Time Sheet Archive List";
    begin
        Commit();
        if TimeSheetNo <> '' then begin
            TimeSheetHeaderArchive.Get(TimeSheetNo);
            TimeSheetArchiveList.SetRecord(TimeSheetHeaderArchive);
        end;

        TimeSheetArchiveList.LookupMode := true;
        if TimeSheetArchiveList.RunModal() = ACTION::LookupOK then begin
            TimeSheetArchiveList.GetRecord(TimeSheetHeaderArchive);
            TimeSheetNo := TimeSheetHeaderArchive."No.";
            SetTimeSheetArchiveNo(TimeSheetNo, TimeSheetLineArchive);
        end;
    end;

    procedure LookupApproverTimeSheetArchive(var TimeSheetNo: Code[20]; var TimeSheetLineArchive: Record "Time Sheet Line Archive"; var TimeSheetHeaderArchive: Record "Time Sheet Header Archive")
    var
        ManagerTimeSheetArcList: Page "Manager Time Sheet Arc. List";
    begin
        Commit();
        if TimeSheetNo <> '' then begin
            TimeSheetHeaderArchive.Get(TimeSheetNo);
            ManagerTimeSheetArcList.SetRecord(TimeSheetHeaderArchive);
        end;

        ManagerTimeSheetArcList.LookupMode := true;
        if ManagerTimeSheetArcList.RunModal() = ACTION::LookupOK then begin
            ManagerTimeSheetArcList.GetRecord(TimeSheetHeaderArchive);
            TimeSheetNo := TimeSheetHeaderArchive."No.";
            SetTimeSheetArchiveNo(TimeSheetNo, TimeSheetLineArchive);
        end;
    end;

    procedure CalcSummaryArcFactBoxData(TimeSheetHeaderArchive: Record "Time Sheet Header Archive"; var DateDescription: array[32] of Text[30]; var DateQuantity: array[32] of Decimal; var TotalQuantity: Decimal; var AbsenceQuantity: Decimal)
    var
        Calendar: Record Date;
        i: Integer;
    begin
        TotalQuantity := 0;
        Calendar.SetRange("Period Type", Calendar."Period Type"::Date);
        Calendar.SetRange("Period Start", TimeSheetHeaderArchive."Starting Date", TimeSheetHeaderArchive."Ending Date");
        if Calendar.FindSet() then
            repeat
                i += 1;
                DateDescription[i] := FormatDate(Calendar."Period Start", 0);
                TimeSheetHeaderArchive.SetRange("Date Filter", Calendar."Period Start");
                TimeSheetHeaderArchive.CalcFields(Quantity);
                DateQuantity[i] := TimeSheetHeaderArchive.Quantity;
                TotalQuantity += TimeSheetHeaderArchive.Quantity;
            until Calendar.Next() = 0;

        TimeSheetHeaderArchive.SetRange("Type Filter", TimeSheetHeaderArchive."Type Filter"::Absence);
        TimeSheetHeaderArchive.SetRange("Date Filter", TimeSheetHeaderArchive."Starting Date", TimeSheetHeaderArchive."Ending Date");
        TimeSheetHeaderArchive.CalcFields(Quantity);
        AbsenceQuantity := TimeSheetHeaderArchive.Quantity;
    end;

    procedure MoveTimeSheetToArchive(TimeSheetHeader: Record "Time Sheet Header")
    var
        TimeSheetLine: Record "Time Sheet Line";
        TimeSheetDetail: Record "Time Sheet Detail";
        TimeSheetCommentLine: Record "Time Sheet Comment Line";
        TimeSheetHeaderArchive: Record "Time Sheet Header Archive";
        TimeSheetLineArchive: Record "Time Sheet Line Archive";
        TimeSheetDetailArchive: Record "Time Sheet Detail Archive";
        TimeSheetCmtLineArchive: Record "Time Sheet Cmt. Line Archive";
    begin
        with TimeSheetHeader do begin
            Check();

            TimeSheetHeaderArchive.TransferFields(TimeSheetHeader);
            TimeSheetHeaderArchive.Insert();

            TimeSheetLine.SetRange("Time Sheet No.", "No.");
            if TimeSheetLine.FindSet() then begin
                repeat
                    TimeSheetLineArchive.TransferFields(TimeSheetLine);
                    TimeSheetLineArchive.Insert();
                until TimeSheetLine.Next() = 0;
                TimeSheetLine.DeleteAll();
            end;

            TimeSheetDetail.SetRange("Time Sheet No.", "No.");
            if TimeSheetDetail.FindSet() then begin
                repeat
                    TimeSheetDetailArchive.TransferFields(TimeSheetDetail);
                    TimeSheetDetailArchive.Insert();
                until TimeSheetDetail.Next() = 0;
                TimeSheetDetail.DeleteAll();
            end;

            TimeSheetCommentLine.SetRange("No.", "No.");
            if TimeSheetCommentLine.FindSet() then begin
                repeat
                    TimeSheetCmtLineArchive.TransferFields(TimeSheetCommentLine);
                    TimeSheetCmtLineArchive.Insert();
                until TimeSheetCommentLine.Next() = 0;
                TimeSheetCommentLine.DeleteAll();
            end;

            Delete();
        end;
    end;

    procedure CheckCopyPrevTimeSheetLines(TimeSheetHeader: Record "Time Sheet Header")
    var
        QtyToBeCopied: Integer;
    begin
        QtyToBeCopied := CalcPrevTimeSheetLines(TimeSheetHeader);
        if QtyToBeCopied = 0 then
            Message(NoLinesToCopyErr)
        else
            if Confirm(CopyLinesQst, true, QtyToBeCopied) then
                CopyPrevTimeSheetLines(TimeSheetHeader);
    end;

    procedure CopyPrevTimeSheetLines(ToTimeSheetHeader: Record "Time Sheet Header")
    var
        FromTimeSheetHeader: Record "Time Sheet Header";
        FromTimeSheetLine: Record "Time Sheet Line";
        ToTimeSheetLine: Record "Time Sheet Line";
        LineNo: Integer;
        IsHandled: Boolean;
    begin
        LineNo := ToTimeSheetHeader.GetLastLineNo();

        FromTimeSheetHeader.Get(ToTimeSheetHeader."No.");
        FromTimeSheetHeader.SetCurrentKey("Resource No.", "Starting Date");
        FromTimeSheetHeader.SetRange("Resource No.", ToTimeSheetHeader."Resource No.");
        if FromTimeSheetHeader.Next(-1) <> 0 then begin
            FromTimeSheetLine.SetRange("Time Sheet No.", FromTimeSheetHeader."No.");
            FromTimeSheetLine.SetFilter(Type, '<>%1&<>%2', FromTimeSheetLine.Type::Service, FromTimeSheetLine.Type::"Assembly Order");
            if FromTimeSheetLine.FindSet() then
                repeat
                    IsHandled := false;
                    OnCopyPrevTimeSheetLinesOnBeforeCopyLine(FromTimeSheetLine, IsHandled);
                    if not IsHandled then begin
                        LineNo := LineNo + 10000;
                        ToTimeSheetLine.Init();
                        ToTimeSheetLine."Time Sheet No." := ToTimeSheetHeader."No.";
                        ToTimeSheetLine."Line No." := LineNo;
                        ToTimeSheetLine."Time Sheet Starting Date" := ToTimeSheetHeader."Starting Date";
                        ToTimeSheetLine.Type := FromTimeSheetLine.Type;
                        case ToTimeSheetLine.Type of
                            ToTimeSheetLine.Type::Job:
                                begin
                                    ToTimeSheetLine.Validate("Job No.", FromTimeSheetLine."Job No.");
                                    ToTimeSheetLine.Validate("Job Task No.", FromTimeSheetLine."Job Task No.");
                                end;
                            ToTimeSheetLine.Type::Absence:
                                ToTimeSheetLine.Validate("Cause of Absence Code", FromTimeSheetLine."Cause of Absence Code");
                        end;
                        ToTimeSheetLine.Description := FromTimeSheetLine.Description;
                        ToTimeSheetLine.Chargeable := FromTimeSheetLine.Chargeable;
                        ToTimeSheetLine."Work Type Code" := FromTimeSheetLine."Work Type Code";
                        OnBeforeToTimeSheetLineInsert(ToTimeSheetLine, FromTimeSheetLine);
                        ToTimeSheetLine.Insert();

#if not CLEAN22
                        if TimeSheetV2Enabled() then
#endif
                        CopyTimeSheetLineDetails(ToTimeSheetLine, FromTimeSheetLine);
                    end;
                until FromTimeSheetLine.Next() = 0;
        end;

        OnAfterCopyPrevTimeSheetLines();
    end;

    local procedure CopyTimeSheetLineDetails(ToTimeSheetLine: Record "Time Sheet Line"; FromTimeSheetLine: Record "Time Sheet Line")
    var
        ToTimeSheetDetail: Record "Time Sheet Detail";
        FromTimeSheetDetail: Record "Time Sheet Detail";
    begin
        FromTimeSheetDetail.SetRange("Time Sheet No.", FromTimeSheetLine."Time Sheet No.");
        FromTimeSheetDetail.SetRange("Time Sheet Line No.", FromTimeSheetLine."Line No.");
        if FromTimeSheetDetail.FindSet() then
            repeat
                ToTimeSheetDetail.Init();
                ToTimeSheetDetail.TransferFields(FromTimeSheetDetail);
                ToTimeSheetDetail."Time Sheet No." := ToTimeSheetLine."Time Sheet No.";
                ToTimeSheetDetail."Time Sheet Line No." := ToTimeSheetLine."Line No.";
                ToTimeSheetDetail.Date := ToTimeSheetLine."Time Sheet Starting Date" + (FromTimeSheetDetail."Date" - FromTimeSheetLine."Time Sheet Starting Date");
                ToTimeSheetDetail.Status := "Time Sheet Status"::Open;
                ToTimeSheetDetail.Posted := false;
                ToTimeSheetDetail."Posted Quantity" := 0;
                ToTimeSheetDetail.Insert();
            until FromTimeSheetDetail.Next() = 0;
    end;

    procedure CalcPrevTimeSheetLines(ToTimeSheetHeader: Record "Time Sheet Header") LinesQty: Integer
    var
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetLine: Record "Time Sheet Line";
    begin
        TimeSheetHeader.Get(ToTimeSheetHeader."No.");
        TimeSheetHeader.SetCurrentKey("Resource No.", "Starting Date");
        TimeSheetHeader.SetRange("Resource No.", ToTimeSheetHeader."Resource No.");
        if TimeSheetHeader.Next(-1) <> 0 then begin
            TimeSheetLine.SetRange("Time Sheet No.", TimeSheetHeader."No.");
            TimeSheetLine.SetFilter(Type, '<>%1&<>%2', TimeSheetLine.Type::Service, TimeSheetLine.Type::"Assembly Order");
            LinesQty := TimeSheetLine.Count();
        end;
    end;

    procedure CheckCreateLinesFromJobPlanning(TimeSheetHeader: Record "Time Sheet Header"): Integer
    var
        QtyToBeCreated: Integer;
    begin
        QtyToBeCreated := CalcLinesFromJobPlanning(TimeSheetHeader);
        if QtyToBeCreated = 0 then
            Message(JobPlanningLinesNotFoundErr)
        else
            if Confirm(CreateLinesQst, true, QtyToBeCreated) then
                exit(CreateLinesFromJobPlanning(TimeSheetHeader));
    end;

    procedure CreateLinesFromJobPlanning(TimeSheetHeader: Record "Time Sheet Header") CreatedLinesQty: Integer
    var
        TimeSheetLine: Record "Time Sheet Line";
        TempJobPlanningLine: Record "Job Planning Line" temporary;
        LineNo: Integer;
    begin
        LineNo := TimeSheetHeader.GetLastLineNo();

        FillJobPlanningBuffer(TimeSheetHeader, TempJobPlanningLine);

        TempJobPlanningLine.Reset();
        if TempJobPlanningLine.FindSet() then
            repeat
                LineNo := LineNo + 10000;
                CreatedLinesQty := CreatedLinesQty + 1;
                TimeSheetLine.Init();
                TimeSheetLine."Time Sheet No." := TimeSheetHeader."No.";
                TimeSheetLine."Line No." := LineNo;
                TimeSheetLine."Time Sheet Starting Date" := TimeSheetHeader."Starting Date";
                TimeSheetLine.Validate(Type, TimeSheetLine.Type::Job);
                TimeSheetLine.Validate("Job No.", TempJobPlanningLine."Job No.");
                TimeSheetLine.Validate("Job Task No.", TempJobPlanningLine."Job Task No.");
                OnCreateLinesFromJobPlanningOnBeforeTimeSheetLineInsert(TimeSheetLine, TempJobPlanningLine);
                TimeSheetLine.Insert();
            until TempJobPlanningLine.Next() = 0;
    end;

    procedure CalcLinesFromJobPlanning(TimeSheetHeader: Record "Time Sheet Header"): Integer
    var
        TempJobPlanningLine: Record "Job Planning Line" temporary;
    begin
        FillJobPlanningBuffer(TimeSheetHeader, TempJobPlanningLine);
        exit(TempJobPlanningLine.Count);
    end;

    local procedure FillJobPlanningBuffer(TimeSheetHeader: Record "Time Sheet Header"; var JobPlanningLineBuffer: Record "Job Planning Line")
    var
        JobPlanningLine: Record "Job Planning Line";
        SkipLine: Boolean;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeFillJobPlanningBuffer(JobPlanningLine, JobPlanningLineBuffer, TimeSheetHeader, IsHandled);
        if IsHandled then
            exit;

        JobPlanningLine.SetRange(Type, JobPlanningLine.Type::Resource);
        JobPlanningLine.SetRange("No.", TimeSheetHeader."Resource No.");
        JobPlanningLine.SetRange("Planning Date", TimeSheetHeader."Starting Date", TimeSheetHeader."Ending Date");
        if JobPlanningLine.FindSet() then
            repeat
                SkipLine := TimesheetLineWithJobPlanningLineExists(TimeSheetHeader, JobPlanningLine);
                if not SkipLine then
                    SkipLine := JobPlanningLineIsNotValidForTimesheetLine(JobPlanningLine);
                OnCheckInsertJobPlanningLine(JobPlanningLine, JobPlanningLineBuffer, SkipLine);
                if not SkipLine then begin
                    JobPlanningLineBuffer.SetRange("Job No.", JobPlanningLine."Job No.");
                    JobPlanningLineBuffer.SetRange("Job Task No.", JobPlanningLine."Job Task No.");
                    if JobPlanningLineBuffer.IsEmpty() then begin
                        JobPlanningLineBuffer."Job No." := JobPlanningLine."Job No.";
                        JobPlanningLineBuffer."Job Task No." := JobPlanningLine."Job Task No.";
                        OnFillJobPlanningBufferOnBeforeJobPlanningLineBufferInsert(JobPlanningLine, JobPlanningLineBuffer);
                        JobPlanningLineBuffer.Insert();
                    end;
                end;
            until JobPlanningLine.Next() = 0;
        JobPlanningLineBuffer.Reset();
    end;

    local procedure TimesheetLineWithJobPlanningLineExists(TimeSheetHeader: Record "Time Sheet Header"; JobPlanningLine: Record "Job Planning Line"): Boolean
    var
        TimeSheetLine: Record "Time Sheet Line";
    begin
        TimeSheetLine.SetRange("Time Sheet No.", TimeSheetHeader."No.");
        TimeSheetLine.SetRange(Type, TimeSheetLine.Type::Job);
        TimeSheetLine.SetRange("Job No.", JobPlanningLine."Job No.");
        TimeSheetLine.SetRange("Job Task No.", JobPlanningLine."Job Task No.");
        exit(not TimeSheetLine.IsEmpty());
    end;

    local procedure JobPlanningLineIsNotValidForTimesheetLine(JobPlanningLine: Record "Job Planning Line"): Boolean
    var
        Job: Record Job;
    begin
        if JobPlanningLine."Job No." = '' then
            exit(true);

        if not Job.Get(JobPlanningLine."Job No.") then
            exit(true);

        if (Job.Blocked = Job.Blocked::All) or (Job.Status = Job.Status::Completed) then
            exit(true);

        exit(false);
    end;

    procedure FindTimeSheet(var TimeSheetHeader: Record "Time Sheet Header"; Which: Option Prev,Next): Code[20]
    begin
        TimeSheetHeader.Reset();
        TimeSheetHeader.SetCurrentKey("Resource No.", "Starting Date");
        TimeSheetHeader.SetRange("Resource No.", TimeSheetHeader."Resource No.");
        case Which of
            Which::Prev:
                TimeSheetHeader.Next(-1);
            Which::Next:
                TimeSheetHeader.Next(1);
        end;
        exit(TimeSheetHeader."No.");
    end;

    procedure FindTimeSheetArchive(var TimeSheetHeaderArchive: Record "Time Sheet Header Archive"; Which: Option Prev,Next): Code[20]
    begin
        TimeSheetHeaderArchive.Reset();
        TimeSheetHeaderArchive.SetCurrentKey("Resource No.", "Starting Date");
        TimeSheetHeaderArchive.SetRange("Resource No.", TimeSheetHeaderArchive."Resource No.");
        OnFindTimeSheetArchiveOnAfterSetFilters(TimeSheetHeaderArchive);
        case Which of
            Which::Prev:
                TimeSheetHeaderArchive.Next(-1);
            Which::Next:
                TimeSheetHeaderArchive.Next(1);
        end;
        exit(TimeSheetHeaderArchive."No.");
    end;

    procedure GetDateFilter(StartingDate: Date; EndingDate: Date) DateFilter: Text[30]
    begin
        case true of
            (StartingDate <> 0D) and (EndingDate <> 0D):
                DateFilter := StrSubstNo('%1..%2', StartingDate, EndingDate);
            (StartingDate = 0D) and (EndingDate <> 0D):
                DateFilter := StrSubstNo('..%1', EndingDate);
            (StartingDate <> 0D) and (EndingDate = 0D):
                DateFilter := StrSubstNo('%1..', StartingDate);
        end;
    end;

    procedure CreateServDocLinesFromTS(ServiceHeader: Record "Service Header")
    var
        TimeSheetLine: Record "Time Sheet Line";
    begin
        CreateServLinesFromTS(ServiceHeader, TimeSheetLine, false);
    end;

    procedure CreateServDocLinesFromTSLine(ServiceHeader: Record "Service Header"; var TimeSheetLine: Record "Time Sheet Line")
    begin
        CreateServLinesFromTS(ServiceHeader, TimeSheetLine, true);
    end;

    local procedure GetFirstServiceItemNo(ServiceHeader: Record "Service Header"): Code[20]
    var
        ServiceItemLine: Record "Service Item Line";
    begin
        ServiceItemLine.SetRange("Document Type", ServiceHeader."Document Type");
        ServiceItemLine.SetRange("Document No.", ServiceHeader."No.");
        ServiceItemLine.FindFirst();
        exit(ServiceItemLine."Service Item No.");
    end;

    procedure CreateTSLineFromServiceLine(ServiceLine: Record "Service Line"; DocumentNo: Code[20]; Chargeable: Boolean)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCreateTSLineFromServiceLine(ServiceLine, IsHandled);
        if IsHandled then
            exit;

        with ServiceLine do
            if "Time Sheet No." = '' then
                CreateTSLineFromDocLine(
                  DATABASE::"Service Line", "No.", "Posting Date", DocumentNo, "Document No.", "Line No.",
                  "Work Type Code", Chargeable, Description, -"Qty. to Ship");
    end;

    procedure CreateTSLineFromServiceShptLine(ServiceShipmentLine: Record "Service Shipment Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCreateTSLineFromServiceShptLine(ServiceShipmentLine, IsHandled);
        if IsHandled then
            exit;

        with ServiceShipmentLine do
            if "Time Sheet No." = '' then
                CreateTSLineFromDocLine(
                  DATABASE::"Service Shipment Line", "No.", "Posting Date", "Document No.", "Order No.", "Order Line No.",
                  "Work Type Code", true, Description, -"Qty. Shipped Not Invoiced");
    end;

    local procedure CreateTSLineFromDocLine(TableID: Integer; ResourceNo: Code[20]; PostingDate: Date; DocumentNo: Code[20]; OrderNo: Code[20]; OrderLineNo: Integer; WorkTypeCode: Code[10]; Chargbl: Boolean; Desc: Text[100]; Quantity: Decimal)
    var
        Resource: Record Resource;
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetLine: Record "Time Sheet Line";
        TimeSheetDetail: Record "Time Sheet Detail";
        LineNo: Integer;
    begin
        Resource.Get(ResourceNo);
        if not Resource."Use Time Sheet" then
            exit;

        TimeSheetHeader.SetRange("Resource No.", Resource."No.");
        TimeSheetHeader.SetFilter("Starting Date", '..%1', PostingDate);
        TimeSheetHeader.SetFilter("Ending Date", '%1..', PostingDate);
        TimeSheetHeader.FindFirst();

        with TimeSheetLine do begin
            SetRange("Time Sheet No.", TimeSheetHeader."No.");
            if FindLast() then;
            LineNo := "Line No." + 10000;

            Init();
            "Time Sheet No." := TimeSheetHeader."No.";
            "Line No." := LineNo;
            "Time Sheet Starting Date" := TimeSheetHeader."Starting Date";
            case TableID of
                DATABASE::"Service Line",
                DATABASE::"Service Shipment Line":
                    begin
                        Type := Type::Service;
                        "Service Order No." := OrderNo;
                        "Service Order Line No." := OrderLineNo;
                    end;
                DATABASE::"Assembly Line":
                    begin
                        Type := Type::"Assembly Order";
                        "Assembly Order No." := OrderNo;
                        "Assembly Order Line No." := OrderLineNo;
                    end;
            end;
            Description := Desc;
            "Work Type Code" := WorkTypeCode;
            Chargeable := Chargbl;
            "Approver ID" := TimeSheetHeader."Approver User ID";
            "Approved By" := UserId;
            "Approval Date" := Today;
            Status := Status::Approved;
            Posted := true;
            Insert();

            TimeSheetDetail.Init();
            TimeSheetDetail.CopyFromTimeSheetLine(TimeSheetLine);
            TimeSheetDetail.Date := PostingDate;
            TimeSheetDetail.Quantity := Quantity;
            TimeSheetDetail."Posted Quantity" := Quantity;
            TimeSheetDetail.Posted := true;
            TimeSheetDetail.Insert();

            CreateTSPostingEntry(TimeSheetDetail, Quantity, PostingDate, DocumentNo, Description);
        end;
    end;

    procedure CreateTSLineFromAssemblyLine(AssemblyHeader: Record "Assembly Header"; AssemblyLine: Record "Assembly Line"; Qty: Decimal)
    begin
        AssemblyLine.TestField(Type, AssemblyLine.Type::Resource);

        with AssemblyLine do
            CreateTSLineFromDocLine(
              DATABASE::"Assembly Line",
              "No.",
              AssemblyHeader."Posting Date",
              AssemblyHeader."Posting No.",
              "Document No.",
              "Line No.",
              '',
              true,
              Description,
              Qty);
    end;

    procedure CreateTSPostingEntry(TimeSheetDetail: Record "Time Sheet Detail"; Qty: Decimal; PostingDate: Date; DocumentNo: Code[20]; Desc: Text[100])
    var
        TimeSheetPostingEntry: Record "Time Sheet Posting Entry";
    begin
        with TimeSheetPostingEntry do begin
            Init();
            "Time Sheet No." := TimeSheetDetail."Time Sheet No.";
            "Time Sheet Line No." := TimeSheetDetail."Time Sheet Line No.";
            "Time Sheet Date" := TimeSheetDetail.Date;
            Quantity := Qty;
            "Document No." := DocumentNo;
            "Posting Date" := PostingDate;
            Description := Desc;
            Insert();
        end;

        OnAfterCreateTSPostingEntry(TimeSheetDetail, TimeSheetPostingEntry);
    end;

    local procedure CheckTSLineDetailPosting(TimeSheetNo: Code[20]; TimeSheetLineNo: Integer; TimeSheetDate: Date; QtyToPost: Decimal; QtyPerUnitOfMeasure: Decimal; var MaxAvailableQty: Decimal): Boolean
    var
        TimeSheetDetail: Record "Time Sheet Detail";
        MaxAvailableQtyBase: Decimal;
    begin
        TimeSheetDetail.Get(TimeSheetNo, TimeSheetLineNo, TimeSheetDate);
        TimeSheetDetail.TestField(Status, TimeSheetDetail.Status::Approved);
        TimeSheetDetail.TestField(Posted, false);

        MaxAvailableQtyBase := TimeSheetDetail.GetMaxQtyToPost();
        MaxAvailableQty := MaxAvailableQtyBase * QtyPerUnitOfMeasure;
        exit(QtyToPost <= MaxAvailableQty);
    end;

    procedure CheckResJnlLine(ResJnlLine: Record "Res. Journal Line")
    var
        MaxAvailableQty: Decimal;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckResJnlLine(ResJnlLine, IsHandled);
        if IsHandled then
            exit;

        with ResJnlLine do begin
            TestField("Qty. per Unit of Measure");
            if not CheckTSLineDetailPosting(
                 "Time Sheet No.",
                 "Time Sheet Line No.",
                 "Time Sheet Date",
                 Quantity,
                 "Qty. per Unit of Measure",
                 MaxAvailableQty)
            then
                FieldError(Quantity, StrSubstNo(Text004, MaxAvailableQty, "Unit of Measure Code"));
        end;
    end;

    procedure CheckJobJnlLine(JobJnlLine: Record "Job Journal Line")
    var
        MaxAvailableQty: Decimal;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckJobJnlLine(JobJnlLine, IsHandled);
        if IsHandled then
            exit;

        with JobJnlLine do begin
            TestField("Qty. per Unit of Measure");
            if not CheckTSLineDetailPosting(
                 "Time Sheet No.",
                 "Time Sheet Line No.",
                 "Time Sheet Date",
                 Quantity,
                 "Qty. per Unit of Measure",
                 MaxAvailableQty)
            then
                FieldError(Quantity, StrSubstNo(Text004, MaxAvailableQty, "Unit of Measure Code"));
        end;
    end;

    procedure CheckServiceLine(ServiceLine: Record "Service Line")
    var
        MaxAvailableQty: Decimal;
    begin
        with ServiceLine do begin
            TestField("Qty. per Unit of Measure");
            if not CheckTSLineDetailPosting(
                 "Time Sheet No.",
                 "Time Sheet Line No.",
                 "Time Sheet Date",
                 "Qty. to Ship",
                 "Qty. per Unit of Measure",
                 MaxAvailableQty)
            then
                FieldError(Quantity, StrSubstNo(Text004, MaxAvailableQty, "Unit of Measure Code"));
        end;
    end;

    procedure CopyFilteredTimeSheetLinesToBuffer(var TimeSheetLineFrom: Record "Time Sheet Line"; var TimeSheetLineTo: Record "Time Sheet Line")
    begin
        if TimeSheetLineFrom.FindSet() then
            repeat
                TimeSheetLineTo := TimeSheetLineFrom;
                TimeSheetLineTo.Insert();
            until TimeSheetLineFrom.Next() = 0;
    end;

    procedure UpdateTimeAllocation(TimeSheetLine: Record "Time Sheet Line"; AllocatedQty: array[32] of Decimal)
    var
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetDetail: Record "Time Sheet Detail";
        TimeSheetDate: Date;
        i: Integer;
    begin
        with TimeSheetLine do begin
            TimeSheetHeader.Get("Time Sheet No.");
            for i := 1 to 7 do begin
                TimeSheetDate := TimeSheetHeader."Starting Date" + i - 1;
                if AllocatedQty[i] <> 0 then begin
                    if TimeSheetDetail.Get("Time Sheet No.", "Line No.", TimeSheetDate) then begin
                        TimeSheetDetail.Quantity := AllocatedQty[i];
                        TimeSheetDetail."Posted Quantity" := TimeSheetDetail.Quantity;
                        TimeSheetDetail.Modify();
                    end else begin
                        TimeSheetDetail.Init();
                        TimeSheetDetail.CopyFromTimeSheetLine(TimeSheetLine);
                        TimeSheetDetail.Posted := true;
                        TimeSheetDetail.Date := TimeSheetDate;
                        TimeSheetDetail.Quantity := AllocatedQty[i];
                        TimeSheetDetail."Posted Quantity" := TimeSheetDetail.Quantity;
                        TimeSheetDetail.Insert();
                    end;
                end else
                    if TimeSheetDetail.Get("Time Sheet No.", "Line No.", TimeSheetDate) then
                        TimeSheetDetail.Delete();
            end;
        end;
    end;

    procedure GetActivityInfo(TimeSheetLine: Record "Time Sheet Line"; var ActivityCaption: Text[30]; var ActivityID: Code[20]; var ActivitySubCaption: Text[30]; var ActivitySubID: Code[20])
    begin
        ActivitySubCaption := '';
        ActivitySubID := '';
        ActivityCaption := '';
        ActivityID := '';
        with TimeSheetLine do
            case Type of
                Type::Job:
                    begin
                        ActivityCaption := FieldCaption("Job No.");
                        ActivityID := "Job No.";
                        ActivitySubCaption := FieldCaption("Job Task No.");
                        ActivitySubID := "Job Task No.";
                    end;
                Type::Absence:
                    begin
                        ActivityCaption := FieldCaption("Cause of Absence Code");
                        ActivityID := "Cause of Absence Code";
                    end;
                Type::"Assembly Order":
                    begin
                        ActivityCaption := FieldCaption("Assembly Order No.");
                        ActivityID := "Assembly Order No.";
                    end;
                Type::Service:
                    begin
                        ActivityCaption := FieldCaption("Service Order No.");
                        ActivityID := "Service Order No.";
                    end;
                else
                    OnGetActivityInfoCaseTypeElse(TimeSheetLine, ActivitySubCaption, ActivitySubID, ActivityCaption, ActivityID);
            end;

        OnAfterGetActivityInfo(TimeSheetLine, ActivitySubCaption, ActivitySubID, ActivityCaption, ActivityID);
    end;

    procedure ShowPostingEntries(TimeSheetNo: Code[20]; TimeSheetLineNo: Integer)
    var
        TimeSheetPostingEntry: Record "Time Sheet Posting Entry";
        TimeSheetPostingEntries: Page "Time Sheet Posting Entries";
    begin
        TimeSheetPostingEntry.FilterGroup(2);
        TimeSheetPostingEntry.SetRange("Time Sheet No.", TimeSheetNo);
        TimeSheetPostingEntry.SetRange("Time Sheet Line No.", TimeSheetLineNo);
        TimeSheetPostingEntry.FilterGroup(0);
        Clear(TimeSheetPostingEntries);
        TimeSheetPostingEntries.SetTableView(TimeSheetPostingEntry);
        TimeSheetPostingEntries.RunModal();
    end;

    procedure FindNearestTimeSheetStartDate(Date: Date): Date
    var
        ResourcesSetup: Record "Resources Setup";
    begin
        ResourcesSetup.Get();
        if Date2DWY(Date, 1) = ResourcesSetup."Time Sheet First Weekday" + 1 then
            exit(Date);

        exit(CalcDate(StrSubstNo('<WD%1>', ResourcesSetup."Time Sheet First Weekday" + 1), Date));
    end;

    local procedure CreateServLinesFromTS(ServiceHeader: Record "Service Header"; var TimeSheetLine: Record "Time Sheet Line"; AddBySelectedTimesheetLine: Boolean)
    var
        TimeSheetDetail: Record "Time Sheet Detail";
        TempTimeSheetDetail: Record "Time Sheet Detail" temporary;
        ServiceLine: Record "Service Line";
        LineNo: Integer;
    begin
        ServiceLine.SetRange("Document Type", ServiceHeader."Document Type");
        ServiceLine.SetRange("Document No.", ServiceHeader."No.");
        if ServiceLine.FindLast() then;
        LineNo := ServiceLine."Line No." + 10000;

        ServiceLine.SetFilter("Time Sheet No.", '<>%1', '');
        if ServiceLine.FindSet() then
            repeat
                if not TempTimeSheetDetail.Get(
                     ServiceLine."Time Sheet No.",
                     ServiceLine."Time Sheet Line No.",
                     ServiceLine."Time Sheet Date")
                then
                    if TimeSheetDetail.Get(
                         ServiceLine."Time Sheet No.",
                         ServiceLine."Time Sheet Line No.",
                         ServiceLine."Time Sheet Date")
                    then begin
                        TempTimeSheetDetail := TimeSheetDetail;
                        TempTimeSheetDetail.Insert();
                    end;
            until ServiceLine.Next() = 0;

        TimeSheetDetail.SetRange("Service Order No.", ServiceHeader."No.");
        TimeSheetDetail.SetRange(Status, TimeSheetDetail.Status::Approved);
        if AddBySelectedTimesheetLine = true then begin
            TimeSheetDetail.SetRange("Time Sheet No.", TimeSheetLine."Time Sheet No.");
            TimeSheetDetail.SetRange("Time Sheet Line No.", TimeSheetLine."Line No.");
        end;
        TimeSheetDetail.SetRange(Posted, false);
        if TimeSheetDetail.FindSet() then
            repeat
                if not TempTimeSheetDetail.Get(
                     TimeSheetDetail."Time Sheet No.",
                     TimeSheetDetail."Time Sheet Line No.",
                     TimeSheetDetail.Date)
                then begin
                    AddServLinesFromTSDetail(ServiceHeader, TimeSheetDetail, LineNo);
                    LineNo := LineNo + 10000;
                end;
            until TimeSheetDetail.Next() = 0;
    end;

    local procedure AddServLinesFromTSDetail(ServiceHeader: Record "Service Header"; var TimeSheetDetail: Record "Time Sheet Detail"; LineNo: Integer)
    var
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetLine: Record "Time Sheet Line";
        ServiceLine: Record "Service Line";
        QtyToPost: Decimal;
        IsHandled: Boolean;
    begin
        OnBeforeAddServLinesFromTSDetail(ServiceHeader, TimeSheetDetail, LineNo, IsHandled);
        if IsHandled then
            exit;

        QtyToPost := TimeSheetDetail.GetMaxQtyToPost();
        if QtyToPost <> 0 then begin
            ServiceLine.Init();
            ServiceLine."Document Type" := ServiceHeader."Document Type";
            ServiceLine."Document No." := ServiceHeader."No.";
            ServiceLine."Line No." := LineNo;
            ServiceLine.Validate("Service Item No.", GetFirstServiceItemNo(ServiceHeader));
            ServiceLine."Time Sheet No." := TimeSheetDetail."Time Sheet No.";
            ServiceLine."Time Sheet Line No." := TimeSheetDetail."Time Sheet Line No.";
            ServiceLine."Time Sheet Date" := TimeSheetDetail.Date;
            ServiceLine.Type := ServiceLine.Type::Resource;
            TimeSheetHeader.Get(TimeSheetDetail."Time Sheet No.");
            ServiceLine.Validate("No.", TimeSheetHeader."Resource No.");
            ServiceLine.Validate(Quantity, TimeSheetDetail.Quantity);
            TimeSheetLine.Get(TimeSheetDetail."Time Sheet No.", TimeSheetDetail."Time Sheet Line No.");
            if not TimeSheetLine.Chargeable then
                ServiceLine.Validate("Qty. to Consume", QtyToPost);
            ServiceLine."Planned Delivery Date" := TimeSheetDetail.Date;
            ServiceLine.Validate("Work Type Code", TimeSheetLine."Work Type Code");
            ServiceLine.Insert();
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalcActSchedFactBoxData(var TimeSheetHeader: Record "Time Sheet Header"; var TotalQtyText: Text; var TotalPresenceQty: Decimal; var AbsenceQty: Decimal);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreateTSPostingEntry(TimeSheetDetail: Record "Time Sheet Detail"; var TimeSheetPostingEntry: Record "Time Sheet Posting Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyPrevTimeSheetLines()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFilterAllLines(var TimeSheetLine: Record "Time Sheet Line"; ActionType: Option Submit,ReopenSubmitted,Approve,ReopenApproved,Reject)
    begin
    end;

#if not CLEAN22
    [Obsolete('Remove old time sheet experience.', '22.0')]
    [IntegrationEvent(false, false)]
    local procedure OnAfterTimeSheetV2Enabled(var Result: Boolean)
    begin
    end;
#endif

    [IntegrationEvent(false, false)]
    local procedure OnCalcStatusFactBoxDataOnAfterTimeSheetHeaderSetFilters(var TimeSheetHeader: Record "Time Sheet Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCalcActSchedFactBoxDataOnAfterTimeSheetHeaderSetFilters(var TimeSheetHeader: Record "Time Sheet Header"; Calendar: Record Date)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCalcActSchedFactBoxDataOnBeforeResouceCalcFields(var Resource: Record Resource; Calendar: Record Date)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCheckInsertJobPlanningLine(JobPlanningLine: Record "Job Planning Line"; var JobPlanningLineBuffer: Record "Job Planning Line"; var SkipLine: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCopyPrevTimeSheetLinesOnBeforeCopyLine(var TimeSheetLine: Record "Time Sheet Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckJobJnlLine(var JobJnlLine: Record "Job Journal Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckResJnlLine(ResJournalLine: Record "Res. Journal Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateTSLineFromServiceLine(var ServiceLine: Record "Service Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateTSLineFromServiceShptLine(var ServiceShipmentLine: Record "Service Shipment Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFillJobPlanningBuffer(var JobPlanningLine: Record "Job Planning Line"; var JobPlanningLineBuffer: Record "Job Planning Line"; TimeSheetHeader: Record "Time Sheet Header"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFilterTimeSheets(var TimeSheetHeader: Record "Time Sheet Header"; FieldNo: Integer; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeToTimeSheetLineInsert(var ToTimeSheetLine: Record "Time Sheet Line"; FromTimeSheetLine: Record "Time Sheet Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateLinesFromJobPlanningOnBeforeTimeSheetLineInsert(var TimeSheetLine: Record "Time Sheet Line"; var JobPlanningLine: Record "Job Planning Line");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetActivityInfo(var TimeSheetLine: Record "Time Sheet Line"; var ActivityCaption: Text[30]; var ActivityID: Code[20]; var ActivitySubCaption: Text[30]; var ActivitySubID: Code[20]);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnFillJobPlanningBufferOnBeforeJobPlanningLineBufferInsert(JobPlanningLine: Record "Job Planning Line"; var JobPlanningLineBuffer: Record "Job Planning Line" temporary);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnFindTimeSheetArchiveOnAfterSetFilters(var TimeSheetHeaderArchive: Record "Time Sheet Header Archive")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnGetActivityInfoCaseTypeElse(var TimeSheetLine: Record "Time Sheet Line"; var ActivityCaption: Text[30]; var ActivityID: Code[20]; var ActivitySubCaption: Text[30]; var ActivitySubID: Code[20]);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAddServLinesFromTSDetail(ServiceHeader: Record "Service Header"; var TimeSheetDetail: Record "Time Sheet Detail"; LineNo: Integer; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCalcActSchedFactBoxDataOnAfterSetDateDescription(TimeSheetHeader: Record "Time Sheet Header"; Calendar: Record Date; var DateDescriptionForSpecificDate: Text[30]);
    begin
    end;
}


