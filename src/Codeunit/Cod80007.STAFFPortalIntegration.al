Codeunit 80007 "STAFFPortalIntegration"
{

    trigger OnRun()
    begin
        //fnApproval('REQ0019');
        //MESSAGE(fnJournalLines('EMP1', 'BNK0001'));
        //MESSAGE(fnGetNoticeBoard());
        //MESSAGE(fnGetEmployeeDetails('0202'));//
        //MESSAGE(fnUploadedDocuments2('CDOSD'));

        //MESSAGE(FORMAT(CheckLeaveDaysAvailable('SICK','0202')));
        //fnTimesheetApproval('TMS_0002');
    end;

    var
        Vehicleheader: Record "Vehicle Requisition";
        TimesheetLinesHeader: Record TimesheetLines;
        TETimeSheet1: Record "TE Time Sheet1";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        TimesheetRec: Variant;
        GlBudget: Record "G/L Budget Entry";
        HREmployees: Record "HR Employees";
        objPayrollEmployee: Record "Payroll Employee_AU";
        GenLedgerSetup: Record "Purchases & Payables Setup";
        objHRLeaveApplication: Record "HR Leave Application";
        objHRSetup: Record "HR Setup";
        objNumSeries: Codeunit NoSeriesManagement;
        objHREmployees: Record "HR Employees";
        objUsers: Record "User Setup";
        ApprovalMgt: Codeunit 1535;
        objCustomer: Record Customer;
        ObjApprovalEntries: Record "Approval Entry";
        HelbDesk: Record "General Equiries.";
        CUApprovalMgt: Codeunit 1535;
        ObjPrPeriods: Record "Payroll Calender_AU";
        ObjHRLeaveTypes: Record "HR Leave Types";
        BaseCalendarChange: Record "Base Calendar Change";
        ObjImprestLines: Record "Purchase Line";
        RecPay: Record "Payment Terms";
        objHREmployees2: Record "HR Employees";
        PortalDocuments: Record 50035;
        filename: Text;
        FILESPATH: label 'D:\Data\AU\Self Service NG\mmmSelfservice\Downloads\';

        FP: label 'E:\Payslips\';
        counter: Integer;
        SalCard: Record "Payroll Employee_AU";
        BaseCalendar: Record "Base Calendar Change";
        UserSetup: Record "User Setup";
        GeneralOptions: Record "HR Setup";
        variantrec: Variant;
        //newtonsoft : JsonObject;
        JSONTextWriter: dotnet JsonTextWriter;
        JSON: dotnet String;
        StringWriter: dotnet StringWriter;
        StringBuilder: DotNet StringBuilder;
        AssignmentMatrix: Record "Payroll Transaction Code_AU";
        encrypt01: Codeunit 80011;
        FilePath: DotNet Path;

        ecnryptedpassword: Text;
        purchaseheader: Record "Purchase Header";
        PurchaseQuote: Record "Purchase Quote Header";
        purchaseline: Record "Purchase Line";
        dimensionvalues: Record "Dimension Value";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        TrainingRequests: Record "Training Requests";
        hrsetup: Record "HR Setup";
        ApprovalsMgt1: Codeunit "Custom Approvals Codeunit";
        ApprovalMgt1: Codeunit "Custom Approvals Codeunit";
        documents: Record "Company Documents";
        attachments: Record Attachment;
        attachments2: Record Attachment;
        documents2: Record "Company Documents";
        inttemplate: Record "Interaction Tmpl. Language";
        FName: dotnet String;
        Seperator: dotnet String;
        //Values: dotnet Array;
        Values: DotNet Array;
        Value: Text;
        Fileset: array[2] of Text;
        ObjImprestRequisition: Record "Purchase Header";
        Trainingscehdule: Record "Training Schedule";
        currencycodes: Record Currency;
        purchaseheader2: Record "Purchase Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        p9report: Record "Payroll Employee P9_AU";
        notice: Record "Notice Board";
        approvalentries: Record "Approval Entry";
        hrdocuments: Record "HR Documents";
        //smtpsetup: Record "SMTP Mail Setup";
        //smtp: Codeunit "SMTP Mail";
        EmailMessage: Codeunit "Email Message";
        SendEmail: Codeunit Email;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        PurchaseLine6: Record "Purchase Line";
        PayrollEmployeeP9_AU6: Record "Payroll Employee P9_AU";
        NNo: Code[10];
        p9: Report P9Report;
        ChangeExchangeRate: Page "Change Exchange Rate";
        CurrExchRate: Record "Currency Exchange Rate";
        HREmployees6: Record "HR Employees";
        TimesheetHeader: Record "TE Time Sheet1";
        TimesheetHeaderNew: Record 170123;
        TimesheetLinesNew: Record 170124;
        TimeSheetLines: Record TimesheetLines;
        MileageHeader: Record MileageHeader;
        MileageLines: Record MileageLines;
        lJsonArray: DotNet JArray;
        lJObject: dotnet JObject;
        lArrayString: Text;
        lJSONString: Text;
        CompanyInformation: Record "Company Information";
        PortalUploads: Record "SharePoint Intergration";

    procedure LOGIN(username: Code[50]; password: Text): Boolean
    var
        hrEmployee: record "HR Employees";
        authenticated: Boolean;
    begin
        authenticated := false;
        hrEmployee.reset;
        hrEmployee.SetRange("No.", username);
        hrEmployee.SetRange("Portal Password", password);
        hrEmployee.SetRange("Changed Password", true);
        if hrEmployee.FindFirst() then authenticated := true;
        exit(authenticated);

    end;

    procedure REGISTER(username: Code[50]; email: Text; idno: code[20]): Boolean
    //TODO: Create a better otp management for registering new users
    VAR
        hrEmployee: record "HR Employees";
        otp: Text;
        rand: Text;
    begin
        otp := '';
        hrEmployee.Reset;
        hrEmployee.SetRange("No.", username);
        hrEmployee.SetRange(hrEmployee."E-Mail", email);
        hrEmployee.SetRange("ID Number", idno);
        if hrEmployee.FindFirst then begin
            rand := Format(Random(99999));
            hrEmployee."Portal Password" := rand;
            hrEmployee.Modify(true);
            exit(SENDEMAILs(email, 'Your O.T.P is ' + Format(rand)));

        end else
            exit(false);

    end;

    procedure SENDEMAILs(email: text; message: Text): Boolean;
    var
        smtp: Codeunit Email;
        smtpsetup: Codeunit "Email Message";
    begin

        smtpsetup.Create(email, 'Self service portal communication', message);
        smtp.Send(smtpsetup);

        exit(true);
    end;

    procedure CONFIRMREGISTRATION(username: Code[50]; otp: Text; password: Text): Boolean
    var
        hremployee: record "HR Employees";
        confirmed: Boolean;
    begin
        confirmed := false;
        hremployee.Reset();
        hremployee.SetRange("No.", username);
        hremployee.SetRange("Portal Password", otp);
        if hremployee.FindFirst() then begin
            hremployee."Portal Password" := password;
            hremployee."Changed Password" := true;
            hremployee.Modify(true);
            confirmed := true;
        end;
        exit(confirmed);
    end;


    procedure FnImprestRequisitionCreate("Employee No": Code[100]; "Date Required": Date; "Dept Code": Code[100]; Description: Text; ResponsibilityCenter: Code[100]; BankAccount: Code[100])
    begin
        /*ObjImprestRequisition.INIT;
        GenLedgerSetup.RESET;
        GenLedgerSetup.GET();
        
        ObjImprestRequisition."No.":=objNumSeries.GetNextNo(GenLedgerSetup."Impretst Nos",0D,TRUE);
        ObjImprestRequisition."No. Series":=GenLedgerSetup."Imprest Nos";s
        d
        ObjImprestRequisition."Employee No":="Employee No";
        IF objHREmployees.GET("Employee No") THENsfFnInstImrSrNew
        
          BEGIN
            ObjImprestRequisition.Cashier:=objHREmployees."User ID";
            IF UserSetup.GET(objHREmployees."User ID")THEN BEGIN
            UserSetup.TESTFIELD(UserSetup."Staff Travel Account");
            ObjImprestRequisition."Account Type":=ObjImprestRequisition."Account Type"::Customer;
            ObjImprestRequisition."Account No.":=UserSetup."Staff Travel Account";
            ObjImprestRequisition.VALIDATE("Account No.");
            END ELSE
            ERROR('User must be setup under User Setup and their respective Account Entered');
          END;
        ObjImprestRequisition.Date:=TODAY;
        ObjImprestRequisition."Shortcut Dimension 2 Code":="Dept Code";
        ObjImprestRequisition.VALIDATE(ObjImprestRequisition."Shortcut Dimension 2 Code");
        ObjImprestRequisition.Purpose:=Description;
        ObjImprestRequisition.Status:=ObjImprestRequisition.Status::Pending;
        ObjImprestRequisition.Cashier:=fnGetUser("Employee No");
        ObjImprestRequisition."Global Dimension 1 Code":='NAIROBI';
        ObjImprestRequisition.VALIDATE(ObjImprestRequisition."Global Dimension 1 Code");
        ObjImprestRequisition."Responsibility Center":=ResponsibilityCenter;
        ObjImprestRequisition.VALIDATE(ObjImprestRequisition."Employee No");
        ObjImprestRequisition."Pay Mode Code":=BankAccount;
        ObjImprestRequisition.VALIDATE(ObjImprestRequisition."Pay Mode Code");
        ObjImprestRequisition.INSERT;
        
        
        */

    end;

    local procedure fnGetUser(EmployeeNo: Code[100]) empUserId: Text
    begin
        objHREmployees.Reset;
        objHREmployees.SetRange(objHREmployees."No.", EmployeeNo);
        if objHREmployees.Find('-') then begin
            empUserId := objHREmployees."User ID";
        end;
        exit(empUserId);
    end;

    procedure FnCheckOpenLeave(EmployeeNo: Code[100]) foundopen: boolean
    var
        NextLeaveApplicationNo: Code[100];
        EndDate: Date;
        ReturnDate: Date;
        SenderComments: Text;
        ResponsibilityCenter: Code[100];
    begin
        foundopen := false;

        objHRLeaveApplication.Reset;
        objHRLeaveApplication.SetRange(objHRLeaveApplication."Employee No", EmployeeNo);
        objHRLeaveApplication.SetRange(objHRLeaveApplication.Status, objHRLeaveApplication.Status::New);
        if objHRLeaveApplication.Find('-') then begin
            foundopen := true;
        end;
        exit(foundopen);
    end;

    procedure FnLeaveApplication(EmployeeNo: Code[100]; LeaveType: Code[100]; AppliedDays: Decimal; StartDate: Date; Reliever: Code[100]; pendingtasks: Text; Reimbursed: Boolean)
    var
        NextLeaveApplicationNo: Code[100];
        EndDate: Date;
        ReturnDate: Date;
        SenderComments: Text;
        ResponsibilityCenter: Code[100];
    begin
        objHRSetup.Get();
        objHRLeaveApplication.Reset;
        objHRLeaveApplication.SetRange(objHRLeaveApplication."Employee No", EmployeeNo);
        objHRLeaveApplication.SetRange(objHRLeaveApplication.Status, objHRLeaveApplication.Status::New);
        if objHRLeaveApplication.Find('-') then begin
            Error('Kindly utilize existing new leave application no %1 before raising new leave', objHRLeaveApplication."Application Code");

        end else begin
            objHRLeaveApplication.Init;
            if AppliedDays < 1 then begin
                // IF AppliedDays=0 THEN AppliedDays:=0.5;
                ReturnDate := StartDate;
                EndDate := StartDate;
            end else begin
                FnValidateStartDate(StartDate);
                //NextLeaveApplicationNo:=objNumSeries.GetNextNo(objHRSetup."Leave Application Nos.",0D,TRUE);
                //ReturnDate := DetermineLeaveReturnDate(StartDate, AppliedDays, LeaveType);
                //EndDate := CalcEndDate(StartDate, AppliedDays, LeaveType);
            end;
            NextLeaveApplicationNo := objNumSeries.GetNextNo(objHRSetup."Leave Application Nos.", 0D, true);
            objHREmployees.Reset;
            objHREmployees.SetRange("No.", EmployeeNo);
            if objHREmployees.Find('-')
            then begin
                ResponsibilityCenter := objHREmployees."Responsibility Center";
                objHRLeaveApplication."User ID" := objHREmployees."User ID";
                objHRLeaveApplication."Application Code" := NextLeaveApplicationNo;
                objHRLeaveApplication."Employee No" := EmployeeNo;
                objHRLeaveApplication.Insert;
                //Commit();
                objHRLeaveApplication.Names := objHREmployees."First Name" + '  ' + objHREmployees."Middle Name";
                //objHRLeaveApplication."Department Code":=objHREmployees."Department Code";
                objHRLeaveApplication."E-mail Address" := objHREmployees."Company E-Mail";
                //objHRLeaveApplication.INSERT;
                // objHRLeaveApplication."Application Code":= NextLeaveApplicationNo;
                objHRLeaveApplication."Leave Type" := LeaveType;
                if LeaveType = 'CTO' then begin
                    if Reimbursed = true then begin
                        objHRLeaveApplication."Is reimbursement" := True;
                    end

                end;
                objHRLeaveApplication."Days Applied" := AppliedDays;
                objHRLeaveApplication.Validate(objHRLeaveApplication."Days Applied");
                objHRLeaveApplication."Application Date" := Today;
                objHRLeaveApplication."No series" := 'LEAVE';
                objHRLeaveApplication."Start Date" := StartDate;
                objHRLeaveApplication.Validate("Start Date");
                // //objHRLeaveApplication."Return Date" := ReturnDate;
                // //objHRLeaveApplication."End Date" := EndDate;
                objHRLeaveApplication."Responsibility Center" := ResponsibilityCenter;
                objHRLeaveApplication.Reliever := Reliever;
                objHRLeaveApplication.Validate(objHRLeaveApplication.Reliever);
                objHRLeaveApplication.Description := SenderComments;
                objHRLeaveApplication.Validate("Employee No");
                objHRLeaveApplication."Pending Tasks" := pendingtasks;
                objHRLeaveApplication."Supervisor" := objHREmployees."Supervisor ID";
                objHRLeaveApplication."Branch Code" := objHREmployees."Global Dimension 1 Code";
                objHRLeaveApplication.Modify(true);
                Commit();
            end;
        end;
    end;

    procedure DetermineLeaveReturnDate(fBeginDate: Date; fDays: Decimal; "Leave Type": Code[100]) fReturnDate: Date
    var
        varDaysApplied: Decimal;
    begin
        ObjHRLeaveTypes.Reset;
        ObjHRLeaveTypes.SetRange(Code, "Leave Type");
        if ObjHRLeaveTypes.Find('-') then begin
            varDaysApplied := fDays;
            fReturnDate := fBeginDate;
            if fDays < 1 then begin
                fReturnDate := fBeginDate;

            end;

            repeat

                if fDays >= 1 then begin

                    if DetermineIfIncludesNonWorking("Leave Type") = false then begin
                        fReturnDate := CalcDate('1D', fReturnDate);
                        if DetermineIfIsNonWorking(fReturnDate, ObjHRLeaveTypes) then
                            varDaysApplied := varDaysApplied + 1
                        else
                            varDaysApplied := varDaysApplied;
                        varDaysApplied := varDaysApplied - 1
                    end
                    else begin
                        fReturnDate := CalcDate('1D', fReturnDate);
                        varDaysApplied := varDaysApplied - 1;
                    end;
                end;
            until varDaysApplied = 0;
        end;
        exit(fReturnDate);
    end;

    procedure DetermineLeaveReturnDate1(fBeginDate: Date; fDays: Decimal; "Leave Type": Code[100]) fReturnDate: Date
    var
        varDaysApplied: Decimal;
    begin
        ObjHRLeaveTypes.Reset;
        ObjHRLeaveTypes.SetRange(Code, "Leave Type");
        if ObjHRLeaveTypes.Find('-') then begin
            varDaysApplied := fDays;
            fReturnDate := fBeginDate;
            repeat
                if DetermineIfIncludesNonWorking("Leave Type") = false then begin
                    fReturnDate := CalcDate('1D', fReturnDate);
                    if DetermineIfIsNonWorking(fReturnDate, ObjHRLeaveTypes) then
                        varDaysApplied := varDaysApplied + 1
                    else
                        varDaysApplied := varDaysApplied;
                    varDaysApplied := varDaysApplied - 1
                end
                else begin
                    fReturnDate := CalcDate('1D', fReturnDate);
                    varDaysApplied := varDaysApplied - 1;
                end;
            until varDaysApplied = 0;
        end;
        exit(fReturnDate);
    end;

    local procedure DetermineIfIncludesNonWorking(fLeaveCode: Code[100]): Boolean
    begin
        if ObjHRLeaveTypes.Get(fLeaveCode) then begin
            if ObjHRLeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
        end;
    end;

    local procedure DetermineIfIsNonWorking2(bcDate: Date; var ltype: Record "HR Leave Types") ItsNonWorking: Boolean
    var
        dates: Record Date;
        HREmp: Record "HR Employees";
    begin
        /*BaseCalendarChange.SETFILTER(BaseCalendarChange."Base Calendar Code",objHRSetup."Base Calendar");
        BaseCalendarChange.SETRANGE(BaseCalendafrChange.Date,bcDate);
        
        IF BaseCalendarChange.FIND('-') THEN BEGIN
        IF BaseCalendarChange.Nonworking = FALSE THEN
        ERROR('Start date can only be a Working Day Date');
        EXIT(TRUE);
        END;*/
        Clear(ItsNonWorking);
        GeneralOptions.Find('-');
        //One off Hollidays like Good Friday

        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar.Date, bcDate);
        if BaseCalendar.Find('-') then begin
            HREmployees.Reset();
            HREmployees.SetRange("Branch Code", BaseCalendar."Base Calendar Code");
            if HREmployees.find('-') then begin
                if BaseCalendar.Nonworking = true then
                    ItsNonWorking := true;
            end;
        end;

        // For Annual Holidays

        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."recurring system"::"Annual Recurring");
        if BaseCalendar.Find('-') then begin
            repeat
                HREmployees.Reset();
                HREmployees.SetRange("Branch Code", BaseCalendar."Base Calendar Code");
                if HREmployees.find('-') then begin
                    if ((Date2dmy(bcDate, 1) = BaseCalendar.Day)) then begin
                        if BaseCalendar.Nonworking = true then
                            ItsNonWorking := true;
                    end;
                end;
            until BaseCalendar.Next = 0;
        end;


        if ItsNonWorking = false then begin
            // Check if its a weekend
            dates.Reset;
            dates.SetRange(dates."Period Type", dates."period type"::Date);
            dates.SetRange(dates."Period Start", bcDate);
            if dates.Find('-') then begin
                //if date is a sunday
                if dates."Period Name" = 'Sunday' then begin
                    //check if Leave includes sunday
                    if ltype."Inclusive of Sunday" = false then ItsNonWorking := true;
                end else
                    if dates."Period Name" = 'Saturday' then begin
                        //check if Leave includes sato
                        if ltype."Inclusive of Saturday" = false then ItsNonWorking := true;
                    end;

            end;
        end;

    end;
    //end;

    procedure DetermineIfIsNonWorking(var bcDate: Date; var ltype: Record "HR Leave Types") ItsNonWorking: Boolean
    var
        dates: Record Date;
    begin
        Clear(ItsNonWorking);
        GeneralOptions.Find('-');
        //One off Hollidays like Good Friday
        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar.Date, bcDate);
        if BaseCalendar.Find('-') then begin
            if BaseCalendar.Nonworking = true then
                ItsNonWorking := true;
        end;

        // For Annual Holidays
        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."recurring system"::"Annual Recurring");
        if BaseCalendar.Find('-') then begin
            repeat
                //IF ((DATE2DMY(bcDate,1)=BaseCalendar."Date Day") AND (DATE2DMY(bcDate,2)=BaseCalendar."Date Month")) THEN BEGIN
                if bcDate = BaseCalendar.Date then begin
                    if BaseCalendar.Nonworking = true then
                        ItsNonWorking := true;
                end;
            until BaseCalendar.Next = 0;
        end;

        if ItsNonWorking = false then begin
            // Check if its a weekend
            dates.Reset;
            dates.SetRange(dates."Period Type", dates."period type"::Date);
            dates.SetRange(dates."Period Start", bcDate);
            if dates.Find('-') then begin
                //if date is a sunday
                if dates."Period Name" = 'Sunday' then begin
                    //check if Leave includes sunday
                    if ltype."Inclusive of Sunday" = false then ItsNonWorking := true;
                end else
                    if dates."Period Name" = 'Saturday' then begin
                        //check if Leave includes sato
                        if ltype."Inclusive of Saturday" = false then ItsNonWorking := true;
                    end;
            end;
        end;
    end;

    procedure CalcEndDate(SDate: Date; LDays: Decimal; varLType: Code[100]) LEndDate: Date
    var
        EndLeave: Boolean;
        DayCount: Decimal;
        ltype: Record "HR Leave Types";
        dates: Record Date;
    begin

        if LDays < 1 then begin

            LEndDate := sdate;
        end;
        if LDays >= 1 then begin
            if ltype.Get(varLType) then begin
                SDate := SDate;
                DayCount := LDays;
                EndLeave := false;
                while EndLeave = false do begin
                    if not DetermineIfIsNonWorking(SDate, ltype) then begin
                        DayCount := DayCount - 1;
                        SDate := SDate + 1;
                    end
                    else
                        SDate := SDate + 1;
                    if DayCount = 0 then
                        EndLeave := true;
                end;
                LEndDate := SDate - 1;

                while DetermineIfIsNonWorking(LEndDate, ltype) = true do begin
                    LEndDate := LEndDate + 1;
                end;
            end;

        end;

    end;



    procedure CalcEndDate1(SDate: Date; LDays: Decimal; varLType: Code[100]) LEndDate: Date
    var
        EndLeave: Boolean;
        DayCount: Decimal;
        ltype: Record "HR Leave Types";
    begin
        /*ltype.RESET;
        IF ltype.GET(varLType) THEN BEGIN
        END;
        SDate:=SDate-1;
        EndLeave:=FALSE;
        WHILE EndLeave=FALSE DO
        BEGIN
          IF NOT DetermineIfIsNonWorking(SDate) THEN
          DayCount:=DayCount+1;
          SDate:=SDate+1;
          IF DayCount>LDays THEN
          EndLeave:=TRUE;
        END;
        LEndDate:=SDate-1;
        WHILE DetermineIfIsNonWorking(LEndDate)=TRUE
        DO
        BEGIN
        LEndDate:=LEndDate+1;
        END;*/
        if ltype.Get(varLType) then begin
            SDate := SDate - 1;
            DayCount := LDays;
            EndLeave := false;
            while EndLeave = false do begin
                if not DetermineIfIsNonWorking(SDate, ltype) then begin
                    DayCount := DayCount + 1;
                    SDate := SDate + 1;
                end
                else
                    SDate := SDate + 1;
                if DayCount = 0 then
                    EndLeave := true;
            end;
            LEndDate := SDate + 1;



            while DetermineIfIsNonWorking(LEndDate, ltype) = true do begin
                LEndDate := LEndDate + 1;
            end;
        end;

    end;


    procedure FnValidateStartDate("Start Date": Date)
    var
        BaseCalendar: Record "Base Calendar Change";
    begin
        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", objHRSetup."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar.Date, "Start Date");
        if BaseCalendar.Find('-') then begin
            repeat
                if BaseCalendar.Nonworking = true then begin
                    if BaseCalendar.Description <> '' then
                        Error('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                    else
                        Error('You can not start your Leave on a Holiday');
                end;
            until BaseCalendar.Next = 0;
        end;

        // For Annual Holidays
        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", objHRSetup."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."recurring system"::"Annual Recurring");
        if BaseCalendar.Find('-') then begin
            repeat
                if ((Date2dmy("Start Date", 1) = BaseCalendar.Day)) then begin
                    if BaseCalendar.Nonworking = true then begin
                        if BaseCalendar.Description <> '' then
                            Error('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                        else
                            Error('You can not start your Leave on a Holiday');
                    end;
                end;
            until BaseCalendar.Next = 0;
        end;

        //IF "Start Date"<TODAY THEN
        //ERROR('You cannot Start your leave before the application date');
    end;


    procedure FnImprestRequisitionLinesCreate(ImprestNo: Code[100]; ItemCode: Code[100]; ItemAmount: Decimal)
    begin
        /*ObjImprestLines.RESET;
        ObjImprestLines.SETRANGE(No,ImprestNo);
        ObjImprestLines.SETRANGE("Advance Type",ItemCode);
        IF ObjImprestLines.FIND('-') THEN
          ObjImprestLines.DELETE;
        ObjImprestLines.INIT;
        ObjImprestLines.No:=ImprestNo;
        ObjImprestLines."Advance Type":=ItemCode;
        RecPay.RESET;
        RecPay.SETRANGE(RecPay.Code,ItemCode);
        RecPay.SETRANGE(RecPay.Type,RecPay.Type::Imprest);
        IF RecPay.FIND('-') THEN BEGIN
          ObjImprestLines."Account No:":=RecPay."G/L Account";
          ObjImprestLines."Account Name":=RecPay.Description;
        END;
         ObjImprestLines.Amount:=ItemAmount;
         ObjImprestLines.VALIDATE(Amount);
        ObjImprestLines.INSERT(TRUE);
        */

    end;


    procedure FnImprestRequsitionRemoveLine(ImprestNo: Code[100]; ItemCode: Code[100])
    begin
        /*s
        ObjImprestLines.RESET;
        ObjImprestLines.SETRANGE(No,ImprestNo);
        ObjImprestLines.SETRANGE("Advance Type",ItemCode);
        IF ObjImprestLines.FIND('-') THEN
          ObjImprestLines.DELETE;
        */

    end;

    procedure fnLeaveApprovalRequest(LeaveApplicationCode: Code[50])
    begin
        objHRLeaveApplication.Reset;
        objHRLeaveApplication.SetRange(objHRLeaveApplication."Application Code", LeaveApplicationCode);
        if objHRLeaveApplication.Find('-') then begin
            if objHRLeaveApplication.Status = objHRLeaveApplication.Status::New then begin
                variantrec := objHRLeaveApplication;
                if ApprovalMgt1.CheckApprovalsWorkflowEnabled(variantrec) then
                    ApprovalMgt1.OnSendDocForApproval(variantrec);
            end;
        end;
    end;

    procedure fnImprestApprovalRequest(ImprestNo: Code[50])
    begin
        /*ObjImprestRequisition.RESET;
        ObjImprestRequisition.SETRANGE(ObjImprestRequisition."No.",ImprestNo);
        IF ObjImprestRequisition.FIND('-') THEN
          BEGIN
            IF ObjImprestRequisition.Status=ObjImprestRequisition.Status::Pending THEN
              BEGIN
                IF ApprovalMgt2.chec(ObjImprestRequisition) THEN
                ApprovalMgt2.OnSendImprestApplicationForApproval(ObjImprestRequisition);
                END;
          END;
        
          */

    end;


    procedure FnTransportRequisitionCreate(RequestingUser: Code[100]; DRequired: Date; Reasons: Text; Destination: Code[100]; Duration: Code[100]; GDim1: Code[100]; GDim2: Code[100]; RequestingOfficer: Code[100]; PassengerCount: Integer; responsibilityCenter: Code[100])
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        /*Setup.GET;
          Setup.TESTFIELD(Setup."Transport Requisition");
        ObjTransportRequisition.INIT;
        ObjTransportRequisition."No. Series":='TREQ';
        ObjTransportRequisition."Task Order No":=NoSeriesMgt.GetNextNo(Setup."Transport Requisition",0D,TRUE);
        ObjTransportRequisition."User ID":=RequestingUser;
        ObjTransportRequisition."Date Requested":=TODAY;
        ObjTransportRequisition."Date Required":=DRequired;
        ObjTransportRequisition.Reasons:=Reasons;
        ObjTransportRequisition.Destination:=Destination;
        ObjTransportRequisition.Duration:=Duration;
        ObjTransportRequisition."Global Dimension 1 Code":=GDim1;
        ObjTransportRequisition."Global Dimension 2 Code":=GDim2;
        ObjTransportRequisition."Responsibility Centre":=responsibilityCenter;
        objCustomer.RESET;
        objCustomer.SETRANGE("Hr Emp No",RequestingOfficer);
        IF objCustomer.FIND('-') THEN
        ObjTransportRequisition."Officer Requeting":=objCustomer."No.";
        ObjTransportRequisition.VALIDATE(ObjTransportRequisition."Officer Requeting");
        ObjTransportRequisition.INSERT;//(TRUE);
        */

    end;


    procedure fnTransportApprovalRequest(TaskNo: Code[50])
    begin
        /*ObjTransportRequisition.RESET;
        ObjTransportRequisition.SETRANGE(ObjTransportRequisition."Task Order No",TaskNo);
        IF ObjTransportRequisition.FIND('-') THEN
          BEGIN
            IF ObjTransportRequisition.Status=ObjTransportRequisition.Status::Open THEN
              BEGIN
                IF ApprovalMgt.IsTransportRequisitionApprovalsWorkflowEnabled(ObjTransportRequisition) THEN BEGIN
                   ApprovalMgt.OnSendTransportRequisitionForApproval(ObjTransportRequisition)
                  END
                END;
          END;
          */

    end;


    procedure fnAppraisalHeaderCreate(EmployeeNo: Code[100])
    begin
        /*objAppraisalHeader.INIT;
        objAppraisalHeader."Employee No":=EmployeeNo;
        objAppraisalHeader."Appraisal Date":=TODAY;
        IF objHREmployees.GET(EmployeeNo) THEN
          BEGIN
            objAppraisalHeader."Employee Name":=objHREmployees."First Name" + ' ' + objHREmployees."Middle Name" + ' ' + objHREmployees."Last Name";
            objAppraisalHeader."Date of Employment":=objHREmployees."Date Of Joining the Company";
            objAppraisalHeader."Global Dimension 1 Code":=objHREmployees."Global Dimension 1 Code";
            objAppraisalHeader."Global Dimension 2 Code":=objHREmployees."Global Dimension 2 Code";
            objAppraisalHeader."Job Title":=objHREmployees."Job Specification";
            objAppraisalHeader."Contract Type":= objHREmployees."Contract Type" ;
            objAppraisalHeader."User ID":=objHREmployees."User ID";
            objAppraisalHeader."Supervisor ID":=objHREmployees."Supervisor ID";
            objHREmployees2.RESET;
            objHREmployees2.SETRANGE("User ID",objHREmployees."Supervisor ID");
            IF objHREmployees2.FIND('-') THEN
              objAppraisalHeader.Supervisor:=objHREmployees2."No.";
            objAppraisalHeader.VALIDATE(Supervisor);
            objAppraisalHeader."Appraisal Stage":=objAppraisalHeader."Appraisal Stage"::"Target Setting";
          END;
        
        HRLookUpValues.RESET;
        HRLookUpValues.SETRANGE(HRLookUpValues.Type,HRLookUpValues.Type::"Appraisal Period");
        HRLookUpValues.SETRANGE(HRLookUpValues.Closed,FALSE);
        IF HRLookUpValues.FIND('-') THEN BEGIN
          objAppraisalHeader."Appraisal Period":=HRLookUpValues.Code;
          objAppraisalHeader."Appraisal Stage":=HRLookUpValues."Appraisal Stage";
          objAppraisalHeader."Evaluation Period Start":=HRLookUpValues.From;
          objAppraisalHeader."Evaluation Period End":=HRLookUpValues."To";
        END
        ELSE
        BEGIN
            ERROR('There are no open Appraisal Periods, Please define one in HR Lookup Values');
        END;
        objAppraisalHeader.INSERT(TRUE);
        */

    end;


    procedure fnAppraisalLinesTargetSetting(AppraisalNo: Code[100])
    var
        LastLineNo: Integer;
        AppraisalPeriod: Code[100];
        EmployeeNo: Code[100];
    begin
        /*objAppraisalHeader.RESET;
        objAppraisalHeader.SETRANGE("Appraisal No",AppraisalNo);
        IF objAppraisalHeader.FIND('-') THEN
        BEGIN
          AppraisalPeriod:=objAppraisalHeader."Appraisal Period";
          EmployeeNo:=objAppraisalHeader."Employee No";
        END;
        
        objHRAppraisalLines.RESET;
        objHRAppraisalLines.SETRANGE("Appraisal No",AppraisalNo);
        IF objHRAppraisalLines.FIND('-') THEN
          objHRAppraisalLines.DELETEALL;
        
        REPEAT
          //Get last no.
          objHRAppraisalLines2.RESET;
          IF objHRAppraisalLines2.FIND('+') THEN
          BEGIN
              LastLineNo:=objHRAppraisalLines2."Line No";
          END ELSE
          BEGIN
              LastLineNo:=1;
          END;
        
          objHRAppraisalLines.INIT;
          objHRAppraisalLines."Line No":=LastLineNo+1;
          objHRAppraisalLines."Appraisal No":=AppraisalNo;
          objHRAppraisalLines."Appraisal Period":=AppraisalPeriod;
          objHRAppraisalLines."Employee No":=EmployeeNo;
          objHRAppraisalLines."Categorize As":=HRAppEvalAreas."Categorize As";
          objHRAppraisalLines."Sub Category":=HRAppEvalAreas."Sub Category";
          objHRAppraisalLines."Perfomance Goals and Targets":=HRAppEvalAreas.Description;
          objHRAppraisalLines.INSERT;
        UNTIL HRAppEvalAreas.NEXT=0;
        */

    end;

    procedure fnGetPayslip(No: Code[20]; PayPeriod: Date; VAR BigText: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        PaySlipReport: Report 50099;
        PayslipMalawi: Report 50050;
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        objHREmployees.Reset;
        objHREmployees.SetRange(objHREmployees."No.", No);
        if objHREmployees.Find('-') then begin
            SalCard.Reset;
            SalCard.SetRange(SalCard."No.", objHREmployees."No.");
            SalCard.SetRange(SalCard."Current Month Filter", PayPeriod);
            if SalCard.Find('-') then begin

                if SalCard."Global Dimension 1" = 'KENYA' then begin
                    PaySlipReport.SetTableView(SalCard);
                    TempBlob.CreateOutStream(StatementOutstream);
                    if PaySlipReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                        TempBlob.CreateInStream(StatementInstream);
                        BigText := Base64Convert.ToBase64(StatementInstream, true);
                    end;
                end else
                    if SalCard."Global Dimension 1" = 'MALAWI' then begin

                        PayslipMalawi.SetTableView(SalCard);
                        TempBlob.CreateOutStream(StatementOutstream);
                        if PayslipMalawi.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                            TempBlob.CreateInStream(StatementInstream);
                            BigText := Base64Convert.ToBase64(StatementInstream, true);
                        end;
                    end;
            end;



        end;
    end;

    procedure fnGetPayslipss("Employee No": Code[20]; PayPeriod: Date; var BigText: BigText)
    var
        objPREmployee: Record "HR Employees";
        Filename: Text[100];
        Convert: dotnet Convert;
        _File: dotnet File;
        FileAccess: dotnet FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
    begin
        //day := DATE2DMY(PayPeriod,2); month := DATE2DMY(PayPeriod,1); year := DATE2DMY(PayPeriod,3);
        Filename := '';
        _File.Delete(Filename);
        objHREmployees.Reset;
        objHREmployees.SetRange(objHREmployees."No.", "Employee No");
        if objHREmployees.Find('-') then
            SalCard.Reset;
        SalCard.SetRange(SalCard."No.", "Employee No");
        SalCard.SetFilter(SalCard."Period Filter", Format(PayPeriod));
        if SalCard.Find('-') then begin
            Report.SaveAsPdf(80011, Filename, SalCard);
            // FileMode := 4;
            // FileAccess := 1;

            // FileStream := _File.Open(Filename, FileMode, FileAccess);

            // MemoryStream := MemoryStream.MemoryStream();

            // MemoryStream.SetLength(FileStream.Length);
            // FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

            // BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
            // MemoryStream.Close();
            // MemoryStream.Dispose();
            // FileStream.Close();
            // FileStream.Dispose();
            // //MESSAGE(FORMAT(Path));

        end;

    end;

    procedure FnImprestRequisitionUpdate("Employee No": Code[100]; "Date Required": Date; "Dept Code": Code[100]; Description: Text; ResponsibilityCenter: Code[100]; DocNo: Code[100])
    begin
        /*ObjImprestRequisition.RESET;
        GenLedgerSetup.RESET;
        GenLedgerSetup.GET();
        ObjImprestRequisition.SETRANGE(ObjImprestRequisition."No.",DocNo);
        IF ObjImprestRequisition.FIND('-') THEN
          BEGIN
            ObjImprestRequisition.Date:=TODAY;
            ObjImprestRequisition."Shortcut Dimension 2 Code":="Dept Code";
            ObjImprestRequisition.VALIDATE(ObjImprestRequisition."Shortcut Dimension 2 Code");
            ObjImprestRequisition.Purpose:=Description;
            ObjImprestRequisition.Status:=objHRLeaveApplication.Status::New;
            ObjImprestRequisition.Cashier:=fnGetUser("Employee No");
            ObjImprestRequisition."Global Dimension 1 Code":='NAIROBI';
            ObjImprestRequisition.VALIDATE(ObjImprestRequisition."Global Dimension 1 Code");
            ObjImprestRequisition."Responsibility Center":=ResponsibilityCenter;
            ObjImprestRequisition.VALIDATE(ObjImprestRequisition."Employee No");
            ObjImprestRequisition.MODIFY;
          END;
          */

    end;


    procedure FnImprestSurrenderCreate("Employee No": Code[100]; ImprestDocNumber: Code[100])
    begin
        /*ObjImprestRequisition.RESET;
        ObjImprestRequisition.SETRANGE("No.",ImprestDocNumber);
        IF ObjImprestRequisition.FIND('-') THEN
          BEGIN
        ObjImprestRequisition.CALCFIELDS("Total Net Amount");
        ObjImprestSurrender.INIT;
        GenLedgerSetup.RESET;
        GenLedgerSetup.GET();
        
        ObjImprestSurrender.No:=objNumSeries.GetNextNo(GenLedgerSetup."Imprest Surrender Nos",0D,TRUE);
        ObjImprestSurrender."No. Series":=GenLedgerSetup."Imprest Surrender Nos";
        ObjImprestSurrender."Employee No":="Employee No";
        ObjImprestSurrender."Surrender Date":=TODAY;
        ObjImprestSurrender.Amount:=ObjImprestRequisition."Total Net Amount";
        ObjImprestSurrender."Shortcut Dimension 2 Code":=ObjImprestRequisition."Shortcut Dimension 2 Code";
        ObjImprestSurrender.VALIDATE(ObjImprestSurrender."Shortcut Dimension 2 Code");
        ObjImprestSurrender."Imprest Issue Doc. No":=ImprestDocNumber;
        ObjImprestSurrender."Account No.":=ObjImprestRequisition."Account No.";
        ObjImprestSurrender.Status:=ObjImprestSurrender.Status::Pending;
        ObjImprestSurrender.Cashier:=fnGetUser("Employee No");
        ObjImprestSurrender."Global Dimension 1 Code":='NAIROBI';
        ObjImprestSurrender.VALIDATE(ObjImprestSurrender."Global Dimension 1 Code");
        ObjImprestSurrender."Responsibility Center":=ObjImprestRequisition."Responsibility Center";
        ObjImprestSurrender.VALIDATE(ObjImprestSurrender."Employee No");
        ObjImprestSurrender.INSERT;
        END;
        */

    end;


    procedure fnGetLeaveDocument(ApplicationNo: Code[20]; var BigText: BigText)
    var
        objPREmployee: Record "HR Employees";
        Filename: Text[100];
        Convert: dotnet Convert;
        Path: dotnet Path;
        _File: dotnet File;
        FileAccess: dotnet FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
    begin
        Filename := Path.GetTempPath() + Path.GetRandomFileName();
        objHRLeaveApplication.Reset;
        objHRLeaveApplication.SetRange(objHRLeaveApplication."Application Code", ApplicationNo);
        if objHRLeaveApplication.Find('-') then begin
            Report.SaveAsPdf(51516139, Filename, objHRLeaveApplication);
            FileMode := 4;
            FileAccess := 1;
            FileStream := _File.Open(Filename, FileMode, FileAccess);
            MemoryStream := MemoryStream.MemoryStream();
            MemoryStream.SetLength(FileStream.Length);
            FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);
            BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
            MemoryStream.Close();
            MemoryStream.Dispose();
            FileStream.Close();
            FileStream.Dispose();
            _File.Delete(Filename);
        end;
    end;


    procedure fnGetImprestDocument(ApplicationNo: Code[20]; var BigText: BigText)
    var
        objPREmployee: Record "HR Employees";
        Filename: Text[100];
        Convert: dotnet Convert;
        Path: dotnet Path;
        _File: dotnet File;
        FileAccess: dotnet FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
    begin
        /*Filename:=Path.GetTempPath()+Path.GetRandomFileName();
        ObjImprestRequisition.RESET;
        ObjImprestRequisition.SETRANGE(ObjImprestRequisition."No.",ApplicationNo);
        IF ObjImprestRequisition.FIND('-') THEN
        BEGIN
          REPORT.SAVEASPDF(51516132,Filename,ObjImprestRequisition);
          FileMode:=4;
          FileAccess:=1;
          FileStream:=_File.Open(Filename,FileMode,FileAccess);
          MemoryStream:=MemoryStream.MemoryStream();
          MemoryStream.SetLength(FileStream.Length);
          FileStream.Read(MemoryStream.GetBuffer(),0,FileStream.Length);
          BigText.ADDTEXT((Convert.ToBase64String(MemoryStream.GetBuffer())));
          MemoryStream.Close();
          MemoryStream.Dispose();
          FileStream.Close();
          FileStream.Dispose();
          _File.Delete(Filename);
        END;
        */

    end;

    procedure FnApproveRecords(DocumentNumber: Code[50]; ApproverId: Code[100])
    var
        ApprovalNotificationSetup: Record "Approval Notification Setup";
    begin
        objHRLeaveApplication.Reset();
        objHRLeaveApplication.SetRange("Application Code", DocumentNumber);
        if objHRLeaveApplication.Find('-') then begin

            objHRLeaveApplication."Approved days" := objHRLeaveApplication."Days Applied";
            objHRLeaveApplication.Modify();
        end;
        HREmployees.Reset();
        HREmployees.SetRange("No.", ApproverId);
        if HREmployees.Find('-') then
            ObjApprovalEntries.Reset;
        ObjApprovalEntries.SetRange(ObjApprovalEntries."Approver ID", HREmployees."Employee UserID");
        ObjApprovalEntries.SetRange(ObjApprovalEntries."Document No.", DocumentNumber);
        ObjApprovalEntries.SetRange(ObjApprovalEntries.Status, ObjApprovalEntries.Status::Open);
        if ObjApprovalEntries.FindFirst() then begin
            CUApprovalMgt.ApproveApprovalRequests(ObjApprovalEntries);
        end;
        ObjApprovalEntries.Reset;
        ObjApprovalEntries.SetRange(ObjApprovalEntries."Document No.", DocumentNumber);
        ObjApprovalEntries.SetRange(ObjApprovalEntries.Status, ObjApprovalEntries.Status::Open);
        if ObjApprovalEntries.FindFirst() then begin
            ApprovalNotificationsetup.Reset();
            ApprovalNotificationsetup.SetRange("Document No", ObjApprovalEntries."Document No.");
            ApprovalNotificationSetup.SetRange("Approver ID", ObjApprovalEntries."Approver ID");
            if ApprovalNotificationSetup.Find('-') then begin

                ApprovalNotificationSetup.Status := ObjApprovalEntries.Status;
                ApprovalNotificationsetup.Modify();
                // Message('rr Status %1', ApprovalNotificationSetup.Status);
            end;
        end;
    end;

    procedure fnLeaveCancelApprovalRequest(LeaveApplicationCode: Code[50])
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        objHRLeaveApplication.Reset;
        objHRLeaveApplication.SetRange(objHRLeaveApplication."Application Code", LeaveApplicationCode);
        if objHRLeaveApplication.Find('-') then begin
            if objHRLeaveApplication.Status = objHRLeaveApplication.Status::"Pending Approval" then begin
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Document No.", LeaveApplicationCode);
                if ApprovalEntry.FindSet then begin
                    repeat
                        ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                        ApprovalEntry.Modify;
                    until ApprovalEntry.Next = 0;
                end;
                objHRLeaveApplication.Status := objHRLeaveApplication.Status::New;
                objHRLeaveApplication.Modify;

            end;
        end;
    end;

    procedure fnImprestCancelApprovalRequest(ImprestNo: Code[50])
    begin
        /*ObjImprestRequisition.RESET;
        ObjImprestRequisition.SETRANGE(ObjImprestRequisition."No.",ImprestNo);
        IF ObjImprestRequisition.FIND('-') THEN
          BEGIN
            IF ObjImprestRequisition.Status=ObjImprestRequisition.Status::"Pending Approval" THEN
              BEGIN
                IF ApprovalMgt.IsImprestApplicationApprovalsWorkflowEnabled(ObjImprestRequisition) THEN
                ApprovalMgt.OnCancelImprestApplicationApprovalRequest(ObjImprestRequisition);
                END;
          END;
          */

    end;

    procedure fnRejectApprovalRequest1(DocumentNumber: Code[50]; ApproverId: Code[100]; comments: Text)
    variancerec: Variant;
    begin
        objHREmployees.Reset();
        objHREmployees.SetRange("No.", ApproverId);
        if objHREmployees.Find('-') then begin
            ObjApprovalEntries.Reset;
            ObjApprovalEntries.SetRange(ObjApprovalEntries."Approver ID", objHREmployees."Employee UserID");
            ObjApprovalEntries.SetRange(ObjApprovalEntries."Document No.", DocumentNumber);
            ObjApprovalEntries.SetRange(ObjApprovalEntries.Status, ObjApprovalEntries.Status::Open);
            if ObjApprovalEntries.FindLast then begin
                ObjApprovalEntries.Comments := comments;
                ObjApprovalEntries.Modify;
                variancerec := ObjApprovalEntries;
                //CUApprovalMgt.RejectApprovalRequests(ObjApprovalEntries);
                ApprovalsMgt1.OnCancelDocApprovalRequest(variancerec);
            end;
        end;
    end;


    procedure fnImprestSurrenderApproval(ImpNo: Code[20]; Request: Boolean)
    begin
        /*Imprest.RESET;
        Imprest.SETRANGE(No, ImpNo);
        IF Imprest.FIND('-') THEN BEGIN
          IF Request=TRUE THEN BEGIN
          IF ApprovalMgt.CheckImprestSurrenderApprovalsWorkflowEnabled(Imprest) THEN
           ApprovalMgt.OnSendImprestSurrenderForApproval(Imprest);
          END
          ELSE IF Request=FALSE THEN BEGIN
         IF ApprovalMgt.CheckImprestSurrenderApprovalsWorkflowEnabled(Imprest) THEN
           ApprovalMgt.OnCancelImprestSurrenderApprovalRequest(Imprest);
          END;
        
        END;
        */

    end;

    procedure FnInserImprest(Impno: Code[20]; Cashier2: Code[30])
    begin
        /*Imprest.INIT;
        //Imprest.No:='';
        Imprest.VALIDATE(No);
        Imprest."Imprest Issue Doc. No":=Impno;
        Imprest.Cashier:=Cashier2;
        Imprest.VALIDATE(Cashier);
        //Imprest.VALIDATE("Imprest Issue Doc. No");
        Imprest.INSERT(TRUE);
        Imprest.VALIDATE("Imprest Issue Doc. No");
        Imprest.MODIFY;
        */

    end;


    procedure SurrenderDetails(SurrNo: Code[20]; Actualspent: Decimal; Receipt: Text; Cash: Decimal; AmountL: Decimal)
    begin
        /*Surrender.RESET;
        Surrender.SETRANGE("Surrender Doc No.", SurrNo);
        Surrender.SETRANGE(Amount, AmountL);
        IF Surrender.FIND('-') THEN BEGIN
          Surrender."Actual Spent":=Actualspent;
          Surrender."Cash Receipt No":=Receipt;
          Surrender."Cash Receipt Amount":=Cash;
         // Surrender.VALIDATE("Actual Spent");
          Surrender.MODIFY;
          END;
        */

    end;


    procedure KAhawa(DocNo: Code[20])
    begin
        /*tblKahawa.RESET;
        tblKahawa.SETRANGE("Document No", DocNo);
        IF tblKahawa.FIND('-') THEN BEGIN
          tblKahawa.Status:=0;
          tblKahawa."Sent To Server":=0;
          tblKahawa.MODIFY;
          END;
          */

    end;

    procedure UpdateLeave(LeaveNo: Code[30]; Leavetype: Code[40]; Applieddays: Decimal; Startdate: Date; Enddate: Date; returndate: Date; sendercomments: Text; relieverno: Code[30]; responsibilitycenter: Code[40])
    begin
    end;


    procedure fnGetImprestSurrenderDocument(ApplicationNo: Code[20]; var BigText: BigText)
    var
        objPREmployee: Record "HR Employees";
        Filename: Text[100];
        Convert: dotnet Convert;
        Path: dotnet Path;
        _File: dotnet File;
        FileAccess: dotnet FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
    begin
        /*Filename:=Path.GetTempPath()+Path.GetRandomFileName();
        ObjImprestSurrender.RESET;
        ObjImprestSurrender.SETRANGE(ObjImprestSurrender.No,ApplicationNo);
        IF ObjImprestSurrender.FIND('-') THEN
        BEGIN
          REPORT.SAVEASPDF(51516134,Filename,ObjImprestSurrender);
          FileMode:=4;
          FileAccess:=1;
          FileStream:=_File.Open(Filename,FileMode,FileAccess);
          MemoryStream:=MemoryStream.MemoryStream();
          MemoryStream.SetLength(FileStream.Length);
          FileStream.Read(MemoryStream.GetBuffer(),0,FileStream.Length);
          BigText.ADDTEXT((Convert.ToBase64String(MemoryStream.GetBuffer())));
          MemoryStream.Close();
          MemoryStream.Dispose();
          FileStream.Close();
          FileStream.Dispose();
          _File.Delete(Filename);
        END;
        */

    end;


    procedure CheckLeaveDaysAvailable(LeaveType: Text; EmpNo: Code[100]) DaysAvailable: Decimal
    begin

        HREmployees.Reset;
        HREmployees.SetRange("No.", EmpNo);
        if HREmployees.Find('-') then begin
            if (LeaveType = 'ANNUAL') then
                HREmployees.CalcFields(HREmployees."Annual Leave Account");
            DaysAvailable := HREmployees."Annual Leave Account";
        end else
            if (LeaveType = 'COMPASSIONATE') then begin
                HREmployees.CalcFields(HREmployees."Compassionate Leave Acc.");
                DaysAvailable := HREmployees."Compassionate Leave Acc.";
            end else
                if (LeaveType = 'MATERNITY') then begin
                    HREmployees.CalcFields(HREmployees."Maternity Leave Acc.");
                    DaysAvailable := HREmployees."Maternity Leave Acc.";
                end else
                    if (LeaveType = 'PATERNITY') then begin
                        HREmployees.CalcFields(HREmployees."Paternity Leave Acc.");
                        DaysAvailable := HREmployees."Paternity Leave Acc.";
                    end else
                        if (LeaveType = 'SICK') then begin
                            HREmployees.CalcFields(HREmployees."Sick Leave Acc.");
                            DaysAvailable := HREmployees."Sick Leave Acc.";
                        end else
                            if (LeaveType = 'CTO') then begin
                                HREmployees.CalcFields(HREmployees."CTO  Leave Acc.");
                                DaysAvailable := HREmployees."CTO  Leave Acc.";

                                //END;
                            end;
    end;

    local procedure CreateJsonAttribute(Attributename: Text; Value: Variant)
    begin
        JSONTextWriter.WritePropertyName(Attributename);
        JSONTextWriter.WriteValue(Format(Value));
    end;

    procedure fnGetEmployeeDetails(EmployeeNo: Code[30]) returnout: Text
    var
        JsonOut: dotnet String;
        picture: BigText;

        noticeobj: JsonObject;
        noticearr: JsonArray;

        detailjson: JsonObject;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);

        JSONTextWriter.WriteStartObject;
        HREmployees.Reset();
        HREmployees.SetRange("No.", EmployeeNo);
        if HREmployees.Find('-') then begin
            HREmployees.CalcFields("Total Leave Taken", "Reimbursed Leave Days", "Allocated Leave Days", "Annual Leave Account", "Compassionate Leave Acc.");
            HREmployees.CalcFields("Maternity Leave Acc.", "Paternity Leave Acc.", "Sick Leave Acc.", "Study Leave Acc", "CTO  Leave Acc.");

            detailjson.add('No', HREmployees."No.");
            detailjson.add('FirstName', HREmployees."First Name");
            detailjson.add('LastName', HREmployees."Last Name");
            detailjson.add('IdNumber', HREmployees."ID Number");
            detailjson.add('Department', HREmployees."Department Name");
            detailjson.add('JobId', HREmployees."Job Title");
            detailjson.add('EmailAddress', HREmployees."E-Mail");
            detailjson.add('officialAddress', HREmployees."E-Mail");

            detailjson.add('MobilePhone', HREmployees."Cellular Phone Number");
            detailjson.add('TotalLeavedays', HREmployees."Total (Leave Days)");
            detailjson.add('LeavedaysAllocated', HREmployees."Allocated Leave Days");
            detailjson.add('LeaveDaysreimbursed', HREmployees."Reimbursed Leave Days");
            detailjson.add('LeavedaysTaken', HREmployees."Total Leave Taken");
            detailjson.add('LeaveBalance', HREmployees."Annual Leave Account");

            detailjson.add('annualLeaveAcc', HREmployees."Annual Leave Account");
            detailjson.add('compasionateLeaveAcc', HREmployees."Compassionate Leave Acc.");
            detailjson.add('sickLeaveAcc', HREmployees."Sick Leave Acc.");
            detailjson.add('paternityLeaveAcc', HREmployees."Paternity Leave Acc.");
            detailjson.add('studyLeaveAcc', HREmployees."Study Leave Acc");
            detailjson.add('maternityLeaveAcc', HREmployees."Maternity Leave Acc.");
            detailjson.add('Cto', HREmployees."CTO  Leave Acc.");
            if hrsetup.Get() then begin
                fnAppreciation(picture);
                //detailjson.add('picture', picture);
                detailjson.add('title', hrsetup."Appreciation Title");
                detailjson.add('summary', hrsetup."Appreciation Narration");
                detailjson.add('name', '');
            end;
            Clear(noticearr);
            notice.reset();
            if notice.findset() then begin
                repeat
                    Clear(noticeobj);
                    noticeobj.add('text', notice.Announcement);
                    noticeobj.add('department', notice."Department Announcing");
                    noticeobj.add('date', notice."Date of Announcement");
                    noticearr.add(noticeobj);
                until notice.next() = 0;
            end;

            detailjson.add('notices1', format(noticearr));

            // JSONTextWriter.WritePropertyName('notices1');
            // JSONTextWriter.WriteValue(Format(fnGetNoticeBoard()));

            // MESSAGE(fnGetNoticeBoard());
            CreateJsonAttribute('picture', picture);
        end;
        JSONTextWriter.WriteEndObject;
        JsonOut := StringBuilder.ToString;
        returnout := Format(detailjson);
    end;

    procedure fnGetPaymentInformation(No: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);

        JSONTextWriter.WriteStartObject;

        if objPayrollEmployee.Get(No) then begin
            CreateJsonAttribute('BankAccount', objPayrollEmployee."Bank Account No");
            CreateJsonAttribute('KRAPin', objPayrollEmployee."PIN No");
            CreateJsonAttribute('Nhif', objPayrollEmployee."NHIF No");
            CreateJsonAttribute('Nssf', objPayrollEmployee."NSSF No");
            CreateJsonAttribute('BankBranch', objPayrollEmployee."Branch Name");
            CreateJsonAttribute('hourlyPay', ROUND(objPayrollEmployee."Hourly Rate", 0.01, '>'));
            CreateJsonAttribute('MonthlyRate', 0);
        end;
        JSONTextWriter.WriteEndObject;
        JsonOut := StringBuilder.ToString;
        returnout := Format(JsonOut);
    end;

    procedure fnGetSummaryPayment(No: Code[60]; payPeriod: Text) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);


        if objPayrollEmployee.Get(No) then begin
            //objPayrollEmployee.SETFILTER("Period Filter", FORMAT(payPeriod)); need to remove the comment
            // IF objPayrollEmployee.FIND('-') THEN BEGIN
            JSONTextWriter.WriteStartObject;
            objPayrollEmployee.CalcFields("Cummulative Basic Pay", "Cummulative Allowances", "Cummulative Deductions", "Cummulative Net Pay");
            CreateJsonAttribute('BasicPay', Format(objPayrollEmployee."Cummulative Basic Pay"));
            CreateJsonAttribute('TotalAllowances', Format(objPayrollEmployee."Cummulative Allowances"));
            CreateJsonAttribute('TotalDeductions', Format(objPayrollEmployee."Cummulative Deductions"));
            CreateJsonAttribute('NetPay', Format(objPayrollEmployee."Cummulative Net Pay"));
            JSONTextWriter.WriteEndObject;
            // END;
        end;

        JsonOut := StringBuilder.ToString;
        returnout := Format(JsonOut);
        Message(JsonOut);
    end;

    procedure fnlogin(user: Code[60]; password: Text) empno: Code[50]
    begin
        objHREmployees.Reset;
        objHREmployees.SetRange("User ID", user);
        //password:=encrypt01.Decrypt(password);
        //objHREmployees.SETRANGE("Portal Password", password);
        //objHREmployees.SETRANGE(Registered, TRUE);
        if objHREmployees.Find('-') then begin
            empno := objHREmployees."No.";
        end
        else
            empno := '';

        //encrypt.Encrypt(pass
    end;

    procedure fnRegister(empno: Code[40]; regcode: Text; newpassword: Text) register: Boolean
    begin
        objHREmployees.Reset;
        objHREmployees.SetRange("No.", empno);
        //regcode:=encrypt01.Decrypt(regcode);
        objHREmployees.SetRange("Portal Password", regcode);
        if objHREmployees.Find('-') then begin
            objHREmployees.Registered := true;
            objHREmployees."Portal Password" := newpassword;
            objHREmployees.Modify;
            register := true;
        end else
            register := false;
    end;

    procedure fninserreccode(empno: Code[50]; idnumber: Code[40]; email: Text) success: Boolean
    var
        randomnumber: Integer;
        inpassword: Text;
        smtp: Codeunit Email;
        smtpsetup: Codeunit "Email Message";
        Body: Text;
        Body2: text;
    begin
        objHREmployees.Reset;
        objHREmployees.SetRange("No.", empno);
        objHREmployees.SetRange("ID Number", idnumber);
        objHREmployees.SetRange("E-Mail", email);
        if objHREmployees.Find('-') then begin
            //ENCRYPT(inpassword);
            randomnumber := Random(99999);
            //ecnryptedpassword:= encrypt01.Encrypt(FORMAT(randomnumber));
            objHREmployees."Portal Password" := Format(randomnumber);

            if objHREmployees.Registered = true then
                objHREmployees.Registered := false;
            objHREmployees.Modify;
            success := true;
            Body := 'Dear Sir/Madam your Self service portal one time password is ';
            Body2 := ' please use this code for the next step';
            //Send to email
            //smtpsetup.Get();
            smtpsetup.Create(email, 'MMM Self service password', 'Dear Sir/Madam your Self service portal one time password is '
            + Format(randomnumber) + ' please use this code for the next step', false);
            smtp.Send(smtpsetup);
        end else
            success := false;

        exit(success);
    end;

    procedure fnGetPeriods() returnout: Text
    var
        JsonOut: dotnet String;
        PeriodName: Text;
    begin
        ObjPrPeriods.Reset;
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        repeat

            // PeriodName:=FORMat(ObjPrPeriods.Name+'-'+(DATE2DMY(ObjPrPeriods."Starting Date",3)));
            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('Period', ObjPrPeriods."Period Name");
            CreateJsonAttribute('Name', Format(ObjPrPeriods."Period Name"));
            //CreateJsonAttribute('Year', DATE2DMY(ObjPrPeriods."Starting Date",3));

            JSONTextWriter.WriteEndObject;
        until ObjPrPeriods.Next = 0;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
        Message(Format(JsonOut));
    end;

    procedure fnleaveinformation(empNo: Code[60]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);

        HREmployees.Reset();
        HREmployees.SetRange("No.", empNo);
        if HREmployees.Find('-') then begin
            HREmployees.CalcFields("Total Leave Taken", "Reimbursed Leave Days", "Allocated Leave Days");
            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('EmailAddress', HREmployees."E-Mail");
            CreateJsonAttribute('officialAddress', HREmployees."E-Mail");
            CreateJsonAttribute('MobilePhone', HREmployees."Cellular Phone Number");
            CreateJsonAttribute('TotalLeavedays', HREmployees."Total (Leave Days)");
            CreateJsonAttribute('LeavedaysAllocated', HREmployees."Allocated Leave Days");
            CreateJsonAttribute('LeaveDaysreimbursed', HREmployees."Reimbursed Leave Days");
            CreateJsonAttribute('LeavedaysTaken', HREmployees."Total Leave Taken");
            CreateJsonAttribute('LeaveBalance', HREmployees."Leave Balance");
        end;

        JSONTextWriter.WriteEndObject;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnLeaveList(empNo: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        objHRLeaveApplication.Reset;
        objHRLeaveApplication.SetRange("Employee No", empNo);
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        if objHRLeaveApplication.Find('-') then begin
            repeat
                // REPEAT
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', objHRLeaveApplication."Application Code");
                CreateJsonAttribute('Status', Format(objHRLeaveApplication.Status));
                CreateJsonAttribute('StartDate', Format(objHRLeaveApplication."Start Date"));
                CreateJsonAttribute('ReturnDate', Format(objHRLeaveApplication."Return Date"));
                CreateJsonAttribute('NoofDayes', Format(objHRLeaveApplication."Days Applied"));
                CreateJsonAttribute('LeaveType', Format(objHRLeaveApplication."Leave Type"));
                // HREmployees.GET(objHRLeaveApplication.Reliever);
                CreateJsonAttribute('RelieverCode', objHRLeaveApplication."Reliever Name");
                CreateJsonAttribute('EndDate', objHRLeaveApplication."End Date");
                CreateJsonAttribute('ApplicationDate', objHRLeaveApplication."Application Date");
                CreateJsonAttribute('ApprovedDays', objHRLeaveApplication."Approved days");
                CreateJsonAttribute('pendingtasks', objHRLeaveApplication."Pending Tasks");
                CreateJsonAttribute('Reimbursed', objHRLeaveApplication."Is reimbursement");
                JSONTextWriter.WriteEndObject;
            until objHRLeaveApplication.Next = 0;
        end;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnLeaveCard(empNo: Code[50]; leavecode: Code[40]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        objHRLeaveApplication.Reset;
        objHRLeaveApplication.SetRange("Employee No", empNo);
        objHRLeaveApplication.SetRange("Application Code", leavecode);
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        // JSONTextWriter.WriteStartArray;
        if objHRLeaveApplication.Find('-') then begin

            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('No', objHRLeaveApplication."Application Code");
            CreateJsonAttribute('Status', Format(objHRLeaveApplication.Status));
            CreateJsonAttribute('StartDate', Format(objHRLeaveApplication."Start Date"));
            CreateJsonAttribute('ReturnDate', Format(objHRLeaveApplication."Return Date"));
            CreateJsonAttribute('NoofDayes', Format(objHRLeaveApplication."Days Applied"));
            CreateJsonAttribute('LeaveType', Format(objHRLeaveApplication."Leave Type"));
            // HREmployees.GET(objHRLeaveApplication.Reliever);
            CreateJsonAttribute('RelieverCode', objHRLeaveApplication."Reliever Name");
            CreateJsonAttribute('EndDate', objHRLeaveApplication."End Date");
            CreateJsonAttribute('ApplicationDate', objHRLeaveApplication."Application Date");
            CreateJsonAttribute('ApprovedDays', objHRLeaveApplication."Approved days");

            JSONTextWriter.WriteEndObject;
            //UNTIL objHRLeaveApplication.NEXT=0;
        end;

        //JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnGetLeaveTypes() returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjHRLeaveTypes.Reset;
        //ObjHRLeaveTypes.SETRANGE(Setup, FALSE);
        if ObjHRLeaveTypes.Find('-') then begin
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjHRLeaveTypes.Code);
                JSONTextWriter.WriteEndObject;
            until ObjHRLeaveTypes.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure FnGetGlAccounts() returnout: Text
    var
        GLAccounts: Record "G/L Account";
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        GLAccounts.RESET;
        GLAccounts.ASCENDING(TRUE);
        IF GLAccounts.FindSet THEN begin
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', GLAccounts."No.");
                CreateJsonAttribute('Name', GLAccounts."No." + ' - ' + GLAccounts.Name);
                JSONTextWriter.WriteEndObject;
            until GLAccounts.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure FngetDimensions() returnout: Text
    var
        DimensionValues: Record "Dimension Value";
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        DimensionValues.RESET;
        DimensionValues.SetRange("Global Dimension No.", 2);
        DimensionValues.ASCENDING(TRUE);
        IF DimensionValues.FindSet THEN begin
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', DimensionValues.Code);
                CreateJsonAttribute('Name', DimensionValues.Code + ' - ' + DimensionValues.Name);
                JSONTextWriter.WriteEndObject;
            until DimensionValues.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure FnGetDeliverables(DimensionCode: Code[250]) returnout: Text
    var
        DimensionValues: Record "Dimension Value";
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        DimensionValues.RESET;
        DimensionValues.SetRange("Outcome Code", DimensionCode);
        DimensionValues.SetRange("BudgetLine Disabled", false);
        DimensionValues.ASCENDING(TRUE);
        IF DimensionValues.FindSet THEN begin
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', DimensionValues.Code);
                CreateJsonAttribute('Name', DimensionValues.Code + ' - ' + DimensionValues.Name);
                JSONTextWriter.WriteEndObject;
            until DimensionValues.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure FnGetOutcome(DimensionCode: Code[250]) returnout: Text
    var
        DimensionValues: Record "Dimension Value";
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        DimensionValues.RESET;
        DimensionValues.SetRange("Project Code", DimensionCode);
        DimensionValues.SetRange("Global Dimension No.", 4);
        DimensionValues.SetRange("BudgetLine Disabled", false);
        DimensionValues.ASCENDING(TRUE);
        IF DimensionValues.FindSet THEN begin
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', DimensionValues.Code);
                CreateJsonAttribute('Name', DimensionValues.Code + ' - ' + DimensionValues.Name);
                JSONTextWriter.WriteEndObject;
            until DimensionValues.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure FnGetDeliverablesp(DimensionCode: Code[250]) returnout: Text
    var
        DimensionValues: Record "Dimension Value";
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        DimensionValues.RESET;
        DimensionValues.SetRange("Outcome Code", DimensionCode);
        DimensionValues.ASCENDING(TRUE);
        IF DimensionValues.FindSet THEN begin
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', DimensionValues.Code);
                CreateJsonAttribute('Name', DimensionValues.Code + ' - ' + DimensionValues.Name);
                JSONTextWriter.WriteEndObject;
            until DimensionValues.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure FnGetOutcomes(DimensionCode: Code[250]) returnout: Text
    var
        DimensionValues: Record "Dimension Value";
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        DimensionValues.RESET;
        DimensionValues.SetRange("Project Code", DimensionCode);
        DimensionValues.SetRange("Global Dimension No.", 4);
        DimensionValues.ASCENDING(TRUE);
        IF DimensionValues.FindSet THEN begin
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', DimensionValues.Code);
                CreateJsonAttribute('Name', DimensionValues.Code + ' - ' + DimensionValues.Name);
                JSONTextWriter.WriteEndObject;
            until DimensionValues.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnHrEmployees() returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        objHREmployees.Reset;
        objHREmployees.SetRange(Status, objHREmployees.Status::Active);

        if objHREmployees.Find('-') then begin
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('EmpNo', objHREmployees."No.");
                CreateJsonAttribute('Name', objHREmployees."First Name" + ' ' + objHREmployees."Last Name");
                JSONTextWriter.WriteEndObject;
            until objHREmployees.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure FnEditApplication(EmployeeNo: Code[100]; LeaveType: Code[100]; AppliedDays: decimal; StartDate: Date; Reliever: Code[100]; ApplicationNo: Code[50]; pendingtasks: Text; Reimbursed: Boolean)
    var
        NextLeaveApplicationNo: Code[100];
        EndDate: Date;
        ReturnDate: Date;
        SenderComments: Text;
        ResponsibilityCenter: Code[100];
    begin
        objHRSetup.Get();

        objHRLeaveApplication.Init;
        FnValidateStartDate(StartDate);
        NextLeaveApplicationNo := objNumSeries.GetNextNo(objHRSetup."Leave Application Nos.", 0D, true);
        //ReturnDate := DetermineLeaveReturnDate(StartDate, AppliedDays, LeaveType);
        //EndDate := CalcEndDate(StartDate, AppliedDays, LeaveType);


        objHREmployees.Reset;
        objHREmployees.SetRange("No.", EmployeeNo);
        if objHREmployees.Find('-')
        then begin
            ResponsibilityCenter := objHREmployees."Responsibility Center";
            if objHRLeaveApplication.Get(ApplicationNo) then begin
                objHRLeaveApplication."User ID" := objHREmployees."User ID";
                objHRLeaveApplication."Application Code" := ApplicationNo;
                objHRLeaveApplication."Employee No" := EmployeeNo;
                // objHRLeaveApplication.INSERT;
                objHRLeaveApplication.Names := objHREmployees."First Name" + '  ' + objHREmployees."Middle Name";
                //objHRLeaveApplication."Department Code":=objHREmployees."Department Code";
                objHRLeaveApplication."E-mail Address" := objHREmployees."Company E-Mail";
                if LeaveType = 'CTO' then begin
                    if Reimbursed = true then begin
                        objHRLeaveApplication."Is reimbursement" := True;
                    end

                end;
                objHRLeaveApplication."Supervisor" := objHREmployees."Supervisor ID";
                objHRLeaveApplication."Leave Type" := LeaveType;
                objHRLeaveApplication."Days Applied" := AppliedDays;
                objHRLeaveApplication.Validate(objHRLeaveApplication."Days Applied");
                objHRLeaveApplication."Application Date" := Today;
                objHRLeaveApplication."No series" := 'LEAVE';
                objHRLeaveApplication."Start Date" := StartDate;
                objHRLeaveApplication.Validate("Start Date");
                //objHRLeaveApplication."Return Date" := ReturnDate;
                // objHRLeaveApplication."End Date" := ReturnDate;
                objHRLeaveApplication."Responsibility Center" := ResponsibilityCenter;

                HREmployees.Reset();
                HREmployees.SetRange("No.", Reliever);
                if HREmployees.Find('-') then begin
                    objHRLeaveApplication.Reliever := Reliever;
                    objHRLeaveApplication.Validate(objHRLeaveApplication.Reliever);
                end;
                objHRLeaveApplication.Description := SenderComments;
                objHRLeaveApplication.Validate("Employee No");
                objHRLeaveApplication."Pending Tasks" := pendingtasks;
                objHRLeaveApplication.Modify;
                Commit();
            end;
        end;
    end;

    procedure fnDelete(leaveCode: Code[40])
    begin
        objHRLeaveApplication.Reset;
        //objHRLeaveApplication.SETRANGE(Posted, FALSE);
        objHRLeaveApplication.SetRange(Status, objHRLeaveApplication.Status::New);
        objHRLeaveApplication.SetRange("Application Code", leaveCode);

        if objHRLeaveApplication.Find('-') then begin
            objHRLeaveApplication.Delete;
        end;
    end;

    procedure fnGetleaveStatement("Employee No": Code[20]; var BigText: BigText; Path: Text)
    var
        objPREmployee: Record "Payroll Employee_AU";
        Filename: Text[100];
        Convert: dotnet Convert;
        _File: dotnet File;
        FileAccess: dotnet FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
        p9repor: Report "VAT Statement";
    begin

        Filename := Path;
        _File.Delete(Filename);
        objHREmployees.Reset;
        objHREmployees.SetRange(objHREmployees."No.", "Employee No");
        if objHREmployees.Find('-') then begin
            Report.SaveAsPdf(80029, Filename, objHREmployees);
            // FileMode := 4;
            // FileAccess := 1;

            // FileStream := _File.Open(Filename, FileMode, FileAccess);

            // MemoryStream := MemoryStream.MemoryStream();

            // MemoryStream.SetLength(FileStream.Length);
            // FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

            // BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
            // MemoryStream.Close();
            // MemoryStream.Dispose();
            // FileStream.Close();
            // FileStream.Dispose();
            //MESSAGE(FORMAT(Path));

        end;
    end;

    procedure fnGetP9Report1("Employee No": Code[20]; "starting date": Date; "ending date": Date; var BigText: BigText; Path: Text)
    var
        objPREmployee: Record "Payroll Employee_AU";
        Filename: Text[100];
        Convert: dotnet Convert;
        _File: dotnet File;
        FileAccess: dotnet FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
    begin
        Filename := Path;
        _File.Delete(Filename);
        HREmployees6.Reset;
        HREmployees6.SetRange(HREmployees6."No.", "Employee No");
        //P9report.SETFILTER(P9report."Period Year",FORMAT(PayPeriod));
        if HREmployees6.Find('-') then begin
            p9report.Reset;
            // P9report.SETFILTER(P9report."Period Year",FORMAT(PayPeriod));
            p9report.SetFilter(p9report."Period Year", Format(Date2dmy("starting date", 3)));

            if p9report.FindFirst then
                p9.SetTableview(p9report);
            p9.SetTableview(HREmployees6);
            p9.SaveAsPdf(Filename);
            // REPORT.SAVEASPDF(50184,Filename,objPayrollEmployee);
            // FileMode := 4;
            // FileAccess := 1;

            // FileStream := _File.Open(Filename, FileMode, FileAccess);

            // MemoryStream := MemoryStream.MemoryStream();

            // MemoryStream.SetLength(FileStream.Length);
            // FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

            // BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
            // MemoryStream.Close();
            // MemoryStream.Dispose();
            // FileStream.Close();
            // FileStream.Dispose();
            // //MESSAGE(FORMAT(Path));
            // _File.Delete(Filename);
        end;

    end;

    procedure fnLeaveDelete(empNo: Code[50]; LeaveNo: Code[20]) returnout: Text
    var
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        if objHRLeaveApplication.Get(LeaveNo) then
            objHRLeaveApplication.Delete;
        objHRLeaveApplication.Reset;
        objHRLeaveApplication.SetRange("Employee No", empNo);
        if objHRLeaveApplication.Find('-') then begin
            repeat
                // REPEAT
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', objHRLeaveApplication."Application Code");
                CreateJsonAttribute('Status', Format(objHRLeaveApplication.Status));
                CreateJsonAttribute('StartDate', Format(objHRLeaveApplication."Start Date"));
                CreateJsonAttribute('ReturnDate', Format(objHRLeaveApplication."Return Date"));
                CreateJsonAttribute('NoofDayes', Format(objHRLeaveApplication."Days Applied"));
                CreateJsonAttribute('LeaveType', Format(objHRLeaveApplication."Leave Type"));
                // HREmployees.GET(objHRLeaveApplication.Reliever);
                CreateJsonAttribute('RelieverCode', objHRLeaveApplication."Reliever Name");
                CreateJsonAttribute('EndDate', objHRLeaveApplication."End Date");
                CreateJsonAttribute('ApplicationDate', objHRLeaveApplication."Application Date");
                CreateJsonAttribute('ApprovedDays', objHRLeaveApplication."Approved days");
                JSONTextWriter.WriteEndObject;
            until objHRLeaveApplication.Next = 0;
        end;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnUpdateImprestCard(ImprestNo: Code[20]; departmentcode: Code[20]; directoratecode: Code[20]; purpose: Text; responsibilitycenter: Code[20]; startdate: Date; enddate: Date) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestHeader: Record "Purchase Header";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
    begin
        /*
        StringBuilder:=StringBuilder.StringBuilder;
           StringWriter:=StringWriter.StringWriter(StringBuilder);
           JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        IF ObjImprestHeader.GET(ImprestNo) THEN BEGIN
        
           ObjImprestHeader.StartDate:=startdate;
           ObjImprestHeader.Enddate:=enddate;
           ObjImprestHeader."Global Dimension 1 Code":=departmentcode;
           ObjImprestHeader.VALIDATE(ObjImprestHeader."Global Dimension 1 Code");
           ObjImprestHeader."Shortcut Dimension 2 Code":=directoratecode;
           ObjImprestHeader.VALIDATE(ObjImprestHeader."Shortcut Dimension 2 Code");
           ObjImprestHeader.Purpose:=purpose;
           ObjImprestHeader."Responsibility Center":=responsibilitycenter;
            IF ObjImprestHeader.MODIFY(TRUE) THEN BEGIN
              ObjImprestHeader.CALCFIELDS("Total Net Amount LCY");
              JSONTextWriter.WriteStartObject;
              CreateJsonAttribute('No', ObjImprestHeader."No.");
              CreateJsonAttribute('Document_Date', ObjImprestHeader.Date);
              CreateJsonAttribute('Status', ObjImprestHeader.Status);
              CreateJsonAttribute('ResponsibilityCenter', ObjImprestHeader."Responsibility Center");
              CreateJsonAttribute('Amount', ObjImprestHeader."Total Net Amount LCY");
              CreateJsonAttribute('DepartmentCode', ObjImprestHeader."Global Dimension 1 Code");
              CreateJsonAttribute('StartDate', ObjImprestHeader.StartDate);
              CreateJsonAttribute('EndDate', ObjImprestHeader.Enddate);
              CreateJsonAttribute('DirectorateCode', ObjImprestHeader."Shortcut Dimension 2 Code");
              CreateJsonAttribute('Purpose',ObjImprestHeader.Purpose);
              JSONTextWriter.WriteEndObject;
            END;
        JsonOut:=StringBuilder.ToString;
        returnout:=JsonOut;
        END;*/

    end;

    procedure fnImprestCard(empNo: Code[50]; departmentcode: Code[20]; directoratecode: Code[20]; purpose: Text; responsibilitycenter: Code[20]; startdate: Date; enddate: Date) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestHeader: Record "Purchase Header";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
    begin
        if ObjHREmployee.Get(empNo) then begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            GenLedgerSetup.Get();
            ObjImprestHeader.Init;
            ObjImprestHeader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Mission Proposal Nos.", 0D, true);
            ObjImprestHeader."Document Date" := Today;
            ObjImprestHeader.IM := true;
            // ObjImprestHeader.StartDate:=startdate;
            // ObjImprestHeader.Enddate:=enddate;
            ObjImprestHeader."Shortcut Dimension 1 Code" := departmentcode;
            ObjImprestHeader.Validate(ObjImprestHeader."Shortcut Dimension 1 Code");
            ObjImprestHeader."Shortcut Dimension 2 Code" := directoratecode;
            ObjImprestHeader.Validate(ObjImprestHeader."Shortcut Dimension 2 Code");
            ObjImprestHeader."Posting Description" := purpose;
            ObjImprestHeader.Status := ObjImprestHeader.Status::Open;
            // ObjImprestHeader.c:=empNo;
            if ObjUserSetup.Get(ObjHREmployee."User ID") then begin
                // ObjImprestHeader."Account No":=ObjUserSetup.;
                // ObjImprestHeader.VALIDATE("Account No.");
            end;
            //  ObjImprestHeader.VALIDATE(ObjImprestHeader."Employee No");
            ObjImprestHeader."Responsibility Center" := responsibilitycenter;
            if ObjImprestHeader.Insert(true) then begin
                ObjImprestHeader.CalcFields(Amount);
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', ObjImprestHeader."No.");
                CreateJsonAttribute('Document_Date', ObjImprestHeader."Document Date");
                CreateJsonAttribute('Status', ObjImprestHeader.Status);
                CreateJsonAttribute('ResponsibilityCenter', ObjImprestHeader."Responsibility Center");
                CreateJsonAttribute('Amount', ObjImprestHeader.Amount);
                CreateJsonAttribute('DepartmentCode', ObjImprestHeader."Shortcut Dimension 1 Code");
                CreateJsonAttribute('StartDate', ObjImprestHeader."Expected Receipt Date");
                CreateJsonAttribute('EndDate', ObjImprestHeader."Document Date");
                CreateJsonAttribute('DirectorateCode', ObjImprestHeader."Shortcut Dimension 2 Code");
                CreateJsonAttribute('Purpose', ObjImprestHeader."Posting Description");
                JSONTextWriter.WriteEndObject;
            end;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
        end;
    end;

    procedure fnImprestCardEdit(ImprestNo: Code[20]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestHeader: Record "Purchase Header";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);

        if ObjImprestHeader.Get(ObjImprestHeader."document type"::Quote, ImprestNo) then begin
            ObjImprestHeader.CalcFields(Amount);
            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('No', ObjImprestHeader."No.");
            CreateJsonAttribute('Document_Date', ObjImprestHeader."Document Date");
            CreateJsonAttribute('Status', ObjImprestHeader.Status);
            CreateJsonAttribute('ResponsibilityCenter', ObjImprestHeader."Responsibility Center");
            CreateJsonAttribute('Amount', ObjImprestHeader.Amount);
            CreateJsonAttribute('DepartmentCode', ObjImprestHeader."Shortcut Dimension 1 Code");
            CreateJsonAttribute('StartDate', ObjImprestHeader."Document Date");
            CreateJsonAttribute('EndDate', ObjImprestHeader."Document Date");
            CreateJsonAttribute('DirectorateCode', ObjImprestHeader."Shortcut Dimension 2 Code");
            CreateJsonAttribute('Purpose', ObjImprestHeader."Posting Description");
            JSONTextWriter.WriteEndObject;

            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
        end;
    end;

    procedure fnPettyCashCardEdit(PettyCashNo: Code[20]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjPettyCash: Record "Payment Terms";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        EmpNo: Code[50];
    begin
        /*StringBuilder:=StringBuilder.StringBuilder;
           StringWriter:=StringWriter.StringWriter(StringBuilder);
           JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        IF ObjPettyCash.GET(PettyCashNo) THEN BEGIN
              JSONTextWriter.WriteStartObject;
              CreateJsonAttribute('No', ObjPettyCash."No.");
              CreateJsonAttribute('Date', ObjPettyCash.Date);
              CreateJsonAttribute('Status', ObjPettyCash.Status);
              CreateJsonAttribute('Amount', ObjPettyCash."Amount Requested");
              CreateJsonAttribute('DirectorateCode', ObjPettyCash."Global Dimension 1 Code");
              CreateJsonAttribute('DepartmentCode', ObjPettyCash."Shortcut Dimension 2 Code");
              CreateJsonAttribute('Purpose', ObjPettyCash.Purpose);
              CreateJsonAttribute('Bank', ObjPettyCash."Paying Bank Account");
              JSONTextWriter.WriteEndObject;
        
          JsonOut:=StringBuilder.ToString;
          returnout:=JsonOut;
          END;*/

    end;

    procedure fnPettyCashCardDelete(PettyCashNo: Code[20])
    var
        JsonOut: dotnet String;
        ObjPettyCash: Record "Payment Terms";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        EmpNo: Code[50];
    begin
        /*
        IF ObjPettyCash.GET(PettyCashNo) THEN
           ObjPettyCash.DELETE;*/

    end;

    procedure fnPettyCashCardDoUpdate(PettyCashNo: Code[20]; departmentcode: Code[20]; directoratecode: Code[20]; purpose: Text; AmountRequested: Decimal; bank: Code[20]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjPettyCash: Record "Payment Terms";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        EmpNo: Code[50];
    begin
        /*StringBuilder:=StringBuilder.StringBuilder;
        StringWriter:=StringWriter.StringWriter(StringBuilder);
        JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        
        IF ObjPettyCash.GET(PettyCashNo) THEN BEGIN
        
           ObjPettyCash."Global Dimension 1 Code":=departmentcode;
           ObjPettyCash.VALIDATE(ObjPettyCash."Global Dimension 1 Code");
           ObjPettyCash."Shortcut Dimension 2 Code":=directoratecode;
           ObjPettyCash.VALIDATE(ObjPettyCash."Shortcut Dimension 2 Code");
           ObjPettyCash.Purpose:=purpose;
           ObjPettyCash."Paying Bank Account":=bank;
           ObjPettyCash.VALIDATE("Paying Bank Account");
           EmpNo:=ObjPettyCash.Cashier;
           ObjPettyCash."Amount Requested":=AmountRequested;
            IF ObjPettyCash.MODIFY(TRUE) THEN BEGIN
              ObjPettyCash.RESET;
              ObjPettyCash.SETRANGE(Cashier,EmpNo);
              IF ObjPettyCash.FINDFIRST THEN
                REPEAT
              //ObjPettyCash.CALCFIELDS("Total Net Amount LCY");
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', ObjPettyCash."No.");
                CreateJsonAttribute('Date', ObjPettyCash.Date);
                CreateJsonAttribute('Status', ObjPettyCash.Status);
                CreateJsonAttribute('Amount', ObjPettyCash."Amount Requested");
                CreateJsonAttribute('DirectorateCode', ObjPettyCash."Global Dimension 1 Code");
                CreateJsonAttribute('DepartmentCode', ObjPettyCash."Shortcut Dimension 2 Code");
                CreateJsonAttribute('Purpose', ObjPettyCash.Purpose);
                CreateJsonAttribute('Bank', ObjPettyCash."Paying Bank Account");
                JSONTextWriter.WriteEndObject;
             UNTIL ObjPettyCash.NEXT = 0;
            END;
        JSONTextWriter.WriteEndArray;
        JsonOut:=StringBuilder.ToString;
        returnout:=JsonOut;
        END;
        */

    end;

    procedure fnPettyCashCard(empNo: Code[50]; departmentcode: Code[20]; directoratecode: Code[20]; purpose: Text; AmountRequested: Decimal; bank: Code[20]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjPettyCash: Record "Payment Terms";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
    begin
        /*IF ObjHREmployee.GET(empNo) THEN BEGIN
        StringBuilder:=StringBuilder.StringBuilder;
           StringWriter:=StringWriter.StringWriter(StringBuilder);
           JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        
           ObjPettyCash.INIT;
           ObjPettyCash.Date:=TODAY;
           ObjPettyCash."Global Dimension 1 Code":=departmentcode;
           ObjPettyCash.VALIDATE(ObjPettyCash."Global Dimension 1 Code");
           ObjPettyCash."Shortcut Dimension 2 Code":=directoratecode;
           ObjPettyCash.VALIDATE(ObjPettyCash."Shortcut Dimension 2 Code");
           ObjPettyCash.Purpose:=purpose;
           ObjPettyCash."Payment Type":=ObjPettyCash."Payment Type"::"Petty Cash";
           ObjPettyCash.VALIDATE("Payment Type");
           ObjPettyCash."Paying Bank Account":=bank;
           ObjPettyCash.VALIDATE("Paying Bank Account");
           ObjPettyCash.Status:=ObjPettyCash.Status::Open;
           ObjPettyCash.Cashier:=empNo;
           //ObjPettyCash."Responsibility Center":=responsibilitycenter;
           ObjPettyCash."Amount Requested":=AmountRequested;
           ObjPettyCash.Payee:=ObjHREmployee."First Name"+' '+ObjHREmployee."Last Name";
            IF ObjPettyCash.INSERT(TRUE) THEN BEGIN
              //ObjPettyCash.CALCFIELDS("Total Net Amount LCY");
              JSONTextWriter.WriteStartObject;
              CreateJsonAttribute('No', ObjPettyCash."No.");
              CreateJsonAttribute('Date', ObjPettyCash.Date);
              CreateJsonAttribute('Status', ObjPettyCash.Status);
              CreateJsonAttribute('Amount', ObjPettyCash."Amount Requested");
              CreateJsonAttribute('DepartmentCode', ObjPettyCash."Global Dimension 1 Code");
              CreateJsonAttribute('DirectorateCode', ObjPettyCash."Shortcut Dimension 2 Code");
              CreateJsonAttribute('Purpose', ObjPettyCash.Purpose);
              CreateJsonAttribute('Bank', ObjPettyCash."Paying Bank Account");
              JSONTextWriter.WriteEndObject;
            END;
        JsonOut:=StringBuilder.ToString;
        returnout:=JsonOut;
        END;*/

    end;

    procedure fnPettyCashList(empNo: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjPettyCashHeader: Record "Payment Terms";
        ObjImprestLine: Record "Purchase Line";
        ObjHrEmployee: Record "HR Employees";
    begin
        /*StringBuilder:=StringBuilder.StringBuilder;
        StringWriter:=StringWriter.StringWriter(StringBuilder);
        JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        
        IF ObjHrEmployee.GET(empNo) THEN
        ObjPettyCashHeader.RESET;
        ObjPettyCashHeader.SETRANGE(Cashier , ObjHrEmployee."User ID");
        IF ObjPettyCashHeader.FINDFIRST THEN
          REPEAT
            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('No', ObjPettyCashHeader."No.");
            CreateJsonAttribute('Date', ObjPettyCashHeader.Date);
            CreateJsonAttribute('Status', ObjPettyCashHeader.Status);
            CreateJsonAttribute('Amount', ObjPettyCashHeader."Amount Requested");
            CreateJsonAttribute('DirectorateCode', ObjPettyCashHeader."Global Dimension 1 Code");
            CreateJsonAttribute('DepartmentCode', ObjPettyCashHeader."Shortcut Dimension 2 Code");
            CreateJsonAttribute('Purpose', ObjPettyCashHeader.Purpose);
            CreateJsonAttribute('Bank', ObjPettyCashHeader."Paying Bank Account");
            JSONTextWriter.WriteEndObject;
          UNTIL ObjPettyCashHeader.NEXT=0;
        
        JSONTextWriter.WriteEndArray;
        JsonOut:=StringBuilder.ToString;
        returnout:=JsonOut;
        */

    end;

    procedure fnPettyCashBank() returnout: Text
    var
        JsonOut: dotnet String;
        ObjBank: Record "Bank Account";
        ObjImprestLine: Record "Purchase Line";
        ObjHrEmployee: Record "HR Employees";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjBank.Reset;
        //ObjBank.SETFILTER(ty,'=%1',ObjBank."Bank Type"::Cash);
        if ObjBank.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjBank."No.");
                CreateJsonAttribute('Name', ObjBank.Name);
                JSONTextWriter.WriteEndObject;
            until ObjBank.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnPettyCashApproval(ImprestNo: Code[50]; Approval: Boolean)
    var
        ObjPettyCashRequisition: Record "Payment Terms";
    begin
        /*ObjPettyCashRequisition.RESET;
        ObjPettyCashRequisition.SETRANGE("No.",ImprestNo);
        IF ObjPettyCashRequisition.FINDFIRST THEN
          BEGIN
            VarVariant:=ObjPettyCashRequisition;
            IF Approval THEN BEGIN
            IF ObjPettyCashRequisition.Status=ObjPettyCashRequisition.Status::Open THEN
              BEGIN
                IF ApprovalMgt.CheckApprovalsWorkflowEnabled(VarVariant) THEN BEGIN
                ApprovalMgt.OnSendDocForApproval(VarVariant);
                END;
              END;
            END ELSE BEGIN
              IF ApprovalMgt.CheckApprovalsWorkflowEnabled(VarVariant)THEN
                ApprovalMgt.OnCancelDocApprovalRequest(VarVariant);
            END;
          END;
          */

    end;

    procedure fnPaymentTypes(Type: Option " ",Receipt,Payment,Imprest,Claim) returnout: Text
    var
        JsonOut: dotnet String;
        ObjPaymentType: Record "G/L Account";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjPaymentType.Reset;
        ObjPaymentType.SetFilter("Direct Posting", 'Yes');
        if ObjPaymentType.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjPaymentType."No.");
                CreateJsonAttribute('Description', ObjPaymentType.Name);
                CreateJsonAttribute('Type', ObjPaymentType."Account Type");
                JSONTextWriter.WriteEndObject;
            until ObjPaymentType.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnImprestLineDelete(ImprestNo: Code[20]; LineNo: Integer) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestLine: Record "Purchase Line";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjImprestLine.Reset;
        ObjImprestLine.SetRange("Document No.", ImprestNo);
        ObjImprestLine.SetRange("Line No.", LineNo);
        if ObjImprestLine.FindFirst then
            ObjImprestLine.Delete;

        ObjImprestLine.Reset;
        ObjImprestLine.SetRange("Document No.", ImprestNo);
        if ObjImprestLine.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', ObjImprestLine."Document No.");
                CreateJsonAttribute('AccountNo', ObjImprestLine."No.");
                CreateJsonAttribute('AccountName', ObjImprestLine.Description);
                CreateJsonAttribute('Amount', ObjImprestLine.Amount);
                CreateJsonAttribute('LineNo', ObjImprestLine."Line No.");
                CreateJsonAttribute('Type', ObjImprestLine.Type);
                JSONTextWriter.WriteEndObject;
            until ObjImprestLine.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnImprestLine(ImprestNo: Code[20]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestLine: Record "Purchase Line";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjImprestLine.Reset;
        ObjImprestLine.SetFilter(Amount, '<>%1', 0);
        ObjImprestLine.SetRange("Document No.", ImprestNo);

        //ObjImprestLine.SETRANGE("Line No.",LineNo);
        if ObjImprestLine.FindFirst then
            repeat
                // IF ObjImprestLine."Line Type"<> ObjImprestLine."Line Type"::Activity THEN BEGIN
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', ObjImprestLine."Document No.");
                CreateJsonAttribute('AccountNo', ObjImprestLine."No.");
                CreateJsonAttribute('AccountName', ObjImprestLine.Description);
                //CreateJsonAttribute('Amount', ObjImprestLine.Amount);
                CreateJsonAttribute('LineNo', ObjImprestLine."Line No.");
                CreateJsonAttribute('Type', ObjImprestLine.Type);
                CreateJsonAttribute('uom', ObjImprestLine."Unit of Measure");
                CreateJsonAttribute('ExpenseCategory', ObjImprestLine.Description);
                CreateJsonAttribute('Description', ObjImprestLine."Description 2");
                JSONTextWriter.WritePropertyName('AmountSpent');
                JSONTextWriter.WriteValue(ObjImprestLine."Amount Spent");
                JSONTextWriter.WritePropertyName('CashRefund');
                JSONTextWriter.WriteValue(ObjImprestLine."Cash Refund");
                JSONTextWriter.WritePropertyName('Amount');
                JSONTextWriter.WriteValue(ObjImprestLine.Amount);
                JSONTextWriter.WritePropertyName('currency');
                JSONTextWriter.WriteValue(ObjImprestLine."Currency Code");
                JSONTextWriter.WritePropertyName('unitcost');
                JSONTextWriter.WriteValue(ObjImprestLine."Unit Cost");
                JSONTextWriter.WritePropertyName('quantity');
                JSONTextWriter.WriteValue(ObjImprestLine.Quantity);
                JSONTextWriter.WriteEndObject;
            //   END;
            until ObjImprestLine.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnImprestLineCard(ImprestNo: Code[20]; LineNo: Integer) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestLine: Record "Purchase Line";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjImprestLine.Reset;
        ObjImprestLine.SetRange("Document No.", ImprestNo);
        ObjImprestLine.SetRange("Line No.", LineNo);
        if ObjImprestLine.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', ObjImprestLine."Document No.");
                CreateJsonAttribute('AccountNo', ObjImprestLine."No.");
                CreateJsonAttribute('AccountName', ObjImprestLine.Description);
                CreateJsonAttribute('Amount', ObjImprestLine.Amount);
                CreateJsonAttribute('LineNo', ObjImprestLine."Line No.");
                JSONTextWriter.WriteEndObject;
            until ObjImprestLine.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnImprestLineCardEdit(ImprestNo: Code[20]; Type: Code[20]; Amount: Decimal) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestLine: Record "Purchase Line";
        glaccount: Record "G/L Account";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjImprestLine.Init;
        ObjImprestLine.Type := ObjImprestLine.Type::"G/L Account";
        ObjImprestLine."Document No." := ImprestNo;
        PurchasesPayablesSetup.Get;
        Evaluate(ObjImprestLine."Line No.", objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.", Today, true));
        //ObjImprestLine."Line No.":=RANDOM(1000)+RANDOM(1000);
        ObjImprestLine."No." := Type;
        glaccount.Get(Type);
        ObjImprestLine.Description := glaccount.Name;
        ObjImprestLine."Document Type" := ObjImprestLine."document type"::Quote;
        //ObjImprestLine.Typ:=Type;
        ObjImprestLine.Amount := Amount;
        //ObjImprestLine.VALIDATE("No.");
        //ObjImprestLine.VALIDATE("Document Type");
        if ObjImprestLine.Insert(true) then begin
            ObjImprestLine.Reset;
            ObjImprestLine.SetRange("Document No.", ImprestNo);
            if ObjImprestLine.FindFirst then
                repeat
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', ObjImprestLine."Document No.");
                    CreateJsonAttribute('AccountNo', ObjImprestLine."No.");
                    CreateJsonAttribute('AccountName', ObjImprestLine.Description);
                    CreateJsonAttribute('Amount', ObjImprestLine.Amount);
                    CreateJsonAttribute('LineNo', ObjImprestLine."Line No.");
                    JSONTextWriter.WriteEndObject;
                until ObjImprestLine.Next = 0;

            JSONTextWriter.WriteEndArray;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
        end;
    end;

    // procedure FnInsertRequestForm(empNo: Code[50]; projectcode: Code[20]; departmentcode: Code[20]; Memo: Text; startdate: Date; enddate: Date; NeedsTravel: Boolean; TravelNo: code[20]; Currency: Code[20]) returnout: Text
    // var
    //     JsonOut: dotnet String;
    //     purchaseHeader: Record "Purchase Header";
    //     ObjHREmployee: Record "HR Employees";
    //     ObjUserSetup: Record "User Setup";
    //     PayableSetup: Record "Purchases & Payables Setup";
    // begin
    //     if ObjHREmployee.Get(empNo) then begin
    //         StringBuilder := StringBuilder.StringBuilder;
    //         StringWriter := StringWriter.StringWriter(StringBuilder);
    //         JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
    //         GenLedgerSetup.Get();
    //         PayableSetup.Get();
    //         purchaseHeader.Init;
    //         purchaseHeader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Property Numbers", 0D, true);
    //         purchaseHeader."No. Series" := GenLedgerSetup."Property Numbers";
    //         purchaseHeader."Document Type" := purchaseHeader."Document Type"::Quote;
    //         purchaseHeader."AU Form Type" := purchaseHeader."AU Form Type"::"Request Form";
    //         purchaseHeader."Document Date" := Today;
    //         purchaseHeader."Shortcut Dimension 1 Code" := projectcode;
    //         //purchaseHeader.Validate(purchaseHeader."Shortcut Dimension 1 Code");
    //         purchaseHeader."Shortcut Dimension 4 Code" := departmentcode;
    //         //purchaseHeader.Validate(purchaseHeader."Shortcut Dimension 4 Code");
    //         purchaseHeader."Payee Naration" := Memo;
    //         purchaseHeader."Employee No" := ObjHREmployee."No.";
    //         purchaseHeader."Employee Name" := ObjHREmployee.FullName;
    //         purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
    //         purchaseHeader."Account No" := ObjHREmployee.Travelaccountno;
    //         purchaseHeader."User ID" := ObjHREmployee."Employee UserID";
    //         purchaseHeader."Responsibility Center" := ObjHREmployee."Responsibility Center";
    //         purchaseHeader."Responsibility Center Name" := ObjHREmployee."Responsibility Center Name";
    //         purchaseHeader."Needs Travel Request Form?" := NeedsTravel;
    //         if NeedsTravel = true then begin
    //             purchaseHeader."Travel Requisition No" := TravelNo;
    //         end;
    //         purchaseHeader.fromDate := startdate;
    //         purchaseHeader."Due Date" := enddate;
    //         purchaseHeader."Currency Code" := Currency;
    //         if (Currency = 'KES') then
    //             purchaseHeader."Currency Factor" := 1;
    //         purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
    //         purchaseHeader.Status := purchaseHeader.Status::Open;

    //         if purchaseHeader.Insert(true) then begin
    //             purchaseHeader."Shortcut Dimension 1 Code" := projectcode;
    //             purchaseHeader."Shortcut Dimension 4 Code" := departmentcode;
    //             purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
    //             purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
    //             purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
    //             purchaseHeader.Modify(true);
    //             Commit();
    //             JSONTextWriter.WriteStartObject;
    //             CreateJsonAttribute('No', purchaseHeader."No.");
    //             CreateJsonAttribute('Document_Date', purchaseHeader."Document Date");
    //             CreateJsonAttribute('Status', purchaseHeader.Status);
    //             CreateJsonAttribute('ShortcutDimension1Code', purchaseHeader."Shortcut Dimension 1 Code");
    //             CreateJsonAttribute('fromDate', purchaseHeader."Expected Receipt Date");
    //             CreateJsonAttribute('DueDate', purchaseHeader."Document Date");
    //             CreateJsonAttribute('ShortcutDimension4Code', purchaseHeader."Shortcut Dimension 2 Code");
    //             CreateJsonAttribute('PayeeNaration', purchaseHeader."Payee Naration");
    //             CreateJsonAttribute('Needs_Travel_Request_Form_x003F_', purchaseHeader."Needs Travel Request Form?");
    //             CreateJsonAttribute('Travel_Requisition_No', purchaseHeader."Travel Requisition No");
    //             JSONTextWriter.WriteEndObject;
    //         end;
    //         JsonOut := StringBuilder.ToString;
    //         returnout := JsonOut;
    //     end;
    // end;

    // procedure FnEditRequestForm(empNo: Code[50]; Memo: Text; startdate: Date; enddate: Date; NeedsTravel: Boolean; TravelNo: code[20]; Currency: Code[20]; No: code[20]) returnout: Text
    // var
    //     JsonOut: dotnet String;
    //     purchaseHeader: Record "Purchase Header";
    //     ObjHREmployee: Record "HR Employees";
    //     ObjUserSetup: Record "User Setup";
    //     PayableSetup: Record "Purchases & Payables Setup";
    // begin
    //     if ObjHREmployee.Get(empNo) then begin
    //         purchaseHeader.reset;
    //         purchaseHeader.SetRange("No.", No);
    //         if purchaseHeader.FindFirst() then begin

    //             StringBuilder := StringBuilder.StringBuilder;
    //             StringWriter := StringWriter.StringWriter(StringBuilder);
    //             JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
    //             GenLedgerSetup.Get();
    //             PayableSetup.Get();
    //             purchaseHeader."No." := No;
    //             purchaseHeader."Document Type" := purchaseHeader."Document Type"::Quote;
    //             purchaseHeader."AU Form Type" := purchaseHeader."AU Form Type"::"Request Form";
    //             purchaseHeader."Document Date" := Today;
    //             purchaseHeader."Payee Naration" := Memo;
    //             purchaseHeader."Employee No" := ObjHREmployee."No.";
    //             purchaseHeader."Employee Name" := ObjHREmployee.FullName;
    //             purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
    //             purchaseHeader."Account No" := ObjHREmployee.Travelaccountno;
    //             purchaseHeader."User ID" := ObjHREmployee."Employee UserID";
    //             purchaseHeader."Responsibility Center" := ObjHREmployee."Responsibility Center";
    //             purchaseHeader."Responsibility Center Name" := ObjHREmployee."Responsibility Center Name";
    //             purchaseHeader."Needs Travel Request Form?" := NeedsTravel;
    //             if NeedsTravel = true then begin
    //                 purchaseHeader."Travel Requisition No" := TravelNo;
    //             end;
    //             purchaseHeader.fromDate := startdate;
    //             purchaseHeader."Due Date" := enddate;
    //             purchaseHeader."Currency Code" := Currency;
    //             if (Currency = 'KES') then
    //                 purchaseHeader."Currency Factor" := 1;
    //             purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
    //             purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
    //             purchaseHeader."Shortcut Dimension 1 Code" := purchaseHeader."Shortcut Dimension 1 Code";
    //             purchaseHeader."Shortcut Dimension 4 Code" := purchaseHeader."Shortcut Dimension 4 Code";

    //             if purchaseHeader.Modify(true) then begin
    //                 JSONTextWriter.WriteStartObject;
    //                 CreateJsonAttribute('No', purchaseHeader."No.");
    //                 CreateJsonAttribute('Document_Date', purchaseHeader."Document Date");
    //                 CreateJsonAttribute('Status', purchaseHeader.Status);
    //                 CreateJsonAttribute('ShortcutDimension1Code', purchaseHeader."Shortcut Dimension 1 Code");
    //                 CreateJsonAttribute('fromDate', purchaseHeader."Expected Receipt Date");
    //                 CreateJsonAttribute('DueDate', purchaseHeader."Document Date");
    //                 CreateJsonAttribute('ShortcutDimension4Code', purchaseHeader."Shortcut Dimension 2 Code");
    //                 CreateJsonAttribute('PayeeNaration', purchaseHeader."Payee Naration");
    //                 CreateJsonAttribute('Needs_Travel_Request_Form_x003F_', purchaseHeader."Needs Travel Request Form?");
    //                 CreateJsonAttribute('Travel_Requisition_No', purchaseHeader."Travel Requisition No");
    //                 JSONTextWriter.WriteEndObject;
    //             end;
    //             JsonOut := StringBuilder.ToString;
    //             returnout := JsonOut;
    //         end;
    //     end;
    // end;


    // procedure FnInsertTravelForm(empNo: Code[50]; projectcode: Code[20]; departmentcode: Code[20]; Names: Text; purpose: Text; TravelDestination: Text; SuggestedRouting: Text; startdate: Date; enddate: Date) returnout: Text
    // var
    //     JsonOut: dotnet String;
    //     purchaseHeader: Record "Purchase Order";
    //     hrEmployee: Record "HR Employees";
    //     ObjUserSetup: Record "User Setup";
    //     PayableSetup: Record "Purchases & Payables Setup";
    //     customer: Record "Customer";
    // begin
    //     if hrEmployee.Get(empNo) then begin
    //         StringBuilder := StringBuilder.StringBuilder;
    //         StringWriter := StringWriter.StringWriter(StringBuilder);
    //         JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
    //         GenLedgerSetup.Get();
    //         PayableSetup.Get();
    //         purchaseHeader.Init;
    //         purchaseHeader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Lease Numbers", 0D, true);
    //         purchaseHeader."No. Series" := GenLedgerSetup."Lease Numbers";
    //         purchaseHeader."Document Type" := purchaseHeader."Document Type"::Quote;
    //         purchaseHeader."Assigned User ID" := hrEmployee."Employee UserID";
    //         purchaseHeader."User ID" := hrEmployee."Employee UserID";
    //         purchaseHeader."AU Form Type" := purchaseHeader."AU Form Type"::"Travel Requsition Form";
    //         purchaseHeader."Posting Description" := Format(purchaseHeader."AU Form Type"::"Travel Requsition Form");
    //         purchaseHeader."Name of Person(s) Travelling" := Names;
    //         purchaseHeader."Purpose for Travel" := purpose;
    //         purchaseHeader."Travel Destination" := TravelDestination;
    //         purchaseHeader."Suggested Routing" := SuggestedRouting;
    //         purchaseHeader."Requested Receipt Date" := Today;
    //         purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
    //         purchaseHeader.Validate("Vendor Posting Group");
    //         purchaseHeader."Employee No" := hrEmployee."No.";
    //         purchaseHeader."Employee Name" := hrEmployee."First Name" + ' ' + hrEmployee."Middle Name" + ' ' + hrEmployee."Last Name";
    //         purchaseHeader."Account No" := hrEmployee.Travelaccountno;
    //         customer.get(hrEmployee.Travelaccountno);
    //         purchaseHeader."Responsibility Center" := hrEmployee."Responsibility Center";
    //         purchaseHeader."Responsibility Center Name" := hrEmployee."Responsibility Center Name";
    //         purchaseHeader."Document Date" := Today;
    //         purchaseHeader."Shortcut Dimension 1 Code" := projectcode;
    //         purchaseHeader."Shortcut Dimension 4 Code" := departmentcode;

    //         purchaseHeader.fromDate := startdate;
    //         purchaseHeader."Due Date" := enddate;
    //         purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
    //         purchaseHeader.Status := purchaseHeader.Status::Open;

    //         if purchaseHeader.Insert(true) then begin
    //             purchaseHeader."Shortcut Dimension 1 Code" := projectcode;
    //             purchaseHeader."Shortcut Dimension 4 Code" := departmentcode;
    //             purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
    //             purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
    //             purchaseHeader.Modify(true);
    //             Commit();
    //             JSONTextWriter.WriteStartObject;
    //             CreateJsonAttribute('No', purchaseHeader."No.");
    //             JSONTextWriter.WriteEndObject;
    //         end;
    //         JsonOut := StringBuilder.ToString;
    //         returnout := JsonOut;
    //     end;
    // end;

    // procedure FnEditTravelForm(empNo: Code[50]; Names: Text; purpose: Text; TravelDestination: Text; SuggestedRouting: Text; startdate: Date; enddate: Date; No: code[20]) returnout: Text
    // var
    //     JsonOut: dotnet String;
    //     purchaseHeader: Record "Purchase Order";
    //     hrEmployee: Record "HR Employees";
    //     ObjUserSetup: Record "User Setup";
    //     PayableSetup: Record "Purchases & Payables Setup";
    //     customer: Record "Customer";
    // begin
    //     if hrEmployee.Get(empNo) then begin
    //         purchaseHeader.reset;
    //         purchaseHeader.SetRange(purchaseHeader."No.", No);
    //         if purchaseHeader.FindFirst() then begin

    //             StringBuilder := StringBuilder.StringBuilder;
    //             StringWriter := StringWriter.StringWriter(StringBuilder);
    //             JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
    //             GenLedgerSetup.Get();
    //             PayableSetup.Get();
    //             purchaseHeader."No." := No;
    //             purchaseHeader."Document Type" := purchaseHeader."Document Type"::Quote;
    //             purchaseHeader."Assigned User ID" := hrEmployee."Employee UserID";
    //             purchaseHeader."User ID" := hrEmployee."Employee UserID";
    //             purchaseHeader."AU Form Type" := purchaseHeader."AU Form Type"::"Travel Requsition Form";
    //             purchaseHeader."Posting Description" := Format(purchaseHeader."AU Form Type"::"Travel Requsition Form");
    //             purchaseHeader."Requested Receipt Date" := Today;
    //             purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
    //             purchaseHeader.Validate("Vendor Posting Group");
    //             purchaseHeader."Employee No" := hrEmployee."No.";
    //             purchaseHeader."Employee Name" := hrEmployee."First Name" + ' ' + hrEmployee."Middle Name" + ' ' + hrEmployee."Last Name";
    //             purchaseHeader."Account No" := hrEmployee.Travelaccountno;
    //             customer.get(hrEmployee.Travelaccountno);
    //             purchaseHeader."Responsibility Center" := hrEmployee."Responsibility Center";
    //             purchaseHeader."Responsibility Center Name" := hrEmployee."Responsibility Center Name";
    //             purchaseHeader."Document Date" := Today;
    //             purchaseHeader.fromDate := startdate;
    //             purchaseHeader."Due Date" := enddate;
    //             purchaseHeader."Name of Person(s) Travelling" := Names;
    //             purchaseHeader."Purpose for Travel" := purpose;
    //             purchaseHeader."Travel Destination" := TravelDestination;
    //             purchaseHeader."Suggested Routing" := SuggestedRouting;

    //             purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
    //             purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
    //             purchaseHeader."Shortcut Dimension 1 Code" := purchaseHeader."Shortcut Dimension 1 Code";
    //             purchaseHeader."Shortcut Dimension 4 Code" := purchaseHeader."Shortcut Dimension 4 Code";

    //             if purchaseHeader.Modify(true) then begin
    //                 JSONTextWriter.WriteStartObject;
    //                 CreateJsonAttribute('No', purchaseHeader."No.");
    //                 JSONTextWriter.WriteEndObject;
    //             end;
    //             JsonOut := StringBuilder.ToString;
    //             returnout := JsonOut;
    //         end;
    //     end;
    // end;

    //Purchase Requisition

    //Imprest
    procedure FnInsertImprestRequisition(empNo: Code[50]; FundCode: Code[250]; ProgrammeCode: Code[250]; OutcomeCode: Code[250]; Deliverable: Code[250]; Purpose: Text[2048]; FromDate: Date; EndDate: Date; Currency: Code[20]) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        PayableSetup: Record "Purchases & Payables Setup";
        Dimensions: Record "Dimension Value";
    begin
        if ObjHREmployee.Get(empNo) then begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            GenLedgerSetup.Get();
            PayableSetup.Get();
            purchaseHeader.Reset();
            purchaseHeader.SetRange("Employee No", empNo);
            purchaseHeader.SetRange(fromDate, FromDate);
            purchaseHeader.SetRange(Purpose, Purpose);
            if purchaseHeader.Find('-') then begin
                error('Imprest Requisition Already exists with same activity date %1', purchaseHeader."No.")
            end else begin
                purchaseHeader.Init;
                purchaseHeader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Imprest Nos.", 0D, true);
                purchaseHeader."No. Series" := GenLedgerSetup."Imprest Nos.";
                purchaseHeader."Document Type" := purchaseHeader."Document Type"::Quote;
                purchaseHeader."AU Form Type" := purchaseHeader."AU Form Type"::"Imprest Requisition";
                purchaseHeader.IM := true;
                purchaseHeader."Document Date" := Today;
                purchaseHeader.DocApprovalType2 := purchaseHeader.DocApprovalType2::Requisition;
                purchaseHeader."Type of Payment2" := purchaseHeader."Type of Payment2"::Imprest;
                purchaseHeader."Doc Type" := purchaseHeader."Doc Type"::PurchReq;
                purchaseHeader.Purpose := Purpose;
                purchaseHeader."Employee No" := ObjHREmployee."No.";
                purchaseHeader."Employee Name" := ObjHREmployee."First Name" + ' ' + ObjHREmployee."Middle Name" + ' ' + ObjHREmployee."Last Name";
                purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."Account No" := ObjHREmployee.Travelaccountno;
                purchaseHeader."Employee Imprest Account No" := ObjHREmployee.Travelaccountno;
                purchaseHeader."User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."Responsibility Center" := ObjHREmployee."Responsibility Center";
                purchaseHeader."Responsibility Center Name" := ObjHREmployee."Responsibility Center Name";
                //purchaseHeader."Payee Naration" := Purpose;
                purchaseHeader.Department := ObjHREmployee."Programme or Department";
                purchaseHeader.fromDate := FromDate;
                purchaseHeader."Due Date" := EndDate;
                purchaseHeader."Order Date" := FromDate;
                purchaseHeader."Posting Date" := EndDate;
                purchaseHeader."Expected Receipt Date" := EndDate;
                purchaseHeader."Requested Receipt Date" := EndDate;
                IF Currency = 'USD' THEN begin
                    purchaseHeader."Currency Factor" := 1;//Added by collo on 12/08/24
                end else begin
                    purchaseHeader."Currency Code" := Currency;
                    purchaseHeader."Currency Factor" := CurrExchRate.ExchangeRate(Today, Currency);
                end;
                purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";


                purchaseHeader.IM := true;
                purchaseHeader.Status := purchaseHeader.Status::Open;
                purchaseHeader."Shortcut Dimension 1 Code" := FundCode;
                purchaseHeader."Shortcut Dimension 2 Code" := ProgrammeCode;
                purchaseHeader."Shortcut Dimension 3 Code" := Deliverable;
                purchaseHeader."Shortcut Dimension 4 Code" := OutcomeCode;
                Dimensions.Reset();
                Dimensions.SetRange(Dimensions.Code, ProgrammeCode);
                if Dimensions.FindFirst() then
                    purchaseHeader."Shortcut Dimension 5 Code" := Dimensions."Thematic Code";
                if purchaseHeader.Insert(true) then begin
                    purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
                    purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
                    purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
                    purchaseHeader.Modify(true);
                    Commit();
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', purchaseHeader."No.");
                    CreateJsonAttribute('Document_Date', purchaseHeader."Document Date");
                    CreateJsonAttribute('Status', purchaseHeader.Status);
                    CreateJsonAttribute('ShortcutDimension1Code', purchaseHeader."Shortcut Dimension 1 Code");
                    CreateJsonAttribute('fromDate', purchaseHeader."Expected Receipt Date");
                    CreateJsonAttribute('DueDate', purchaseHeader."Document Date");
                    CreateJsonAttribute('ShortcutDimension4Code', purchaseHeader."Shortcut Dimension 2 Code");
                    CreateJsonAttribute('PayeeNaration', purchaseHeader."Payee Naration");

                    JSONTextWriter.WriteEndObject;
                end;
                JsonOut := StringBuilder.ToString;
                returnout := JsonOut;
            end;
        end;
    end;

    procedure FnEditImprestRequisition(empNo: Code[50]; No: Code[250]; FundCode: Code[250]; ProgrammeCode: Code[250]; OutcomeCode: Code[250]; Deliverable: Code[250]; Purpose: Text[2048]; FromDate: Date; EndDate: Date; Currency: Code[20]) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        PayableSetup: Record "Purchases & Payables Setup";
        Dimensions: Record "Dimension Value";
    begin
        if ObjHREmployee.Get(empNo) then begin
            purchaseHeader.reset;
            purchaseHeader.SetRange("No.", No);
            if purchaseHeader.FindFirst() then begin

                StringBuilder := StringBuilder.StringBuilder;
                StringWriter := StringWriter.StringWriter(StringBuilder);
                JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
                GenLedgerSetup.Get();
                PayableSetup.Get();
                purchaseHeader."No." := No;
                purchaseHeader."Document Type" := purchaseHeader."Document Type"::Quote;
                purchaseHeader."AU Form Type" := purchaseHeader."AU Form Type"::"Imprest Requisition";
                purchaseHeader.IM := true;
                purchaseHeader."Document Date" := Today;
                purchaseHeader.DocApprovalType2 := purchaseHeader.DocApprovalType2::Requisition;
                purchaseHeader."Type of Payment2" := purchaseHeader."Type of Payment2"::Imprest;
                purchaseHeader."Doc Type" := purchaseHeader."Doc Type"::PurchReq;
                purchaseHeader.Purpose := Purpose;
                //purchaseHeader."Payee Naration" := Purpose;
                purchaseHeader."Employee No" := ObjHREmployee."No.";
                purchaseHeader."Employee Name" := ObjHREmployee."First Name" + ' ' + ObjHREmployee."Middle Name" + ' ' + ObjHREmployee."Last Name";
                purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."Account No" := ObjHREmployee.Travelaccountno;
                purchaseHeader."Employee Imprest Account No" := ObjHREmployee.Travelaccountno;
                purchaseHeader."User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."Responsibility Center" := ObjHREmployee."Responsibility Center";
                purchaseHeader."Responsibility Center Name" := ObjHREmployee."Responsibility Center Name";
                purchaseHeader.Department := ObjHREmployee."Programme or Department";
                purchaseHeader."Shortcut Dimension 4 Code" := ProgrammeCode;
                purchaseHeader.fromDate := FromDate;
                purchaseHeader."Due Date" := EndDate;
                purchaseHeader."Order Date" := FromDate;
                purchaseHeader."Posting Date" := EndDate;
                purchaseHeader."Expected Receipt Date" := EndDate;
                purchaseHeader."Requested Receipt Date" := EndDate;
                IF Currency = 'USD' THEN begin
                    purchaseHeader."Currency Factor" := 1;//Added by collo on 12/08/24
                end else begin
                    purchaseHeader."Currency Code" := Currency;
                    purchaseHeader."Currency Factor" := CurrExchRate.ExchangeRate(Today, Currency);
                end;
                purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
                purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
                purchaseHeader."Shortcut Dimension 1 Code" := FundCode;
                purchaseHeader."Shortcut Dimension 2 Code" := ProgrammeCode;
                purchaseHeader."Shortcut Dimension 3 Code" := Deliverable;
                purchaseHeader."Shortcut Dimension 4 Code" := OutcomeCode;
                Dimensions.Reset();
                Dimensions.SetRange(Dimensions.Code, ProgrammeCode);
                if Dimensions.FindFirst() then
                    purchaseHeader."Shortcut Dimension 5 Code" := Dimensions."Thematic Code";
                if purchaseHeader.Modify(true) then begin


                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', purchaseHeader."No.");
                    JSONTextWriter.WriteEndObject;
                end;
                JsonOut := StringBuilder.ToString;
                returnout := JsonOut;
            end;
        end;
    end;

    procedure FnInsertImprestRequisitionLines(No: Code[50]; AccountType: Code[2000]; Description2: Text; Quantity: Integer; Amount: Decimal; OutputCode: code[250]; LineNo: Integer) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        purchaseLine: Record "Purchase Line";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        purchaseLines: Record "Purchase Line";
        DonorBudgetMatrix: Record "G/L Budget Entry";
        Customer: Record Customer;
        StandardText: Record "Standard Text";
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        purchaseHeader.Reset();
        purchaseHeader.SetRange("No.", No);
        if purchaseHeader.FindFirst() then begin
            StandardText.Reset();
            StandardText.SetRange(StandardText.Code, AccountType);
            if StandardText.FindFirst() then begin
                Customer.Get(purchaseHeader."Account No");
                purchaseLine.Init;
                purchaseLine."Line No." := LineNo;
                purchaseLine.Type := purchaseLine.Type::"G/L Account";
                purchaseLine."No." := StandardText."G/L Account";
                purchaseLine.Description := StandardText.Description;
                purchaseLine."Shortcut Dimension 1 Code" := purchaseHeader."Shortcut Dimension 1 Code";
                purchaseLine."Shortcut Dimension 2 Code" := purchaseHeader."Shortcut Dimension 2 Code";
                purchaseLine."ShortcutDimCode[3]" := purchaseHeader."Shortcut Dimension 3 Code";
                purchaseLine."ShortcutDimCode[4]" := purchaseHeader."Shortcut Dimension 4 Code";
                purchaseLine."Document No." := No;
                purchaseLine."Expense Category" := AccountType;
                purchaseLine."Document Type" := purchaseLine."Document Type"::Quote;
                purchaseLine."Description 2" := Description2;
                purchaseLine."Imprest Account No" := purchaseHeader."Account No";
                purchaseLine."Imprest Account Name" := Customer.Name;
                purchaseLine."Direct Unit Cost" := Amount;
                //purchaseLine.Validate("Direct Unit Cost");

                purchaseLine.Quantity := Quantity;
                // purchaseLine.Validate(Quantity);
                purchaseLine."Amount Including VAT" := Amount;
                // purchaseLine.Validate("Amount Including VAT");

                purchaseLine."Unit Cost (LCY)" := CurrExchRate.ExchangeAmtFCYToLCY(Today, purchaseHeader."Currency Code", Amount, purchaseHeader."Currency Factor");
                purchaseLine."Unit Cost (LCY) New" := CurrExchRate.ExchangeAmtFCYToLCY(Today, purchaseHeader."Currency Code", Amount, purchaseHeader."Currency Factor");
                purchaseLine."Amount New" := purchaseLine."Unit Cost (LCY) New" * Quantity;
                purchaseLine."Line Amount" := purchaseLine."Unit Cost (LCY) New" * Quantity;
                purchaseLine."Line Amount New" := Amount * Quantity;
                purchaseLine.Validate("Line Amount");
                purchaseLine."Currency Code" := purchaseHeader."Currency Code";
                purchaseLine."Currency Factor" := purchaseHeader."Currency Factor";
                if purchaseLine.Insert(true) then begin
                    Commit();

                    purchaseLine."Imprest Account No" := purchaseHeader."Account No";
                    purchaseLine.Validate("Imprest Account No");
                    purchaseLine.Modify(true);
                    Commit();
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', purchaseHeader."No.");
                    JSONTextWriter.WriteEndObject;
                end;
                JsonOut := StringBuilder.ToString;
                returnout := JsonOut;
            end;
        end;
    end;

    procedure FnEditImprestRequisitionLines(No: Code[50]; AccountType: Code[2000]; Description2: Text; Quantity: Integer; Amount: Decimal; OutputCode: code[250]; LineNo: Integer) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        purchaseLine: Record "Purchase Line";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        DonorBudgetMatrix: Record "G/L Budget Entry";
        Customer: Record Customer;
        StandardText: Record "Standard Text";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        purchaseHeader.Reset();
        purchaseHeader.SetRange("No.", No);
        if purchaseHeader.FindFirst() then begin
            purchaseLine.Reset();
            purchaseLine.SetRange(purchaseLine."Document No.", No);
            purchaseLine.SetRange(purchaseLine."Line No.", LineNo);
            purchaseLine.SetRange("Document Type", purchaseLine."Document Type"::Quote);
            if purchaseLine.Find('-') then begin
                StandardText.Reset();
                StandardText.SetRange(StandardText.Code, AccountType);
                if StandardText.FindFirst() then begin
                    Customer.Get(purchaseHeader."Account No");
                    purchaseLine."Line No." := LineNo;
                    purchaseLine.Type := purchaseLine.Type::"G/L Account";
                    purchaseLine."No." := StandardText."G/L Account";
                    purchaseLine.Description := StandardText.Description;
                    purchaseLine."Shortcut Dimension 1 Code" := purchaseHeader."Shortcut Dimension 1 Code";
                    purchaseLine."Shortcut Dimension 2 Code" := purchaseHeader."Shortcut Dimension 2 Code";
                    purchaseLine."ShortcutDimCode[3]" := purchaseHeader."Shortcut Dimension 3 Code";
                    purchaseLine."ShortcutDimCode[4]" := purchaseHeader."Shortcut Dimension 4 Code";
                    purchaseLine."Document No." := No;
                    purchaseLine."Expense Category" := AccountType;
                    purchaseLine."Document Type" := purchaseLine."Document Type"::Quote;
                    purchaseLine."Description 2" := Description2;
                    purchaseLine."Imprest Account No" := purchaseHeader."Account No";
                    purchaseLine."Imprest Account Name" := Customer.Name;
                    purchaseLine."Direct Unit Cost" := Amount;
                    // purchaseLine.Validate("Direct Unit Cost");

                    purchaseLine.Quantity := Quantity;
                    //purchaseLine.Validate(Quantity);
                    purchaseLine."Amount Including VAT" := Amount;
                    // purchaseLine.Validate("Amount Including VAT");

                    purchaseLine."Unit Cost (LCY)" := CurrExchRate.ExchangeAmtFCYToLCY(Today, purchaseHeader."Currency Code", Amount, purchaseHeader."Currency Factor");
                    purchaseLine."Unit Cost (LCY) New" := CurrExchRate.ExchangeAmtFCYToLCY(Today, purchaseHeader."Currency Code", Amount, purchaseHeader."Currency Factor");
                    purchaseLine."Amount New" := purchaseLine."Unit Cost (LCY) New" * Quantity;
                    purchaseLine."Line Amount" := purchaseLine."Unit Cost (LCY) New" * Quantity;
                    purchaseLine."Line Amount New" := Amount * Quantity;
                    purchaseLine.Validate("Line Amount");
                    purchaseLine."Currency Code" := purchaseHeader."Currency Code";
                    purchaseLine."Currency Factor" := purchaseHeader."Currency Factor";

                    if purchaseLine.Modify(true) then begin
                        purchaseHeader.Reset();
                        purchaseHeader.SetRange("No.", No);
                        if purchaseHeader.Find('-') then
                            if purchaseHeader."Currency Code" <> '' then begin

                                purchaseHeader.TestField("Currency Factor");
                                purchaseLine."Unit Cost (LCY) New" :=
                                  CurrExchRate.ExchangeAmtFCYToLCY(
                                    Today, purchaseHeader."Currency Code",
                                    purchaseLine."Direct Unit Cost", purchaseHeader."Currency Factor");
                            end;
                        purchaseLine."Amount New" := purchaseLine."Unit Cost (LCY) New" * purchaseLine.Quantity;

                        purchaseLine.Modify();

                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('No', purchaseHeader."No.");
                        JSONTextWriter.WriteEndObject;
                    end;
                    JsonOut := StringBuilder.ToString;
                    returnout := JsonOut;
                end;
            end;
        end;
    end;

    //Purchase Req
    procedure FnInsertPurchaseRequisition(empNo: Code[50]; ProgrammeCode: Code[250]; Purpose: Text[2048]; FromDate: Date; EndDate: Date; Currency: Code[20]; ExpenseCode: Code[30]; RequestDate: Date) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        PayableSetup: Record "Purchases & Payables Setup";
    begin
        if ObjHREmployee.Get(empNo) then begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            GenLedgerSetup.Get();
            PayableSetup.Get();
            purchaseHeader.Reset();
            purchaseHeader.SetRange("Employee No", empNo);
            purchaseHeader.SetRange(fromDate, FromDate);
            if purchaseHeader.find('-') then begin
                Error('A Purchase Requistion of same date already exists From date %1', FromDate);
            end else begin

                purchaseHeader.Init;
                purchaseHeader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Requisition Nos.", 0D, true);
                purchaseHeader."No. Series" := GenLedgerSetup."Requisition Nos.";
                purchaseHeader."Document Type" := purchaseHeader."Document Type"::Quote;
                purchaseHeader."AU Form Type" := purchaseHeader."AU Form Type"::"Purchase Requisition";
                purchaseHeader.PR := true;
                purchaseHeader."Document Date" := Today;
                purchaseHeader.DocApprovalType2 := purchaseHeader.DocApprovalType2::Purchase;
                purchaseHeader."Type of Payment2" := purchaseHeader."Type of Payment2"::PurchaseRequisition;
                purchaseHeader."Doc Type" := purchaseHeader."Doc Type"::PurchReq;
                purchaseHeader.Purpose := Purpose;
                //purchaseHeader."Payee Naration" := Purpose;
                purchaseHeader."Employee No" := ObjHREmployee."No.";
                purchaseHeader."Employee Name" := ObjHREmployee."First Name" + ' ' + ObjHREmployee."Middle Name" + ' ' + ObjHREmployee."Last Name";
                purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."Responsibility Center" := ObjHREmployee."Responsibility Center";
                purchaseHeader."Responsibility Center Name" := ObjHREmployee."Responsibility Center Name";
                purchaseHeader.Department := ObjHREmployee."Programme or Department";
                purchaseHeader.fromDate := FromDate;
                purchaseHeader."Due Date" := EndDate;
                purchaseHeader."Order Date" := FromDate;
                purchaseHeader."Posting Date" := RequestDate;
                purchaseHeader."Expected Receipt Date" := EndDate;
                purchaseHeader."Requested Receipt Date" := EndDate;
                IF Currency = 'USD' THEN begin
                    purchaseHeader."Currency Factor" := 1;//Added by collo on 12/08/24
                end else begin
                    purchaseHeader."Currency Code" := Currency;
                    purchaseHeader."Currency Factor" := CurrExchRate.ExchangeRate(Today, Currency);
                end;
                purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
                purchaseHeader."Expense Requisition No" := ExpenseCode;
                purchaseHeader.Status := purchaseHeader.Status::Open;

                if purchaseHeader.Insert(true) then begin
                    purchaseHeader."Shortcut Dimension 4 Code" := ProgrammeCode;
                    purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
                    purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
                    purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
                    purchaseHeader.Modify(true);
                    Commit();
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', purchaseHeader."No.");
                    CreateJsonAttribute('Document_Date', purchaseHeader."Document Date");
                    CreateJsonAttribute('Status', purchaseHeader.Status);
                    CreateJsonAttribute('ShortcutDimension1Code', purchaseHeader."Shortcut Dimension 1 Code");
                    CreateJsonAttribute('fromDate', purchaseHeader."Expected Receipt Date");
                    CreateJsonAttribute('DueDate', purchaseHeader."Document Date");
                    CreateJsonAttribute('ShortcutDimension4Code', purchaseHeader."Shortcut Dimension 2 Code");
                    CreateJsonAttribute('PayeeNaration', purchaseHeader."Payee Naration");

                    JSONTextWriter.WriteEndObject;
                end;
                JsonOut := StringBuilder.ToString;
                returnout := JsonOut;
            end;
        end
    end;

    procedure FnEditPurchaseRequisition(empNo: Code[50]; ProgrammeCode: Code[250]; Purpose: Text[2048]; FromDate: Date; EndDate: Date; Currency: Code[20]; No: code[20]; ExpenseCode: Code[30]) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        PayableSetup: Record "Purchases & Payables Setup";
    begin
        if ObjHREmployee.Get(empNo) then begin
            purchaseHeader.reset;
            purchaseHeader.SetRange("No.", No);
            if purchaseHeader.FindFirst() then begin

                StringBuilder := StringBuilder.StringBuilder;
                StringWriter := StringWriter.StringWriter(StringBuilder);
                JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
                GenLedgerSetup.Get();
                PayableSetup.Get();
                purchaseHeader."No." := No;
                purchaseHeader."Document Type" := purchaseHeader."Document Type"::Quote;
                purchaseHeader."AU Form Type" := purchaseHeader."AU Form Type"::"Purchase Requisition";
                purchaseHeader.IM := true;
                purchaseHeader."Document Date" := Today;
                purchaseHeader.DocApprovalType2 := purchaseHeader.DocApprovalType2::Requisition;
                purchaseHeader."Type of Payment2" := purchaseHeader."Type of Payment2"::PurchaseRequisition;
                purchaseHeader."Doc Type" := purchaseHeader."Doc Type"::PurchReq;
                purchaseHeader.Purpose := Purpose;
                //purchaseHeader."Payee Naration" := Purpose;
                purchaseHeader."Employee No" := ObjHREmployee."No.";
                purchaseHeader."Employee Name" := ObjHREmployee."First Name" + ' ' + ObjHREmployee."Middle Name" + ' ' + ObjHREmployee."Last Name";
                purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."Responsibility Center" := ObjHREmployee."Responsibility Center";
                purchaseHeader."Responsibility Center Name" := ObjHREmployee."Responsibility Center Name";
                purchaseHeader.Department := ObjHREmployee."Programme or Department";
                purchaseHeader."Shortcut Dimension 4 Code" := ProgrammeCode;
                purchaseHeader.fromDate := FromDate;
                purchaseHeader."Due Date" := EndDate;
                purchaseHeader."Order Date" := FromDate;
                purchaseHeader."Posting Date" := EndDate;
                purchaseHeader."Expected Receipt Date" := EndDate;
                purchaseHeader."Requested Receipt Date" := EndDate;
                IF Currency = 'USD' THEN begin
                    purchaseHeader."Currency Factor" := 1;//Added by collo on 12/08/24
                end else begin
                    purchaseHeader."Currency Code" := Currency;
                    purchaseHeader."Currency Factor" := CurrExchRate.ExchangeRate(Today, Currency);
                end;
                purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
                purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
                purchaseHeader."Expense Requisition No" := ExpenseCode;
                if purchaseHeader.Modify(true) then begin
                    purchaseHeader."Shortcut Dimension 4 Code" := ProgrammeCode;
                    purchaseHeader.Modify(true);
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', purchaseHeader."No.");
                    JSONTextWriter.WriteEndObject;
                end;
                JsonOut := StringBuilder.ToString;
                returnout := JsonOut;
            end;
        end;
    end;

    procedure FnInsertPurchaseRequisitionLines(No: Code[50]; AccountNo: Code[2000]; ImprestParticular: Text; Amount: Decimal; Project: Code[100];
  Budget: Code[100]; Donor: Code[100]; Dept: Code[100]; Strategic: Code[100]; CaseCode: Code[100]; Currency: code[20]; Comment: Text; Lineno: Integer) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        purchaseLine: Record "Purchase Line";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        purchaseLines: Record "Purchase Line";
        //DonorBudgetMatrix: Record "Donors Budget Matrix line";
        DonorBudgetMatrix: Record "G/L Budget Entry";
        Customer: Record Customer;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        purchaseHeader.Reset();
        purchaseHeader.SetRange("No.", No);
        if purchaseHeader.FindFirst() then begin

            DonorBudgetMatrix.Reset();
            DonorBudgetMatrix.SetRange(DonorBudgetMatrix."Global Dimension 1 Code", Project);
            DonorBudgetMatrix.SetRange(DonorBudgetMatrix."Global Dimension 2 Code", Budget);
            if DonorBudgetMatrix.FindFirst() then begin
                purchaseLine.Init;
                purchaseLine."Line No." := Lineno;
                //DonorBudgetMatrix.CalcFields("Committed Amount");
                purchaseLine.Type := purchaseLine.Type::"G/L Account";
                purchaseLine."No." := AccountNo;
                purchaseLine.Description := DonorBudgetMatrix.Description;
                purchaseLine."Budget Line description" := DonorBudgetMatrix."Budget Line Description";
                purchaseLine."Shortcut Dimension 1 Code" := DonorBudgetMatrix."Global Dimension 1 Code";
                purchaseLine."Shortcut Dimension 2 Code" := DonorBudgetMatrix."Global Dimension 2 Code";
                purchaseLine."Budget Amount" := DonorBudgetMatrix.Amount;
                purchaseLine."Committed Amount" := 0;
                purchaseLine."Budget Balance" := 0;
                purchaseLine."Document No." := No;
                purchaseLine."Document Type" := purchaseLine."Document Type"::Quote;
                purchaseLine."Description 2" := ImprestParticular;
                purchaseLine."Direct Unit Cost" := Amount;
                purchaseLine.Validate("Direct Unit Cost");
                purchaseLine.Amount := Amount;
                purchaseLine.Validate(Amount);
                purchaseLine.Quantity := 1;
                purchaseLine."Amount Including VAT" := Amount;
                purchaseLine.Validate("Amount Including VAT");
                purchaseLine."Currency Code" := Currency;
                purchaseLine."Line Comments" := Comment;
                if purchaseLine.Insert(true) then begin
                    Commit();
                    purchaseLine."ShortcutDimCode[3]" := Project;
                    purchaseLine."ShortcutDimCode[4]" := Budget;
                    purchaseLine."ShortcutDimCode[5]" := Donor;
                    purchaseLine."ShortcutDimCode[6]" := Dept;
                    purchaseLine."ShortcutDimCode[7]" := Strategic;
                    purchaseLine."ShortcutDimCode[8]" := CaseCode;
                    purchaseLine."Imprest Account No" := purchaseHeader."Account No";
                    purchaseLine.Validate("Imprest Account No");
                    purchaseLine.Modify(true);
                    Commit();
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', purchaseHeader."No.");
                    JSONTextWriter.WriteEndObject;
                end;
                JsonOut := StringBuilder.ToString;
                returnout := JsonOut;
            end;
        end;
    end;


    procedure FnEditPurchaseRequisitionLines(No: Code[50]; AccountNo: Code[2000]; ImprestParticular: Text; Amount: Decimal; Project: Code[100];
  Budget: Code[100]; Donor: Code[100]; Dept: Code[100]; Strategic: Code[100]; CaseCode: Code[100]; Currency: code[20]; LineNo: Integer; Comment: Text) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        purchaseLine: Record "Purchase Line";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        //DonorBudgetMatrix: Record "Donors Budget Matrix line";
        DonorBudgetMatrix: Record "G/L Budget Entry";
        Customer: Record Customer;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        purchaseHeader.Reset();
        purchaseHeader.SetRange("No.", No);
        if purchaseHeader.FindFirst() then begin
            purchaseLine.Reset();

            purchaseLine.SetRange(purchaseLine."Document No.", No);
            if purchaseLine.Find('-') then begin
                DonorBudgetMatrix.Reset();
                DonorBudgetMatrix.SetRange(DonorBudgetMatrix."Global Dimension 1 Code", purchaseLine."Shortcut Dimension 1 Code");
                DonorBudgetMatrix.SetRange(DonorBudgetMatrix."Global Dimension 2 Code", purchaseLine."Shortcut Dimension 2 Code");
                if DonorBudgetMatrix.FindFirst() then begin
                    //DonorBudgetMatrix.CalcFields("Committed Amount");
                    purchaseLine.Type := purchaseLine.Type::"G/L Account";
                    purchaseLine."No." := AccountNo;
                    purchaseLine.Description := DonorBudgetMatrix.Description;
                    purchaseLine."Budget Line description" := DonorBudgetMatrix."Budget Line Description";
                    purchaseLine."Shortcut Dimension 1 Code" := DonorBudgetMatrix."Global Dimension 1 Code";
                    purchaseLine."Shortcut Dimension 2 Code" := DonorBudgetMatrix."Global Dimension 2 Code";
                    purchaseLine."Budget Amount" := DonorBudgetMatrix.Amount;
                    purchaseLine."Budget Amount" := DonorBudgetMatrix.Amount;
                    purchaseLine."Committed Amount" := 0;
                    purchaseLine."Budget Balance" := 0;
                    purchaseLine."Document No." := No;
                    purchaseLine."Line No." := LineNo;
                    purchaseLine."Document Type" := purchaseLine."Document Type"::Quote;
                    purchaseLine."Description 2" := ImprestParticular;
                    purchaseLine."Direct Unit Cost" := Amount;
                    purchaseLine.Validate("Direct Unit Cost");
                    purchaseLine.Amount := Amount;
                    purchaseLine.Validate(Amount);
                    purchaseLine.Quantity := 1;
                    purchaseLine."Amount Including VAT" := Amount;
                    purchaseLine.Validate("Amount Including VAT");
                    purchaseLine."Currency Code" := Currency;
                    purchaseLine."Line Comments" := Comment;
                    if purchaseLine.Modify(true) then begin
                        purchaseLine."ShortcutDimCode[3]" := Project;
                        purchaseLine."ShortcutDimCode[4]" := Budget;
                        purchaseLine."ShortcutDimCode[5]" := Donor;
                        purchaseLine."ShortcutDimCode[6]" := Dept;
                        purchaseLine."ShortcutDimCode[7]" := Strategic;
                        purchaseLine."ShortcutDimCode[8]" := CaseCode;
                        purchaseLine."No." := DonorBudgetMatrix."G/L Account No.";
                        purchaseLine.Description := DonorBudgetMatrix."Budget Line Description";
                        purchaseLine.Modify(true);
                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('No', purchaseHeader."No.");
                        JSONTextWriter.WriteEndObject;
                    end;
                    JsonOut := StringBuilder.ToString;
                    returnout := JsonOut;
                end;
            end;
        end;
    end;

    //Expense Req   

    procedure FnInsertExpenseRequisition(empNo: Code[50]; ProgrammeCode: Code[250]; FundCode: Code[250]; PayeeNarration: Text; DateRequired: Date; Currency: Code[20]) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        PayableSetup: Record "Purchases & Payables Setup";
    begin
        if ObjHREmployee.Get(empNo) then begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            GenLedgerSetup.Get();
            PayableSetup.Get();
            purchaseHeader.Init;
            purchaseHeader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Landlord Nos", 0D, true);
            purchaseHeader."No. Series" := GenLedgerSetup."Landlord Nos";
            purchaseHeader."Document Type" := purchaseHeader."Document Type"::Quote;
            purchaseHeader."AU Form Type" := purchaseHeader."AU Form Type"::"Expense Requisition";
            purchaseHeader."Document Date" := Today;
            purchaseHeader.DocApprovalType2 := purchaseHeader.DocApprovalType2::Purchase;
            purchaseHeader."Type of Payment2" := purchaseHeader."Type of Payment2"::General;
            purchaseHeader."Doc Type" := purchaseHeader."Doc Type"::PurchReq;
            purchaseHeader.Purpose := PayeeNarration;
            purchaseHeader."Payee Naration" := PayeeNarration;
            purchaseHeader."Employee No" := ObjHREmployee."No.";
            purchaseHeader."Employee Name" := ObjHREmployee."First Name" + ' ' + ObjHREmployee."Middle Name" + ' ' + ObjHREmployee."Last Name";
            purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
            purchaseHeader."User ID" := ObjHREmployee."Employee UserID";
            purchaseHeader."Responsibility Center" := ObjHREmployee."Responsibility Center";
            purchaseHeader."Responsibility Center Name" := ObjHREmployee."Responsibility Center Name";
            purchaseHeader.Department := ObjHREmployee."Programme or Department";
            purchaseHeader.fromDate := DateRequired;
            purchaseHeader."Due Date" := DateRequired;
            purchaseHeader."Order Date" := DateRequired;
            purchaseHeader."Posting Date" := DateRequired;
            purchaseHeader."Expected Receipt Date" := DateRequired;
            purchaseHeader."Requested Receipt Date" := DateRequired;
            purchaseHeader."Currency Code" := Currency;
            purchaseHeader."Currency Factor" := CurrExchRate.ExchangeRate(Today, Currency);
            purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
            purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
            purchaseHeader.Status := purchaseHeader.Status::Open;
            purchaseHeader."Shortcut Dimension 1 Code" := FundCode;
            purchaseHeader."Shortcut Dimension 4 Code" := ProgrammeCode;
            if purchaseHeader.Insert(true) then begin
                purchaseHeader."Shortcut Dimension 1 Code" := FundCode;
                purchaseHeader."Shortcut Dimension 4 Code" := ProgrammeCode;
                purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";

                purchaseHeader.Modify(true);
                Commit();
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', purchaseHeader."No.");
                CreateJsonAttribute('Document_Date', purchaseHeader."Document Date");
                CreateJsonAttribute('Status', purchaseHeader.Status);
                CreateJsonAttribute('ShortcutDimension1Code', purchaseHeader."Shortcut Dimension 1 Code");
                CreateJsonAttribute('fromDate', purchaseHeader."Expected Receipt Date");
                CreateJsonAttribute('DueDate', purchaseHeader."Document Date");
                CreateJsonAttribute('ShortcutDimension4Code', purchaseHeader."Shortcut Dimension 2 Code");
                CreateJsonAttribute('PayeeNaration', purchaseHeader."Payee Naration");

                JSONTextWriter.WriteEndObject;
            end;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
        end;
    end;

    procedure FnEditExpenseRequisition(empNo: Code[50]; ProgrammeCode: Code[250]; FundCode: Code[250]; PayeeNarration: Text; DateRequired: Date; Currency: Code[20]; No: code[20]) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        PayableSetup: Record "Purchases & Payables Setup";
    begin
        if ObjHREmployee.Get(empNo) then begin
            purchaseHeader.reset;
            purchaseHeader.SetRange("No.", No);
            if purchaseHeader.FindFirst() then begin

                StringBuilder := StringBuilder.StringBuilder;
                StringWriter := StringWriter.StringWriter(StringBuilder);
                JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
                GenLedgerSetup.Get();
                PayableSetup.Get();
                purchaseHeader."No." := No;
                purchaseHeader."Document Type" := purchaseHeader."Document Type"::Quote;
                purchaseHeader."AU Form Type" := purchaseHeader."AU Form Type"::"Expense Requisition";
                purchaseHeader."Document Date" := Today;
                purchaseHeader.DocApprovalType2 := purchaseHeader.DocApprovalType2::Purchase;
                purchaseHeader."Type of Payment2" := purchaseHeader."Type of Payment2"::General;
                purchaseHeader."Doc Type" := purchaseHeader."Doc Type"::PurchReq;
                purchaseHeader.Purpose := PayeeNarration;
                purchaseHeader."Payee Naration" := PayeeNarration;
                purchaseHeader."Employee No" := ObjHREmployee."No.";
                purchaseHeader."Employee Name" := ObjHREmployee."First Name" + ' ' + ObjHREmployee."Middle Name" + ' ' + ObjHREmployee."Last Name";
                purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."Responsibility Center" := ObjHREmployee."Responsibility Center";
                purchaseHeader."Responsibility Center Name" := ObjHREmployee."Responsibility Center Name";
                purchaseHeader.Department := ObjHREmployee."Programme or Department";
                purchaseHeader.fromDate := DateRequired;
                purchaseHeader."Due Date" := DateRequired;
                purchaseHeader."Order Date" := DateRequired;
                purchaseHeader."Posting Date" := DateRequired;
                purchaseHeader."Expected Receipt Date" := DateRequired;
                purchaseHeader."Requested Receipt Date" := DateRequired;
                purchaseHeader."Currency Code" := Currency;
                purchaseHeader."Currency Factor" := CurrExchRate.ExchangeRate(Today, Currency);
                purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
                purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
                purchaseHeader.Status := purchaseHeader.Status::Open;
                purchaseHeader."Shortcut Dimension 1 Code" := FundCode;
                purchaseHeader."Shortcut Dimension 4 Code" := ProgrammeCode;
                if purchaseHeader.Modify(true) then begin
                    purchaseHeader."Shortcut Dimension 1 Code" := FundCode;
                    purchaseHeader."Shortcut Dimension 4 Code" := ProgrammeCode;
                    purchaseHeader.Modify(true);
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', purchaseHeader."No.");
                    JSONTextWriter.WriteEndObject;
                end;
                JsonOut := StringBuilder.ToString;
                returnout := JsonOut;
            end;
        end;
    end;

    procedure FnInsertExpenseRequisitionLines(No: Code[50]; AccountNo: Code[2000]; ImprestParticular: Text; Amount: Decimal; FundCode: Code[100];
  Budget: Code[100]; Donor: Code[100]; Dept: Code[100]; StaffCode: Code[100]; OutputCode: Code[100]; Strategic: Code[100]; CaseCode: Code[100]; Currency: code[20]; Comment: Text; LineNo: Integer; Quantity: Integer) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        purchaseLine: Record "Purchase Line";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        purchaseLines: Record "Purchase Line";
        DonorBudgetMatrix: Record "Donors Budget Matrix line";
        Customer: Record Customer;
        GL: Record "G/L Account";
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        purchaseHeader.Reset();
        purchaseHeader.SetRange("No.", No);
        if purchaseHeader.FindFirst() then begin
            GlBudget.Reset();
            GlBudget.SetRange(GlBudget."Global Dimension 1 Code", FundCode);//dded by Ron
            GlBudget.SetRange(GlBudget."Global Dimension 2 Code", Budget);//addition
            if GlBudget.FindFirst() then begin
                GL.Reset();
                GL.SetRange(GL."No.", AccountNo);
                if GL.FindFirst() then
                    purchaseLine.Init;
                purchaseLine."Line No." := LineNo;
                purchaseLine.Type := purchaseLine.Type::"G/L Account";
                purchaseLine."No." := AccountNo;
                purchaseLine."Account No New" := AccountNo;
                purchaseLine.Description := GL.Name;
                purchaseLine."Budget Line description" := GlBudget."Budget Line Description";
                purchaseLine."Shortcut Dimension 1 Code" := FundCode;
                purchaseLine."Shortcut Dimension 2 Code" := Budget;
                //DonorBudgetMatrix.CalcFields("Committed Amount");
                purchaseLine."Budget Amount" := GlBudget.Amount;
                purchaseLine."Committed Amount" := 0;
                purchaseLine."Budget Balance" := GlBudget.Amount - 0;
                purchaseLine."Document No." := No;
                purchaseLine."Document Type" := purchaseLine."Document Type"::Quote;
                purchaseLine."Description 2" := ImprestParticular;
                purchaseLine."Direct Unit Cost" := Amount;
                purchaseLine.Validate("Direct Unit Cost");
                purchaseLine.Quantity := Quantity;
                purchaseLine."Amount In Foreign" := Amount;
                purchaseLine.Amount := Amount;
                purchaseLine.Validate(Amount);
                purchaseLine."Amount Including VAT" := Amount;
                purchaseLine.Validate("Amount Including VAT");
                purchaseLine."Currency Code" := Currency;
                purchaseLine."Currency Factor" := purchaseHeader."Currency Factor";
                purchaseLine."Line Comments" := Comment;
                if purchaseLine.Insert(true) then begin
                    purchaseLine."ShortcutDimCode[3]" := Donor;
                    purchaseLine."ShortcutDimCode[4]" := Dept;
                    purchaseLine."ShortcutDimCode[5]" := StaffCode;
                    purchaseLine."ShortcutDimCode[6]" := OutputCode;
                    purchaseLine."ShortcutDimCode[7]" := Strategic;
                    purchaseLine."ShortcutDimCode[8]" := CaseCode;
                    purchaseLine."Imprest Account No" := purchaseHeader."Account No";
                    purchaseLine.Validate("Imprest Account No");
                    purchaseLine.Modify(true);
                    Commit();
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', purchaseHeader."No.");
                    JSONTextWriter.WriteEndObject;
                end;
                JsonOut := StringBuilder.ToString;
                returnout := JsonOut;
            end;
        end;
    end;

    procedure FnInsertPurchaseReq(empNo: Code[50]; ProgrammeCode: Code[250]; FundCode: Code[250]; PayeeNarration: Text; Currency: Code[20]; RequestDate: Date) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        PayableSetup: Record "Purchases & Payables Setup";
        Dimensions: Record "Dimension Value";
    begin
        if ObjHREmployee.Get(empNo) then begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);

            GenLedgerSetup.Get();
            PayableSetup.Get();
            purchaseHeader.Init;
            purchaseHeader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Landlord Nos", 0D, true);
            purchaseHeader."No. Series" := GenLedgerSetup."Landlord Nos";
            purchaseHeader."Document Type" := purchaseHeader."Document Type"::Quote;
            purchaseHeader."AU Form Type" := purchaseHeader."AU Form Type"::"Purchase Requisition";
            purchaseHeader."Document Date" := Today;
            purchaseHeader.DocApprovalType2 := purchaseHeader.DocApprovalType2::Purchase;
            purchaseHeader."Type of Payment2" := purchaseHeader."Type of Payment2"::General;
            purchaseHeader."Doc Type" := purchaseHeader."Doc Type"::PurchReq;
            purchaseHeader.Purpose := PayeeNarration;
            purchaseHeader."Payee Naration" := PayeeNarration;
            purchaseHeader."Employee No" := ObjHREmployee."No.";
            purchaseHeader."Employee Name" := ObjHREmployee."First Name" + ' ' + ObjHREmployee."Middle Name" + ' ' + ObjHREmployee."Last Name";
            purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
            purchaseHeader."User ID" := ObjHREmployee."Employee UserID";
            purchaseHeader."Responsibility Center" := ObjHREmployee."Responsibility Center";
            purchaseHeader."Responsibility Center Name" := ObjHREmployee."Responsibility Center Name";
            purchaseHeader.Department := ObjHREmployee."Programme or Department";
            IF Currency = 'USD' THEN begin
                purchaseHeader."Currency Factor" := 1;//Added by collo on 12/08/24
            end else begin
                purchaseHeader."Currency Code" := Currency;
                purchaseHeader."Currency Factor" := CurrExchRate.ExchangeRate(Today, Currency);
            end;
            purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
            purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
            purchaseHeader.Status := purchaseHeader.Status::Open;
            purchaseHeader."Shortcut Dimension 1 Code" := FundCode;
            purchaseHeader."Shortcut Dimension 2 Code" := ProgrammeCode;
            purchaseHeader."Posting Date" := RequestDate;
            Dimensions.Reset();
            Dimensions.SetRange(Dimensions.Code, ProgrammeCode);
            if Dimensions.FindFirst() then
                purchaseHeader."Shortcut Dimension 5 Code" := Dimensions."Thematic Code";
            if purchaseHeader.Insert(true) then begin
                purchaseHeader."Shortcut Dimension 1 Code" := FundCode;
                purchaseHeader."Shortcut Dimension 2 Code" := ProgrammeCode;
                purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";

                purchaseHeader.Modify(true);
                Commit();
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', purchaseHeader."No.");
                CreateJsonAttribute('Document_Date', purchaseHeader."Document Date");
                CreateJsonAttribute('Status', purchaseHeader.Status);
                CreateJsonAttribute('ShortcutDimension1Code', purchaseHeader."Shortcut Dimension 1 Code");
                CreateJsonAttribute('ShortcutDimension4Code', purchaseHeader."Shortcut Dimension 2 Code");
                CreateJsonAttribute('PayeeNaration', purchaseHeader."Payee Naration");

                JSONTextWriter.WriteEndObject;
            end;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
        end;
    end;

    procedure FnEditPurchaseReq(empNo: Code[50]; ProgrammeCode: Code[250]; FundCode: Code[250]; PayeeNarration: Text; Currency: Code[20]; No: code[20]; RequestDate: Date) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        PayableSetup: Record "Purchases & Payables Setup";
        Dimensions: Record "Dimension Value";
    begin
        if ObjHREmployee.Get(empNo) then begin
            purchaseHeader.reset;
            purchaseHeader.SetRange("No.", No);
            if purchaseHeader.FindFirst() then begin
                Dimensions.Reset();
                Dimensions.SetRange(Dimensions.Code, ProgrammeCode);
                if Dimensions.FindFirst() then
                    StringBuilder := StringBuilder.StringBuilder;
                StringWriter := StringWriter.StringWriter(StringBuilder);
                JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
                GenLedgerSetup.Get();
                PayableSetup.Get();
                purchaseHeader."No." := No;
                purchaseHeader."Document Type" := purchaseHeader."Document Type"::Quote;
                purchaseHeader."AU Form Type" := purchaseHeader."AU Form Type"::"Purchase Requisition";
                purchaseHeader."Document Date" := Today;
                purchaseHeader.DocApprovalType2 := purchaseHeader.DocApprovalType2::Purchase;
                purchaseHeader."Type of Payment2" := purchaseHeader."Type of Payment2"::General;
                purchaseHeader."Doc Type" := purchaseHeader."Doc Type"::PurchReq;
                purchaseHeader.Purpose := PayeeNarration;
                purchaseHeader."Payee Naration" := PayeeNarration;
                purchaseHeader."Employee No" := ObjHREmployee."No.";
                purchaseHeader."Employee Name" := ObjHREmployee."First Name" + ' ' + ObjHREmployee."Middle Name" + ' ' + ObjHREmployee."Last Name";
                purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."Responsibility Center" := ObjHREmployee."Responsibility Center";
                purchaseHeader."Responsibility Center Name" := ObjHREmployee."Responsibility Center Name";
                purchaseHeader.Department := ObjHREmployee."Programme or Department";
                IF Currency = 'USD' THEN begin
                    purchaseHeader."Currency Factor" := 1;//Added by collo on 12/08/24
                end else begin
                    purchaseHeader."Currency Code" := Currency;
                    purchaseHeader."Currency Factor" := CurrExchRate.ExchangeRate(Today, Currency);
                end;
                purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
                purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
                purchaseHeader.Status := purchaseHeader.Status::Open;
                purchaseHeader."Shortcut Dimension 1 Code" := FundCode;
                purchaseHeader."Shortcut Dimension 2 Code" := ProgrammeCode;
                purchaseHeader."Shortcut Dimension 5 Code" := Dimensions."Thematic Code";
                purchaseHeader."Posting Date" := RequestDate;
                if purchaseHeader.Modify(true) then begin
                    purchaseHeader."Shortcut Dimension 1 Code" := FundCode;
                    purchaseHeader."Shortcut Dimension 2 Code" := ProgrammeCode;
                    purchaseHeader.Modify(true);
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', purchaseHeader."No.");
                    JSONTextWriter.WriteEndObject;
                end;
                JsonOut := StringBuilder.ToString;
                returnout := JsonOut;
            end;
        end;
    end;

    procedure FnEditExpenseRequisitionLines(No: Code[50]; AccountNo: Code[2000]; ImprestParticular: Text; Amount: Decimal; FundCode: Code[100];
  Budget: Code[100]; Donor: Code[100]; Dept: Code[100]; StaffCode: Code[100]; OutputCode: Code[100]; Strategic: Code[100]; CaseCode: Code[100]; Currency: code[20]; LineNo: Integer; Comment: Text; Quantity: Integer) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        purchaseLine: Record "Purchase Line";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        DonorBudgetMatrix: Record "Donors Budget Matrix line";
        Customer: Record Customer;
        GL: Record "G/L Account";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        purchaseLine.Reset();
        purchaseLine.SetRange(purchaseLine."Document No.", No);
        purchaseLine.SetRange(purchaseLine."Line No.", LineNo);
        purchaseLine.SetRange("Document Type", purchaseLine."Document Type"::Quote);
        if purchaseLine.Find('-') then begin
            GlBudget.Reset();
            GlBudget.SetRange(GlBudget."Global Dimension 1 Code", FundCode);//added by Ron
            GlBudget.SetRange(GlBudget."Global Dimension 2 Code", Budget);
            if GlBudget.FindFirst() then begin
                GL.Reset();
                GL.SetRange(GL."No.", AccountNo);
                if GL.FindFirst() then
                    purchaseLine.Type := purchaseLine.Type::"G/L Account";
                purchaseLine."No." := AccountNo;
                purchaseLine."Account No New" := AccountNo;
                purchaseLine.Description := GL.Name;
                purchaseLine."Budget Line description" := GlBudget."Budget Line Description";
                purchaseLine."Shortcut Dimension 1 Code" := FundCode;
                purchaseLine."Shortcut Dimension 2 Code" := Budget;
                // DonorBudgetMatrix.CalcFields("Committed Amount");
                purchaseLine."Budget Amount" := GlBudget.Amount;
                purchaseLine."Committed Amount" := 0;
                purchaseLine."Budget Balance" := GlBudget.Amount;
                purchaseLine."Document No." := No;
                purchaseLine."Line No." := LineNo;
                purchaseLine."Document Type" := purchaseLine."Document Type"::Quote;
                purchaseLine."Description 2" := ImprestParticular;
                purchaseLine."Direct Unit Cost" := Amount;
                purchaseLine.Quantity := Quantity;
                purchaseLine.Validate("Direct Unit Cost");
                purchaseLine."Amount In Foreign" := Amount;
                purchaseLine.Amount := Amount;
                purchaseLine.Validate(Amount);
                purchaseLine."Amount Including VAT" := Amount;
                purchaseLine.Validate("Amount Including VAT");
                purchaseLine."Currency Code" := Currency;
                purchaseLine."Currency Factor" := purchaseHeader."Currency Factor";
                purchaseLine."Line Comments" := Comment;
                if purchaseLine.Modify(true) then begin
                    purchaseLine."ShortcutDimCode[3]" := Donor;
                    purchaseLine."ShortcutDimCode[4]" := Dept;
                    purchaseLine."ShortcutDimCode[5]" := StaffCode;
                    purchaseLine."ShortcutDimCode[6]" := OutputCode;
                    purchaseLine."ShortcutDimCode[7]" := Strategic;
                    purchaseLine."ShortcutDimCode[8]" := CaseCode;
                    purchaseLine.Modify(true);
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', purchaseHeader."No.");
                    JSONTextWriter.WriteEndObject;
                end;
                JsonOut := StringBuilder.ToString;
                returnout := JsonOut;
            end;
        end;
        // end;
    end;


    //Expense Req   

    procedure FnInsertStaffClaim(empNo: Code[50]; ProgrammeCode: Code[250]; FundCode: Code[250]; PayeeNarration: Text[2048]; Currency: Code[20]) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        PayableSetup: Record "Purchases & Payables Setup";
        Dimensions: Record "Dimension Value";
    begin
        if ObjHREmployee.Get(empNo) then begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);

            GenLedgerSetup.Get();
            PayableSetup.Get();
            purchaseHeader.Reset();
            purchaseHeader.SetRange("Employee No", empNo);
            purchaseHeader.SetRange(Purpose, PayeeNarration);
            if purchaseHeader.Find('-') then begin
                error('Staff  Claim Already exists with same narration %1', purchaseHeader."No.")
            end else begin
                purchaseHeader.Init;
                purchaseHeader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Claims Voucher Form", 0D, true);
                purchaseHeader."No. Series" := GenLedgerSetup."Claims Voucher Form";
                purchaseHeader."Document Type" := purchaseHeader."Document Type"::Quote;
                purchaseHeader."AU Form Type" := purchaseHeader."AU Form Type"::"Claim Voucher";
                purchaseHeader."Document Date" := Today;
                purchaseHeader.DocApprovalType2 := purchaseHeader.DocApprovalType2::Purchase;
                purchaseHeader."Type of Payment2" := purchaseHeader."Type of Payment2"::General;
                purchaseHeader."Doc Type" := purchaseHeader."Doc Type"::PurchReq;
                purchaseHeader.Purpose := PayeeNarration;
                //purchaseHeader."Payee Naration" := PayeeNarration;
                purchaseHeader."Employee No" := ObjHREmployee."No.";
                purchaseHeader."Employee Name" := ObjHREmployee."First Name" + ' ' + ObjHREmployee."Middle Name" + ' ' + ObjHREmployee."Last Name";
                purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader.Supervisor := ObjHREmployee."Supervisor ID";
                purchaseHeader."Responsibility Center" := ObjHREmployee."Responsibility Center";
                purchaseHeader."Responsibility Center Name" := ObjHREmployee."Responsibility Center Name";
                purchaseHeader.Department := ObjHREmployee."Programme or Department";
                IF Currency = 'USD' THEN begin
                    purchaseHeader."Currency Factor" := 1;//Added by collo on 12/08/24
                end else begin
                    purchaseHeader."Currency Code" := Currency;
                    purchaseHeader."Currency Factor" := CurrExchRate.ExchangeRate(Today, Currency);
                end;

                purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
                purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
                purchaseHeader.Status := purchaseHeader.Status::Open;
                purchaseHeader."Shortcut Dimension 1 Code" := FundCode;
                purchaseHeader."Shortcut Dimension 2 Code" := ProgrammeCode;
                Dimensions.Reset();
                Dimensions.SetRange(Dimensions.Code, ProgrammeCode);
                if Dimensions.FindFirst() then
                    purchaseHeader."Shortcut Dimension 5 Code" := Dimensions."Thematic Code";
                if purchaseHeader.Insert(true) then begin
                    purchaseHeader."Shortcut Dimension 1 Code" := FundCode;
                    purchaseHeader."Shortcut Dimension 2 Code" := ProgrammeCode;
                    purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
                    purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";

                    purchaseHeader.Modify(true);
                    Commit();
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', purchaseHeader."No.");
                    CreateJsonAttribute('Document_Date', purchaseHeader."Document Date");
                    CreateJsonAttribute('Status', purchaseHeader.Status);
                    CreateJsonAttribute('ShortcutDimension1Code', purchaseHeader."Shortcut Dimension 1 Code");
                    CreateJsonAttribute('ShortcutDimension4Code', purchaseHeader."Shortcut Dimension 2 Code");
                    CreateJsonAttribute('PayeeNaration', purchaseHeader."Payee Naration");

                    JSONTextWriter.WriteEndObject;
                end;
                JsonOut := StringBuilder.ToString;
                returnout := JsonOut;
            end;
        end;
    end;

    procedure FnEditStaffClaim(empNo: Code[50]; ProgrammeCode: Code[250]; FundCode: Code[250]; PayeeNarration: Text[2048]; Currency: Code[20]; No: code[20]) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        PayableSetup: Record "Purchases & Payables Setup";
        Dimensions: Record "Dimension Value";
    begin
        if ObjHREmployee.Get(empNo) then begin
            purchaseHeader.reset;
            purchaseHeader.SetRange("No.", No);
            if purchaseHeader.FindFirst() then begin
                Dimensions.Reset();
                Dimensions.SetRange(Dimensions.Code, ProgrammeCode);
                if Dimensions.FindFirst() then
                    StringBuilder := StringBuilder.StringBuilder;
                StringWriter := StringWriter.StringWriter(StringBuilder);
                JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
                GenLedgerSetup.Get();
                PayableSetup.Get();
                purchaseHeader."No." := No;
                purchaseHeader."Document Type" := purchaseHeader."Document Type"::Quote;
                purchaseHeader."AU Form Type" := purchaseHeader."AU Form Type"::"Claim Voucher";
                purchaseHeader."Document Date" := Today;
                purchaseHeader.DocApprovalType2 := purchaseHeader.DocApprovalType2::Purchase;
                purchaseHeader."Type of Payment2" := purchaseHeader."Type of Payment2"::General;
                purchaseHeader."Doc Type" := purchaseHeader."Doc Type"::PurchReq;
                purchaseHeader.Purpose := PayeeNarration;
                // purchaseHeader."Payee Naration" := PayeeNarration;
                purchaseHeader."Employee No" := ObjHREmployee."No.";
                purchaseHeader."Employee Name" := ObjHREmployee."First Name" + ' ' + ObjHREmployee."Middle Name" + ' ' + ObjHREmployee."Last Name";
                purchaseHeader."Assigned User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader."User ID" := ObjHREmployee."Employee UserID";
                purchaseHeader.Supervisor := ObjHREmployee."Supervisor ID";
                purchaseHeader."Responsibility Center" := ObjHREmployee."Responsibility Center";
                purchaseHeader."Responsibility Center Name" := ObjHREmployee."Responsibility Center Name";
                purchaseHeader.Department := ObjHREmployee."Programme or Department";
                IF Currency = 'USD' THEN begin
                    purchaseHeader."Currency Factor" := 1;//Added by collo on 12/08/24
                end else begin
                    purchaseHeader."Currency Code" := Currency;
                    purchaseHeader."Currency Factor" := CurrExchRate.ExchangeRate(Today, Currency);
                end;
                purchaseHeader."Buy-from Vendor No." := PayableSetup."Default Vendor";
                purchaseHeader."Vendor Posting Group" := PayableSetup."Vendor Posting Group";
                purchaseHeader.Status := purchaseHeader.Status::Open;
                purchaseHeader."Shortcut Dimension 1 Code" := FundCode;
                purchaseHeader."Shortcut Dimension 2 Code" := ProgrammeCode;
                purchaseHeader."Shortcut Dimension 5 Code" := Dimensions."Thematic Code";
                if purchaseHeader.Modify(true) then begin
                    purchaseHeader."Shortcut Dimension 1 Code" := FundCode;
                    purchaseHeader."Shortcut Dimension 2 Code" := ProgrammeCode;
                    purchaseHeader.Modify(true);
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', purchaseHeader."No.");
                    JSONTextWriter.WriteEndObject;
                end;
                JsonOut := StringBuilder.ToString;
                returnout := JsonOut;
            end;
        end;
    end;

    procedure FnInsertStaffClaimLines(No: Code[50]; Deliverable: Code[2000]; Quantity: Integer; Amount: Decimal;
  ExpenditureDate: DateTime; ExpenditureDescription: Text; Outcomecode: Code[100]; LineNo: integer) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        purchaseLine: Record "Purchase Line";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        purchaseLines: Record "Purchase Line";
        Dimensions: Record "Dimension Value";
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        purchaseHeader.Reset();
        purchaseHeader.SetRange("No.", No);
        if purchaseHeader.FindFirst() then begin
            Dimensions.Reset();
            Dimensions.SetRange(Dimensions.Code, Deliverable);
            if Dimensions.FindFirst() then begin

                purchaseLine.Init;
                purchaseLine."Line No." := LineNo;
                purchaseLine.Type := purchaseLine.Type::"G/L Account";
                purchaseLine."Claim Type" := purchaseLine."Claim Type"::"G/L Account";
                purchaseLine."No." := Dimensions."G/L Account";
                purchaseLine."Account No New" := Dimensions."G/L Account";
                purchaseLine.Description := Dimensions."G/L Account Name";
                purchaseLine."ShortcutDimCode[3]" := Deliverable;
                purchaseLine."Shortcut Dimension 1 Code" := purchaseHeader."Shortcut Dimension 1 Code";
                purchaseLine."Shortcut Dimension 2 Code" := purchaseHeader."Shortcut Dimension 2 Code";
                purchaseLine."ShortcutDimCode[4]" := Outcomecode;
                purchaseLine."Document No." := No;
                purchaseLine."Document Type" := purchaseLine."Document Type"::Quote;
                purchaseLine.date := ExpenditureDate;
                purchaseLine."Description 2" := ExpenditureDescription;
                purchaseLine."Direct Unit Cost" := Amount;
                //purchaseLine.Validate("Direct Unit Cost");
                purchaseLine.Quantity := Quantity;
                //purchaseLine.Validate(Quantity);
                purchaseLine."Amount Including VAT" := Amount;
                // purchaseLine.Validate("Amount Including VAT");

                purchaseLine."Unit Cost (LCY)" := CurrExchRate.ExchangeAmtFCYToLCY(Today, purchaseHeader."Currency Code", Amount, purchaseHeader."Currency Factor");
                purchaseLine.Amount := purchaseLine."Unit Cost (LCY)" * Quantity;
                purchaseLine."Unit Cost (LCY) New" := CurrExchRate.ExchangeAmtFCYToLCY(Today, purchaseHeader."Currency Code", Amount, purchaseHeader."Currency Factor");
                purchaseLine."Amount New" := purchaseLine."Unit Cost (LCY) New" * Quantity;
                purchaseLine."Line Amount" := purchaseLine."Unit Cost (LCY) New" * Quantity;
                purchaseLine."Line Amount New" := Amount * Quantity;
                purchaseLine.Validate("Line Amount");
                purchaseLine."Currency Code" := purchaseHeader."Currency Code";
                purchaseLine."Currency Factor" := purchaseHeader."Currency Factor";
                if purchaseLine.Insert(true) then begin
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', purchaseHeader."No.");
                    JSONTextWriter.WriteEndObject;
                end;
                JsonOut := StringBuilder.ToString;
                returnout := JsonOut;
            end;
        end;
    end;


    procedure FnEditStaffClaimLines(No: Code[50]; Deliverable: Code[2000]; Quantity: Integer; Amount: Decimal;
  ExpenditureDate: DateTime; ExpenditureDescription: Text; Outcomecode: Code[100]; LineNo: integer) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        purchaseLine: Record "Purchase Line";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        Dimensions: Record "Dimension Value";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        purchaseLine.Reset();
        purchaseLine.SetRange(purchaseLine."Document No.", No);
        purchaseLine.SetRange(purchaseLine."Line No.", LineNo);
        purchaseLine.SetRange("Document Type", purchaseLine."Document Type"::Quote);
        if purchaseLine.Find('-') then begin
            Dimensions.Reset();
            Dimensions.SetRange(Dimensions.Code, Deliverable);
            if Dimensions.FindFirst() then begin
                purchaseLine."Line No." := LineNo;
                purchaseLine.Type := purchaseLine.Type::"G/L Account";
                purchaseLine."Claim Type" := purchaseLine."Claim Type"::"G/L Account";
                purchaseLine."No." := Dimensions."G/L Account";
                purchaseLine."Account No New" := Dimensions."G/L Account";
                purchaseLine.Description := Dimensions."G/L Account Name";
                purchaseLine."ShortcutDimCode[3]" := Deliverable;
                purchaseLine."Shortcut Dimension 1 Code" := purchaseHeader."Shortcut Dimension 1 Code";
                purchaseLine."Shortcut Dimension 2 Code" := purchaseHeader."Shortcut Dimension 2 Code";
                purchaseLine."ShortcutDimCode[4]" := Outcomecode;
                purchaseLine."Document No." := No;
                purchaseLine."Document Type" := purchaseLine."Document Type"::Quote;
                purchaseLine.date := ExpenditureDate;
                purchaseLine."Description 2" := ExpenditureDescription;
                purchaseLine."Direct Unit Cost" := Amount;
                //purchaseLine.Validate("Direct Unit Cost");

                purchaseLine.Quantity := Quantity;
                //purchaseLine.Validate(Quantity);
                purchaseLine."Amount Including VAT" := Amount;
                // purchaseLine.Validate("Amount Including VAT");

                purchaseLine."Unit Cost (LCY)" := CurrExchRate.ExchangeAmtFCYToLCY(Today, purchaseHeader."Currency Code", Amount, purchaseHeader."Currency Factor");
                purchaseLine.Amount := purchaseLine."Unit Cost (LCY)" * Quantity;
                purchaseLine."Unit Cost (LCY) New" := CurrExchRate.ExchangeAmtFCYToLCY(Today, purchaseHeader."Currency Code", Amount, purchaseHeader."Currency Factor");
                purchaseLine."Amount New" := purchaseLine."Unit Cost (LCY) New" * Quantity;
                purchaseLine."Line Amount" := purchaseLine."Unit Cost (LCY) New" * Quantity;
                purchaseLine."Line Amount New" := Amount * Quantity;
                purchaseLine.Validate("Line Amount");
                purchaseLine."Currency Code" := purchaseHeader."Currency Code";
                purchaseLine."Currency Factor" := purchaseHeader."Currency Factor";
                if purchaseLine.Modify(true) then begin
                    purchaseHeader.Reset();
                    purchaseHeader.SetRange("No.", No);
                    if purchaseHeader.Find('-') then
                        if purchaseHeader."Currency Code" <> '' then begin

                            purchaseHeader.TestField("Currency Factor");
                            purchaseLine."Unit Cost (LCY)" :=
                              CurrExchRate.ExchangeAmtFCYToLCY(
                                Today, purchaseHeader."Currency Code",
                                purchaseLine."Direct Unit Cost", purchaseHeader."Currency Factor");
                        end;
                    purchaseLine.Amount := purchaseLine."Unit Cost (LCY)" * purchaseLine.Quantity;
                    purchaseLine.Modify();

                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('No', purchaseHeader."No.");
                    JSONTextWriter.WriteEndObject;
                end;
                JsonOut := StringBuilder.ToString;
                returnout := JsonOut;
            end;
        end;
        // end;
    end;

    procedure UpdateAmount(No: Code[250])
    var
        TotalAmount: decimal;
    begin
        TotalAmount := 0;
        if purchaseheader.Get(purchaseheader."Document Type"::Quote, No) then
            purchaseline.reset();
        purchaseline.setrange("Document No.", No);
        if purchaseline.FINDSET then begin
            repeat
                TotalAmount := TotalAmount + (purchaseline.Quantity * purchaseline."Direct Unit Cost");
            until purchaseline.next = 0;
            purchaseheader.Amount := TotalAmount;
            purchaseheader.Modify();
            Commit();
        end
    end;


    procedure DeleteLines(DocumentNo: Code[100]; LineNo: Integer)
    begin
        purchaseline.Reset;
        purchaseline.SetRange("Document No.", DocumentNo);
        purchaseline.SetRange("Line No.", LineNo);
        if purchaseline.FindFirst() then begin
            purchaseline.Delete(true);
        end;

    end;
    //Imprest Surrender
    procedure FnInsertImprestSurrender(imprestno: Code[50]; empno: Code[50]; Narration: Text) impsurrno: Code[50]
    var
        ImprestHeader: Record "Purchase Header";

    begin
        ImprestHeader.reset;
        ImprestHeader.SetRange(ImprestHeader."No.", imprestno);
        if ImprestHeader.Find('-') then begin
            purchaseheader.Init;
            GenLedgerSetup.Get();

            HREmployees.Reset();
            HREmployees.SetRange("No.", empno);
            if HREmployees.Find('-') then
                purchaseheader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Surrender Nos.", 0D, true);
            purchaseheader."No. Series" := GenLedgerSetup."Surrender Nos.";
            purchaseheader."Document Type" := purchaseheader."document type"::Quote;
            purchaseheader.DocApprovalType2 := purchaseheader.Docapprovaltype2::Requisition;
            purchaseheader."AU Form Type" := purchaseheader."AU Form Type"::"Imprest Accounting";
            purchaseheader."Account No" := HREmployees.Travelaccountno;
            purchaseheader."Employee No" := HREmployees."No.";
            purchaseheader."Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
            purchaseheader."User ID" := HREmployees."Employee UserID";
            purchaseheader."Document Date" := Today;
            purchaseheader."Posting Date" := Today;
            purchaseheader."Employee No" := empno;
            purchaseheader.SR := true;
            purchaseheader."Imprest No" := imprestno;
            purchaseheader."Applies To Document No" := imprestno;
            purchaseheader."Surrender Narration" := Narration;
            purchaseheader.Insert;
            purchaseheader.SR := true;
            purchaseheader."Applies To Document No" := imprestno;
            purchaseheader.InsertPortal := true;
            purchaseheader.Validate(InsertPortal);
            purchaseheader.Status := purchaseheader.Status::Open;

            purchaseheader."Currency Code" := ImprestHeader."Currency Code";
            purchaseheader."Currency Factor" := ImprestHeader."Currency Factor";
            purchaseheader."Payee Naration" := ImprestHeader."Payee Naration";
            purchaseheader.Modify;

            impsurrno := purchaseheader."No.";
        end;
    end;

    procedure FnUpdateSurrender(No: Code[50]; Narration: Code[50])
    var
        ImprestHeader: Record "Purchase Header";
    begin
        ImprestHeader.Reset();
        ImprestHeader.SetRange(ImprestHeader."No.", No);
        if ImprestHeader.Find('-') then begin
            ImprestHeader."Surrender Narration" := Narration;
            ImprestHeader.modify;
        end;
    end;

    procedure fnEditImprestSurrender(No: Code[50]; imprestno: Code[50]; empno: Code[50]; ProgramCode: Code[100]; PayeeNarration: Text; Currency: Code[100]) impsurrno: Code[50]
    var
        ImprestHeader: Record "Purchase Header";

    begin
        ImprestHeader.reset;
        ImprestHeader.SetRange(ImprestHeader."No.", No);
        if ImprestHeader.Find('-') then begin
            GenLedgerSetup.Get();
            HREmployees.Reset();
            HREmployees.SetRange("No.", empno);
            if HREmployees.Find('-') then
                purchaseheader."No." := No;
            purchaseheader."Document Type" := purchaseheader."document type"::Quote;
            purchaseheader.DocApprovalType2 := purchaseheader.Docapprovaltype2::Requisition;
            purchaseheader."AU Form Type" := purchaseheader."AU Form Type"::"Imprest Accounting";
            purchaseheader."Account No" := HREmployees.Travelaccountno;
            purchaseheader."Employee No" := HREmployees."No.";
            purchaseheader."Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
            purchaseheader."User ID" := HREmployees."Employee UserID";
            purchaseheader."Document Date" := Today;
            purchaseheader."Posting Date" := Today;
            purchaseheader."Employee No" := empno;
            purchaseheader.SR := true;
            purchaseheader."Imprest No" := imprestno;
            purchaseheader."Applies To Document No" := imprestno;
            purchaseheader.SR := true;
            purchaseheader."Applies To Document No" := imprestno;
            purchaseheader."Shortcut Dimension 4 Code" := ProgramCode;

            purchaseheader.Modify;
            purchaseheader.InsertPortal := true;
            purchaseheader.Validate(InsertPortal);
            purchaseheader.Status := purchaseheader.Status::Open;
            purchaseheader."Currency Code" := ImprestHeader."Currency Code";
            purchaseheader."Currency Factor" := ImprestHeader."Currency Factor";
            purchaseheader."Payee Naration" := PayeeNarration;
            purchaseheader.Modify;

            impsurrno := purchaseheader."No.";
        end;
    end;

    procedure FnEditImprestSurrenderLines(No: Code[50]; AccountNo: Code[2000]; ImprestParticular: Text; Amount: Decimal; Project: Code[100];
Budget: Code[100]; Donor: Code[100]; Dept: Code[100]; Strategic: Code[100]; CaseCode: Code[100]; LineNo: Integer; Comment: Text; Currency: code[20]; CurrencyFactor: Decimal; AmountSpent: Decimal; CashRefund: Decimal; CashRefundNo: Code[200]) impsurrno: Code[50]
    var
        ImprestHeader: Record "Purchase Header";
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        purchaseLine: Record "Purchase Line";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        DonorBudgetMatrix: Record "G/L Budget Entry";
        Customer: Record Customer;
        Banks: Record 270;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        purchaseHeader.Reset();
        purchaseHeader.SetRange("No.", No);
        if purchaseHeader.FindFirst() then begin
            purchaseLine.Reset();
            purchaseLine.SetRange(purchaseLine."Budget Line Codes", Budget);
            purchaseLine.SetRange(purchaseLine."Document No.", No);
            if purchaseLine.Find('-') then begin
                DonorBudgetMatrix.Reset();
                DonorBudgetMatrix.SetRange(DonorBudgetMatrix."Global Dimension 1 Code", Project);
                DonorBudgetMatrix.SetRange(DonorBudgetMatrix."Global Dimension 2 Code", Budget);
                if DonorBudgetMatrix.FindFirst() then begin
                    Banks.Reset();
                    Banks.SetRange(Banks."No.", CashRefundNo);
                    if Banks.FindFirst() then
                        purchaseLine.Type := purchaseLine.Type::"G/L Account";
                    purchaseLine."No." := AccountNo;
                    purchaseLine.Description := DonorBudgetMatrix.Description;
                    purchaseLine."Budget Line description" := DonorBudgetMatrix."Budget Line Description";
                    purchaseLine."Shortcut Dimension 1 Code" := DonorBudgetMatrix."Global Dimension 1 Code";
                    purchaseLine."Shortcut Dimension 2 Code" := DonorBudgetMatrix."Global Dimension 2 Code";
                    purchaseLine."Budget Amount" := DonorBudgetMatrix.Amount;
                    purchaseLine."Document No." := No;
                    purchaseLine."Line No." := LineNo;
                    purchaseLine."Document Type" := purchaseLine."Document Type"::Quote;
                    purchaseLine."Description 2" := ImprestParticular;
                    purchaseLine."Direct Unit Cost" := Amount;
                    purchaseLine.Validate("Direct Unit Cost");
                    purchaseLine.Amount := Amount;
                    purchaseLine.Quantity := 1;
                    purchaseLine.Validate(Amount);
                    purchaseLine."Amount Including VAT" := Amount;
                    purchaseLine.Validate("Amount Including VAT");
                    purchaseLine."Amount Spent" := AmountSpent;
                    purchaseLine.Validate("Amount Spent");
                    if (CashRefund > 0) then begin
                        purchaseLine."Cash Refund" := CashRefund;
                        purchaseLine.Validate("Cash Refund");
                        purchaseLine."Cash Refund  Account" := Banks."No.";
                        purchaseLine."Bank Account Name" := Banks.Name;
                        purchaseLine."Bank Account Number" := Banks."Bank Account No.";
                    end;
                    purchaseLine."Currency Code" := Currency;
                    purchaseLine."Currency Factor" := CurrencyFactor;
                    purchaseLine."Line Comments" := Comment;
                    if purchaseLine.Modify(true) then begin
                        purchaseLine."ShortcutDimCode[3]" := Project;
                        purchaseLine."ShortcutDimCode[4]" := Budget;
                        purchaseLine."ShortcutDimCode[5]" := Donor;
                        purchaseLine."ShortcutDimCode[6]" := Dept;
                        purchaseLine."ShortcutDimCode[7]" := Strategic;
                        purchaseLine."ShortcutDimCode[8]" := CaseCode;
                        purchaseLine."No." := DonorBudgetMatrix."G/L Account No.";
                        purchaseLine.Description := DonorBudgetMatrix.Description;
                        purchaseLine.Modify(true);
                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('No', purchaseHeader."No.");
                        JSONTextWriter.WriteEndObject;
                    end;
                    JsonOut := StringBuilder.ToString;
                    impsurrno := JsonOut;
                end;
            end;
        end;
    end;

    procedure FnGetGlDescription(GlAccount: Code[250]) returnout: Text
    var
        JsonOut: dotnet String;
        Gl: Record 15;
    begin

        Gl.Reset();
        Gl.SetRange("No.", GlAccount);
        if Gl.FindSet() then begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('Description', Gl.Name);
            JSONTextWriter.WriteEndObject;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
            exit(returnout);
        end;
    end;

    procedure FnGetBudget(Budget: Code[250]; Fund: Code[250]) returnout: Text
    var
        JsonOut: dotnet String;
        DimensionValues: Record 349;
        BudgetMatrix: Record "Donors Budget Matrix line";
        GlBudget: Record "G/L Budget Entry";

    begin
        DimensionValues.Reset();
        DimensionValues.SetRange(DimensionValues.Code, Budget);
        if DimensionValues.FindFirst() then begin
            GlBudget.Reset();
            GlBudget.SetRange(GlBudget."Global Dimension 2 Code", Budget);
            GlBudget.SetRange(GlBudget."Global Dimension 1 Code", Fund);
            if GlBudget.FindFirst() then
                // GlBudget.CalcFields(Amount);
                StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('BudgetLineDescription', GlBudget."Budget Line Description");
            CreateJsonAttribute('BudgetAmount', GlBudget.Amount);
            CreateJsonAttribute('CommittedAmount', '0');
            JSONTextWriter.WriteEndObject;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
            exit(returnout);
        end;
    end;

    procedure FnGetBanks(BankCode: Code[250]) returnout: Text
    var
        JsonOut: dotnet String;
        Banks: Record 270;
    begin
        Banks.Reset();
        Banks.SetRange(Banks."No.", BankCode);
        if Banks.FindFirst() then begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('BankAccountName', Banks.Name);
            CreateJsonAttribute('BankAccountNumber', Banks."Bank Account No.");
            JSONTextWriter.WriteEndObject;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
            exit(returnout);
        end;
    end;

    procedure FnFetchHeader(ProjectCode: Code[250]) returnout: Text
    var
        JsonOut: dotnet String;
        DimensionValues: Record 349;

    begin
        DimensionValues.Reset();
        DimensionValues.SetRange(DimensionValues.Code, ProjectCode);
        if DimensionValues.FindFirst() then begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('BudgetCenterName', DimensionValues.Name);
            CreateJsonAttribute('ThematicCode', DimensionValues."Thematic Code");
            CreateJsonAttribute('GlAccount', DimensionValues."G/L Account");
            CreateJsonAttribute('Description', DimensionValues."G/L Account Name");
            JSONTextWriter.WriteEndObject;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
            exit(returnout);
        end;
    end;

    procedure FnGetStandardTexts(StandardCode: Code[250]) returnout: Text
    var
        JsonOut: dotnet String;
        StandardText: Record "Standard Text";

    begin
        StandardText.Reset();
        StandardText.SetRange(Code, StandardCode);
        if StandardText.FindFirst() then begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('Code', StandardText.Code);
            CreateJsonAttribute('Name', StandardText.Description);
            CreateJsonAttribute('No', StandardText."G/L Account");
            JSONTextWriter.WriteEndObject;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
            exit(returnout);
        end;
    end;



    procedure FnGetBanksAccounts() returnout: Text;
    var
        JsonOut: dotnet String;
        Banks: Record 270;
    begin
        Banks.Reset();
        Banks.ASCENDING(TRUE);
        if Banks.FINDFIRST then begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            JSONTextWriter.WriteStartArray;

            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', Banks."No.");
                CreateJsonAttribute('Name', Banks.Name);
                JSONTextWriter.WriteEndObject;
            until Banks.Next = 0;

            JSONTextWriter.WriteEndArray;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
            exit(returnout);
        end;
    end;

    procedure ApprovalList(empNo: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjApproval: Record "Approval Entry";
        ObjHrEmployee: Record "HR Employees";
        Leave: Record "HR Leave Application";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        if ObjHrEmployee.Get(empNo) then begin

            ObjApproval.Reset;
            ObjApproval.SetRange("Approver ID", ObjHrEmployee."Employee UserID");
            ObjApproval.SETFILTER(Status, '=%1', ObjApproval.Status::Open);
            if ObjApproval.FindFirst then
                repeat
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('DocumentNo', ObjApproval."Document No.");
                    CreateJsonAttribute('SenderID', ObjApproval."Sender ID");
                    purchaseheader2.Reset;
                    purchaseheader2.SetRange("No.", ObjApproval."Document No.");
                    if purchaseheader2.FindFirst then begin
                        CreateJsonAttribute('SenderID', purchaseheader2."Employee Name");
                    end;


                    Leave.Reset;
                    Leave.SetRange(Leave."Application Code", ObjApproval."Document No.");
                    if Leave.FindFirst then begin
                        CreateJsonAttribute('SenderID', Leave."Employee Name");
                    end;
                    CreateJsonAttribute('ApproverID', ObjApproval."Approver ID");
                    CreateJsonAttribute('DateTimeSent', ObjApproval."Date-Time Sent for Approval");
                    CreateJsonAttribute('Amount', ObjApproval.Amount);
                    CreateJsonAttribute('Status', ObjApproval.Status);
                    CreateJsonAttribute('PayingBank', ObjApproval."Paying Bank Number");
                    CreateJsonAttribute('ChequeNo', ObjApproval."Payment Voucher No");
                    CreateJsonAttribute('CashBook', ObjApproval."CashBook Narration");
                    CreateJsonAttribute('Payee', ObjApproval.Memo);
                    CreateJsonAttribute('Name', ObjApproval."Mission Narration");
                    CreateJsonAttribute('Purpose', ObjApproval."Purpose for Travel");
                    CreateJsonAttribute('DepartureDate', ObjApproval.fromDate);
                    JSONTextWriter.WriteEndObject;
                until ObjApproval.Next = 0;

            JSONTextWriter.WriteEndArray;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
        end;
    end;

    procedure fnClaimList(empNo: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjClaimHeader: Record "Purchase Header";
        ObjHrEmployee: Record "HR Employees";
    begin
        /*StringBuilder:=StringBuilder.StringBuilder;
        StringWriter:=StringWriter.StringWriter(StringBuilder);
        JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        
        IF ObjHrEmployee.GET(empNo) THEN
        ObjClaimHeader.RESET;
        ObjClaimHeader.SETRANGE(Cashier , ObjHrEmployee."User ID");
        IF ObjClaimHeader.FINDFIRST THEN
          REPEAT
            ObjClaimHeader.CALCFIELDS("Total Net Amount LCY");
            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('No', ObjClaimHeader."No.");
            CreateJsonAttribute('Document_Date', ObjClaimHeader.Date);
            CreateJsonAttribute('Status', ObjClaimHeader.Status);
            CreateJsonAttribute('Amount', ObjClaimHeader."Total Net Amount LCY");
            CreateJsonAttribute('DepartmentCode', ObjClaimHeader."Global Dimension 1 Code");
            CreateJsonAttribute('DirectorateCode', ObjClaimHeader."Shortcut Dimension 2 Code");
            CreateJsonAttribute('bank', ObjClaimHeader."Bank Name");
            CreateJsonAttribute('Purpose',ObjClaimHeader.Purpose);
            JSONTextWriter.WriteEndObject;
          UNTIL ObjClaimHeader.NEXT=0;
        
        JSONTextWriter.WriteEndArray;
        JsonOut:=StringBuilder.ToString;
        returnout:=JsonOut;*/

    end;

    procedure fnClaimCard(empNo: Code[50]; departmentcode: Code[20]; directoratecode: Code[20]; purpose: Text; responsibilitycenter: Code[20]; startdate: Date; enddate: Date) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestHeader: Record "Purchase Line";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
    begin
        /*IF ObjHREmployee.GET(empNo) THEN BEGIN
        StringBuilder:=StringBuilder.StringBuilder;
           StringWriter:=StringWriter.StringWriter(StringBuilder);
           JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        
           ObjImprestHeader.INIT;
           ObjImprestHeader.Date:=TODAY;
           ObjImprestHeader.StartDate:=startdate;
           ObjImprestHeader.Enddate:=enddate;
           ObjImprestHeader."Global Dimension 1 Code":=departmentcode;
           ObjImprestHeader.VALIDATE(ObjImprestHeader."Global Dimension 1 Code");
           ObjImprestHeader."Shortcut Dimension 2 Code":=directoratecode;
           ObjImprestHeader.VALIDATE(ObjImprestHeader."Shortcut Dimension 2 Code");
           ObjImprestHeader.Purpose:=purpose;
           ObjImprestHeader.Status:=ObjImprestHeader.Status::Open;
           ObjImprestHeader.Cashier:=empNo;
           IF ObjUserSetup.GET(ObjHREmployee."User ID") THEN BEGIN
             ObjImprestHeader."Account No.":=ObjUserSetup."Other Advance Staff Account";
             ObjImprestHeader.VALIDATE("Account No.");
             END;
           ObjImprestHeader.VALIDATE(ObjImprestHeader."Employee No");
           ObjImprestHeader."Responsibility Center":=responsibilitycenter;
            IF ObjImprestHeader.INSERT(TRUE) THEN BEGIN
              ObjImprestHeader.CALCFIELDS("Total Net Amount LCY");
              JSONTextWriter.WriteStartObject;
              CreateJsonAttribute('No', ObjImprestHeader."No.");
              CreateJsonAttribute('Document_Date', ObjImprestHeader.Date);
              CreateJsonAttribute('Status', ObjImprestHeader.Status);
              CreateJsonAttribute('ResponsibilityCenter', ObjImprestHeader."Responsibility Center");
              CreateJsonAttribute('Amount', ObjImprestHeader."Total Net Amount LCY");
              CreateJsonAttribute('DepartmentCode', ObjImprestHeader."Global Dimension 1 Code");
              CreateJsonAttribute('StartDate', ObjImprestHeader.StartDate);
              CreateJsonAttribute('EndDate', ObjImprestHeader.Enddate);
              CreateJsonAttribute('DirectorateCode', ObjImprestHeader."Shortcut Dimension 2 Code");
              CreateJsonAttribute('Purpose',ObjImprestHeader.Purpose);
              JSONTextWriter.WriteEndObject;
            END;
        JsonOut:=StringBuilder.ToString;
        returnout:=JsonOut;
        END;*/

    end;

    procedure fnClaimCardEdit(ImprestNo: Code[20]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestHeader: Record "Purchase Header";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
    begin
        /*
        StringBuilder:=StringBuilder.StringBuilder;
           StringWriter:=StringWriter.StringWriter(StringBuilder);
           JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        
            IF ObjImprestHeader.GET(ImprestNo) THEN BEGIN
              ObjImprestHeader.CALCFIELDS("Total Net Amount LCY");
              JSONTextWriter.WriteStartObject;
              CreateJsonAttribute('No', ObjImprestHeader."No.");
              CreateJsonAttribute('Document_Date', ObjImprestHeader.Date);
              CreateJsonAttribute('Status', ObjImprestHeader.Status);
              CreateJsonAttribute('ResponsibilityCenter', ObjImprestHeader."Responsibility Center");
              CreateJsonAttribute('Amount', ObjImprestHeader."Total Net Amount LCY");
              CreateJsonAttribute('DepartmentCode', ObjImprestHeader."Global Dimension 1 Code");
              CreateJsonAttribute('StartDate', ObjImprestHeader.StartDate);
              CreateJsonAttribute('EndDate', ObjImprestHeader.Enddate);
              CreateJsonAttribute('DirectorateCode', ObjImprestHeader."Shortcut Dimension 2 Code");
              CreateJsonAttribute('Purpose',ObjImprestHeader.Purpose);
              JSONTextWriter.WriteEndObject;
        
          JsonOut:=StringBuilder.ToString;
          returnout:=JsonOut;
            END;*/

    end;

    procedure fnClaimLineDelete(ImprestNo: Code[20]; LineNo: Integer) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestLine: Record "Purchase Line";
    begin
        /*StringBuilder:=StringBuilder.StringBuilder;
        StringWriter:=StringWriter.StringWriter(StringBuilder);
        JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjImprestLine.RESET;
        ObjImprestLine.SETRANGE(No,ImprestNo);
        ObjImprestLine.SETRANGE("Line No.",LineNo);
        IF ObjImprestLine.FINDFIRST THEN
          ObjImprestLine.DELETE;
        
         ObjImprestLine.RESET;
         ObjImprestLine.SETRANGE(No,ImprestNo);
        IF ObjImprestLine.FINDFIRST THEN
          REPEAT
            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('No', ObjImprestLine.No);
            CreateJsonAttribute('AccountNo', ObjImprestLine."Account No:");
            CreateJsonAttribute('AccountName', ObjImprestLine."Account Name");
            CreateJsonAttribute('Amount', ObjImprestLine.Amount);
            CreateJsonAttribute('LineNo', ObjImprestLine."Line No.");
            CreateJsonAttribute('Type', ObjImprestLine.Type);
            JSONTextWriter.WriteEndObject;
          UNTIL ObjImprestLine.NEXT=0;
        
        JSONTextWriter.WriteEndArray;
        JsonOut:=StringBuilder.ToString;
        returnout:=JsonOut;*/

    end;

    procedure fnClaimLine(ImprestNo: Code[20]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestLine: Record "Purchase Line";
    begin
        /*StringBuilder:=StringBuilder.StringBuilder;
        StringWriter:=StringWriter.StringWriter(StringBuilder);
        JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjImprestLine.RESET;
        ObjImprestLine.SETRANGE(No,ImprestNo);
        //ObjImprestLine.SETRANGE("Line No.",LineNo);
        IF ObjImprestLine.FINDFIRST THEN
          REPEAT
            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('No', ObjImprestLine.No);
            CreateJsonAttribute('AccountNo', ObjImprestLine."Account No:");
            CreateJsonAttribute('AccountName', ObjImprestLine."Account Name");
            CreateJsonAttribute('Amount', ObjImprestLine.Amount);
            CreateJsonAttribute('LineNo', ObjImprestLine."Line No.");
            CreateJsonAttribute('Type', ObjImprestLine.Type);
            JSONTextWriter.WriteEndObject;
          UNTIL ObjImprestLine.NEXT=0;
        
        JSONTextWriter.WriteEndArray;
        JsonOut:=StringBuilder.ToString;
        returnout:=JsonOut;*/

    end;

    procedure fnClaimLineCard(ImprestNo: Code[20]; LineNo: Integer) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestLine: Record "Purchase Line";
    begin
        /*StringBuilder:=StringBuilder.StringBuilder;
        StringWriter:=StringWriter.StringWriter(StringBuilder);
        JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjImprestLine.RESET;
        ObjImprestLine.SETRANGE(No,ImprestNo);
        ObjImprestLine.SETRANGE("Line No.",LineNo);
        IF ObjImprestLine.FINDFIRST THEN
          REPEAT
            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('No', ObjImprestLine.No);
            CreateJsonAttribute('AccountNo', ObjImprestLine."Account No:");
            CreateJsonAttribute('AccountName', ObjImprestLine."Account Name");
            CreateJsonAttribute('Amount', ObjImprestLine.Amount);
            CreateJsonAttribute('LineNo', ObjImprestLine."Line No.");
            JSONTextWriter.WriteEndObject;
          UNTIL ObjImprestLine.NEXT=0;
        
        JSONTextWriter.WriteEndArray;
        JsonOut:=StringBuilder.ToString;
        returnout:=JsonOut;*/

    end;

    procedure fnClaimLineCardEdit(ImprestNo: Code[20]; Type: Code[20]; Amount: Decimal) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestLine: Record "Purchase Line";
    begin
        /*StringBuilder:=StringBuilder.StringBuilder;
        StringWriter:=StringWriter.StringWriter(StringBuilder);
        JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjImprestLine.INIT;
        ObjImprestLine.No:=ImprestNo;
        ObjImprestLine.Type:=Type;
        ObjImprestLine.Amount:=Amount;
        ObjImprestLine.VALIDATE(No);
        ObjImprestLine.VALIDATE(Type);
        IF ObjImprestLine.INSERT(TRUE) THEN BEGIN
          ObjImprestLine.RESET;
          ObjImprestLine.SETRANGE(No,ImprestNo);
          IF ObjImprestLine.FINDFIRST THEN
            REPEAT
              JSONTextWriter.WriteStartObject;
              CreateJsonAttribute('No', ObjImprestLine.No);
              CreateJsonAttribute('AccountNo', ObjImprestLine."Account No:");
              CreateJsonAttribute('AccountName', ObjImprestLine."Account Name");
              CreateJsonAttribute('Amount', ObjImprestLine.Amount);
              CreateJsonAttribute('LineNo', ObjImprestLine."Line No.");
              JSONTextWriter.WriteEndObject;
            UNTIL ObjImprestLine.NEXT=0;
        
          JSONTextWriter.WriteEndArray;
          JsonOut:=StringBuilder.ToString;
          returnout:=JsonOut;
        END;
        */

    end;

    procedure fnDepartment() returnout: Text
    var
        ObjDimensionValue: Record "Dimension Value";
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjDimensionValue.Reset;
        ObjDimensionValue.SetRange("Global Dimension No.", 1);
        //ObjDimensionValue.SETRANGE("Fund Code",fundcode);
        if ObjDimensionValue.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjDimensionValue.Code);
                CreateJsonAttribute('Name', ObjDimensionValue.Name);
                JSONTextWriter.WriteEndObject;
            until ObjDimensionValue.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnDepartmentValue() returnout: Text
    var
        ObjDimensionValue: Record "Dimension Value";
        JsonOut: dotnet String;
        HRLeaveTypes: Record "HR Leave Types";
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjDimensionValue.Reset;
        ObjDimensionValue.SetRange("Global Dimension No.", 1);
        //ObjDimensionValue.SETRANGE("Fund Code",fundcode);
        if ObjDimensionValue.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjDimensionValue.Code);
                CreateJsonAttribute('Name', ObjDimensionValue.Code + ' - ' + ObjDimensionValue.Name);
                JSONTextWriter.WriteEndObject;
            until ObjDimensionValue.Next = 0;
        ///Leave

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnRolecenter() returnout: Text
    var
        ObjRolecenter: Record "Responsibility Center";
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjRolecenter.Reset;
        if ObjRolecenter.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjRolecenter.Code);
                CreateJsonAttribute('Name', ObjRolecenter.Name);
                JSONTextWriter.WriteEndObject;
            until ObjRolecenter.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnImprestList(empNo: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestHeader: Record "Purchase Header";
        ObjImprestLine: Record "Purchase Line";
        ObjHrEmployee: Record "HR Employees";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        if ObjHrEmployee.Get(empNo) then
            ObjImprestHeader.Reset;
        ObjImprestHeader.SetRange(IM, true);
        ObjImprestHeader.SetRange("Employee No", empNo);
        ObjImprestHeader.SetRange(ObjImprestHeader.Status, ObjImprestHeader.Status::Released);
        ObjImprestHeader.SetRange(ObjImprestHeader.Surrendered, false);
        if ObjImprestHeader.Find('-') then
            repeat
                ObjImprestHeader.CalcFields(Amount, "Amount Including VAT");
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', ObjImprestHeader."No.");
                CreateJsonAttribute('Document_Date', ObjImprestHeader."Document Date");
                CreateJsonAttribute('Status', ObjImprestHeader.Status);
                CreateJsonAttribute('Amount', ObjImprestHeader."Amount Including VAT");
                CreateJsonAttribute('DepartmentCode', ObjImprestHeader."Shortcut Dimension 1 Code");
                CreateJsonAttribute('Department', ObjImprestHeader."Posting Description");
                CreateJsonAttribute('DirectorateCode', ObjImprestHeader."Shortcut Dimension 2 Code");
                CreateJsonAttribute('StartDate', ObjImprestHeader."Posting Date");
                JSONTextWriter.WritePropertyName('StartDate');
                JSONTextWriter.WriteValue(ObjImprestHeader."Document Date");
                CreateJsonAttribute('EndDate', ObjImprestHeader."Document Date");
                CreateJsonAttribute('Completed', ObjImprestHeader.Completed);
                CreateJsonAttribute('Posted', ObjImprestHeader.Completed);
                CreateJsonAttribute('budgetdminesion', ObjImprestHeader."Shortcut Dimension 3 Code");
                CreateJsonAttribute('departmentdimension', ObjImprestHeader."Shortcut Dimension 4 Code");
                CreateJsonAttribute('budgetdescription', ObjImprestHeader."Shortcut Dimension 5 Code");
                CreateJsonAttribute('missionNo', ObjImprestHeader."Mission Proposal No");
                CreateJsonAttribute('ProjectTitle', ObjImprestHeader."Project Title");
                CreateJsonAttribute('purchaseRequisition', ObjImprestHeader."Requisition No");
                CreateJsonAttribute('briefOfProject', ObjImprestHeader.briefOfProject);
                CreateJsonAttribute('fromDate', ObjImprestHeader.fromDate);
                CreateJsonAttribute('toDate', ObjImprestHeader."Review From");
                CreateJsonAttribute('travelTo', ObjImprestHeader.travelTo);
                CreateJsonAttribute('placeofStay', ObjImprestHeader.placeOfStay);
                CreateJsonAttribute('Purpose', ObjImprestHeader.Purpose);
                CreateJsonAttribute('contactPerson', ObjImprestHeader.contactPerson);
                CreateJsonAttribute('itemsInPosession', ObjImprestHeader.itemsInPosession);
                CreateJsonAttribute('modeofTransport', ObjImprestHeader.modeOfTransport);

                JSONTextWriter.WritePropertyName('TravelDetails');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::ActionPoints then begin
                            JSONTextWriter.WriteStartObject;
                            // CreateJsonAttribute('ExpenseCategory', purchaseline."Expense Category");
                            JSONTextWriter.WritePropertyName('departureTime');
                            JSONTextWriter.WriteValue(purchaseline.departureTime);
                            JSONTextWriter.WritePropertyName('departurePlace');
                            JSONTextWriter.WriteValue(purchaseline.departurePlace);
                            JSONTextWriter.WritePropertyName('arrivalPlace');
                            JSONTextWriter.WriteValue(purchaseline.arrivalPlace);
                            JSONTextWriter.WritePropertyName('arrivalTime');
                            JSONTextWriter.WriteValue(purchaseline.arrivalTime);
                            JSONTextWriter.WritePropertyName('remarks');
                            JSONTextWriter.WriteValue(purchaseline.remarks);

                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;


                JSONTextWriter.WritePropertyName('AccomodationDetails');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::Activity then begin
                            JSONTextWriter.WriteStartObject;
                            //  CreateJsonAttribute('ExpenseCategory', purchaseline."Expense Category");
                            JSONTextWriter.WritePropertyName('dateFrom');
                            JSONTextWriter.WriteValue(purchaseline.dateFrom);
                            JSONTextWriter.WritePropertyName('dateTo');
                            JSONTextWriter.WriteValue(purchaseline.dateTo);
                            JSONTextWriter.WritePropertyName('accomodationCatered');
                            JSONTextWriter.WriteValue(purchaseline.accomodtionCatered);
                            JSONTextWriter.WritePropertyName('locationOfStay');
                            JSONTextWriter.WriteValue(purchaseline.locationOfStay);
                            JSONTextWriter.WritePropertyName('amount');
                            JSONTextWriter.WriteValue(purchaseline.Amount);
                            JSONTextWriter.WritePropertyName('noOfNights');
                            JSONTextWriter.WriteValue(purchaseline.noOfDays);
                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;


                JSONTextWriter.WritePropertyName('MealsAndIncidentals');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::"Budget Info" then begin
                            JSONTextWriter.WriteStartObject;
                            // CreateJsonAttribute('ExpenseCategory', purchaseline."Expense Category");
                            JSONTextWriter.WritePropertyName('date');
                            JSONTextWriter.WriteValue(purchaseline.date);
                            JSONTextWriter.WritePropertyName('location');
                            JSONTextWriter.WriteValue(purchaseline."location.");
                            JSONTextWriter.WritePropertyName('description');
                            JSONTextWriter.WriteValue(purchaseline.Description);
                            JSONTextWriter.WritePropertyName('amount');
                            JSONTextWriter.WriteValue(purchaseline.Amount);
                            JSONTextWriter.WritePropertyName('noOfDays');
                            JSONTextWriter.WriteValue(purchaseline.noOfDays);

                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;




                JSONTextWriter.WritePropertyName('OtherExpenses');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::"Budget Notes" then begin
                            JSONTextWriter.WriteStartObject;

                            JSONTextWriter.WritePropertyName('date');
                            JSONTextWriter.WriteValue(purchaseline.date);
                            JSONTextWriter.WritePropertyName('description');
                            JSONTextWriter.WriteValue(purchaseline.Description);
                            JSONTextWriter.WritePropertyName('amount');
                            JSONTextWriter.WriteValue(purchaseline.Amount);

                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;



                JSONTextWriter.WritePropertyName('activities');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::Activity then begin
                            JSONTextWriter.WriteStartObject;
                            JSONTextWriter.WritePropertyName('ExpectedReceiptDate');
                            JSONTextWriter.WriteValue(purchaseline."Expected Receipt Date");
                            JSONTextWriter.WritePropertyName('Description2');
                            JSONTextWriter.WriteValue(purchaseline.Description);
                            JSONTextWriter.WritePropertyName('Description3');
                            JSONTextWriter.WriteValue(purchaseline."Description 2");
                            JSONTextWriter.WritePropertyName('details');
                            JSONTextWriter.WriteValue(purchaseline."Description 3");
                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WritePropertyName('surrendered');
                JSONTextWriter.WriteValue(ObjImprestHeader.Surrendered);
                JSONTextWriter.WriteEndObject;
            until ObjImprestHeader.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnLeaveCardEdit(empNo: Code[50]; leavecode: Code[40]; Startdate: Date; Resposnsibilitycenter: Code[50]; LeaveType: Code[20]; DayApplied: Decimal; Releavecode: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        // JSONTextWriter.WriteStartArray;
        objHRLeaveApplication.Reset;
        objHRLeaveApplication.SetRange("Application Code", leavecode);
        if objHRLeaveApplication.Find('-') then begin
            objHRLeaveApplication."Leave Type" := LeaveType;
            objHRLeaveApplication."Responsibility Center" := Resposnsibilitycenter;
            objHRLeaveApplication."Days Applied" := DayApplied;
            objHRLeaveApplication."Start Date" := Startdate;
            objHRLeaveApplication.Reliever := Releavecode;
            objHRLeaveApplication.Validate("Start Date");
            if objHRLeaveApplication.Modify = true then begin
                objHRLeaveApplication.Reset;
                objHRLeaveApplication.SetRange("Employee No", empNo);
                if objHRLeaveApplication.Find('-') then
                    repeat
                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('No', objHRLeaveApplication."Application Code");
                        CreateJsonAttribute('Status', Format(objHRLeaveApplication.Status));
                        CreateJsonAttribute('StartDate', Format(objHRLeaveApplication."Start Date"));
                        CreateJsonAttribute('ReturnDate', Format(objHRLeaveApplication."Return Date"));
                        CreateJsonAttribute('NoofDayes', Format(objHRLeaveApplication."Days Applied"));
                        CreateJsonAttribute('LeaveType', Format(objHRLeaveApplication."Leave Type"));
                        // HREmployees.GET(objHRLeaveApplication.Reliever);
                        CreateJsonAttribute('RelieverCode', objHRLeaveApplication."Reliever Name");
                        CreateJsonAttribute('EndDate', objHRLeaveApplication."End Date");
                        CreateJsonAttribute('ApplicationDate', objHRLeaveApplication."Application Date");
                        CreateJsonAttribute('ApprovedDays', objHRLeaveApplication."Approved days");

                        JSONTextWriter.WriteEndObject;
                    until objHRLeaveApplication.Next = 0;
            end;

        end;

        //JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnMissionProportsalsList(empNo: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestHeader: Record "Purchase Header";
        ObjImprestLine: Record "Purchase Line";
        ObjHrEmployee: Record "HR Employees";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        if ObjHrEmployee.Get(empNo) then
            ObjImprestHeader.Reset;
        ObjImprestHeader.SetRange(MP, true);
        ObjImprestHeader.SetRange(Archived, false);
        ObjImprestHeader.SetRange("Employee No", empNo);
        if ObjImprestHeader.Find('-') then
            repeat
                ObjImprestHeader.CalcFields(Amount);
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', ObjImprestHeader."No.");
                CreateJsonAttribute('Document_Date', ObjImprestHeader."Document Date");
                CreateJsonAttribute('Status', ObjImprestHeader.Status);
                //CreateJsonAttribute('Amount', ObjImprestHeader.Amount);
                JSONTextWriter.WritePropertyName('Amount');
                JSONTextWriter.WriteValue(ObjImprestHeader.Amount);
                CreateJsonAttribute('ProgramCode', ObjImprestHeader."Shortcut Dimension 1 Code");
                CreateJsonAttribute('budgetdminesion', ObjImprestHeader."Shortcut Dimension 2 Code");
                // CreateJsonAttribute('StartDate', ObjImprestHeader."Document Date");
                JSONTextWriter.WritePropertyName('StartDate');
                JSONTextWriter.WriteValue(ObjImprestHeader."Document Date");
                CreateJsonAttribute('EndDate', ObjImprestHeader."Document Date");
                CreateJsonAttribute('Purpose', ObjImprestHeader.Purpose);
                CreateJsonAttribute('Completed', ObjImprestHeader.Completed);
                CreateJsonAttribute('StrategicFocusArea', ObjImprestHeader."Strategic Focus Area");
                CreateJsonAttribute('SubPillar', ObjImprestHeader."Sub Pillar");
                CreateJsonAttribute('ProjectTitle', ObjImprestHeader."Project Title");
                CreateJsonAttribute('Country', ObjImprestHeader.Country2);
                CreateJsonAttribute('County', ObjImprestHeader.County);
                CreateJsonAttribute('DateOfActivity', ObjImprestHeader."Date(s) of Activity");
                CreateJsonAttribute('MissionTeam', ObjImprestHeader."Mission Team");
                CreateJsonAttribute('InvitedMembers', ObjImprestHeader."Invited Members/Partners");
                CreateJsonAttribute('FundCode', ObjImprestHeader."Shortcut Dimension 1 Code");
                // CreateJsonAttribute('ProgramCode', ObjImprestHeader."Shortcut Dimension 2 Code");
                CreateJsonAttribute('Completed', ObjImprestHeader.Completed);
                //CreateJsonAttribute('budgetdminesion', ObjImprestHeader."Shortcut Dimension 3 Code");
                CreateJsonAttribute('departmentdimension', ObjImprestHeader."Shortcut Dimension 4 Code");
                CreateJsonAttribute('budgetdescription', ObjImprestHeader."Shortcut Dimension 5 Code");
                CreateJsonAttribute('InvitedMembers', ObjImprestHeader."Invited Members/Partners");
                CreateJsonAttribute('Background', ObjImprestHeader.Background);
                CreateJsonAttribute('StrategicFocus', ObjImprestHeader."Contribution to focus");
                CreateJsonAttribute('Outcome', ObjImprestHeader."Main Outcome");
                JSONTextWriter.WritePropertyName('TARLines');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" <> purchaseline."line type"::Activity then begin
                            JSONTextWriter.WriteStartObject;
                            CreateJsonAttribute('ExpenseCategory', purchaseline."ShortcutDimCode[4]");
                            JSONTextWriter.WritePropertyName('unitcost');
                            JSONTextWriter.WriteValue(purchaseline."Unit Cost");
                            JSONTextWriter.WritePropertyName('quantity');
                            JSONTextWriter.WriteValue(purchaseline.Quantity);
                            JSONTextWriter.WritePropertyName('unitcost');
                            JSONTextWriter.WriteValue(purchaseline."Unit Cost");
                            JSONTextWriter.WritePropertyName('Amount');
                            JSONTextWriter.WriteValue(purchaseline."No of pax");
                            JSONTextWriter.WritePropertyName('lineAmount');
                            JSONTextWriter.WriteValue(purchaseline."Line Amount");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WritePropertyName('activities');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::Activity then begin
                            JSONTextWriter.WriteStartObject;
                            JSONTextWriter.WritePropertyName('ExpectedReceiptDate');
                            JSONTextWriter.WriteValue(purchaseline."Expected Receipt Date");
                            JSONTextWriter.WritePropertyName('Description2');
                            JSONTextWriter.WriteValue(purchaseline.Description);
                            JSONTextWriter.WritePropertyName('Description3');
                            JSONTextWriter.WriteValue(purchaseline."Description 2");
                            JSONTextWriter.WritePropertyName('details');
                            JSONTextWriter.WriteValue(purchaseline."Description 3");
                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WritePropertyName('TravelDetails');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::ActionPoints then begin
                            JSONTextWriter.WriteStartObject;
                            // CreateJsonAttribute('ExpenseCategory', purchaseline."Expense Category");
                            JSONTextWriter.WritePropertyName('departureTime');
                            JSONTextWriter.WriteValue(purchaseline.departureTime);
                            JSONTextWriter.WritePropertyName('departurePlace');
                            JSONTextWriter.WriteValue(purchaseline.departurePlace);
                            JSONTextWriter.WritePropertyName('arrivalPlace');
                            JSONTextWriter.WriteValue(purchaseline.arrivalPlace);
                            JSONTextWriter.WritePropertyName('arrivalTime');
                            JSONTextWriter.WriteValue(purchaseline.arrivalTime);
                            JSONTextWriter.WritePropertyName('remarks');
                            JSONTextWriter.WriteValue(purchaseline.remarks);

                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;


                JSONTextWriter.WritePropertyName('AccomodationDetails');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::Activity then begin
                            JSONTextWriter.WriteStartObject;
                            //  CreateJsonAttribute('ExpenseCategory', purchaseline."Expense Category");
                            JSONTextWriter.WritePropertyName('dateFrom');
                            JSONTextWriter.WriteValue(purchaseline.dateFrom);
                            JSONTextWriter.WritePropertyName('dateTo');
                            JSONTextWriter.WriteValue(purchaseline.dateTo);
                            JSONTextWriter.WritePropertyName('accomodationCatered');
                            JSONTextWriter.WriteValue(purchaseline.accomodtionCatered);
                            JSONTextWriter.WritePropertyName('locationOfStay');
                            JSONTextWriter.WriteValue(purchaseline.locationOfStay);
                            JSONTextWriter.WritePropertyName('amount');
                            JSONTextWriter.WriteValue(purchaseline.Amount);
                            JSONTextWriter.WritePropertyName('noOfNights');
                            JSONTextWriter.WriteValue(purchaseline.noOfDays);
                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;


                JSONTextWriter.WritePropertyName('MealsAndIncidentals');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::"Budget Info" then begin
                            JSONTextWriter.WriteStartObject;
                            // CreateJsonAttribute('ExpenseCategory', purchaseline."Expense Category");
                            JSONTextWriter.WritePropertyName('date');
                            JSONTextWriter.WriteValue(purchaseline.date);
                            JSONTextWriter.WritePropertyName('location');
                            JSONTextWriter.WriteValue(purchaseline."location.");
                            JSONTextWriter.WritePropertyName('description');
                            JSONTextWriter.WriteValue(purchaseline.Description);
                            JSONTextWriter.WritePropertyName('amount');
                            JSONTextWriter.WriteValue(purchaseline.Amount);
                            JSONTextWriter.WritePropertyName('noOfDays');
                            JSONTextWriter.WriteValue(purchaseline.noOfDays);

                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;




                JSONTextWriter.WritePropertyName('OtherExpenses');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::"Budget Notes" then begin
                            JSONTextWriter.WriteStartObject;

                            JSONTextWriter.WritePropertyName('date');
                            JSONTextWriter.WriteValue(purchaseline.date);
                            JSONTextWriter.WritePropertyName('description');
                            JSONTextWriter.WriteValue(purchaseline.Description);
                            JSONTextWriter.WritePropertyName('amount');
                            JSONTextWriter.WriteValue(purchaseline.Amount);

                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;



                JSONTextWriter.WritePropertyName('activities');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::Activity then begin
                            JSONTextWriter.WriteStartObject;
                            JSONTextWriter.WritePropertyName('ExpectedReceiptDate');
                            JSONTextWriter.WriteValue(purchaseline."Expected Receipt Date");
                            JSONTextWriter.WritePropertyName('Description2');
                            JSONTextWriter.WriteValue(purchaseline.Description);
                            JSONTextWriter.WritePropertyName('Description3');
                            JSONTextWriter.WriteValue(purchaseline."Description 2");
                            JSONTextWriter.WritePropertyName('details');
                            JSONTextWriter.WriteValue(purchaseline."Description 3");
                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;
                // CreateJsonAttribute('Purpose',ObjImprestHeader.Purpose);
                JSONTextWriter.WritePropertyName('surrendered');
                JSONTextWriter.WriteValue(ObjImprestHeader.Surrendered);

                JSONTextWriter.WriteEndObject;
            until ObjImprestHeader.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure EmployeePhoto(StaffNo: Code[20]; VAR PictureText: text)
    var
        InStream: InStream;
        Employee: record "HR Employees";
        Media: Record "Tenant Media";
        Picture: Record "Media Set";
        FileSystem: File;
        FileName: Text[100];
        Base64: Codeunit "Base64 Convert";
    begin
        Employee.Reset();
        Employee.SetRange("No.", StaffNo);
        if Employee.Find('-') then begin
            Employee.CalcFields(Picture);
            if Employee.Picture.HasValue then begin
                Employee.Picture.CreateInstream(InStream);
                PictureText := Base64.ToBase64(InStream);
            end;
        end;

    end;

    procedure AppreciationPhoto(VAR PictureText: text)
    var
        HrSetup: Record "HR Setup";
        InStream: InStream;
        Media: Record "Tenant Media";
        Picture: Record "Media Set";
        FileSystem: File;
        FileName: Text[100];
        Base64: Codeunit "Base64 Convert";
    begin
        HrSetup.GET();
        HrSetup.CalcFields("Employee Picture");
        if HrSetup."Employee Picture".HasValue then begin
            HrSetup."Employee Picture".CreateInstream(InStream);
            PictureText := Base64.ToBase64(InStream);
        end;
    end;

    procedure fnGetProfilePicture(empno: Code[30]; var PictureText: BigText)
    var
        PictureInStream: InStream;
        PictureOutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
    begin
        HREmployees.Reset;
        HREmployees.SetRange("No.", empno);
        if HREmployees.Find('-') then begin
            HREmployees.CalcFields(Picture);
            if HREmployees.Picture.Hasvalue then begin
                // PictureText.ADDTEXT(HREmployees
                // Clear(PictureText);
                // Clear(PictureInStream);
                // HREmployees.Picture.CreateInstream(PictureInStream);
                // TempBlob.DeleteAll;
                // TempBlob.Init;
                // TempBlob.Blob.CreateOutstream(PictureOutStream);
                // CopyStream(PictureOutStream, PictureInStream);
                // TempBlob.Insert;
                // TempBlob.CalcFields(Blob);
                // PictureText.AddText(TempBlob.ToBase64String);
            end;
        end;
    end;

    procedure fnGetStandardText() returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestHeader: Record "Purchase Header";
        ObjImprestLine: Record "Purchase Line";
        ObjHrEmployee: Record "HR Employees";
        standardtext: Record "Standard Text";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;


        if standardtext.Find('-') then
            repeat
                // ObjImprestHeader.CALCFIELDS(Amount);
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', standardtext.Code);
                CreateJsonAttribute('Name', standardtext.Description);
                CreateJsonAttribute('Type', standardtext.Type2);

                JSONTextWriter.WriteEndObject;
            until standardtext.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnGetContryregions() returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestHeader: Record "Purchase Header";
        ObjImprestLine: Record "Purchase Line";
        ObjHrEmployee: Record "HR Employees";
        countryRegions: Record "Country/Region";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;


        if countryRegions.Find('-') then
            repeat
                // ObjImprestHeader.CALCFIELDS(Amount);
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', countryRegions.Code);
                CreateJsonAttribute('Name', countryRegions.Name);
                CreateJsonAttribute('Type', countryRegions.Type3);

                JSONTextWriter.WriteEndObject;
            until countryRegions.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnInsertMissionProporsal(stratrgicFocusarea: Code[60]; subpillar: Code[60]; projecttitle: Text; country: Code[80]; county: Code[90]; datesofActivities: Text; missionteam: Text; invitedmebers: Text; fundcode: Code[90]; programcode: Code[90]; departmentdimension: Code[50]; budgetdimesion: Code[50]; budgetdescription: Code[60]; background: Text; strategicfocus: Text; outcome: Text; empno: Code[40]) mssno: Code[60]
    begin
        purchaseheader.Init;
        GenLedgerSetup.Get();
        purchaseheader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Mission Proposal Nos.", 0D, true);
        purchaseheader."No. Series" := GenLedgerSetup."Mission Proposal Nos.";
        purchaseheader."Strategic Focus Area" := stratrgicFocusarea;
        purchaseheader."Sub Pillar" := subpillar;
        purchaseheader."Project Title" := projecttitle;
        purchaseheader.Country2 := country;
        purchaseheader.County := county;
        purchaseheader."Date(s) of Activity" := datesofActivities;
        purchaseheader."Mission Team" := missionteam;
        purchaseheader."Invited Members/Partners" := invitedmebers;
        purchaseheader."Shortcut Dimension 1 Code" := programcode;
        purchaseheader."Shortcut Dimension 2 Code" := fundcode;
        purchaseheader.MP := true;
        purchaseheader.Status := purchaseheader.Status::Open;
        purchaseheader."User ID" := UserId;
        purchaseheader."Shortcut Dimension 3 Code" := budgetdimesion;
        purchaseheader."Shortcut Dimension 4 Code" := departmentdimension;
        purchaseheader."Shortcut Dimension 5 Code" := budgetdescription;
        purchaseheader."Main Outcome" := outcome;
        purchaseheader.Background := background;
        purchaseheader."Contribution to focus" := strategicfocus;
        if empno = '' then Error('Session timeout please login and try again');
        purchaseheader."Employee No" := empno;
        purchaseheader.Validate("Employee No");
        purchaseheader.Insert;


        mssno := purchaseheader."No.";
    end;

    procedure fnUpdateMissionProporsal(stratrgicFocusarea: Code[60]; subpillar: Code[60]; projecttitle: Text; country: Code[80]; county: Code[90]; datesofActivities: Text; missionteam: Text; invitedmebers: Text; fundcode: Code[90]; programcode: Code[90]; No: Code[50]; departmentdimension: Code[50]; budgetdimesion: Code[50]; budgetdescription: Code[60]; background: Text; strategicfocus: Text; outcome: Text) msnno: Code[40]
    begin

        //GenLedgerSetup.GET();
        purchaseheader.Get(purchaseheader."document type"::Quote, No);
        //purchaseheader."No.":=No;
        //purchaseheader."No. Series":=GenLedgerSetup."Mission Proposal Nos.";
        purchaseheader."Strategic Focus Area" := stratrgicFocusarea;
        purchaseheader."Sub Pillar" := subpillar;
        purchaseheader."Project Title" := projecttitle;
        purchaseheader.Country2 := country;
        purchaseheader.County := county;
        purchaseheader."Date(s) of Activity" := datesofActivities;
        purchaseheader."Mission Team" := missionteam;
        purchaseheader."Invited Members/Partners" := invitedmebers;
        purchaseheader."Shortcut Dimension 1 Code" := fundcode;
        purchaseheader."Shortcut Dimension 2 Code" := programcode;
        purchaseheader.MP := true;
        purchaseheader.Status := purchaseheader.Status::Open;
        purchaseheader."User ID" := UserId;
        purchaseheader."User ID" := UserId;
        purchaseheader."Shortcut Dimension 3 Code" := budgetdimesion;
        purchaseheader."Shortcut Dimension 4 Code" := departmentdimension;
        purchaseheader."Shortcut Dimension 5 Code" := budgetdescription;
        purchaseheader."Main Outcome" := outcome;
        purchaseheader.Background := background;
        purchaseheader."Contribution to focus" := strategicfocus;
        purchaseheader.Modify;
        msnno := purchaseheader."No.";
    end;

    procedure fnPurchaseRequisitionList(empNo: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestHeader: Record "Purchase Header";
        ObjImprestLine: Record "Purchase Line";
        ObjHrEmployee: Record "HR Employees";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        if ObjHrEmployee.Get(empNo) then
            ObjImprestHeader.Reset;
        ObjImprestHeader.SetRange(PR, true);
        //ObjImprestHeader.SETRANGE("User ID", ObjHrEmployee."User ID");
        ObjImprestHeader.SetRange("Employee No", empNo);
        if ObjImprestHeader.Find('-') then begin
            repeat
                ObjImprestHeader.CalcFields(Amount);
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', ObjImprestHeader."No.");
                CreateJsonAttribute('Document_Date', ObjImprestHeader."Expected Receipt Date");
                CreateJsonAttribute('Status', ObjImprestHeader.Status);
                CreateJsonAttribute('Amount', ObjImprestHeader.Amount);
                CreateJsonAttribute('DepartmentCode', ObjImprestHeader."Shortcut Dimension 1 Code");
                CreateJsonAttribute('DirectorateCode', ObjImprestHeader."Shortcut Dimension 2 Code");
                // CreateJsonAttribute('StartDate', ObjImprestHeader."Expected Receipt Date");
                JSONTextWriter.WritePropertyName('StartDate');
                JSONTextWriter.WriteValue(ObjImprestHeader."Expected Receipt Date");
                CreateJsonAttribute('EndDate', ObjImprestHeader."Document Date");
                CreateJsonAttribute('Completed', ObjImprestHeader.Completed);
                CreateJsonAttribute('StrategicFocusArea', ObjImprestHeader."Strategic Focus Area");
                CreateJsonAttribute('SubPillar', ObjImprestHeader."Sub Pillar");
                CreateJsonAttribute('ProjectTitle', ObjImprestHeader."Project Title");
                CreateJsonAttribute('Country', ObjImprestHeader.Country2);
                CreateJsonAttribute('County', ObjImprestHeader.Country2);
                CreateJsonAttribute('DateOfActivity', ObjImprestHeader."Date(s) of Activity");
                CreateJsonAttribute('MissionTeam', ObjImprestHeader."Mission Team");
                CreateJsonAttribute('InvitedMembers', ObjImprestHeader."Invited Members/Partners");
                CreateJsonAttribute('FundCode', ObjImprestHeader."Shortcut Dimension 1 Code");
                CreateJsonAttribute('ProgramCode', ObjImprestHeader."Shortcut Dimension 2 Code");
                CreateJsonAttribute('Completed', ObjImprestHeader.Completed);
                CreateJsonAttribute('missionNo', ObjImprestHeader."Mission Proposal No");
                //dimensionvalues.RESET;
                //dimensionvalues.SETRANGE("Dimension Code", ObjImprestHeader."Shortcut Dimension 5 Code");

                CreateJsonAttribute('budgetdminesion', ObjImprestHeader."Shortcut Dimension 3 Code");

                CreateJsonAttribute('departmentdimension', ObjImprestHeader."Shortcut Dimension 5 Code");
                CreateJsonAttribute('budgetdescription', ObjImprestHeader."Shortcut Dimension 4 Code");

                // CreateJsonAttribute('Purpose',ObjImprestHeader.Purpose);
                JSONTextWriter.WriteEndObject;
            until ObjImprestHeader.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnInsertPurchaseRequest(fundcode: Code[90]; programcode: Code[90]; daterequried: Date; missionno: Code[50]; departmentdimension: Code[50]; budgetdimesion: Code[50]; budgetdescription: Code[60]; empno: Code[40])
    begin
        purchaseheader.Init;
        GenLedgerSetup.Get();
        purchaseheader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Requisition Nos.", 0D, true);
        purchaseheader."No. Series" := GenLedgerSetup."Requisition Nos.";
        purchaseheader."Document Type" := purchaseheader."document type"::Quote;
        purchaseheader.DocApprovalType2 := purchaseheader.Docapprovaltype2::Requisition;

        purchaseheader."Expected Receipt Date" := daterequried;
        purchaseheader."Mission Proposal No" := missionno;
        purchaseheader."Shortcut Dimension 1 Code" := fundcode;
        purchaseheader."Shortcut Dimension 2 Code" := programcode;
        purchaseheader.PR := true;
        purchaseheader.Requisition := true;
        purchaseheader.Status := purchaseheader.Status::Open;
        purchaseheader."User ID" := UserId;
        purchaseheader."Shortcut Dimension 3 Code" := budgetdimesion;
        purchaseheader."Shortcut Dimension 4 Code" := departmentdimension;
        purchaseheader."Shortcut Dimension 5 Code" := budgetdescription;
        purchaseheader."Employee No" := empno;
        purchaseheader.Validate("Employee No");
        purchaseheader.Insert;
    end;

    procedure fninsertimprestnew(JsonData: Text; emp: Code[50])
    var
        lineNo: Integer;
        departuretime: DateTime;
        arrivalTime: DateTime;
        ModifyLineNo: Integer;
        no: Code[30];
    begin

        lJSONString := JsonData;
        if lJSONString <> '' then
            lJObject := lJObject.Parse(Format(lJSONString));

        Evaluate(no, Format(lJObject.GetValue('No')));
        if no = '' then begin
            purchaseheader.Init;
            GenLedgerSetup.Get;
            purchaseheader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Imprest Nos.", 0D, true);
            purchaseheader."No. Series" := GenLedgerSetup."Imprest Nos.";
            purchaseheader."Document Type" := purchaseheader."document type"::Quote;
            purchaseheader.IM := true;
        end
        else
            purchaseheader."No." := Format(lJObject.GetValue('No'));

        purchaseheader."Shortcut Dimension 1 Code" := Format(lJObject.GetValue('ProgramCode'));
        purchaseheader."Shortcut Dimension 2 Code" := Format(lJObject.GetValue('budgetdminesion'));
        purchaseheader.Purpose := Format(lJObject.GetValue('Purpose'));
        purchaseheader."Posting Description" := Format(lJObject.GetValue('Department'));

        purchaseheader."Employee No" := emp;

        purchaseheader.Validate("Employee No");
        lineNo := 10000;
        // Peformance
        //Travel detials
        lJObject := lJObject.Parse(Format(lJSONString));
        lArrayString := lJObject.SelectToken('TravelDetails').ToString;
        if lArrayString <> '' then begin
            Clear(lJObject);
            lJsonArray := lJsonArray.Parse(lArrayString);



            foreach lJObject in lJsonArray do begin
                Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));

                if ModifyLineNo = 0 then begin
                    purchaseline.Init;
                    purchaseline."Line No." := lineNo;
                end else
                    purchaseline."Line No." := ModifyLineNo;
                purchaseline."Document No." := purchaseheader."No.";
                purchaseline."Line Type" := purchaseline."line type"::ActionPoints;


                Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));
                purchaseline.date := purchaseline.date;
                Evaluate(departuretime, Format(lJObject.GetValue('departureTime')));
                purchaseline.departureTime := Dt2Time(departuretime);
                purchaseline.departurePlace := Format(lJObject.GetValue('departurePlace'));
                purchaseline.arrivalPlace := Format(lJObject.GetValue('arrivalPlace'));
                Evaluate(arrivalTime, Format(lJObject.GetValue('arrivalTime')));
                purchaseline.arrivalTime := Dt2Time(arrivalTime);
                purchaseline.remarks := Format(lJObject.GetValue('remarks'));
                lineNo += 1000;
                if ModifyLineNo = 0 then
                    purchaseline.Insert
                else
                    purchaseline.Modify;
            end;
            lineNo += 1000;
        end;
        lJObject := lJObject.Parse(Format(lJSONString));
        lArrayString := lJObject.SelectToken('AccomodationDetails').ToString;
        Clear(lJObject);
        if lArrayString <> '' then begin
            lJsonArray := lJsonArray.Parse(lArrayString);

            //Accoumodation detils
            foreach lJObject in lJsonArray do begin
                Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
                if ModifyLineNo = 0 then begin
                    purchaseline.Init;
                    purchaseline."Line No." := lineNo;
                end else
                    purchaseline."Line No." := ModifyLineNo;
                purchaseline."Document No." := purchaseheader."No.";
                purchaseline."Line Type" := purchaseline."line type"::Activity;


                Evaluate(purchaseline.dateFrom, Format(lJObject.GetValue('dateFrom')));
                Evaluate(purchaseline.dateTo, Format(lJObject.GetValue('dateTo')));
                purchaseline.date := purchaseline.date;
                Evaluate(purchaseline.accomodtionCatered, Format(lJObject.GetValue('accomodationCatered')));
                purchaseline.locationOfStay := Format(lJObject.GetValue('locationOfStay'));
                Evaluate(purchaseline."Amount Spent", Format(lJObject.GetValue('amountSpent')));
                Evaluate(purchaseline.amountToRefund, Format(lJObject.GetValue('amountToRefund')));
                Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));
                Evaluate(purchaseline.noOfDays, Format(lJObject.GetValue('noOfNights')));

                purchaseline."Travel Line Total" := purchaseline.Amount * purchaseline.noOfDays;
                lineNo += 1000;
                if ModifyLineNo = 0 then
                    purchaseline.Insert
                else
                    purchaseline.Modify;
            end;
            lineNo += 1000;
        end;

        /// Meals and incidentals
        lJObject := lJObject.Parse(Format(lJSONString));
        lArrayString := lJObject.SelectToken('MealsAndIncidentals').ToString;
        if lArrayString <> '' then begin
            Clear(lJObject);
            lJsonArray := lJsonArray.Parse(lArrayString);

            foreach lJObject in lJsonArray do begin
                Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
                if ModifyLineNo = 0 then begin
                    purchaseline.Init;
                    purchaseline."Line No." := lineNo;
                end else
                    purchaseline."Line No." := ModifyLineNo;
                purchaseline."Document No." := purchaseheader."No.";
                purchaseline."Line Type" := purchaseline."line type"::"Budget Info";


                Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));
                Evaluate(purchaseline.amountToRefund, Format(lJObject.GetValue('amountToRefund')));
                Evaluate(purchaseline."Amount Spent", Format(lJObject.GetValue('amount')));
                purchaseline."location." := Format(lJObject.GetValue('location'));
                purchaseline.Description := Format(lJObject.GetValue('description'));
                Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));
                Evaluate(purchaseline.noOfDays, Format(lJObject.GetValue('noOfDays')));
                purchaseline."Travel Line Total" := purchaseline.Amount * purchaseline.noOfDays;
                lineNo += 1000;
                if ModifyLineNo = 0 then
                    purchaseline.Insert
                else
                    purchaseline.Modify;
            end;
            lineNo += 1000;
        end;

        // other expenses
        lJObject := lJObject.Parse(Format(lJSONString));
        lArrayString := lJObject.SelectToken('OtherExpenses').ToString;
        if lArrayString <> '' then begin
            Clear(lJObject);
            lJsonArray := lJsonArray.Parse(lArrayString);


            foreach lJObject in lJsonArray do begin
                Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
                if ModifyLineNo = 0 then begin
                    purchaseline.Init;
                    purchaseline."Line No." := lineNo;
                end else
                    purchaseline."Line No." := ModifyLineNo;
                purchaseline."Document No." := purchaseheader."No.";
                purchaseline."Line Type" := purchaseline."line type"::"Budget Notes";


                Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));
                Evaluate(purchaseline.amountToRefund, Format(lJObject.GetValue('amountToRefund')));
                Evaluate(purchaseline."Amount Spent", Format(lJObject.GetValue('amount')));
                purchaseline."location." := Format(lJObject.GetValue('location'));
                purchaseline.Description := Format(lJObject.GetValue('description'));
                Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));
                purchaseline."Travel Line Total" := purchaseline.Amount;
                lineNo += 1000;
                if ModifyLineNo = 0 then
                    purchaseline.Insert
                else
                    purchaseline.Modify;
                lineNo += 1000;
            end;
        end;
        if no = '' then
            purchaseheader.Insert
        else
            purchaseheader.Modify;
    end;

    procedure fnimprestlineinsert(expensecategory: Code[50]; description: Text; unitcost: Decimal; currency: Code[10]; amount: Decimal; documentno: Code[50])
    begin
        purchaseline.Init;
        purchaseline."Document No." := documentno;
        PurchasesPayablesSetup.Get;
        Evaluate(purchaseline."Line No.", objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.", Today, true));
        purchaseline."Expense Category" := expensecategory;
        purchaseline.Validate("Expense Category");
        purchaseline.Description := description;
        purchaseline."Direct Unit Cost" := unitcost;
        purchaseline."Currency Code" := currency;
        purchaseline.Validate("Currency Code");
        purchaseline.Quantity := amount;
        purchaseline.Validate("Direct Unit Cost");
        purchaseline.Insert;
    end;

    procedure fninsertPurchasenew(fundcode: Code[50]; programcode: Code[50]; purpose: Code[40]; daterequired: Date; departmentdimension: Code[50]; budgetdimesion: Code[50]; budgetdescription: Code[60]; missionno: Code[50]; empno: Code[50]) impno: Code[50]
    begin
        purchaseheader.Init;
        GenLedgerSetup.Get();
        purchaseheader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Requisition Nos.", 0D, true);
        purchaseheader."No. Series" := GenLedgerSetup."Requisition Nos.";
        purchaseheader."Document Type" := purchaseheader."document type"::Quote;
        purchaseheader.DocApprovalType2 := purchaseheader.Docapprovaltype2::Requisition;
        purchaseheader."Posting Description" := purpose;
        purchaseheader."Posting Date" := Today;
        purchaseheader."Mission Proposal No" := missionno;
        purchaseheader."Expected Receipt Date" := daterequired;
        //purchaseheader."Mission Proposal No":=missionno;
        purchaseheader."Shortcut Dimension 2 Code" := budgetdimesion;
        purchaseheader."Shortcut Dimension 1 Code" := fundcode;
        purchaseheader.PR := true;
        purchaseheader.Requisition := true;
        purchaseheader.Status := purchaseheader.Status::Open;
        purchaseheader."User ID" := UserId;
        purchaseheader."Shortcut Dimension 3 Code" := budgetdimesion;
        purchaseheader."Shortcut Dimension 5 Code" := departmentdimension;
        purchaseheader."Shortcut Dimension 4 Code" := budgetdescription;
        purchaseheader."Employee No" := empno;
        purchaseheader.Validate("Employee No");
        purchaseheader.Insert;

        impno := purchaseheader."No.";
    end;

    procedure fnPurchaselineinsert(expensecategory: Code[50]; description: Text; unicost: Decimal; currency: Code[10]; amount: Decimal; documentno: Code[50])
    begin
        purchaseline.Init;

        purchaseheader.Get(purchaseheader."document type"::Quote, documentno);
        PurchasesPayablesSetup.Get;
        Evaluate(purchaseline."Line No.", objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.", Today, true));
        purchaseline."Document No." := documentno;
        //purchaseline."Shortcut Dimension 4 Code":=purchaseheader."Shortcut Dimension 4 Code";
        //purchaseline.VALIDATE("Shortcut Dimension 4 Code");
        //purchaseline.VALIDATE("Expense Category");
        //purchaseline."Direct Unit Cost":=unicost;
        purchaseline."Direct Unit Cost" := unicost;
        purchaseline.Validate("Direct Unit Cost");
        purchaseline."Unit of Measure" := expensecategory;
        purchaseline.Quantity := amount;
        purchaseline.Validate(Quantity);
        purchaseline.Amount := unicost * amount;
        //purchaseline."Currency Code":=currency;
        //purchaseline.VALIDATE("Currency Code");
        //purchaseline.VALIDATE("Direct Unit Cost");
        purchaseline."Description 2" := description;

        purchaseline.Insert;
    end;

    procedure fnDimensionValuesList(fundcode: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestHeader: Record "Purchase Header";
        ObjImprestLine: Record "Purchase Line";
        ObjHrEmployee: Record "HR Employees";
        countryRegions: Record "Dimension Value";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        if fundcode <> '' then
            countryRegions.SetRange("Project Code", fundcode);

        if countryRegions.Find('-') then
            repeat
                // ObjImprestHeader.CALCFIELDS(Amount);
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', countryRegions.Code);
                CreateJsonAttribute('Name', countryRegions.Name);
                CreateJsonAttribute('Type', countryRegions."Global Dimension No.");

                JSONTextWriter.WriteEndObject;
            until countryRegions.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnApproval(no: Code[50])

    var
        purchaseheaderNew: Record "Purchase Header";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        purchaseheader.Reset;
        purchaseheader.SetRange("No.", no);
        if purchaseheader.Find('-') then begin
            if (ApprovalMgt.CheckPurchaseApprovalPossible(purchaseheader)) then
                ApprovalMgt.OnSendPurchaseDocForApproval(purchaseheader);
        end;
        // // TRAVEL REQUEST 
        // purchaseheaderNew.Reset;
        // purchaseheaderNew.SetRange("No.", no);
        // if purchaseheaderNew.Find('-') then begin
        //     if (ApprovalsMgmt.CheckPurchaseApprovalPossible(purchaseheaderNew)) then
        //         ApprovalsMgmt.OnSendPurchaseDocForApproval(purchaseheaderNew);
        // end;
    end;

    procedure fnCancelApproval(no: Code[50])

    var
        purchaseheaderNew: Record "Purchase Header";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        purchaseheader.Reset;
        purchaseheader.SetRange("No.", no);
        if purchaseheader.Find('-') then begin
            if (ApprovalMgt.CheckPurchaseApprovalPossible(purchaseheader)) then
                ApprovalMgt.OnCancelPurchaseApprovalRequest(purchaseheader);
        end;

    end;

    procedure ApprovedList(empNo: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjApproval: Record "Approval Entry";
        ObjHrEmployee: Record "HR Employees";
        Leave: Record "Hr Leave Application";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        if ObjHrEmployee.Get(empNo) then begin

            ObjApproval.Reset;
            ObjApproval.SetRange("Approver ID", ObjHrEmployee."Employee UserID");
            ObjApproval.SETFILTER(Status, '=%1', ObjApproval.Status::Approved);
            if ObjApproval.FindFirst then
                repeat
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('DocumentNo', ObjApproval."Document No.");
                    CreateJsonAttribute('SenderID', ObjApproval."Sender ID");
                    purchaseheader2.Reset;
                    purchaseheader2.SetRange("No.", ObjApproval."Document No.");
                    if purchaseheader2.FindFirst then begin
                        CreateJsonAttribute('SenderID', purchaseheader2."Employee Name");
                    end;


                    Leave.Reset;
                    Leave.SetRange(Leave."Application Code", ObjApproval."Document No.");
                    if Leave.FindFirst then begin
                        CreateJsonAttribute('SenderID', Leave."Employee Name");
                    end;

                    CreateJsonAttribute('ApproverID', ObjApproval."Approver ID");
                    CreateJsonAttribute('DateTimeSent', ObjApproval."Date-Time Sent for Approval");
                    CreateJsonAttribute('Amount', ObjApproval.Amount);
                    CreateJsonAttribute('Status', ObjApproval.Status);
                    CreateJsonAttribute('PayingBank', ObjApproval."Paying Bank Number");
                    CreateJsonAttribute('ChequeNo', ObjApproval."Payment Voucher No");
                    CreateJsonAttribute('CashBook', ObjApproval."CashBook Narration");
                    CreateJsonAttribute('Payee', ObjApproval.Memo);
                    CreateJsonAttribute('Name', ObjApproval."Mission Narration");
                    CreateJsonAttribute('Purpose', ObjApproval."Purpose for Travel");
                    CreateJsonAttribute('DepartureDate', ObjApproval.fromDate);
                    JSONTextWriter.WriteEndObject;
                until ObjApproval.Next = 0;

            JSONTextWriter.WriteEndArray;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
        end;
    end;

    procedure fnSurrenderList(empNo: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestHeader: Record "Purchase Header";
        ObjImprestLine: Record "Purchase Line";
        ObjHrEmployee: Record "HR Employees";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        if ObjHrEmployee.Get(empNo) then
            ObjImprestHeader.Reset;
        ObjImprestHeader.SetRange(SR, true);
        ObjImprestHeader.SetRange("Employee No", empNo);
        if ObjImprestHeader.Find('-') then
            repeat
                ObjImprestHeader.CalcFields(Amount, "Amount Including VAT");
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', ObjImprestHeader."No.");
                CreateJsonAttribute('Document_Date', ObjImprestHeader."Document Date");
                CreateJsonAttribute('Status', ObjImprestHeader.Status);
                CreateJsonAttribute('Amount', ObjImprestHeader."Amount Including VAT");
                CreateJsonAttribute('DepartmentCode', ObjImprestHeader."Shortcut Dimension 1 Code");
                CreateJsonAttribute('Department', ObjImprestHeader."Posting Description");
                CreateJsonAttribute('DirectorateCode', ObjImprestHeader."Shortcut Dimension 2 Code");
                CreateJsonAttribute('StartDate', ObjImprestHeader."Posting Date");
                JSONTextWriter.WritePropertyName('StartDate');
                JSONTextWriter.WriteValue(ObjImprestHeader."Document Date");
                CreateJsonAttribute('EndDate', ObjImprestHeader."Document Date");
                CreateJsonAttribute('Completed', ObjImprestHeader.Completed);
                CreateJsonAttribute('Posted', ObjImprestHeader.Completed);
                CreateJsonAttribute('budgetdminesion', ObjImprestHeader."Shortcut Dimension 3 Code");
                CreateJsonAttribute('departmentdimension', ObjImprestHeader."Shortcut Dimension 4 Code");
                CreateJsonAttribute('budgetdescription', ObjImprestHeader."Shortcut Dimension 5 Code");
                CreateJsonAttribute('missionNo', ObjImprestHeader."Mission Proposal No");
                CreateJsonAttribute('ProjectTitle', ObjImprestHeader."Project Title");
                CreateJsonAttribute('purchaseRequisition', ObjImprestHeader."Requisition No");
                CreateJsonAttribute('briefOfProject', ObjImprestHeader.briefOfProject);
                CreateJsonAttribute('fromDate', ObjImprestHeader.fromDate);
                CreateJsonAttribute('toDate', ObjImprestHeader."Review From");
                CreateJsonAttribute('travelTo', ObjImprestHeader.travelTo);
                CreateJsonAttribute('placeofStay', ObjImprestHeader.placeOfStay);
                CreateJsonAttribute('Purpose', ObjImprestHeader.Purpose);
                CreateJsonAttribute('contactPerson', ObjImprestHeader.contactPerson);
                CreateJsonAttribute('itemsInPosession', ObjImprestHeader.itemsInPosession);
                CreateJsonAttribute('modeofTransport', ObjImprestHeader.modeOfTransport);

                JSONTextWriter.WritePropertyName('TravelDetails');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::ActionPoints then begin
                            JSONTextWriter.WriteStartObject;
                            // CreateJsonAttribute('ExpenseCategory', purchaseline."Expense Category");
                            JSONTextWriter.WritePropertyName('departureTime');
                            JSONTextWriter.WriteValue(purchaseline.departureTime);
                            JSONTextWriter.WritePropertyName('departurePlace');
                            JSONTextWriter.WriteValue(purchaseline.departurePlace);
                            JSONTextWriter.WritePropertyName('arrivalPlace');
                            JSONTextWriter.WriteValue(purchaseline.arrivalPlace);
                            JSONTextWriter.WritePropertyName('arrivalTime');
                            JSONTextWriter.WriteValue(purchaseline.arrivalTime);
                            JSONTextWriter.WritePropertyName('remarks');
                            JSONTextWriter.WriteValue(purchaseline.remarks);

                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;


                JSONTextWriter.WritePropertyName('AccomodationDetails');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::Activity then begin
                            JSONTextWriter.WriteStartObject;
                            //  CreateJsonAttribute('ExpenseCategory', purchaseline."Expense Category");
                            JSONTextWriter.WritePropertyName('dateFrom');
                            JSONTextWriter.WriteValue(purchaseline.dateFrom);
                            JSONTextWriter.WritePropertyName('dateTo');
                            JSONTextWriter.WriteValue(purchaseline.dateTo);
                            JSONTextWriter.WritePropertyName('accomodationCatered');
                            JSONTextWriter.WriteValue(purchaseline.accomodtionCatered);
                            JSONTextWriter.WritePropertyName('locationOfStay');
                            JSONTextWriter.WriteValue(purchaseline.locationOfStay);
                            JSONTextWriter.WritePropertyName('amount');
                            JSONTextWriter.WriteValue(purchaseline.Amount);
                            JSONTextWriter.WritePropertyName('noOfNights');
                            JSONTextWriter.WriteValue(purchaseline.noOfDays);
                            JSONTextWriter.WritePropertyName('amountSpent');
                            JSONTextWriter.WriteValue(purchaseline.Amount * purchaseline.noOfDays);
                            JSONTextWriter.WritePropertyName('amountToRefund');
                            JSONTextWriter.WriteValue(purchaseline.amountToRefund);
                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;


                JSONTextWriter.WritePropertyName('MealsAndIncidentals');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::"Budget Info" then begin
                            JSONTextWriter.WriteStartObject;
                            // CreateJsonAttribute('ExpenseCategory', purchaseline."Expense Category");
                            JSONTextWriter.WritePropertyName('date');
                            JSONTextWriter.WriteValue(purchaseline.date);
                            JSONTextWriter.WritePropertyName('location');
                            JSONTextWriter.WriteValue(purchaseline."location.");
                            JSONTextWriter.WritePropertyName('description');
                            JSONTextWriter.WriteValue(purchaseline.Description);
                            JSONTextWriter.WritePropertyName('amount');
                            JSONTextWriter.WriteValue(purchaseline.Amount);
                            JSONTextWriter.WritePropertyName('noOfDays');
                            JSONTextWriter.WriteValue(purchaseline.noOfDays);
                            JSONTextWriter.WritePropertyName('amountSpent');
                            JSONTextWriter.WriteValue(purchaseline.noOfDays * purchaseline.Amount);
                            JSONTextWriter.WritePropertyName('amountToRefund');
                            JSONTextWriter.WriteValue(purchaseline.amountToRefund);
                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;




                JSONTextWriter.WritePropertyName('OtherExpenses');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::"Budget Notes" then begin
                            JSONTextWriter.WriteStartObject;

                            JSONTextWriter.WritePropertyName('date');
                            JSONTextWriter.WriteValue(purchaseline.date);
                            JSONTextWriter.WritePropertyName('description');
                            JSONTextWriter.WriteValue(purchaseline.Description);
                            JSONTextWriter.WritePropertyName('amount');
                            JSONTextWriter.WriteValue(purchaseline.Amount);
                            JSONTextWriter.WritePropertyName('amountSpent');
                            JSONTextWriter.WriteValue(purchaseline."Amount Spent");
                            JSONTextWriter.WritePropertyName('amountToRefund');
                            JSONTextWriter.WriteValue(purchaseline.amountToRefund);
                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;



                JSONTextWriter.WritePropertyName('activities');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", ObjImprestHeader."No.");
                if purchaseline.Find('-') then begin
                    repeat
                        if purchaseline."Line Type" = purchaseline."line type"::Activity then begin
                            JSONTextWriter.WriteStartObject;
                            JSONTextWriter.WritePropertyName('ExpectedReceiptDate');
                            JSONTextWriter.WriteValue(purchaseline."Expected Receipt Date");
                            JSONTextWriter.WritePropertyName('Description2');
                            JSONTextWriter.WriteValue(purchaseline.Description);
                            JSONTextWriter.WritePropertyName('Description3');
                            JSONTextWriter.WriteValue(purchaseline."Description 2");
                            JSONTextWriter.WritePropertyName('details');
                            JSONTextWriter.WriteValue(purchaseline."Description 3");
                            JSONTextWriter.WritePropertyName('LineNo');
                            JSONTextWriter.WriteValue(purchaseline."Line No.");
                            JSONTextWriter.WriteEndObject;
                        end;

                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WritePropertyName('surrendered');
                JSONTextWriter.WriteValue(ObjImprestHeader.Surrendered);
                JSONTextWriter.WriteEndObject;
            until ObjImprestHeader.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;



    procedure fninsertbudgetinfo(budgetitem: Text; identifiedvendor: Text; documentno: Code[50]; noofdays: Decimal; noofpas: Decimal; ksh: Decimal; othercurrency: Decimal; missionexpensecategory: Code[50]; currencycode: Code[50])
    begin
        purchaseline.Init;
        //purchaseline."Line No.":=RANDOM(1000)+RANDOM(1000);
        PurchasesPayablesSetup.Get;
        Evaluate(purchaseline."Line No.", objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.", Today, true));
        purchaseline."Description 2" := budgetitem;
        purchaseline."Description 3" := identifiedvendor;
        purchaseline."Document No." := documentno;
        purchaseline."No of days" := noofdays;
        purchaseline."No of pax" := noofpas;
        purchaseline."Line Type" := purchaseline."line type"::"Budget Info";
        purchaseline.Ksh := ksh;
        purchaseline."other currency" := othercurrency;
        purchaseline."Currency Code" := currencycode;
        purchaseline.Validate("Currency Code");
        purchaseline.Validate(Ksh);
        purchaseline.Validate("other currency");
        purchaseline."Mission Expense Category" := missionexpensecategory;
        purchaseline.Insert;
    end;

    procedure fninsertteamroles(name: Text; responsibility: Text; documentno: Code[50])
    begin
        purchaseline.Init;
        //purchaseline."Line No.":=RANDOM(1000)+RANDOM(1000);
        PurchasesPayablesSetup.Get;
        Evaluate(purchaseline."Line No.", objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.", Today, true));
        purchaseline."Document No." := documentno;
        purchaseline."Description 2" := name;
        purchaseline."Description 3" := responsibility;
        purchaseline."Line Type" := purchaseline."line type"::"Team Roles";
        purchaseline.Insert;
    end;

    procedure fninsertmisssionobjectives(description: Text; documentno: Code[50])
    begin
        purchaseline.Init;
        //purchaseline."Line No.":=RANDOM(1000)+RANDOM(1000);
        PurchasesPayablesSetup.Get;
        Evaluate(purchaseline."Line No.", objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.", Today, true));
        purchaseline."Document No." := documentno;
        purchaseline."Description 2" := description;
        purchaseline."Line Type" := purchaseline."line type"::Objectives;
        purchaseline.Insert;
    end;

    procedure fninsertmissionactivities(date: Date; description: Text; documentno: Code[50]; descrition2: Text; description3: Text)
    var
        LINENO: Integer;
    begin
        purchaseline.Init;
        PurchasesPayablesSetup.Get;
        Evaluate(purchaseline."Line No.", objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.", Today, true));
        purchaseline."Document No." := documentno;
        purchaseline."Expected Receipt Date" := date;
        purchaseline.Description := description;
        purchaseline."Description 2" := descrition2;
        purchaseline."Description 3" := description3;
        purchaseline."Line Type" := purchaseline."line type"::Activity;
        purchaseline.Insert;
    end;

    procedure fnpurchaseLines(DocumentNo: Code[20]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestLine: Record "Purchase Line";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjImprestLine.Reset;
        ObjImprestLine.SetRange("Document No.", DocumentNo);
        //ObjImprestLine.SETRANGE("Line No.",LineNo);
        if ObjImprestLine.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;

                CreateJsonAttribute('DocumentNo', ObjImprestLine."Document No.");
                CreateJsonAttribute('Description2', ObjImprestLine."Description 2");
                CreateJsonAttribute('Description3', ObjImprestLine."Description 3");
                CreateJsonAttribute('LineType', ObjImprestLine."Line Type");
                CreateJsonAttribute('UOM', ObjImprestLine."Unit of Measure");
                // CreateJsonAttribute('ExpectedReceiptDate', ObjImprestLine."Expected Receipt Date");
                JSONTextWriter.WritePropertyName('ExpectedReceiptDate');
                JSONTextWriter.WriteValue(ObjImprestLine."Expected Receipt Date");
                // CreateJsonAttribute('NoOfDays', ObjImprestLine."No of days");
                JSONTextWriter.WritePropertyName('NoOfDays');
                JSONTextWriter.WriteValue(ObjImprestLine."No of days");
                // CreateJsonAttribute('NoOfPax', ObjImprestLine."No of pax");
                JSONTextWriter.WritePropertyName('NoOfPax');
                JSONTextWriter.WriteValue(ObjImprestLine."No of pax");
                //  CreateJsonAttribute('Ksh', ObjImprestLine.Ksh);
                JSONTextWriter.WritePropertyName('Ksh');
                JSONTextWriter.WriteValue(ObjImprestLine.Ksh);
                //CreateJsonAttribute('OtherCurrency', ObjImprestLine."other currency");
                JSONTextWriter.WritePropertyName('OtherCurrency');
                JSONTextWriter.WriteValue(ObjImprestLine."other currency");
                CreateJsonAttribute('ExpenseCategory', ObjImprestLine."Mission Expense Category");
                // CreateJsonAttribute('TotalKsh', ObjImprestLine."Total Ksh");
                JSONTextWriter.WritePropertyName('Totalksh');
                JSONTextWriter.WriteValue(ObjImprestLine."Total Ksh");
                // CreateJsonAttribute('TotalCurrency', ObjImprestLine."Total Other Currency");
                JSONTextWriter.WritePropertyName('TotalCurrency');
                JSONTextWriter.WriteValue(ObjImprestLine."Total Other Currency");
                CreateJsonAttribute('DocumentType', ObjImprestLine."Document Type");
                JSONTextWriter.WritePropertyName('AmountSpent');
                JSONTextWriter.WriteValue(ObjImprestLine."Amount Spent");
                JSONTextWriter.WritePropertyName('CashRefund');
                JSONTextWriter.WriteValue(ObjImprestLine."Cash Refund");
                // CreateJsonAttribute('LineNo', ObjImprestLine."Line No.");
                CreateJsonAttribute('details', ObjImprestLine."Description 3");
                CreateJsonAttribute('Vendor1', ObjImprestLine."Description 2");
                CreateJsonAttribute('Vendor2', ObjImprestLine."Description 4");
                CreateJsonAttribute('Vendor3', ObjImprestLine."Description 5");
                CreateJsonAttribute('Comments', ObjImprestLine."Description 6");
                CreateJsonAttribute('currencyCode', ObjImprestLine."Currency Code");
                if currencycodes.Get(ObjImprestLine."Currency Code") then
                    CreateJsonAttribute('currencyName', currencycodes.Description);
                JSONTextWriter.WritePropertyName('LineNo');
                JSONTextWriter.WriteValue(ObjImprestLine."Line No.");
                JSONTextWriter.WriteEndObject;
            until ObjImprestLine.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnInsertGeneralJournal(PostingDate: Date; DocumentNo: Code[50]; PayingBank: Code[50]; Amount: Decimal; Descirption: Text; empNo: Code[60])
    var
        usertemplate: Code[50];
        lineno: Integer;
    begin
        HREmployees.Reset;
        HREmployees.SetRange("No.", empNo);
        if HREmployees.Find('-') then begin
            UserSetup.Get(HREmployees."User ID");
            usertemplate := UserSetup."Payments Batch";
            //GenJournalLine2.
            lineno := GenJournalLine2.Count() + 2000;
            GenJournalLine.Init;
            GenJournalLine."Line No." := lineno;
            GenJournalLine."Journal Batch Name" := usertemplate;
            GenJournalLine."Journal Template Name" := 'PAYMENTS';
            GenJournalLine.Description := Descirption;
            GenJournalLine.Amount := Amount;
            GenJournalLine."Document No." := empNo + '_' + Format(PostingDate);
            GenJournalLine.Validate("Document No.");
            GenJournalLine.Validate("Journal Template Name");
            GenJournalLine."Posting Date" := PostingDate;
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
            GenJournalLine."Bal. Account No." := PayingBank;
            //GenJournalLine.VALIDATE("Bal. Account No.");
            //GenJournalLine.VALIDATE("Bal. Account Type");
            GenJournalLine.Validate(Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
        end;
    end;

    procedure fnJournalLines(empno: Code[20]; payingBank: Code[60]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestLine: Record "Purchase Line";
        templatename: Code[100];
    begin
        HREmployees.Reset();
        HREmployees.SetRange("No.", empno);
        if HREmployees.Find('-') then
            UserSetup.Reset;
        Message(HREmployees."User ID");
        //UserSetup.SETRANGE("User ID", HREmployees."User ID");
        UserSetup.Get(HREmployees."User ID");
        templatename := UserSetup."Payments Batch";
        Message(templatename);
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        GenJournalLine.Reset;
        GenJournalLine.SetFilter("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetFilter("Journal Batch Name", templatename);

        GenJournalLine.SetRange("Bal. Account No.", payingBank);
        if GenJournalLine.Find('-') then begin
            repeat
                JSONTextWriter.WriteStartObject;


                CreateJsonAttribute('description', GenJournalLine.Description);
                CreateJsonAttribute('lineno', Format(GenJournalLine."Line No."));
                CreateJsonAttribute('amount', GenJournalLine.Amount);

                JSONTextWriter.WriteEndObject;
            until GenJournalLine.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnUpdatebudgetinfo(budgetitem: Text; identifiedvendor: Text; documentno: Code[50]; noofdays: Decimal; noofpas: Decimal; ksh: Decimal; othercurrency: Decimal; missionexpensecategory: Code[50]; Documenttype: Code[60]; Lineno: Integer; linetype: Integer; date: Date; activity: Text; duration: Text; output: Text; name: Text; responsibility: Text; description: Text; currenccycode: Code[50])
    begin
        purchaseline."Line No." := Lineno;

        purchaseline."Document No." := documentno;
        purchaseline."No of days" := noofdays;
        purchaseline."No of pax" := noofpas;
        purchaseline."Line Type" := linetype;
        purchaseline.Ksh := ksh;
        purchaseline."other currency" := othercurrency;
        purchaseline.Validate(Ksh);
        purchaseline.Validate("other currency");
        purchaseline."Mission Expense Category" := missionexpensecategory;
        purchaseline."Currency Code" := currenccycode;
        purchaseline.Validate("Currency Code");
        if linetype = 4 then begin
            purchaseline."Description 2" := budgetitem;
            purchaseline."Description 3" := identifiedvendor;
        end;
        if linetype = 3 then begin
            purchaseline."Expected Receipt Date" := date;
            purchaseline."Description 3" := activity;
            purchaseline."Unit of Measure" := duration;
            purchaseline."Description 2" := output;
        end;
        if linetype = 2 then begin
            purchaseline."Description 2" := name;
            purchaseline."Description 3" := responsibility;
        end;

        if linetype = 1 then begin
            purchaseline."Description 2" := description;
        end;

        purchaseline.Modify;
    end;

    procedure fnUpdatePurchasenew(fundcode: Code[50]; programcode: Code[50]; purpose: Code[40]; daterequired: Date; departmentdimension: Code[50]; budgetdimesion: Code[50]; budgetdescription: Code[60]; missionno: Code[50]; reqne: Code[50]) reqNo: Code[60]
    begin
        purchaseheader.Init;
        GenLedgerSetup.Get();
        purchaseheader."No." := reqne;
        purchaseheader2.Get(purchaseheader2."document type"::Quote, reqne);
        //purchaseheader."No. Series":=GenLedgerSetup."Requisition Nos.";
        purchaseheader."Document Type" := purchaseheader."document type"::Quote;
        purchaseheader.DocApprovalType2 := purchaseheader.DocApprovalType2::Requisition;
        purchaseheader."Posting Description" := purpose;
        purchaseheader."Posting Date" := Today;
        purchaseheader."Mission Proposal No" := missionno;
        purchaseheader."Expected Receipt Date" := daterequired;
        //purchaseheader."Mission Proposal No":=missionno;
        purchaseheader."Shortcut Dimension 1 Code" := fundcode;
        purchaseheader."Shortcut Dimension 2 Code" := programcode;
        purchaseheader.PR := true;
        purchaseheader.Requisition := true;
        purchaseheader.Status := purchaseheader.Status::Open;
        purchaseheader."User ID" := UserId;
        purchaseheader."Shortcut Dimension 3 Code" := budgetdimesion;
        purchaseheader."Shortcut Dimension 5 Code" := departmentdimension;
        purchaseheader."Shortcut Dimension 4 Code" := budgetdescription;
        purchaseheader."Employee No" := purchaseheader2."Employee No";
        purchaseheader.Validate("Employee No");
        purchaseheader.Modify;

        reqNo := reqne;
    end;

    procedure fngetLeaveBalanceType(empNo: Code[50]; leavetype: Code[50]) balance: Code[40]
    begin
        HREmployees.Reset;
        HREmployees.SetRange("No.", empNo);
        if HREmployees.Find('-') then begin
            HREmployees.CalcFields("Maternity Leave Acc.", "Paternity Leave Acc.", "Annual Leave Account", "Compassionate Leave Acc.", "Sick Leave Acc.", "Study Leave Acc", "CTO  Leave Acc.");
            if leavetype = 'COMPASSIONATE' then
                balance := Format(HREmployees."Compassionate Leave Acc.");
            if leavetype = 'EXAM' then
                balance := Format(HREmployees."Study Leave Acc");
            if leavetype = 'MATERNITY' then
                balance := Format(HREmployees."Maternity Leave Acc.");
            if leavetype = 'PATERNITY' then
                balance := Format(HREmployees."Paternity Leave Acc.");
            if leavetype = 'ANNUAL' then
                balance := Format(HREmployees."Annual Leave Account");
            if leavetype = 'SICK' then
                balance := Format(HREmployees."Sick Leave Acc.");
            if leavetype = 'CTO' then
                balance := Format(HREmployees."CTO  Leave Acc.");
        end;
    end;

    procedure fnInsertTrainingRequest(need: Text; empployees: Text; link: Text; purpose: Text; outcome: Text; details: Text; otherdetails: Text; empno: Code[60])
    begin
        TrainingRequests.Init;
        hrsetup.Get();
        TrainingRequests."Application Code" := objNumSeries.GetNextNo(hrsetup."Training Application Nos.", 0D, true);
        TrainingRequests.Validate("Application Code");
        TrainingRequests."No series" := hrsetup."Training Application Nos.";
        TrainingRequests."Employee Code" := empno;
        TrainingRequests.Validate("Employee Code");
        TrainingRequests."Training Need" := need;
        TrainingRequests."Employees Involved" := empployees;
        TrainingRequests."Business Linkage" := link;
        TrainingRequests."Job Relation" := purpose;
        TrainingRequests."Hope to Learn" := outcome;
        TrainingRequests."Details of Training" := details;
        TrainingRequests."Other Details" := otherdetails;
        TrainingRequests.Insert(true);
    end;

    procedure FnTrainingList(empno: Code[60]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        TrainingRequests.Reset;
        TrainingRequests.SetRange("Employee Code", empno);
        //ObjImprestLine.SETRANGE("Line No.",LineNo);
        if TrainingRequests.Find('-') then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('ApplicationNo', TrainingRequests."Application Code");
                CreateJsonAttribute('need', TrainingRequests."Training Need");
                CreateJsonAttribute('employees', TrainingRequests."Employees Involved");
                CreateJsonAttribute('link', TrainingRequests."Business Linkage");
                CreateJsonAttribute('purpose', TrainingRequests."Job Relation");
                CreateJsonAttribute('outcome', TrainingRequests."Hope to Learn");
                CreateJsonAttribute('details', TrainingRequests."Details of Training");
                CreateJsonAttribute('otherdetails', TrainingRequests."Other Details");
                CreateJsonAttribute('status', TrainingRequests.Status);
                JSONTextWriter.WriteEndObject;
            until TrainingRequests.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnUpdateTrainingRequest(need: Text; empployees: Text; link: Text; purpose: Text; outcome: Text; details: Text; otherdetails: Text; empno: Code[60]; ApplicationNo: Code[60])
    begin
        TrainingRequests.Init;
        hrsetup.Get();
        TrainingRequests.Reset;
        TrainingRequests.SetRange("Application Code", ApplicationNo);
        if TrainingRequests.Find('-') then begin
            TrainingRequests."Application Code" := objNumSeries.GetNextNo(hrsetup."Training Application Nos.", 0D, true);
            TrainingRequests.Validate("Application Code");
            TrainingRequests."No series" := hrsetup."Training Application Nos.";
            TrainingRequests."Employee Code" := empno;
            TrainingRequests.Validate("Employee Code");
            TrainingRequests."Training Need" := need;
            TrainingRequests."Employees Involved" := empployees;
            TrainingRequests."Business Linkage" := link;
            TrainingRequests."Job Relation" := purpose;
            TrainingRequests."Hope to Learn" := outcome;
            TrainingRequests."Details of Training" := details;
            TrainingRequests."Other Details" := otherdetails;
            TrainingRequests.Modify;
        end;
    end;

    procedure fnReqTrainingApproval(no: Code[50])
    var
        variancerec: Variant;
    begin
        TrainingRequests.Reset;
        TrainingRequests.SetRange("Application Code", no);
        if TrainingRequests.Find('-') then begin
            variancerec := TrainingRequests;

            ApprovalsMgt1.CheckApprovalsWorkflowEnabled(variancerec);
            ApprovalsMgt1.OnSendDocForApproval(variancerec);
        end;
    end;

    procedure fnInsertPortalAttachments(DocumentNo: Code[100]; Description: Text; Url: Text; Type: Text) uploaded: Boolean
    var
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Ostream: OutStream;
        counter: Integer;
    begin
        IF CompanyInformation.GET THEN
            PortalUploads.INIT;
        PortalUploads."Document No" := DocumentNo;
        PortalUploads.Description := Description;
        PortalUploads.LocalUrl := Url;
        PortalUploads.Uploaded := TRUE;
        PortalUploads.Fetch_To_Sharepoint := TRUE;
        PortalUploads.Base_URL := CompanyInformation."Sharepoint Path" + '/' + Type + '/';
        IF PortalUploads.INSERT(TRUE) THEN BEGIN
            uploaded := TRUE;
            EXIT(uploaded);
        END;
        EXIT(uploaded);
    end;




    procedure fnUploadedDocuments(documentNo: Code[60]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        PortalUploads.Reset;
        PortalUploads.SetRange(PortalUploads."Document No", documentNo);
        if PortalUploads.Find('-') then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('AttachmentNo', PortalUploads."Entry No");
                CreateJsonAttribute('DocumentDescription', PortalUploads.Description);
                CreateJsonAttribute('Url', PortalUploads.SP_URL_Returned);
                CreateJsonAttribute('DocumentNo', PortalUploads."Document No");
                JSONTextWriter.WriteEndObject;
            until PortalUploads.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnSurrenderLineUpdate(lineno: Integer; amountsepnt: Decimal; document: Code[50]; cashrefund: Decimal)
    begin
        //purchaseline.INIT;

        purchaseline.Reset;
        purchaseline.SetRange("Document No.", document);
        purchaseline.SetRange("Line No.", lineno);
        if purchaseline.Find('-') then begin

            //purchaseline."Line No.":=lineno;
            purchaseline."Amount Spent" := amountsepnt;
            purchaseline."Cash Refund" := cashrefund;
            //purchaseline."Document No.":=document;
            purchaseline.Validate("Amount Spent");
            purchaseline.Modify;
        end;
    end;

    procedure fnTrainingSchedule() returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        Trainingscehdule.Reset;
        if Trainingscehdule.Find('-') then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('topic', Trainingscehdule.Topic);
                CreateJsonAttribute('Year', Trainingscehdule.Year);
                CreateJsonAttribute('Facilitator', Trainingscehdule.Facilitator);
                CreateJsonAttribute('ScheduledDate', Trainingscehdule."Scheduled date");
                CreateJsonAttribute('Employees', Trainingscehdule."No. of Staff trained");
                CreateJsonAttribute('Evidence', Trainingscehdule."Evidence of training");

                CreateJsonAttribute('status', Trainingscehdule.Status);
                JSONTextWriter.WriteEndObject;
            until Trainingscehdule.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fininserttrainingschedule(year: Text; facilitator: Text; scheduleDate: Date; Employees: Text; evidence: Text; department: Text; topic: Text)
    begin
        Trainingscehdule.Init;
        Trainingscehdule.Year := year;
        Trainingscehdule.Facilitator := facilitator;
        Trainingscehdule."Scheduled date" := scheduleDate;
        Trainingscehdule.Validate("Scheduled date");
        Trainingscehdule."No. of Staff trained" := Employees;
        Trainingscehdule."Evidence of training" := evidence;
        Trainingscehdule."Department/Organization" := department;
        Trainingscehdule.Topic := topic;
        Trainingscehdule.Status := Trainingscehdule.Status::Pending;
        Trainingscehdule.Insert;
    end;

    procedure fnDeletePurchaseLine(lineno: Integer; documentNo: Code[20])
    begin
        purchaseline.Get(purchaseline."document type"::Quote, documentNo, lineno);
        purchaseline.Delete;
    end;

    procedure fnimprestlinemodify(expensecategory: Code[50]; description: Text; unitcost: Decimal; currency: Code[10]; amount: Decimal; documentno: Code[50]; lienno: Integer)
    begin
        purchaseline.Init;
        purchaseline."Document No." := documentno;
        purchaseline."Line No." := lienno;
        purchaseline."Document Type" := purchaseline."document type"::Quote;
        purchaseline."Expense Category" := expensecategory;
        purchaseline.Validate("Expense Category");
        purchaseline."Direct Unit Cost" := unitcost;
        purchaseline."Currency Code" := currency;

        purchaseline.Quantity := amount;
        purchaseline.Validate("Direct Unit Cost");
        purchaseline.Validate("Currency Code");
        purchaseline.Modify;
    end;

    procedure fninsertimprestModify(fundcode: Code[50]; programcode: Code[50]; purpose: Code[40]; departmentdimension: Code[50]; budgetdimesion: Code[50]; budgetdescription: Code[60]; empno: Code[60]; missionproporsal: Code[40]; purchaserequestNo: Code[50]; document: Code[50])
    begin
        purchaseheader.Init;
        GenLedgerSetup.Get();
        purchaseheader."No." := document;
        purchaseheader."No. Series" := GenLedgerSetup."Imprest Nos.";
        purchaseheader."Document Type" := purchaseheader."document type"::Quote;
        //purchaseheader.DocApprovalType2:=purchaseheader.DocApprovalType2::;
        purchaseheader."Posting Description" := purpose;
        purchaseheader."Posting Date" := Today;
        objHREmployees.Reset();
        objHREmployees.SetRange("No.", empno);
        if objHREmployees.Find('-') then begin
            //  ObjImprestRequisition.Cashier:=objHREmployees."User ID";
            if UserSetup.Get(objHREmployees."User ID") then begin
                UserSetup.TestField(UserSetup.ImprestAccount);
                // purchaseheader ."Account Type":=ObjImprestRequisition."Account Type"::Customer;
                purchaseheader."Account No" := UserSetup.ImprestAccount;
                purchaseheader.Validate("Account No");
            end; //ELSE
                 // ERROR('User must be setup under User Setup and their respective Account Entered');
        end;

        //purchaseheader."Requested Receipt Date":=daterequried;
        //purchaseheader."Mission Proposal No":=missionno;
        purchaseheader."Shortcut Dimension 1 Code" := fundcode;
        purchaseheader."Shortcut Dimension 2 Code" := programcode;
        purchaseheader.IM := true;
        purchaseheader."Requisition No" := purchaserequestNo;
        purchaseheader.Status := purchaseheader.Status::Open;
        purchaseheader."User ID" := UserId;
        purchaseheader."Shortcut Dimension 3 Code" := budgetdimesion;
        purchaseheader."Shortcut Dimension 4 Code" := departmentdimension;
        purchaseheader."Shortcut Dimension 5 Code" := budgetdescription;
        purchaseheader."Mission Proposal No" := missionproporsal;
        purchaseheader.Modify;

        //impno:=purchaseheader."No.";
    end;

    procedure fnPurchaselineModify(expensecategory: Code[50]; description: Text; unitcost: Decimal; currency: Code[20]; amount: Decimal; documentno: Code[50]; lineno: Integer)
    begin
        //purchaseline.INIT;
        purchaseline.Get(purchaseline."document type"::Quote, documentno, lineno);
        //purchaseline."Line No.":=lineno;
        //purchaseline."Document No.":=documentno;
        //purchaseline."Document Type":=purchaseline."Document Type"::Quote;
        purchaseline."Expense Category" := expensecategory;
        purchaseline.Validate("Expense Category");
        purchaseline."Direct Unit Cost" := unitcost;

        //purchaseline."Unit Cost":=unitcost;
        purchaseline."Currency Code" := currency;

        purchaseline.Quantity := amount;
        purchaseline.Validate("Currency Code");
        purchaseline.Validate("Direct Unit Cost");
        purchaseline."Description 2" := description;
        purchaseline.Modify;
    end;

    procedure fninsertBudgetNotes(details: Text; vendor1: Text; vendor2: Text; vendor3: Text; comments: Text; document: Code[60])
    begin
        purchaseline.Init;
        //purchaseline."Line No.":=RANDOM(1000)+RANDOM(1000);
        PurchasesPayablesSetup.Get;
        Evaluate(purchaseline."Line No.", objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.", Today, true));
        purchaseline."Description 2" := vendor1;
        purchaseline."Description 3" := details;
        purchaseline."Description 4" := vendor2;
        purchaseline."Description 5" := vendor3;
        purchaseline."Description 6" := comments;
        purchaseline."Document No." := document;
        purchaseline."Line Type" := purchaseline."line type"::"Budget Notes";
        purchaseline.Insert;
    end;

    procedure fnUdpateBudgetNotes(details: Text; vendor1: Text; vendor2: Text; vendor3: Text; comments: Text; document: Code[60]; lineno: Integer)
    begin
        //purchaseline.INIT;
        purchaseline."Line No." := lineno;
        purchaseline."Description 2" := vendor1;
        purchaseline."Description 3" := details;
        purchaseline."Description 4" := vendor2;
        purchaseline."Description 5" := vendor3;
        purchaseline."Description 6" := comments;
        purchaseline."Document No." := document;
        purchaseline."Line Type" := purchaseline."line type"::"Budget Notes";
        purchaseline.Modify;
    end;

    procedure fnGetcurrencyCodes() returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        currencycodes.Reset;
        if currencycodes.Find('-') then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('code', currencycodes.Code);
                CreateJsonAttribute('name', currencycodes.Description);

                JSONTextWriter.WriteEndObject;
            until currencycodes.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure FnGetTravelNo(Account: Code[30]) returnout: Text
    var
        JsonOut: dotnet String;
        PurchaseHeader: Record "Purchase Header";
        HrEmployees: Record "HR Employees";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        HrEmployees.reset;
        HrEmployees.SetRange("No.", Account);
        if HrEmployees.FindFirst() then begin
            PurchaseHeader.Reset;
            PurchaseHeader.SetRange("Account No", HrEmployees.Travelaccountno);
            if PurchaseHeader.Find('-') then
                repeat
                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('code', PurchaseHeader."No.");
                    CreateJsonAttribute('name', PurchaseHeader."Buy-from Vendor Name");

                    JSONTextWriter.WriteEndObject;
                until PurchaseHeader.Next = 0;

            JSONTextWriter.WriteEndArray;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
        end;

    end;

    procedure fnGetAttachment(attachment: Integer; var PictureText: BigText) fileextension: Text
    var
        PictureInStream: InStream;
        PictureOutStream: OutStream;
        TempBlob: Record TempBlob2;
    begin
        attachments.Reset;
        attachments.SetRange("No.", attachment);
        if attachments.Find('-') then begin
            attachments.CalcFields("Attachment File");
            if attachments."Attachment File".Hasvalue then begin
                //  PictureText.ADDTEXT(HREmployees
                Clear(PictureText);
                Clear(PictureInStream);
                HREmployees.Picture.CreateInstream(PictureInStream);
                TempBlob.DeleteAll;
                TempBlob.Init;
                TempBlob.Blob.CreateOutstream(PictureOutStream);
                CopyStream(PictureOutStream, PictureInStream);
                TempBlob.Insert;
                TempBlob.CalcFields(Blob);
                PictureText.AddText(TempBlob.ToBase64String);
            end;
        end;
    end;

    procedure fnDeleteAttachment(attachment: Integer)
    begin
        PortalUploads.Reset;
        PortalUploads.SetRange(PortalUploads."Entry No", attachment);
        if PortalUploads.Find('-') then begin
            PortalUploads.Delete;
        end;
    end;

    procedure UpdateLinks(EntryNo: Integer; Link: Text; Reason: Text)
    begin
        IF PortalUploads.GET(EntryNo) THEN
            PortalUploads.SP_URL_Returned := Link;
        PortalUploads.Polled := TRUE;
        PortalUploads.Failure_reason := Reason;
        PortalUploads.MODIFY;
    end;

    local procedure fnGetNoticeBoard() returnout: Text
    var
        JsonOut: dotnet String;
        JSONTextWriter1: dotnet JsonTextWriter;
        StringWriter1: dotnet StringWriter;
        StringBuilder1: dotnet StringBuilder;
    begin
        StringBuilder1 := StringBuilder1.StringBuilder;
        StringWriter1 := StringWriter1.StringWriter(StringBuilder1);
        JSONTextWriter1 := JSONTextWriter1.JsonTextWriter(StringWriter1);
        JSONTextWriter1.WriteStartArray;
        notice.Reset;

        if notice.Find('-') then
            repeat
                JSONTextWriter1.WriteStartObject;
                JSONTextWriter1.WritePropertyName('text');
                JSONTextWriter1.WriteValue(Format(notice.Announcement));
                JSONTextWriter1.WritePropertyName('date');
                JSONTextWriter1.WriteValue(Format(notice."Date of Announcement"));
                JSONTextWriter1.WritePropertyName('by');
                JSONTextWriter1.WriteValue(Format(notice."Department Announcing"));
                JSONTextWriter1.WriteEndObject;
            until notice.Next = 0;

        JSONTextWriter1.WriteEndArray;
        JsonOut := StringBuilder1.ToString;
        returnout := JsonOut;
    end;

    local procedure fnAppreciation(var PictureText: BigText)
    var
        PictureInStream: InStream;
        PictureOutStream: OutStream;
        TempBlob: Record TempBlob2;
    begin

        if hrsetup.Get() then begin
            hrsetup.CalcFields("Employee Picture");
            if hrsetup."Employee Picture".Hasvalue then begin
                //  PictureText.ADDTEXT(HREmployees
                Clear(PictureText);
                Clear(PictureInStream);
                hrsetup."Employee Picture".CreateInstream(PictureInStream);
                TempBlob.DeleteAll;
                TempBlob.Init;
                TempBlob.Blob.CreateOutstream(PictureOutStream);
                CopyStream(PictureOutStream, PictureInStream);
                TempBlob.Insert;
                TempBlob.CalcFields(Blob);
                PictureText.AddText(TempBlob.ToBase64String);
            end;
        end;
    end;

    procedure FnGetDateOfJoin(EmployeeNo: Code[100]) Year: Date
    var
    begin
        objHREmployees.Reset();
        objHREmployees.SetRange("No.", EmployeeNo);
        if objHREmployees.Find('-') then begin
            Year := objHREmployees."Date Of Join";
            EXIT(Year);
        END;

    end;

    procedure FnGetP9Report(EmployeeNo: Code[40]; SelectedYear: Integer; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        P9Report: Report 80034;
        Base64Convert: Codeunit "Base64 Convert";
        PayrollEmployee: Record "Payroll Employee P9_AU";
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        objHREmployees.Reset;
        objHREmployees.SetRange("No.", EmployeeNo);
        if objHREmployees.Find('-') then begin
            PayrollEmployee.Reset();
            PayrollEmployee.SetFilter("Period Year", '%1', SelectedYear);
            if PayrollEmployee.Find('-') then begin
                P9Report.SetTableView(PayrollEmployee);
                P9Report.SetTableView(objHREmployees);
                TempBlob.CreateOutStream(StatementOutstream);
                if P9Report.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                    TempBlob.CreateInStream(StatementInstream);
                    Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
                end;
            end

        end;
    end;

    procedure GenerateLeaveStatement(EmployeeNo: Code[40]; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        LeaveStatement: Report 80029;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        objHREmployees.Reset;
        objHREmployees.SetRange("No.", EmployeeNo);
        if objHREmployees.Find('-') then begin
            LeaveStatement.SetTableView(objHREmployees);
            TempBlob.CreateOutStream(StatementOutstream);
            if LeaveStatement.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;
    end;

    procedure GenerateEmploreeReq(No: Code[40]; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        EmployeeReqReport: Report 80040;
        Base64Convert: Codeunit "Base64 Convert";
        HrEmployeeRequisition: Record "HR Employee Requisitions";
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        HrEmployeeRequisition.Reset;
        HrEmployeeRequisition.SetRange(HrEmployeeRequisition."Requisition No.", No);
        if HrEmployeeRequisition.Find('-') then begin
            EmployeeReqReport.SetTableView(HrEmployeeRequisition);
            TempBlob.CreateOutStream(StatementOutstream);
            if EmployeeReqReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;
    end;

    procedure GenerateJobSummary(No: Code[40]; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        JobReport: Report 50109;
        Base64Convert: Codeunit "Base64 Convert";
        JobApplication: Record "HR Job Applications";
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        JobApplication.Reset;
        JobApplication.SetRange(JobApplication."Application No", No);
        if JobApplication.Find('-') then begin
            JobReport.SetTableView(JobApplication);
            TempBlob.CreateOutStream(StatementOutstream);
            if JobReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;
    end;

    procedure FnEditImprestSurRequisitionLines(No: Code[50]; AmountSpent: Decimal; LineNo: Integer) returnout: Text
    var
        JsonOut: dotnet String;
        purchaseHeader: Record "Purchase Header";
        purchaseLine: Record "Purchase Line";
        ObjHREmployee: Record "HR Employees";
        ObjUserSetup: Record "User Setup";
        DonorBudgetMatrix: Record "G/L Budget Entry";
        Customer: Record Customer;
        StandardText: Record "Standard Text";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        purchaseHeader.Reset();
        purchaseHeader.SetRange("No.", No);
        if purchaseHeader.FindFirst() then begin
            purchaseLine.Reset();
            purchaseLine.SetRange(purchaseLine."Document No.", No);
            purchaseLine.SetRange(purchaseLine."Line No.", LineNo);
            purchaseLine.SetRange("Document Type", purchaseLine."Document Type"::Quote);
            if purchaseLine.Find('-') then begin
                StandardText.Reset();
                StandardText.SetRange(StandardText.Code, purchaseLine."Expense Category");
                if StandardText.FindFirst() then begin
                    Customer.Get(purchaseHeader."Account No");
                    purchaseLine."Line No." := LineNo;
                    purchaseLine.Type := purchaseLine.Type::"G/L Account";
                    purchaseLine."No." := StandardText."G/L Account";
                    purchaseLine.Description := StandardText.Description;
                    purchaseLine."Shortcut Dimension 1 Code" := purchaseHeader."Shortcut Dimension 1 Code";
                    purchaseLine."Shortcut Dimension 2 Code" := purchaseHeader."Shortcut Dimension 2 Code";
                    purchaseLine."ShortcutDimCode[3]" := purchaseHeader."Shortcut Dimension 3 Code";

                    purchaseLine."Document No." := No;
                    purchaseLine."Document Type" := purchaseLine."Document Type"::Quote;
                    //purchaseLine."Description 2" := Description2;
                    purchaseLine."Imprest Account No" := purchaseHeader."Account No";
                    purchaseLine."Imprest Account Name" := Customer.Name;
                    purchaseLine."Amount Spent" := AmountSpent;
                    //purchaseLine.Rate := Rate;
                    //purchaseLine."Direct Unit Cost" := Amount;
                    //purchaseLine.Quantity := Quantity;
                    //purchaseLine."Amount In Foreign" := Amount;
                    //purchaseLine.Amount := Quantity * Rate * Amount;
                    //purchaseLine.Validate(Amount);
                    //purchaseLine."Amount Including VAT" := Quantity * Rate * Amount;
                    //purchaseLine.Validate("Amount Including VAT");
                    purchaseLine."Currency Code" := purchaseHeader."Currency Code";
                    purchaseLine."Currency Factor" := purchaseHeader."Currency Factor";

                    if purchaseLine.Modify(true) then begin

                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('No', purchaseHeader."No.");
                        JSONTextWriter.WriteEndObject;
                    end;
                    JsonOut := StringBuilder.ToString;
                    returnout := JsonOut;
                end;
            end;
        end;
    end;

    procedure fnGetApprovalEntries(DocumentNo: Code[40]) returnout: Text
    var
        JsonOut: dotnet String;
        approvalComments: Record "Approval Comment Line";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        approvalentries.Reset;
        approvalentries.SetRange("Document No.", DocumentNo);
        approvalentries.SetCurrentkey("Entry No.");
        approvalentries.Ascending(true);
        if approvalentries.Find('-') then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('approverid', approvalentries."Approver ID");
                CreateJsonAttribute('status', approvalentries.Status);
                CreateJsonAttribute('lastmodified', approvalentries."Last Date-Time Modified");
                approvalComments.reset;
                approvalComments.SetRange("Record ID to Approve", approvalentries."Record ID to Approve");
                approvalComments.SetCurrentKey("Entry No.");
                approvalComments.Ascending(true);
                if approvalComments.findlast then
                    CreateJsonAttribute('comments', approvalComments.comment)
                else
                    CreateJsonAttribute('comments', '');
                JSONTextWriter.WriteEndObject;
            until approvalentries.Next = 0;


        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnUploadedDocuments2(documentNo: Code[60]) returnout: Text
    var
        JsonOut: dotnet String;
        PictureInStream: InStream;
        PictureOutStream: OutStream;
        TempBlob: Record TempBlob2;
        PictureText: BigText;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        documents.Reset;
        documents.SetRange("Doc No.", documentNo);
        documents.SetRange(Attachment, documents.Attachment::Yes);
        if documents.Find('-') then begin
            repeat

                attachments.Reset;
                //  attachments.SETRANGE("No.", documents."Attachment No.");
                if attachments.Get(documents."Attachment No.") then begin

                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('AttachmentNo', documents."Attachment No.");
                    CreateJsonAttribute('DocumentDescription', documents."Document Description");
                    CreateJsonAttribute('DocumentNo', documents."Doc No.");
                    CreateJsonAttribute('ext', attachments."File Extension");
                    Clear(PictureText);
                    Clear(PictureInStream);
                    attachments."Attachment File".CreateInstream(PictureInStream);
                    TempBlob.DeleteAll;
                    TempBlob.Init;
                    TempBlob.Blob.CreateOutstream(PictureOutStream);
                    CopyStream(PictureOutStream, PictureInStream);
                    TempBlob.Insert;
                    TempBlob.CalcFields(Blob);
                    PictureText.AddText(TempBlob.ToBase64String);
                    JSONTextWriter.WritePropertyName('attachment');
                    JSONTextWriter.WriteValue(PictureText);
                    JSONTextWriter.WriteEndObject;
                end;
            until documents.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnhrdocuments() returnout: Text
    var
        JsonOut: dotnet String;
        PictureInStream: InStream;
        PictureOutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        PictureText: BigText;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        hrdocuments.Reset;
        if hrdocuments.Find('-') then begin
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('code', hrdocuments.Code);
                CreateJsonAttribute('name', hrdocuments.Description);
                JSONTextWriter.WriteEndObject;

            until hrdocuments.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnGetdocuments(attachmentno: Integer; var PictureText: BigText) fieext: Text
    var
        PictureInStream: InStream;
        PictureOutStream: OutStream;
        TempBlob: Record TempBlob2;
    begin
        attachments.Reset;
        attachments.SetRange("No.", attachmentno);
        if attachments.Find('-') then begin
            attachments.CalcFields("Attachment File");
            fieext := attachments."File Extension";
            if attachments."Attachment File".Hasvalue then begin
                //  PictureText.ADDTEXT(HREmployees
                Clear(PictureText);
                Clear(PictureInStream);
                attachments."Attachment File".CreateInstream(PictureInStream);
                TempBlob.DeleteAll;
                TempBlob.Init;
                TempBlob.Blob.CreateOutstream(PictureOutStream);
                CopyStream(PictureOutStream, PictureInStream);
                TempBlob.Insert;
                TempBlob.CalcFields(Blob);
                PictureText.AddText(TempBlob.ToBase64String);
            end;
        end;
    end;

    procedure fnsuggestionbox(suggestion: Text; anonymous: Boolean; empno: Code[50])
    var
        receivingmail: Text;
        senderaddress: Text;
        senderemail: Text;
        senderpassword: Text;
        EmailMessage: Codeunit "Email Message";
        emailsend: Codeunit Email;
        body: text;
        Body2: Text;
    begin
        objHRSetup.Get();
        // smtpsetup.Get;
        receivingmail := objHRSetup."Feedback Email";
        // senderaddress := smtpsetup."Send As";
        // senderemail := smtpsetup."User ID";
        body := '<h3>This is a confidential email</h3>' + '<p> ' + suggestion + ' </p> </br> </br> </br>  </hr>' + 'From, Anonymous';
        HREmployees.Reset();
        HREmployees.SetRange("No.", empno);
        if HREmployees.Find('-') then
            if anonymous = true then begin

                EmailMessage.Create(receivingmail, 'Employee feedback', body, true);
                emailsend.Send(EmailMessage, Enum::"Email Scenario"::Default);
                // smtp.AppendBody('<h3>This is a confidential email</h3>');
                // smtp.AppendBody('<p> ' + suggestion + ' </p> </br> </br> </br>  </hr>');

                // smtp.AppendBody('From, Anonymous');

                // smtp.Send;
            end;


        if anonymous = false then begin
            Body2 := '<h3>This is a confidential email</h3>' + '<p> ' + suggestion + ' </p> </br> </br> </br>  </hr>' + 'From, ' + HREmployees."First Name" + ' ' + HREmployees."Last Name" + 'Employee No, ' + HREmployees."No." + 'Email, ' + HREmployees."E-Mail";
            EmailMessage.Create(receivingmail, 'Employee feedback', Body2, true);
            // smtp.AppendBody('<h3>This is a confidential email</h3>');
            // smtp.AppendBody('<p> ' + suggestion + ' </p> </br> </br> </br>  </hr>');


            // smtp.AppendBody('From, ' + HREmployees."First Name" + ' ' + HREmployees."Last Name");
            // smtp.AppendBody('Employee No, ' + HREmployees."No.");
            // smtp.AppendBody('Email, ' + HREmployees."E-Mail");

            emailsend.Send(EmailMessage, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure fnAppraisals(empno: Code[60]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        purchaseheader.Reset;
        purchaseheader.SetRange(APP, true);
        purchaseheader.SetRange("Employee No", empno);
        if purchaseheader.Find('-') then begin
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('apprasalcode', purchaseheader."Appraisal Code");
                CreateJsonAttribute('background', purchaseheader.Background);
                CreateJsonAttribute('emno', purchaseheader."Employee No");
                CreateJsonAttribute('status', Format(purchaseheader.Status));
                CreateJsonAttribute('no', purchaseheader."No.");
                JSONTextWriter.WriteEndObject;

            until purchaseheader.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnNewappraisal(empno: Code[30]; background: Text) appno: Code[60]
    begin
        purchaseheader.Init;
        hrsetup.Get;
        purchaseheader."No." := NoSeriesManagement.GetNextNo(hrsetup."Appraisal Nos.", Today, true);
        purchaseheader.Background := background;
        purchaseheader."Employee No" := empno;
        purchaseheader.Validate("Employee No");
        purchaseheader.Insert;


        purchaseheader.Validate("Employee No");
        purchaseheader.APP := true;
        purchaseheader.Modify;

        appno := purchaseheader."No.";


        purchaseline.Init;
        purchaseline."Document No." := appno;
        purchaseline.Insert;
    end;

    procedure fnEditappraisal(appraisalno: Code[50]; background: Text)
    begin
        if purchaseheader.Get(purchaseheader."document type"::Quote, appraisalno) then begin

            //purchaseheader."No.":=appraisalno;
            purchaseheader.Background := background;
            purchaseheader.APP := true;
            purchaseheader.Modify;
        end;
    end;

    procedure fngrievances(suggestion: Text; anonymous: Boolean; empno: Code[50])
    var
        receivingmail: Text;
        senderaddress: Text;
        senderemail: Text;
        senderpassword: Text;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Body: text;
        body2: text;
    begin
        objHRSetup.Get();

        receivingmail := objHRSetup.Email;

        Body := '<h3>This is a confidential email</h3>' + '<p> ' + suggestion + ' </p> </br> </br> </br>  </hr>' + 'From, Anonymous';
        HREmployees.Reset();
        HREmployees.SetRange("No.", empno);
        if HREmployees.Find('-') then
            if anonymous = true then begin

                EmailMessage.Create(receivingmail, 'Grievance', Body, true);
                // smtp.AppendBody('<h3>This is a confidential email</h3>');
                // smtp.AppendBody('<p> ' + suggestion + ' </p> </br> </br> </br>  </hr>');

                // smtp.AppendBody('From, Anonymous');

                Email.Send(EmailMessage);
            end;


        if anonymous = false then begin
            body2 := '<h3>This is a confidential email</h3>' + '<p> ' + suggestion + ' </p> </br> </br> </br>  </hr>' + 'From, ' + HREmployees."First Name" + ' ' + HREmployees."Last Name" + 'Employee No, ' + HREmployees."No." + 'Email, ' + HREmployees."E-Mail";
            EmailMessage.Create(receivingmail, 'Grievance', body2, true);
            // smtp.AppendBody('<h3>This is a confidential email</h3>');
            // smtp.AppendBody('<p> ' + suggestion + ' </p> </br> </br> </br>  </hr>');


            // smtp.AppendBody('From, ' + HREmployees."First Name" + ' ' + HREmployees."Last Name");
            // smtp.AppendBody('Employee No, ' + HREmployees."No.");
            // smtp.AppendBody('Email, ' + HREmployees."E-Mail");

            // smtp.Send;
        end;
    end;

    procedure fnExitInterview(empNo: Code[60]; Designation: Text; "main reason(s) for your exit": Text; "overall impression": Text; "clear objectives": Text; "your performance reviewed": Text; "received enough recognition": Text; "career aspirations": Text; "relationship with your": Text; "with your immediate team": Text; "perception on TI-Kenya’s": Text; "most fulfilling": Text; "greatest accomplishments": Text; "most frustrating": Text; "better place": Text; "TI-Kenya in the future": Text; "constructive feedback": Text; "next step": Text; "Intervire Conducted By": Text)
    var
        exitInterview: Record "Exit Interviews";
    begin
        exitInterview.Reset;
        exitInterview.SetRange("Employee No", empNo);
        if not exitInterview.Find('-') then begin
            exitInterview."Employee No" := empNo;
            exitInterview.Validate("Employee No");
            exitInterview.Insert;
            exitInterview.Designation := Designation;
            exitInterview."main reason(s) for your exit" := "main reason(s) for your exit";
            exitInterview."overall impression" := "overall impression";
            exitInterview."clear objectives" := "clear objectives";
            exitInterview."your performance reviewed" := "your performance reviewed";
            exitInterview."received enough recognition" := "received enough recognition";
            exitInterview."career aspirations" := "career aspirations";
            exitInterview."relationship with your" := "relationship with your";
            exitInterview."with your immediate team" := "with your immediate team";
            exitInterview."greatest accomplishments" := "greatest accomplishments";
            exitInterview."perception on TI-Kenya’s" := "perception on TI-Kenya’s";
            exitInterview."most fulfilling" := "most fulfilling";
            exitInterview."most frustrating" := "most frustrating";
            exitInterview."better place" := "better place";
            exitInterview."TI-Kenya in the future" := "TI-Kenya in the future";
            exitInterview."next step" := "next step";
            exitInterview."constructive feedback" := "constructive feedback";
            exitInterview."Intervire Conducted By" := "Intervire Conducted By";
            exitInterview."Interview Date" := Today;
            exitInterview.Modify;
        end else begin
            exitInterview.Get(empNo);
            exitInterview.Designation := Designation;
            exitInterview."main reason(s) for your exit" := "main reason(s) for your exit";
            exitInterview."overall impression" := "overall impression";
            exitInterview."clear objectives" := "clear objectives";
            exitInterview."your performance reviewed" := "your performance reviewed";
            exitInterview."received enough recognition" := "received enough recognition";
            exitInterview."career aspirations" := "career aspirations";
            exitInterview."relationship with your" := "relationship with your";
            exitInterview."with your immediate team" := "with your immediate team";
            exitInterview."greatest accomplishments" := "greatest accomplishments";
            exitInterview."perception on TI-Kenya’s" := "perception on TI-Kenya’s";
            exitInterview."most fulfilling" := "most fulfilling";
            exitInterview."most frustrating" := "most frustrating";
            exitInterview."better place" := "better place";
            exitInterview."TI-Kenya in the future" := "TI-Kenya in the future";
            exitInterview."next step" := "next step";
            exitInterview."constructive feedback" := "constructive feedback";
            exitInterview."Intervire Conducted By" := "Intervire Conducted By";
            exitInterview."Interview Date" := Today;
            exitInterview.Modify;
        end;
    end;

    procedure fnGetExitInterview(EmpNo: Code[60]) returnout: Text
    var
        exitInterview: Record "Exit Interviews";
        JsonOut: dotnet String;
    begin
        if exitInterview.Get(EmpNo) then begin
            StringBuilder := StringBuilder.StringBuilder;
            StringWriter := StringWriter.StringWriter(StringBuilder);
            JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
            //JSONTextWriter.WriteStartArray;
            JSONTextWriter.WriteStartObject;
            CreateJsonAttribute('EmpNo', exitInterview."Employee No");
            CreateJsonAttribute('mainReason', exitInterview."main reason(s) for your exit");
            CreateJsonAttribute('overallImpression', exitInterview."overall impression");
            CreateJsonAttribute('clearObjectives', exitInterview."clear objectives");
            CreateJsonAttribute('performanceReviewed', exitInterview."your performance reviewed");
            CreateJsonAttribute('enoughRecognition', exitInterview."received enough recognition");
            CreateJsonAttribute('careerAspirations', exitInterview."career aspirations");
            CreateJsonAttribute('relationship_supervisor', exitInterview."relationship with your");
            CreateJsonAttribute('relationship_supervisor', exitInterview."with your immediate team");
            CreateJsonAttribute('accomplishments', exitInterview."greatest accomplishments");
            CreateJsonAttribute('fulfilling_working', exitInterview."most fulfilling");
            CreateJsonAttribute('what_to_change', exitInterview."TI-Kenya in the future");
            CreateJsonAttribute('next_step', exitInterview."next step");
            CreateJsonAttribute('feedback', exitInterview."constructive feedback");
            CreateJsonAttribute('conducted_by', exitInterview."Intervire Conducted By");
            CreateJsonAttribute('ti_perception', exitInterview."perception on TI-Kenya’s");



            JSONTextWriter.WriteEndObject;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
        end;
    end;

    procedure fnGetInductionSchedule(Employee: Code[60]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        /*
          StringBuilder:=StringBuilder.StringBuilder;
        StringWriter:=StringWriter.StringWriter(StringBuilder);
        JSONTextWriter:=JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        inductionshcedule.RESET;
        inductionshcedule.SETRANGE("Inducting Employee No", Employee);
        IF inductionshcedule.FIND('-') THEN BEGIN
        REPEAT
          JSONTextWriter.WriteStartObject;
           CreateJsonAttribute('employee_no', inductionshcedule."Employee No");
           CreateJsonAttribute('employee_name', inductionshcedule."Employee Name");
           JSONTextWriter.WritePropertyName('inducted');
           JSONTextWriter.WriteValue(inductionshcedule.Inducted);
           CreateJsonAttribute('comments', inductionshcedule.Comments);
           JSONTextWriter.WritePropertyName('date_inducted');
           JSONTextWriter.WriteValue(CREATEDATETIME(inductionshcedule."Date Inducted", inductionshcedule."Time Inducted"));
           CreateJsonAttribute('inducting_employee', Employee);
        
        
          JSONTextWriter.WriteEndObject;
        UNTIL inductionshcedule.NEXT=0;
        END;
        //JSONTextWriter.WriteEndObject;
        
        JSONTextWriter.WriteEndArray;
        JsonOut:=StringBuilder.ToString;
        returnout:=JsonOut;
        */

    end;

    procedure fnInduct(inductingEmployee: Code[50]; emloyee: Code[50]; induct: Boolean; comments: Text)
    begin
        /*
        inductionschedule.RESET;
        inductionschedule.SETRANGE("Inducting Employee No", inductingEmployee);
        inductionschedule.SETRANGE("Employee No", emloyee);
        IF inductionschedule.FIND('-') THEN BEGIN
        
          inductionschedule.Inducted:=induct;
          inductionschedule.Comments:=comments;
          inductionschedule."Time Inducted":=TIME;
          inductionschedule."Date Inducted":=TODAY;
          inductionschedule.MODIFY;
          END;
          */

    end;

    procedure fnPaymentMemosList(empNo: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
        ObjImprestHeader: Record "Purchase Header";
        ObjImprestLine: Record "Purchase Line";
        ObjHrEmployee: Record "HR Employees";
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        if ObjHrEmployee.Get(empNo) then
            ObjImprestHeader.Reset;
        //ObjImprestHeader.SETRANGE(PM, TRUE);
        ObjImprestHeader.SetRange(Archived, false);
        ObjImprestHeader.SetRange("Employee No", empNo);
        if ObjImprestHeader.Find('-') then
            repeat
                ObjImprestHeader.CalcFields(Amount);
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', ObjImprestHeader."No.");
                CreateJsonAttribute('Document_Date', ObjImprestHeader."Document Date");
                CreateJsonAttribute('Status', ObjImprestHeader.Status);
                //CreateJsonAttribute('Amount', ObjImprestHeader.Amount);
                JSONTextWriter.WritePropertyName('Amount');
                JSONTextWriter.WriteValue(ObjImprestHeader.Amount);
                CreateJsonAttribute('DepartmentCode', ObjImprestHeader."Shortcut Dimension 1 Code");
                CreateJsonAttribute('DirectorateCode', ObjImprestHeader."Shortcut Dimension 2 Code");
                // CreateJsonAttribute('StartDate', ObjImprestHeader."Document Date");
                JSONTextWriter.WritePropertyName('StartDate');
                JSONTextWriter.WriteValue(ObjImprestHeader."Document Date");
                CreateJsonAttribute('EndDate', ObjImprestHeader."Document Date");
                CreateJsonAttribute('Completed', ObjImprestHeader.Completed);
                CreateJsonAttribute('StrategicFocusArea', ObjImprestHeader."Strategic Focus Area");
                CreateJsonAttribute('SubPillar', ObjImprestHeader."Sub Pillar");
                CreateJsonAttribute('ProjectTitle', ObjImprestHeader."Project Title");
                CreateJsonAttribute('Country', ObjImprestHeader.Country2);
                CreateJsonAttribute('County', ObjImprestHeader.County);
                CreateJsonAttribute('DateOfActivity', ObjImprestHeader."Date(s) of Activity");
                CreateJsonAttribute('MissionTeam', ObjImprestHeader."Mission Team");
                CreateJsonAttribute('InvitedMembers', ObjImprestHeader."Invited Members/Partners");
                CreateJsonAttribute('FundCode', ObjImprestHeader."Shortcut Dimension 1 Code");
                CreateJsonAttribute('ProgramCode', ObjImprestHeader."Shortcut Dimension 2 Code");
                CreateJsonAttribute('Completed', ObjImprestHeader.Completed);
                CreateJsonAttribute('budgetdminesion', ObjImprestHeader."Shortcut Dimension 3 Code");
                CreateJsonAttribute('departmentdimension', ObjImprestHeader."Shortcut Dimension 4 Code");
                CreateJsonAttribute('budgetdescription', ObjImprestHeader."Shortcut Dimension 5 Code");
                CreateJsonAttribute('InvitedMembers', ObjImprestHeader."Invited Members/Partners");
                CreateJsonAttribute('Background', ObjImprestHeader.Background);
                CreateJsonAttribute('StrategicFocus', ObjImprestHeader."Contribution to focus");
                CreateJsonAttribute('Outcome', ObjImprestHeader."Main Outcome");
                CreateJsonAttribute('Ref', ObjImprestHeader."Your Reference");
                CreateJsonAttribute('Subject', ObjImprestHeader.Background);
                CreateJsonAttribute('missionNo', ObjImprestHeader."Mission Proposal No");
                CreateJsonAttribute('purchaseRequisition', ObjImprestHeader."Requisition No");
                CreateJsonAttribute('vendor', ObjImprestHeader."Pay-to Vendor No.");
                CreateJsonAttribute('vendorName', ObjImprestHeader."Pay-to Name");

                JSONTextWriter.WritePropertyName('Date');
                JSONTextWriter.WriteValue(ObjImprestHeader."Document Date");
                // CreateJsonAttribute('Purpose',ObjImprestHeader.Purpose);
                JSONTextWriter.WriteEndObject;
            until ObjImprestHeader.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnInsertPaymentmemo(datesofActivities: Date; fundcode: Code[90]; programcode: Code[90]; departmentdimension: Code[50]; budgetdimesion: Code[50]; budgetdescription: Code[60]; background: Text; empno: Code[40]; ref: Text; purchaseRequest: Code[40]; missionproposal: Code[40]; paye: Code[30]) mssno: Code[60]
    begin
        purchaseheader.Init;
        GenLedgerSetup.Get();
        NNo := '';
        //purchaseheader."No.":=objNumSeries.GetNextNo(GenLedgerSetup."Payment Memo Nos.",0D,TRUE);
        //purchaseheader."No. Series":=GenLedgerSetup."Payment Memo Nos.";
        NNo := purchaseheader."No.";
        purchaseheader."Document Date" := datesofActivities;

        purchaseheader."Shortcut Dimension 1 Code" := fundcode;
        purchaseheader."Shortcut Dimension 2 Code" := programcode;
        //purchaseheader.PM:=TRUE;
        purchaseheader."Your Reference" := ref;
        purchaseheader.Status := purchaseheader.Status::Open;
        purchaseheader."User ID" := UserId;
        purchaseheader."Shortcut Dimension 3 Code" := budgetdimesion;
        purchaseheader."Shortcut Dimension 4 Code" := budgetdescription;
        purchaseheader."Shortcut Dimension 5 Code" := departmentdimension;
        purchaseheader."Mission Proposal No" := missionproposal;
        purchaseheader."Requisition No" := purchaseRequest;
        purchaseheader."Pay-to Vendor No." := paye;
        purchaseheader.Validate("Pay-to Vendor No.");
        purchaseheader.Background := background;
        if empno = '' then Error('Session timeout please login and try again');
        purchaseheader."Employee No" := empno;
        purchaseheader.Validate("Employee No");
        purchaseheader.Insert;

        purchaseline.Init;
        purchaseline."Document No." := NNo;
        purchaseline."Line No." := 10000;
        purchaseline.Insert;


        mssno := purchaseheader."No.";
    end;

    procedure fnupdatePaymentmemo(datesofActivities: Date; fundcode: Code[90]; programcode: Code[90]; departmentdimension: Code[50]; budgetdimesion: Code[50]; budgetdescription: Code[60]; background: Text; empno: Code[40]; ref: Text; no: Code[50]; purchaseRequest: Code[40]; missionProporsal: Code[40]; paye: Code[40]) mssno: Code[60]
    begin
        purchaseheader.Get(purchaseheader."document type"::Quote, no);

        purchaseheader."Document Date" := datesofActivities;

        purchaseheader."Shortcut Dimension 1 Code" := fundcode;
        purchaseheader."Shortcut Dimension 2 Code" := programcode;
        //purchaseheader.PM:=TRUE;
        purchaseheader."Your Reference" := ref;
        purchaseheader.Status := purchaseheader.Status::Open;
        purchaseheader."User ID" := UserId;
        purchaseheader."Shortcut Dimension 3 Code" := budgetdimesion;
        purchaseheader."Shortcut Dimension 4 Code" := budgetdescription;
        purchaseheader."Shortcut Dimension 5 Code" := departmentdimension;
        purchaseheader."Requisition No" := purchaseRequest;
        purchaseheader."Mission Proposal No" := missionProporsal;
        purchaseheader."Pay-to Vendor No." := paye;
        purchaseheader.Validate("Pay-to Vendor No.");
        purchaseheader.Background := background;
        if empno = '' then Error('Session timeout please login and try again');
        purchaseheader."Employee No" := empno;
        purchaseheader.Validate("Employee No");
        purchaseheader.Modify;


        mssno := purchaseheader."No.";
    end;

    procedure fnInsertMileage(plateNo: Code[50]; purpose: Code[40]; county: Code[50]; nature: Code[50]; repaircost: Decimal; comments: Text; startDate: DateTime; employee: Code[50]; pointofdeparture: Code[50]; destination: Code[50]) "code": Code[50]
    begin
        MileageHeader.Init;
        MileageHeader.code := employee + '-' + Format(startDate);
        MileageHeader.Purpose := purpose;
        MileageHeader.county := county;
        MileageHeader.nature := nature;
        MileageHeader.repaircost := repaircost;
        MileageHeader."Point of departure" := pointofdeparture;
        MileageHeader.Destination := destination;
        MileageHeader.comments := comments;
        MileageHeader.Plateno := plateNo;
        MileageHeader.StartDate := Dt2Date(startDate);
        MileageHeader.employee := employee;
        MileageHeader.Insert;

        code := MileageHeader.code;
    end;

    procedure fnModifyMileage(plateNo: Code[50]; purpose: Code[40]; county: Code[50]; nature: Code[50]; repaircost: Decimal; comments: Text; startDate: DateTime; employee: Code[50]; "code": Code[40]; pointofdeparture: Code[50]; destination: Code[50]) MileageCode: Code[50]
    begin
        if MileageHeader.Get(code) then begin
            MileageHeader.code := employee + '-' + Format(startDate);
            ;
            MileageHeader.Purpose := purpose;
            MileageHeader.county := county;
            MileageHeader.nature := nature;
            MileageHeader.repaircost := repaircost;
            MileageHeader.comments := comments;
            MileageHeader.Plateno := plateNo;
            MileageHeader.StartDate := Dt2Date(startDate);
            MileageHeader.employee := employee;
            MileageHeader."Point of departure" := pointofdeparture;
            MileageHeader.Destination := destination;
            MileageHeader.Modify;

            MileageCode := MileageHeader.code;
        end;
    end;

    procedure fnGetMileages(employee: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        MileageHeader.Reset;
        MileageHeader.SetRange(employee, employee);
        if MileageHeader.Find('-') then begin
            repeat
                MileageHeader.CalcFields("Total cost", "Total fuel", "Total miles");
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('code', MileageHeader.code);
                CreateJsonAttribute('plateno', MileageHeader.Plateno);
                CreateJsonAttribute('purpose', MileageHeader.Purpose);
                CreateJsonAttribute('county', MileageHeader.county);
                CreateJsonAttribute('nature', MileageHeader.nature);
                CreateJsonAttribute('repaircost', MileageHeader.repaircost);
                CreateJsonAttribute('comments', MileageHeader.comments);
                CreateJsonAttribute('startdate', MileageHeader.StartDate);
                CreateJsonAttribute('pointofdeparture', MileageHeader."Point of departure");
                CreateJsonAttribute('destination', MileageHeader.Destination);
                CreateJsonAttribute('totalCost', MileageHeader."Total cost");
                CreateJsonAttribute('totalFuel', MileageHeader."Total fuel");
                CreateJsonAttribute('totalMiles', MileageHeader."Total miles");
                JSONTextWriter.WritePropertyName('Mileagelines');
                JSONTextWriter.WriteStartArray;
                MileageLines.Reset;
                MileageLines.SetRange(Mileagecode, MileageHeader.code);
                if MileageLines.Find('-') then begin
                    repeat
                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('mileagecode', MileageLines.Mileagecode);
                        CreateJsonAttribute('startodo', MileageLines.startodo);
                        CreateJsonAttribute('endodo', MileageLines.endodo);
                        CreateJsonAttribute('fuelltrs', MileageLines.fuelLitres);
                        CreateJsonAttribute('fuelkshs', MileageLines.fuelKsh);
                        CreateJsonAttribute('entryno', MileageLines.EntryNo);
                        CreateJsonAttribute('stoplocation', MileageLines.stoplocation);
                        JSONTextWriter.WriteEndObject;
                    until MileageLines.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WriteEndObject;
            until MileageHeader.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnInsertMileageLines("code": Code[50]; startodo: Decimal; endodo: Decimal; fuelltrs: Decimal; fuelkshs: Decimal; stoplocation: Text)
    begin
        MileageLines.Init;
        MileageLines.Mileagecode := code;
        MileageLines.startodo := startodo;
        MileageLines.endodo := endodo;
        MileageLines.stoplocation := stoplocation;
        MileageLines.fuelKsh := fuelkshs;
        MileageLines.fuelLitres := fuelltrs;
        MileageLines.Insert(true);
    end;

    procedure fnModifyMileageLines("code": Code[50]; startodo: Decimal; endodo: Decimal; fuelltrs: Decimal; fuelkshs: Decimal; entryno: Integer; stoplocation: Text)
    begin
        if MileageLines.Get(entryno) then begin
            MileageLines.Mileagecode := code;
            MileageLines.startodo := startodo;
            MileageLines.endodo := endodo;
            MileageLines.stoplocation := stoplocation;
            MileageLines.fuelKsh := fuelkshs;
            MileageLines.fuelLitres := fuelltrs;
            MileageLines.Modify;
        end;
    end;

    procedure fnFundCode() returnout: Text
    var
        ObjDimensionValue: Record "Dimension Value";
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjDimensionValue.Reset;
        ObjDimensionValue.SetRange("Global Dimension No.", 2);
        ObjDimensionValue.SetRange(blocked, false);
        //ObjDimensionValue.SETRANGE("Fund Code",fundcode);
        if ObjDimensionValue.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjDimensionValue.Code);
                CreateJsonAttribute('Name', ObjDimensionValue.Name);
                JSONTextWriter.WriteEndObject;
            until ObjDimensionValue.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnGetWorkplan(ProjectCode: Code[50]) returnout: Text
    var
        ObjDimensionValue: Record 170125;
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjDimensionValue.Reset;
        ObjDimensionValue.SetRange("Project Code", ProjectCode);
        if ObjDimensionValue.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjDimensionValue."Workplan Code");
                CreateJsonAttribute('Name', ObjDimensionValue."Workplan Descption");
                JSONTextWriter.WriteEndObject;
            until ObjDimensionValue.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnGetActivities(WorkplanCode: Code[50]) returnout: Text
    var
        ObjDimensionValue: Record 170126;
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjDimensionValue.Reset;
        ObjDimensionValue.SetRange("Workplan Code", WorkplanCode);
        if ObjDimensionValue.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjDimensionValue."Activity Code");
                CreateJsonAttribute('Name', ObjDimensionValue."Activity Description");
                JSONTextWriter.WriteEndObject;
            until ObjDimensionValue.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnGetProjects() returnout: Text
    var
        ObjDimensionValue: Record "Dimension Value";
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjDimensionValue.Reset;
        ObjDimensionValue.SetRange("Global Dimension No.", 2);
        ObjDimensionValue.SetRange(Closed, false);
        if ObjDimensionValue.FindSet() then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjDimensionValue.Code);
                CreateJsonAttribute('Name', ObjDimensionValue.Code + ' - ' + ObjDimensionValue.Name);
                JSONTextWriter.WriteEndObject;
            until ObjDimensionValue.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnGetBranches() returnout: Text
    var
        ObjDimensionValue: Record "Dimension Value";
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjDimensionValue.Reset;
        ObjDimensionValue.SetRange("Global Dimension No.", 1);
        if ObjDimensionValue.FindSet() then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjDimensionValue.Code);
                CreateJsonAttribute('Name', ObjDimensionValue.Code + ' - ' + ObjDimensionValue.Name);
                JSONTextWriter.WriteEndObject;
            until ObjDimensionValue.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnProjectCode(fundCode: Code[50]) returnout: Text
    var
        ObjDimensionValue: Record "Dimension Value";
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjDimensionValue.Reset;
        ObjDimensionValue.SetRange("Global Dimension No.", 1);
        ObjDimensionValue.SETRANGE(blocked, false);
        if ObjDimensionValue.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjDimensionValue.Code);
                CreateJsonAttribute('Name', ObjDimensionValue.Name);
                JSONTextWriter.WriteEndObject;
            until ObjDimensionValue.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnBudgetLineCode(ProjectCode: Code[50]) returnout: Text
    var
        ObjDimensionValue: Record "Dimension Value";
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjDimensionValue.Reset;
        ObjDimensionValue.SetRange("Global Dimension No.", 3);
        ObjDimensionValue.SetRange("Project Code", ProjectCode);
        ObjDimensionValue.SetRange(Blocked, False);
        if ObjDimensionValue.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjDimensionValue.Code);
                CreateJsonAttribute('Name', ObjDimensionValue.Name);
                JSONTextWriter.WriteEndObject;
            until ObjDimensionValue.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnCategoriesCode(BudgetLineCode: Code[50]) returnout: Text
    var
        ObjDimensionValue: Record "Dimension Value";
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjDimensionValue.Reset;
        ObjDimensionValue.SetRange("Global Dimension No.", 4);
        //ObjDimensionValue.SETRANGE("Actual Spent" ,BudgetLineCode);
        if ObjDimensionValue.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjDimensionValue.Code);
                CreateJsonAttribute('Name', ObjDimensionValue.Name);
                JSONTextWriter.WriteEndObject;
            until ObjDimensionValue.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure FnGetSurrenderList(EmployeeNo: Code[50]) returnout: Text
    var
        ImprestHeader: Record "Purchase Header";
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."Employee No", EmployeeNo);
        ImprestHeader.SetRange("AU Form Type", ImprestHeader."AU Form Type"::"Imprest Requisition");
        ImprestHeader.SetRange(ImprestHeader.Status, ImprestHeader.Status::Released);
        ImprestHeader.SetRange(ImprestHeader.Surrendered, false);
        if ImprestHeader.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', ImprestHeader."No.");
                CreateJsonAttribute('Name', ImprestHeader."No." + ' - ' + ImprestHeader.Purpose);
                JSONTextWriter.WriteEndObject;
            until ImprestHeader.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fninsertTAR(fundcode: Code[50]; programcode: Code[50]; purpose: Code[100]; empno: Code[60]; budgetlinecode: Code[60]; briefofproject: Text; fromDate: DateTime; toDate: DateTime; travelto: Text; placeofstay: Text; contactPerson: Text; itemsInPosession: Text; modeofTransport: Text) impno: Code[50]
    begin
        purchaseheader.Init;
        GenLedgerSetup.Get();
        purchaseheader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Imprest Nos.", 0D, true);
        purchaseheader."No. Series" := GenLedgerSetup."Imprest Nos.";
        purchaseheader."Document Type" := purchaseheader."document type"::Quote;
        //purchaseheader.DocApprovalType2:=purchaseheader.DocApprovalType2::;
        purchaseheader."Posting Description" := purpose;
        purchaseheader."Posting Date" := Today;
        objHREmployees.Reset();
        objHREmployees.SetRange("No.", empno);
        if objHREmployees.Find('-') then begin

            purchaseheader."Account No" := objHREmployees.Travelaccountno;
            purchaseheader.Validate("Account No");

        end;


        purchaseheader."Shortcut Dimension 1 Code" := programcode;
        purchaseheader."Shortcut Dimension 2 Code" := fundcode;
        purchaseheader."Shortcut Dimension 3 Code" := budgetlinecode;
        purchaseheader.IM := true;

        purchaseheader.Status := purchaseheader.Status::Open;
        purchaseheader."User ID" := UserId;

        purchaseheader."Employee No" := empno;
        purchaseheader.Validate("Employee No");
        purchaseheader.fromDate := Dt2Date(fromDate);
        purchaseheader."Review From" := Dt2Date(toDate);
        purchaseheader.travelTo := travelto;
        purchaseheader.briefOfProject := briefofproject;
        purchaseheader.placeOfStay := placeofstay;
        purchaseheader.contactPerson := contactPerson;
        purchaseheader.itemsInPosession := itemsInPosession;
        purchaseheader.modeOfTransport := modeofTransport;
        purchaseheader.Purpose := purpose;
        purchaseheader.Insert;

        impno := purchaseheader."No.";
    end;

    procedure fninsertTarLines(expensecategory: Code[50]; description: Text; unitcost: Decimal; currency: Code[10]; amount: Decimal; documentno: Code[50]; frequency: Decimal)
    var
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        purchaseline.Init;
        purchaseline."Document No." := documentno;
        PurchasesPayablesSetup.Get;
        purchaseheader.Get(purchaseheader."document type"::Quote, documentno);

        purchaseline."Expense Category" := expensecategory;
        purchaseline.Type := purchaseline.Type::"G/L Account";
        purchaseline.Validate("Expense Category");
        Evaluate(purchaseline."Line No.", objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.", Today, true));
        purchaseline."Shortcut Dimension 1 Code" := purchaseheader."Shortcut Dimension 1 Code";
        purchaseline."Shortcut Dimension 2 Code" := purchaseheader."Shortcut Dimension 2 Code";
        purchaseline."ShortcutDimCode[3]" := purchaseheader."Shortcut Dimension 3 Code";
        GLBudgetEntry.Reset;
        GLBudgetEntry.SetRange("Budget Dimension 1 Code", purchaseheader."Shortcut Dimension 3 Code");
        if GLBudgetEntry.FindFirst then begin
            purchaseline."No." := GLBudgetEntry."G/L Account No.";
            purchaseline.Description := GLBudgetEntry.Description;
        end;


        purchaseline.Description := description;
        purchaseline."Direct Unit Cost" := unitcost;
        //purchaseline."Currency Code":=currency;
        //purchaseline.VALIDATE("Currency Code");
        purchaseline.Quantity := amount;
        purchaseline.Validate("Direct Unit Cost");
        purchaseline."No of pax" := frequency;
        purchaseline."Line Amount" := unitcost * amount * unitcost;
        if purchaseline."Line Amount" <> 0 then
            purchaseline.Insert;
    end;

    procedure fninsertFIndings(documentno: Code[20]; description: Text)
    var
        LINENO: Integer;
    begin
        purchaseline.Init;
        PurchasesPayablesSetup.Get;
        Evaluate(purchaseline."Line No.", objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.", Today, true));
        purchaseline."Document No." := documentno;
        purchaseline.Description := description;
        purchaseline."Line Type" := purchaseline."line type"::"Budget Info";
        purchaseline.Insert;
    end;

    procedure fninsertChallenges(documentno: Code[20]; description: Text)
    var
        LINENO: Integer;
    begin
        purchaseline.Init;
        PurchasesPayablesSetup.Get;
        Evaluate(purchaseline."Line No.", objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.", Today, true));
        purchaseline."Document No." := documentno;
        purchaseline.Description := description;
        purchaseline."Line Type" := purchaseline."line type"::"Budget Notes";
        purchaseline.Insert;
    end;

    procedure fninsertConclusions(documentno: Code[20]; description: Text)
    var
        LINENO: Integer;
    begin
        purchaseline.Init;
        PurchasesPayablesSetup.Get;
        Evaluate(purchaseline."Line No.", objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.", Today, true));
        purchaseline."Document No." := documentno;
        purchaseline.Description := description;
        purchaseline."Line Type" := purchaseline."line type"::Objectives;
        purchaseline.Insert;
    end;

    procedure fnStandardTexts() returnout: Text
    var
        ObjDimensionValue: Record "Standard Text";
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjDimensionValue.Reset;
        //ObjDimensionValue.SetRange(Type, ObjDimensionValue.Type::);
        if ObjDimensionValue.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjDimensionValue.Code);
                CreateJsonAttribute('Name', ObjDimensionValue.Description);
                JSONTextWriter.WriteEndObject;
            until ObjDimensionValue.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fninsertBudgetActivity(fundcode: Code[50]; programcode: Code[50]; purpose: Code[100]; empno: Code[60]; budgetlinecode: Code[60]; briefofproject: Text; fromDate: DateTime; toDate: DateTime; travelto: Text; placeofstay: Text; contactPerson: Text; itemsInPosession: Text; modeofTransport: Text) impno: Code[50]
    begin
        purchaseheader.Init;
        GenLedgerSetup.Get();
        purchaseheader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Imprest Nos.", 0D, true);
        purchaseheader."No. Series" := GenLedgerSetup."Imprest Nos.";
        purchaseheader."Document Type" := purchaseheader."document type"::Quote;
        //purchaseheader.DocApprovalType2:=purchaseheader.DocApprovalType2::;
        purchaseheader."Posting Description" := purpose;
        purchaseheader."Posting Date" := Today;
        objHREmployees.Reset();
        objHREmployees.SetRange("No.", empno);
        if objHREmployees.Find('-') then begin

            purchaseheader."Account No" := objHREmployees.Travelaccountno;
            purchaseheader.Validate("Account No");

        end;


        purchaseheader."Shortcut Dimension 1 Code" := programcode;
        purchaseheader."Shortcut Dimension 2 Code" := fundcode;
        purchaseheader."Shortcut Dimension 3 Code" := budgetlinecode;
        purchaseheader.MP := true;

        purchaseheader.Status := purchaseheader.Status::Open;
        purchaseheader."User ID" := UserId;

        purchaseheader."Employee No" := empno;
        purchaseheader.Validate("Employee No");
        purchaseheader.fromDate := Dt2Date(fromDate);
        purchaseheader."Review From" := Dt2Date(toDate);
        purchaseheader.travelTo := travelto;
        purchaseheader.briefOfProject := briefofproject;
        purchaseheader.placeOfStay := placeofstay;
        purchaseheader.contactPerson := contactPerson;
        purchaseheader.itemsInPosession := itemsInPosession;
        purchaseheader.modeOfTransport := modeofTransport;
        purchaseheader.Purpose := purpose;
        purchaseheader.Insert;

        impno := purchaseheader."No.";
    end;

    procedure fninsertBudgetActivityLines(expensecategory: Code[50]; description: Text; unitcost: Decimal; currency: Code[10]; amount: Decimal; documentno: Code[50]; shortcutdimensions: Code[50]; frequency: Decimal)
    var
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        purchaseline.Init;
        purchaseline."Document No." := documentno;
        PurchasesPayablesSetup.Get;
        purchaseheader.Get(purchaseheader."document type"::Quote, documentno);
        purchaseline."Shortcut Dimension 1 Code" := purchaseheader."Shortcut Dimension 1 Code";
        purchaseline."Shortcut Dimension 2 Code" := purchaseheader."Shortcut Dimension 2 Code";
        purchaseline."ShortcutDimCode[3]" := purchaseheader."Shortcut Dimension 3 Code";
        GLBudgetEntry.Reset;
        GLBudgetEntry.SetRange("Budget Dimension 1 Code", purchaseheader."Shortcut Dimension 3 Code");
        if GLBudgetEntry.FindFirst then begin
            purchaseline."No." := GLBudgetEntry."G/L Account No.";
            purchaseline.Description := GLBudgetEntry.Description;
        end;
        purchaseline.Validate("ShortcutDimCode[3]");
        purchaseline."ShortcutDimCode[4]" := shortcutdimensions;
        //purchaseline."Expense Category":=expensecategory;
        //purchaseline.VALIDATE("Expense Category");
        purchaseline.Type := purchaseline.Type::"G/L Account";
        purchaseline.Validate("ShortcutDimCode[4]");
        Evaluate(purchaseline."Line No.", objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.", Today, true));
        //purchaseline."Expense Category":=expensecategory;
        //purchaseline.VALIDATE("Expense Category");
        purchaseline.Description := description;
        purchaseline."Direct Unit Cost" := unitcost;
        purchaseline."Currency Code" := currency;
        purchaseline.Validate("Currency Code");
        purchaseline.Quantity := amount;
        purchaseline."No of pax" := frequency;
        purchaseline.Validate("Direct Unit Cost");
        purchaseline."Line Amount" := unitcost * amount;
        if purchaseline."Line Amount" <> 0 then
            purchaseline.Insert;
    end;

    procedure fnUpdateBudgetActivity(fundcode: Code[50]; programcode: Code[50]; purpose: Code[100]; empno: Code[60]; budgetlinecode: Code[60]; briefofproject: Text; fromDate: DateTime; toDate: DateTime; travelto: Text; placeofstay: Text; contactPerson: Text; itemsInPosession: Text; modeofTransport: Text; "code": Code[50]) impno: Code[50]
    begin
        //purchaseheader.INIT;
        GenLedgerSetup.Get();
        //purchaseheader."No.":=objNumSeries.GetNextNo(GenLedgerSetup."Imprest Nos.",0D,TRUE);

        //purchaseheader."No. Series":=GenLedgerSetup."Imprest Nos.";
        purchaseheader.Get(purchaseheader."document type"::Quote, code);
        //purchaseheader."Document Type":=purchaseheader."Document Type"::Quote;
        //purchaseheader.DocApprovalType2:=purchaseheader.DocApprovalType2::;
        purchaseheader."Posting Description" := purpose;
        purchaseheader."Posting Date" := Today;
        objHREmployees.Reset();
        objHREmployees.SetRange("No.", empno);
        if objHREmployees.Find('-') then begin

            purchaseheader."Account No" := objHREmployees.Travelaccountno;
            purchaseheader.Validate("Account No");

        end;


        purchaseheader."Shortcut Dimension 1 Code" := programcode;
        purchaseheader."Shortcut Dimension 2 Code" := fundcode;
        purchaseheader."Shortcut Dimension 3 Code" := budgetlinecode;
        purchaseheader.MP := true;

        purchaseheader.Status := purchaseheader.Status::Open;
        purchaseheader."User ID" := UserId;

        purchaseheader."Employee No" := empno;
        purchaseheader.Validate("Employee No");
        purchaseheader.fromDate := Dt2Date(fromDate);
        purchaseheader."Review From" := Dt2Date(toDate);
        purchaseheader.travelTo := travelto;
        purchaseheader.briefOfProject := briefofproject;
        purchaseheader.placeOfStay := placeofstay;
        purchaseheader.contactPerson := contactPerson;
        purchaseheader.itemsInPosession := itemsInPosession;
        purchaseheader.modeOfTransport := modeofTransport;
        purchaseheader.Purpose := purpose;
        purchaseheader.Modify;

        impno := purchaseheader."No.";
    end;

    procedure fnUpdateBudgetActivityLines(expensecategory: Code[50]; description: Text; unitcost: Decimal; currency: Code[10]; amount: Decimal; documentno: Code[50]; shortcutdimensions: Code[50]; frequency: Decimal; llineno: Integer)
    var
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        purchaseline.Get(purchaseline."document type"::Quote, documentno, llineno);
        purchaseline."Document No." := documentno;
        PurchasesPayablesSetup.Get;
        purchaseheader.Get(purchaseheader."document type"::Quote, documentno);
        purchaseline."Shortcut Dimension 1 Code" := purchaseheader."Shortcut Dimension 1 Code";
        purchaseline."Shortcut Dimension 2 Code" := purchaseheader."Shortcut Dimension 2 Code";
        purchaseline."ShortcutDimCode[3]" := purchaseheader."Shortcut Dimension 3 Code";
        GLBudgetEntry.Reset;
        GLBudgetEntry.SetRange("Budget Dimension 1 Code", purchaseheader."Shortcut Dimension 3 Code");
        if GLBudgetEntry.FindFirst then begin
            purchaseline."No." := GLBudgetEntry."G/L Account No.";
            purchaseline.Description := GLBudgetEntry.Description;
        end;
        purchaseline.Validate("ShortcutDimCode[3]");
        purchaseline."ShortcutDimCode[4]" := shortcutdimensions;
        purchaseline."Expense Category" := expensecategory;
        purchaseline.Validate("Expense Category");
        purchaseline.Type := purchaseline.Type::"G/L Account";
        purchaseline.Validate("ShortcutDimCode[4]");
        //EVALUATE(purchaseline."Line No.",objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.",TODAY,TRUE));
        //purchaseline."Expense Category":=expensecategory;
        //purchaseline.VALIDATE("Expense Category");
        purchaseline.Description := description;
        purchaseline."Direct Unit Cost" := unitcost;
        purchaseline."Currency Code" := currency;
        purchaseline.Validate("Currency Code");
        purchaseline.Quantity := amount;
        purchaseline."No of pax" := frequency;
        purchaseline.Validate("Direct Unit Cost");
        purchaseline."Line Amount" := unitcost * amount;
        if purchaseline."Line Amount" <> 0 then
            purchaseline.Modify;
    end;

    procedure fnUpdateTAR(fundcode: Code[50]; programcode: Code[50]; purpose: Code[100]; empno: Code[60]; budgetlinecode: Code[60]; briefofproject: Text; fromDate: DateTime; toDate: DateTime; travelto: Text; placeofstay: Text; contactPerson: Text; itemsInPosession: Text; modeofTransport: Text; "code": Code[50]) impno: Code[50]
    begin
        //purchaseheader.INIT;
        GenLedgerSetup.Get();
        //purchaseheader."No.":=objNumSeries.GetNextNo(GenLedgerSetup."Imprest Nos.",0D,TRUE);

        //purchaseheader."No. Series":=GenLedgerSetup."Imprest Nos.";
        purchaseheader.Get(purchaseheader."document type"::Quote, code);
        //purchaseheader."Document Type":=purchaseheader."Document Type"::Quote;
        //purchaseheader.DocApprovalType2:=purchaseheader.DocApprovalType2::;
        purchaseheader."Posting Description" := purpose;
        purchaseheader."Posting Date" := Today;
        objHREmployees.Reset();
        objHREmployees.SetRange("No.", empno);
        if objHREmployees.Find('-') then begin

            purchaseheader."Account No" := objHREmployees.Travelaccountno;
            purchaseheader.Validate("Account No");

        end;


        purchaseheader."Shortcut Dimension 1 Code" := programcode;
        purchaseheader."Shortcut Dimension 2 Code" := fundcode;
        purchaseheader."Shortcut Dimension 3 Code" := budgetlinecode;
        purchaseheader.MP := true;

        purchaseheader.Status := purchaseheader.Status::Open;
        purchaseheader."User ID" := UserId;

        purchaseheader."Employee No" := empno;
        purchaseheader.Validate("Employee No");
        purchaseheader.fromDate := Dt2Date(fromDate);
        purchaseheader."Review From" := Dt2Date(toDate);
        purchaseheader.travelTo := travelto;
        purchaseheader.briefOfProject := briefofproject;
        purchaseheader.placeOfStay := placeofstay;
        purchaseheader.contactPerson := contactPerson;
        purchaseheader.itemsInPosession := itemsInPosession;
        purchaseheader.modeOfTransport := modeofTransport;
        purchaseheader.Purpose := purpose;
        purchaseheader.Modify;

        impno := purchaseheader."No.";
    end;

    procedure fnUpdateTARLines(expensecategory: Code[50]; description: Text; unitcost: Decimal; currency: Code[10]; amount: Decimal; documentno: Code[50]; shortcutdimensions: Code[50]; frequency: Decimal; llineno: Integer)
    var
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        purchaseline.Get(purchaseline."document type"::Quote, documentno, llineno);
        purchaseline."Document No." := documentno;
        PurchasesPayablesSetup.Get;
        /*
        purchaseheader.GET(purchaseheader."Document Type"::Quote,documentno);
        purchaseline."Shortcut Dimension 1 Code":=purchaseheader."Shortcut Dimension 1 Code";
        purchaseline."Shortcut Dimension 2 Code":=purchaseheader."Shortcut Dimension 2 Code";
        purchaseline."Shortcut Dimension 3 Code":=purchaseheader."Shortcut Dimension 3 Code";
        
        GLBudgetEntry.RESET;
        GLBudgetEntry.SETRANGE("Budget Dimension 1 Code",purchaseheader."Shortcut Dimension 3 Code");
        IF GLBudgetEntry.FINDFIRST THEN BEGIN
          purchaseline."No.":=GLBudgetEntry."G/L Account No.";
          purchaseline.Description:=GLBudgetEntry.Description;
          END;
        purchaseline.VALIDATE("Shortcut Dimension 3 Code");
        purchaseline."Shortcut Dimension 4 Code":=purchaseheader."Shortcut Dimension 4 Code";
        */
        purchaseline."Expense Category" := expensecategory;
        purchaseline.Validate("Expense Category");
        purchaseline.Type := purchaseline.Type::"G/L Account";
        purchaseline.Validate("ShortcutDimCode[4]");
        //EVALUATE(purchaseline."Line No.",objNumSeries.GetNextNo(PurchasesPayablesSetup."Line Nos.",TODAY,TRUE));
        //purchaseline."Expense Category":=expensecategory;
        //purchaseline.VALIDATE("Expense Category");
        purchaseline.Description := description;
        purchaseline."Direct Unit Cost" := unitcost;
        //purchaseline."Currency Code":=currency;
        //purchaseline.VALIDATE("Currency Code");
        purchaseline.Quantity := amount;
        purchaseline."No of pax" := frequency;
        purchaseline.Validate("Direct Unit Cost");
        purchaseline."Line Discount Amount" := 0;
        purchaseline."Line Discount %" := 0;
        purchaseline."Line Amount" := unitcost * amount * frequency;

        if purchaseline."Line Amount" <> 0 then
            purchaseline.Modify;

    end;



    Procedure FnModifyTimesheetLines1(Date: Date; Branch: Code[250]; Project: Code[1000]; Deliverable: Code[250]; Narration: Text; Hours: Integer; No: Code[50]; EmployeeNo: Code[100]; LineNo: Integer)
    var
    begin
        TETimeSheet1.RESET;
        TETimeSheet1.SETRANGE(Entry, LineNo);
        TETimeSheet1.SETRANGE("Document No.", No);
        IF TETimeSheet1.FINDFIRST THEN BEGIN
            TETimeSheet1.Entry := LineNo;
            TETimeSheet1."Document No." := No;
            TETimeSheet1.Date := Date;
            TETimeSheet1."Global Dimension 1 Code" := Branch;
            TETimeSheet1."Global Dimension 2 Code" := Project;
            TETimeSheet1."Global Dimension 3 Code" := Deliverable;
            TETimeSheet1.Narration := Narration;
            TETimeSheet1.Hours := Hours;
            IF TETimeSheet1.Hours > 0 THEN
                TETimeSheet1.MODIFY;
        END;
    end;



    procedure fnDepartmentValueLeave() returnout: Text
    var
        ObjDimensionValue: Record "Dimension Value";
        JsonOut: dotnet String;
        HRLeaveTypes: Record "HR Leave Types";
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjDimensionValue.Reset;
        ObjDimensionValue.SetRange("Global Dimension No.", 1);
        //ObjDimensionValue.SETRANGE("Fund Code",fundcode);
        if ObjDimensionValue.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjDimensionValue.Code);
                CreateJsonAttribute('Name', ObjDimensionValue.Code);
                JSONTextWriter.WriteEndObject;
            until ObjDimensionValue.Next = 0;
        ///Leave
        HRLeaveTypes.Reset;
        if HRLeaveTypes.FindFirst then begin
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', HRLeaveTypes.Code);
                CreateJsonAttribute('Name', HRLeaveTypes.Description);
                JSONTextWriter.WriteEndObject;
            until HRLeaveTypes.Next = 0;
        end;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure FnInsertAppraisal(JsonData: Text)
    var
        lineNo: Integer;
        target: Decimal;
        weighting: Decimal;
        fromDate: DateTime;
        toDate: DateTime;
        appraisalNeeds: Record AppraisalNeeds;
    begin
        lJSONString := JsonData;
        if lJSONString <> '' then
            lJObject := lJObject.Parse(Format(lJSONString));
        purchaseheader.Init;
        hrsetup.Get;
        purchaseheader."No." := objNumSeries.GetNextNo(hrsetup."Appraisal Nos.", 0D, true);
        purchaseheader."No. Series" := hrsetup."Appraisal Nos.";
        purchaseheader."Document Type" := purchaseheader."document type"::Quote;
        purchaseheader.APP := true;
        Evaluate(fromDate, Format(lJObject.GetValue('reviewFrom')));
        Evaluate(toDate, Format(lJObject.GetValue('reviewTo')));
        purchaseheader."Employee No" := Format(lJObject.GetValue('emno'));
        purchaseheader.Validate("Employee No");
        purchaseheader."Review From" := Dt2Date(fromDate);
        purchaseheader."Review To" := Dt2Date(toDate);
        // Peformance
        lArrayString := lJObject.SelectToken('Performance').ToString;
        Clear(lJObject);
        lJsonArray := lJsonArray.Parse(lArrayString);
        lineNo := 1000;
        foreach lJObject in lJsonArray do begin
            purchaseline.Init;
            purchaseline."Line No." := lineNo;
            purchaseline."Document No." := purchaseheader."No.";
            purchaseline."Line Type" := purchaseline."line type"::Performance;
            Evaluate(target, Format(lJObject.GetValue('target')));
            Evaluate(weighting, Format(lJObject.GetValue('weighting')));

            purchaseline.keyResultAreas := Format(lJObject.GetValue('keyResultAreas'));
            purchaseline.keyActivities := Format(lJObject.GetValue('keyActivities'));

            purchaseline.performanceMeasures := Format(lJObject.GetValue('performanceMeasures'));

            purchaseline.target := target;
            purchaseline.commentsOnAchievedResults := Format(lJObject.GetValue('commentsOnAchievedResults'));
            purchaseline.weighting := weighting;

            purchaseline.Insert;

            lineNo += 1000;
        end;
        appraisalNeeds.SetRange(appraisalNeeds."Line Type", appraisalNeeds."line type"::AppraisalScore);
        appraisalNeeds.Find('-');
        repeat
            purchaseline.Init;
            purchaseline."Line No." := lineNo;
            purchaseline."Document No." := purchaseheader."No.";
            purchaseline."Line Type" := purchaseline."line type"::Sections;
            purchaseline.appraisalType := appraisalNeeds.Appraisaltype;
            purchaseline.appraisalDescription := appraisalNeeds.Description;
            purchaseline.Insert;
            lineNo += 1000;
        until appraisalNeeds.Next = 0;

        appraisalNeeds.SetRange(appraisalNeeds."Line Type", appraisalNeeds."line type"::Rellections);
        appraisalNeeds.Find('-');
        repeat
            purchaseline.Init;
            purchaseline."Line No." := lineNo;
            purchaseline."Document No." := purchaseheader."No.";
            purchaseline."Line Type" := purchaseline."line type"::Reflections;
            //purchaseline.appraisalType:=appraisalNeeds.Appraisaltype;
            purchaseline.reflectionDescription := appraisalNeeds.Description;
            purchaseline.Insert;
            lineNo += 1000;
        until appraisalNeeds.Next = 0;


        appraisalNeeds.SetRange(appraisalNeeds."Line Type", appraisalNeeds."line type"::PersonalQualities);
        appraisalNeeds.Find('-');
        repeat
            purchaseline.Init;
            purchaseline."Line No." := lineNo;
            purchaseline."Document No." := purchaseheader."No.";
            purchaseline."Line Type" := purchaseline."line type"::PersonalQualities;
            //purchaseline.appraisalType:=appraisalNeeds.Appraisaltype;
            purchaseline.personalDescription := appraisalNeeds.Description;
            purchaseline.Insert;
            lineNo += 1000;
        until appraisalNeeds.Next = 0;


        purchaseheader.Insert;
    end;

    procedure FnUpdateAppraisal(JsonData: Text)
    var
        lineNo: Integer;
        target: Decimal;
        weighting: Decimal;
        fromDate: DateTime;
        toDate: DateTime;
    begin

        lJSONString := JsonData;
        if lJSONString <> '' then
            lJObject := lJObject.Parse(Format(lJSONString));
        purchaseheader.Init;
        GenLedgerSetup.Get();
        purchaseheader."No." := Format(lJObject.GetValue('no'));
        purchaseheader."Document Type" := purchaseheader."document type"::Quote;
        Evaluate(fromDate, Format(lJObject.GetValue('reviewFrom')));
        Evaluate(toDate, Format(lJObject.GetValue('reviewTo')));
        purchaseheader."Employee No" := Format(lJObject.GetValue('emno'));
        purchaseheader.Validate("Employee No");
        purchaseheader."Review From" := Dt2Date(fromDate);
        purchaseheader."Review To" := Dt2Date(toDate);
        // Peformance
        lArrayString := lJObject.SelectToken('Performance').ToString;
        Clear(lJObject);
        lJsonArray := lJsonArray.Parse(lArrayString);
        lineNo := 1000;
        foreach lJObject in lJsonArray do begin
            Evaluate(purchaseline."Line No.", Format(lJObject.GetValue('lineNo')));
            if purchaseline."Line No." = 0 then begin
                purchaseline.Init;
                purchaseline."Line No." := lineNo;
                purchaseline."Document No." := purchaseheader."No.";
                purchaseline."Line Type" := purchaseline."line type"::Performance;
                Evaluate(target, Format(lJObject.GetValue('target')));
                Evaluate(weighting, Format(lJObject.GetValue('weighting')));

                purchaseline.keyResultAreas := Format(lJObject.GetValue('keyResultAreas'));
                purchaseline.keyActivities := Format(lJObject.GetValue('keyActivities'));

                purchaseline.performanceMeasures := Format(lJObject.GetValue('performanceMeasures'));

                purchaseline.target := target;
                purchaseline.commentsOnAchievedResults := Format(lJObject.GetValue('commentsOnAchievedResults'));
                purchaseline.weighting := weighting;

                purchaseline.Insert;


            end else begin
                purchaseline."Document No." := purchaseheader."No.";
                purchaseline."Line Type" := purchaseline."line type"::Performance;
                purchaseline."Document Type" := purchaseline."document type"::Quote;
                Evaluate(target, Format(lJObject.GetValue('target')));
                Evaluate(weighting, Format(lJObject.GetValue('weighting')));

                purchaseline.keyResultAreas := Format(lJObject.GetValue('keyResultAreas'));
                purchaseline.keyActivities := Format(lJObject.GetValue('keyActivities'));

                purchaseline.performanceMeasures := Format(lJObject.GetValue('performanceMeasures'));

                purchaseline.target := target;
                purchaseline.commentsOnAchievedResults := Format(lJObject.GetValue('commentsOnAchievedResults'));
                purchaseline.weighting := weighting;

                purchaseline.Modify;
            end;
            lineNo += 1000;
        end;

        purchaseheader.Modify;
    end;

    procedure fnAppraisalList(empNo: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        purchaseheader.Reset;
        purchaseheader.SetRange("Employee No", empNo);
        purchaseheader.SetRange("Document Type", purchaseheader."document type"::Quote);
        purchaseheader.SetRange(APP, true);

        if purchaseheader.Find('-') then begin
            repeat

                JSONTextWriter.WriteStartObject;

                CreateJsonAttribute('no', purchaseheader."No.");
                //CreateJsonAttribute('reviewFrom', purchaseheader."Review From");
                // CreateJsonAttribute('reviewTo', purchaseheader."Review To");
                JSONTextWriter.WritePropertyName('reviewFrom');
                JSONTextWriter.WriteValue(purchaseheader."Review From");
                JSONTextWriter.WritePropertyName('reviewTo');
                JSONTextWriter.WriteValue(purchaseheader."Review To");
                CreateJsonAttribute('emno', purchaseheader."Employee No");
                CreateJsonAttribute('Status', purchaseheader.Status);



                JSONTextWriter.WritePropertyName('Performance');

                JSONTextWriter.WriteStartArray;

                purchaseline.Reset;
                purchaseline.SetRange("Document No.", purchaseheader."No.");
                purchaseline.SetRange("Line Type", purchaseline."line type"::Performance);
                if purchaseline.Find('-') then begin
                    repeat
                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('documentNo', purchaseline."Document No.");
                        // CreateJsonAttribute('lineNo', purchaseline."Line No.");
                        JSONTextWriter.WritePropertyName('lineNo');
                        JSONTextWriter.WriteValue(purchaseline."Line No.");
                        CreateJsonAttribute('keyResultAreas', purchaseline.keyResultAreas);
                        CreateJsonAttribute('keyActivities', purchaseline.keyActivities);
                        CreateJsonAttribute('performanceMeasures', purchaseline.performanceMeasures);
                        CreateJsonAttribute('commentsOnAchievedResults', purchaseline.commentsOnAchievedResults);
                        // CreateJsonAttribute('target', purchaseline.target);
                        JSONTextWriter.WritePropertyName('target');
                        JSONTextWriter.WriteValue(purchaseline.target);
                        JSONTextWriter.WritePropertyName('actualAchieved');
                        JSONTextWriter.WriteValue(purchaseline.actualAchieved);
                        JSONTextWriter.WritePropertyName('percentageOfTarget');
                        JSONTextWriter.WriteValue(purchaseline.percentageOfTarget);
                        JSONTextWriter.WritePropertyName('rating');
                        JSONTextWriter.WriteValue(purchaseline.rating);
                        JSONTextWriter.WritePropertyName('weightingRating');
                        JSONTextWriter.WriteValue(purchaseline.weightingRating);
                        JSONTextWriter.WritePropertyName('weighting');
                        JSONTextWriter.WriteValue(purchaseline.weighting);
                        /*
                         CreateJsonAttribute('actualAchieved', purchaseline.actualAchieved);
                         CreateJsonAttribute('percentageOfTarget', purchaseline.percentageOfTarget);
                         CreateJsonAttribute('rating', purchaseline.rating);
                         CreateJsonAttribute('weightingRating', purchaseline.weightingRating);
                         CreateJsonAttribute('weighting', purchaseline.weighting);*/
                        JSONTextWriter.WriteEndObject;
                    until purchaseline.Next = 0;
                end;

                JSONTextWriter.WriteEndArray;

                JSONTextWriter.WritePropertyName('Sections');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", purchaseheader."No.");
                purchaseline.SetRange("Line Type", purchaseline."line type"::Sections);
                if purchaseline.Find('-') then begin
                    repeat
                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('documentNo', purchaseline."Document No.");
                        JSONTextWriter.WritePropertyName('lineNo');
                        JSONTextWriter.WriteValue(purchaseline."Line No.");
                        CreateJsonAttribute('appraisalType', purchaseline.appraisalType);
                        CreateJsonAttribute('appraisalDescription', purchaseline.appraisalDescription);

                        // CreateJsonAttribute('staffRating', purchaseline.staffRating);
                        JSONTextWriter.WritePropertyName('staffRating');
                        JSONTextWriter.WriteValue(purchaseline.staffRating);
                        // CreateJsonAttribute('supervisorRating', purchaseline.supervisorRating);
                        JSONTextWriter.WritePropertyName('supervisorRating');
                        JSONTextWriter.WriteValue(purchaseline.staffRating);
                        JSONTextWriter.WriteEndObject;
                    until purchaseline.Next = 0;
                end;

                JSONTextWriter.WriteEndArray;

                JSONTextWriter.WritePropertyName('PersonalQualities');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", purchaseheader."No.");
                purchaseline.SetRange("Line Type", purchaseline."line type"::PersonalQualities);
                if purchaseline.Find('-') then begin
                    repeat
                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('documentNo', purchaseline."Document No.");
                        JSONTextWriter.WritePropertyName('lineNo');
                        JSONTextWriter.WriteValue(purchaseline."Line No.");
                        CreateJsonAttribute('personalDescription', purchaseline.personalDescription);
                        //CreateJsonAttribute('score', FORMAT(purchaseline.score));

                        JSONTextWriter.WritePropertyName('score');
                        JSONTextWriter.WriteValue(purchaseline.score);
                        CreateJsonAttribute('comments', purchaseline.comments);
                        JSONTextWriter.WriteEndObject;
                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;


                JSONTextWriter.WritePropertyName('Reflections');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", purchaseheader."No.");
                purchaseline.SetRange("Line Type", purchaseline."line type"::Reflections);
                if purchaseline.Find('-') then begin
                    repeat
                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('documentNo', purchaseline."Document No.");
                        JSONTextWriter.WritePropertyName('lineNo');
                        JSONTextWriter.WriteValue(purchaseline."Line No.");
                        CreateJsonAttribute('reflectionDescription', purchaseline.reflectionDescription);
                        CreateJsonAttribute('selfAppraisal', purchaseline.selfAppraisal);

                        CreateJsonAttribute('supervisorsFeedback', purchaseline.supervisorsFeedback);

                        JSONTextWriter.WriteEndObject;
                    until purchaseline.Next = 0;
                end;
                JSONTextWriter.WriteEndArray;


                JSONTextWriter.WritePropertyName('CapacityNeeds');
                JSONTextWriter.WriteStartArray;
                purchaseline.Reset;
                purchaseline.SetRange("Document No.", purchaseheader."No.");
                purchaseline.SetRange("Line Type", purchaseline."line type"::CapacityNeeds);
                if purchaseline.Find('-') then begin
                    repeat
                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('documentNo', purchaseline."Document No.");
                        JSONTextWriter.WritePropertyName('lineNo');
                        JSONTextWriter.WriteValue(purchaseline."Line No.");
                        CreateJsonAttribute('capacity', purchaseline.capacity);
                        //  CreateJsonAttribute('completionDate', purchaseline.completionDate);
                        JSONTextWriter.WritePropertyName('completionDate');
                        JSONTextWriter.WriteValue(purchaseline.completionDate);
                        CreateJsonAttribute('capacityNeedsDescription', purchaseline.capacityNeedsDescription);
                        CreateJsonAttribute('remedialMeasures', purchaseline.remedialMeasures);
                        JSONTextWriter.WriteEndObject;
                    until purchaseline.Next = 0;
                end;

                JSONTextWriter.WriteEndArray;

                JSONTextWriter.WritePropertyName('ActionPoints');
                JSONTextWriter.WriteStartArray;

                purchaseline.Reset;
                purchaseline.SetRange("Document No.", purchaseheader."No.");
                purchaseline.SetRange("Line Type", purchaseline."line type"::ActionPoints);
                if purchaseline.Find('-') then begin
                    repeat
                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('documentNo', purchaseline."Document No.");
                        JSONTextWriter.WritePropertyName('lineNo');
                        JSONTextWriter.WriteValue(purchaseline."Line No.");
                        CreateJsonAttribute('planning', purchaseline.planning);
                        CreateJsonAttribute('personResponsible', purchaseline.personResponsible);

                        CreateJsonAttribute('agreedActionPoints', purchaseline.agreedActionPoints);
                        CreateJsonAttribute('timelines', purchaseline.timelines);
                        JSONTextWriter.WriteEndObject;
                    until purchaseline.Next = 0;
                end;

                JSONTextWriter.WriteEndArray;


                JSONTextWriter.WriteEndObject;

            until purchaseheader.Next = 0;
        end;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;

    end;

    procedure fnGetApprovalDocument(documentNo: Code[40]; var Base64Txt: Text)
    var
        Filename: Text[100];
        Leave: Record "HR Leave Application";
        GoNoGoDec: Record GonoGoDecision;
        Proposal: Record "Personal development Tracker";
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        StatementOfAccount: Report 80024;
        Base64Convert: Codeunit "Base64 Convert";
        ImprestReport: Report 80055;
        EmpReqReport: Report 80040;
        ImprestReports: Report 80055;
        ImprestSurrenderReport: Report 80052;
        PurchaseReqReport: Report 80024;
        ExpenseReport: Report 80056;
        TimesheetReport: Report 50060;
        GoNoGoReport: Report 50043;
        ProposalReport: Report 50048;
        ClaimsVoucher: Report 50089;
        LeaveReport: Report 80075;
        RFQReport: Report 17366;
        LPOReport: Report 50002;
        PVReport: report 80054;
        PayrollK: report 17301;
        PayrollM: report 17309;
        PurchaseOrder: Record "Purchase Header";
        RFQHeader: Record "Purchase Quote Header";
        ImprestSurrender: Record "Purchase Header";
        PayrollKe: Record Payroll;
        PayrollMa: Record "Payroll M";
        PayrollTransK: Record "Payroll Monthly Trans_AU";
        PayrollTransM: Record "Payroll Monthly Trans_Malawi";
        Emprequisition: Record "HR Employee Requisitions";
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        purchaseheader.Reset;
        purchaseheader.SetRange("No.", documentNo);
        if purchaseheader.Find('-') then begin
            if purchaseheader."AU Form Type" = purchaseheader."AU Form Type"::"Purchase Requisition" then begin
                PurchaseReqReport.SetTableView(purchaseheader);
                TempBlob.CreateOutStream(StatementOutstream);
                if PurchaseReqReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                    TempBlob.CreateInStream(StatementInstream);
                    Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
                end;
            end;
            if purchaseheader."AU Form Type" = purchaseheader."AU Form Type"::"Imprest Requisition" then begin
                ImprestReports.SetTableView(purchaseheader);
                TempBlob.CreateOutStream(StatementOutstream);
                if ImprestReports.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                    TempBlob.CreateInStream(StatementInstream);
                    Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
                end;
            end;

            if purchaseheader."AU Form Type" = purchaseheader."AU Form Type"::"Claim Voucher" then begin
                ClaimsVoucher.SetTableView(purchaseheader);
                TempBlob.CreateOutStream(StatementOutstream);
                if ClaimsVoucher.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                    TempBlob.CreateInStream(StatementInstream);
                    Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
                end;
            end;


            if purchaseheader."AU Form Type" = purchaseheader."AU Form Type"::"Payment Voucher" then begin
                PVReport.SetTableView(purchaseheader);
                TempBlob.CreateOutStream(StatementOutstream);
                if PVReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                    TempBlob.CreateInStream(StatementInstream);
                    Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
                end;
            end;

            if purchaseheader."Document Type" = purchaseheader."Document Type"::Order then begin
                LPOReport.SetTableView(purchaseheader);
                TempBlob.CreateOutStream(StatementOutstream);
                if LPOReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                    TempBlob.CreateInStream(StatementInstream);
                    Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
                end;
            end;

        end;

        RFQHeader.reset;
        RFQHeader.setrange("no.", documentNo);
        if RFQHeader.find('-') then begin
            //Error('Test');
            RFQReport.SetTableView(RFQHeader);
            TempBlob.CreateOutStream(StatementOutstream);
            if RFQReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;
        Emprequisition.reset;
        Emprequisition.setrange("Requisition No.", documentNo);
        if Emprequisition.find('-') then begin
            //Error('Test');
            EmpReqReport.SetTableView(Emprequisition);
            TempBlob.CreateOutStream(StatementOutstream);
            if EmpReqReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;
        PayrollKe.reset;
        PayrollKe.setrange("Document No", documentNo);
        if PayrollKe.find('-') then begin
            PayrollTransK.reset;
            PayrollTransK.setrange("Payroll Period", PayrollKe."Payroll Period.");
            if PayrollTransK.Find('-') then begin
                //Error('Test');
                PayrollK.SetTableView(PayrollTransK);
                TempBlob.CreateOutStream(StatementOutstream);
                if PayrollK.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                    TempBlob.CreateInStream(StatementInstream);
                    Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
                end;
            end;
        end;
        PayrollMa.reset;
        PayrollMa.setrange("Document No", documentNo);
        if PayrollMa.find('-') then begin
            PayrollTransM.reset;
            PayrollTransM.setrange("Payroll Period", PayrollMa."Payroll Period.");
            if PayrollTransM.Find('-') then begin
                //Error('Test');
                PayrollM.SetTableView(PayrollTransM);
                TempBlob.CreateOutStream(StatementOutstream);
                if PayrollM.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                    TempBlob.CreateInStream(StatementInstream);
                    Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
                end;
            end;
        end;
        // PayrollMa.reset;
        // PayrollMa.setrange("Document No", documentNo);
        // if PayrollMa.find('-') then begin
        //     //Error('Test');
        //     PayrollM.SetTableView(PayrollMa);
        //     TempBlob.CreateOutStream(StatementOutstream);
        //     if PayrollM.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
        //         TempBlob.CreateInStream(StatementInstream);
        //         Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
        //     end;
        // end;
        ImprestSurrender.reset;
        ImprestSurrender.setrange("no.", documentNo);
        ImprestSurrender.setrange("AU Form Type", ImprestSurrender."AU Form Type"::"Imprest Accounting");
        if ImprestSurrender.find('-') then begin
            ImprestSurrenderReport.SetTableView(ImprestSurrender);
            TempBlob.CreateOutStream(StatementOutstream);
            if ImprestSurrenderReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;

        TimesheetHeaderNew.RESET;
        TimesheetHeaderNew.SETRANGE("Timesheet Header No", documentNo);
        IF TimesheetHeaderNew.FIND('-') THEN begin
            TimesheetReport.SetTableView(TimesheetHeaderNew);
            TempBlob.CreateOutStream(StatementOutstream);
            if TimesheetReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;


        Leave.RESET;
        Leave.SETRANGE("Application Code", documentNo);
        IF Leave.FIND('-') THEN begin
            LeaveReport.SetTableView(Leave);
            TempBlob.CreateOutStream(StatementOutstream);
            if LeaveReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;

        GoNoGoDec.RESET;
        GoNoGoDec.SETRANGE(Code, documentNo);
        IF GoNoGoDec.FIND('-') THEN begin
            GoNoGoReport.SetTableView(GoNoGoDec);
            TempBlob.CreateOutStream(StatementOutstream);
            if GoNoGoReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;

        Proposal.RESET;
        Proposal.SETRANGE(Code, documentNo);
        IF Proposal.FIND('-') THEN begin
            ProposalReport.SetTableView(Proposal);
            TempBlob.CreateOutStream(StatementOutstream);
            if ProposalReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;
    end;






    // procedure fnGetApprovalDocuments(documentNo: Code[40]; var BigText: BigText)
    // var
    //     Filename: Text[100];
    //     Convert: dotnet Convert;
    //     _File: dotnet File;
    //     FileAccess: dotnet FileAccess;
    //     FileMode: dotnet FileMode;
    //     MemoryStream: dotnet MemoryStream;
    //     FileStream: DotNet FileStream;
    //     Outputstream: OutStream;
    // begin
    //     Filename := path;
    //     purchaseheader.Reset;
    //     purchaseheader.SetRange("No.", documentNo);
    //     _File.Delete(Filename);
    //     if purchaseheader.Find('-') then begin
    //         if (purchaseheader.IM = true) then Report.SaveAsPdf(80055, Filename, purchaseheader);

    //         if (purchaseheader.SR = true) then Report.SaveAsPdf(80052, Filename, purchaseheader);

    //         if (purchaseheader.IM = true) and (purchaseheader.SR = true) then Report.SaveAsPdf(80041, Filename, purchaseheader);

    //         if purchaseheader.PR = true then Report.SaveAsPdf(80024, Filename, purchaseheader);

    //         if purchaseheader."Document Type" = purchaseheader."document type"::Order then Report.SaveAsPdf(80025, Filename, purchaseheader);
    //         if (purchaseheader.MP = true) and (purchaseheader.SR = false) then Report.SaveAsPdf(80043, Filename, purchaseheader);
    //         if (purchaseheader.MP = true) and (purchaseheader.SR = true) then Report.SaveAsPdf(80043, Filename, purchaseheader);
    //         if (purchaseheader.MP = false) and (purchaseheader.SR = false) and (purchaseheader.PR = false) then Report.SaveAsPdf(80056, Filename, purchaseheader);
    //         begin



    //         end;

    //     end;
    // end;

    procedure CreateTimeSheets(No: Code[50]; StartDate: Date; Weeks: Integer)
    var
        Resource: Record Resource;
        IsHandled: Boolean;
        TimeSheet: Report "Create Time Sheets";
    begin
        IsHandled := false;

        Resource.Get(No);
        Resource.SetRecFilter();
        REPORT.RunModal(REPORT::"Create Time Sheets", true, false, Resource);
    end;

    procedure GenerateRequestForm(documentNo: Code[40]; var BigText: BigText; path: Text)
    var
        PurchaseHeader: Record "Purchase Header";
        Filename: Text[100];
        Convert: dotnet Convert;
        _File: dotnet File;
        FileAccess: dotnet FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: DotNet FileStream;
        Outputstream: OutStream;
        Buffer: List of [Byte];
        InStream: InStream;
        OutStream: OutStream;
        Base64: Codeunit "Base64 Convert";
        TextBuilder: DotNet StringBuilder;
        ByteValue: Byte;
    begin
        Filename := path;
        PurchaseHeader.Reset;
        PurchaseHeader.SetRange("No.", documentNo);
        if PurchaseHeader.Find('-') then begin
            _File.Delete(Filename);
            Report.SaveAsPdf(50000, Filename, PurchaseHeader);
            begin


                exit;
            end;

        end;
    end;

    procedure GeneratePurchaseReqReport(documentNo: Code[40]; var Base64Txt: Text)
    var
        PurchaseHeader: Record "Purchase Header";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        PurchaseReport: Report 80024;
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        PurchaseHeader.Reset;
        PurchaseHeader.SetRange("No.", documentNo);
        if PurchaseHeader.Find('-') then begin
            PurchaseReport.SetTableView(purchaseheader);
            TempBlob.CreateOutStream(StatementOutstream);
            if PurchaseReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;
    end;

    procedure FnAgingReport(documentNo: Code[40]; var Base64Txt: Text)
    var
        Customer: Record Customer;
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        ImprestReport: Report 104;
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        Customer.Reset;
        Customer.SetRange("No.", documentNo);
        if Customer.Find('-') then begin
            ImprestReport.SetTableView(purchaseheader);
            TempBlob.CreateOutStream(StatementOutstream);
            if ImprestReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;
    end;

    procedure GenerateClaimReport(documentNo: Code[40]; var Base64Txt: Text)
    var
        PurchaseHeader: Record "Purchase Header";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        ClaimReport: Report 50089;

    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        PurchaseHeader.Reset;
        PurchaseHeader.SetRange("No.", documentNo);
        if PurchaseHeader.Find('-') then begin
            ClaimReport.SetTableView(purchaseheader);
            TempBlob.CreateOutStream(StatementOutstream);
            if ClaimReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;
    end;

    procedure GenerateExitForm(documentNo: Code[40]; var Base64Txt: Text)
    var
        ExitInterview: Record "Exit Interviews";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        ExitReport: Report 80100;

    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        ExitInterview.Reset;
        ExitInterview.SetRange("Application Code", documentNo);
        if ExitInterview.Find('-') then begin
            ExitReport.SetTableView(ExitInterview);
            TempBlob.CreateOutStream(StatementOutstream);
            if ExitReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;
    end;

    procedure FnGenerateImprestReport(documentNo: Code[40]; var Base64Txt: Text)
    var
        PurchaseHeader: Record "Purchase Header";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        ImprestReport: Report 80055;
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        PurchaseHeader.Reset;
        PurchaseHeader.SetRange("No.", documentNo);
        PurchaseHeader.SetRange(IM, true);
        if PurchaseHeader.Find('-') then begin
            ImprestReport.SetTableView(purchaseheader);
            TempBlob.CreateOutStream(StatementOutstream);
            if ImprestReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end;

    procedure FnGenerateTimesheetSummaryReport(StaffNo: Code[40]; StartDate: Date; EndDate: Date; Project: code[200]; var Base64Txt: Text)
    var
        TimesheetLines: Record "Timesheet Lines";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TimesheetSheetReport: Report 50063;
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        TimesheetLines.Reset;
        TimesheetLines.SetRange("Staff No", StaffNo);
        TimesheetLines.SetFilter(Date, '%1..%2', StartDate, EndDate);
        if project <> '' then begin
            TimesheetLines.SetRange(Project, Project);
        end;
        TimesheetLines.SetFilter(Date, '%1..%2', StartDate, EndDate);
        if TimesheetLines.Find('-') then begin
            TimesheetSheetReport.SetTableView(TimesheetLines);
            TempBlob.CreateOutStream(StatementOutstream);
            if TimesheetSheetReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end;

    procedure FnGenerateTimesheetSummaryReport1(StaffNo: Code[40]; StartDate: Date; EndDate: Date; Project: code[200]; var Base64Txt: Text)
    var
        TimesheetLines: Record "Timesheet Lines";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TimesheetSheetReport: Report 50063;
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        TimesheetLines.Reset;
        TimesheetLines.SetRange("Staff No", StaffNo);
        if project <> '' then begin
            TimesheetLines.SetRange(Project, Project);
        end;
        TimesheetLines.SetFilter(Date, '%1..%2', StartDate, EndDate);
        if TimesheetLines.Find('-') then begin
            TimesheetSheetReport.SetTableView(TimesheetLines);
            TempBlob.CreateOutStream(StatementOutstream);
            if TimesheetSheetReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end;

    procedure FnGenerateTimesheetSummaryReportSmt(StaffNo: Code[40]; StartDate: Date; EndDate: Date; Staff: Code[30]; var Base64Txt: Text)
    var
        TimesheetLines: Record "Timesheet Lines";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TimesheetSheetReport: Report 50066;
        TimesheetHeaders: record "Timesheet Header";
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        if HREmployees.Get(StaffNo) then
            TimesheetHeaders.reset;
        TimesheetHeaders.SetRange("SMT Lead", HREmployees."Employee UserID");
        if TimesheetHeaders.FindFirst() then begin
            TimesheetLines.Reset;
            TimesheetLines.SetRange("Staff No", Staff);
            TimesheetLines.SetFilter(Date, '%1..%2', StartDate, EndDate);
            if TimesheetLines.Find('-') then begin
                TimesheetSheetReport.SetTableView(TimesheetHeaders);
                TimesheetSheetReport.SetTableView(TimesheetLines);
                TempBlob.CreateOutStream(StatementOutstream);
                if TimesheetSheetReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                    TempBlob.CreateInStream(StatementInstream);
                    Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
                end;
            end;

        end;
    end;

    procedure FnGetIfSmt(No: Code[30]) smt: boolean
    var
    begin
        smt := false;
        HREmployees.RESET;
        HREmployees.SetRange("No.", No);
        if HREmployees.find('-') then begin
            objHREmployees.RESET;
            objHREmployees.setrange("SMT Lead", HREmployees."Employee UserID");
            if objHREmployees.find('-') then begin
                smt := true;
                exit(smt);
            end;
        end
    end;

    procedure FnGetIFLineManager(No: Code[30]) smt: boolean
    var
    begin
        smt := false;
        HREmployees.RESET;
        HREmployees.SetRange("No.", No);
        if HREmployees.find('-') then begin
            objHREmployees.RESET;
            objHREmployees.setrange("Supervisor ID", HREmployees."Employee UserID");
            if objHREmployees.find('-') then begin
                smt := true;
                exit(smt);
            end;
        end
    end;

    procedure FnGenerateTimesheetSummaryReportLinem(StaffNo: Code[40]; StartDate: Date; EndDate: Date; var Base64Txt: Text)
    var
        TimesheetLines: Record "Timesheet Lines";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TimesheetSheetReport: Report 50065;
        TimesheetHeaders: record "Timesheet Header";
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        if HREmployees.Get(StaffNo) then
            TimesheetHeaders.reset;
        TimesheetHeaders.SetRange("Line Manager", HREmployees."Employee UserID");
        if TimesheetHeaders.FindFirst() then begin
            TimesheetLines.Reset;
            TimesheetLines.SetFilter(Date, '%1..%2', StartDate, EndDate);
            if TimesheetLines.Find('-') then begin
                TimesheetSheetReport.SetTableView(TimesheetHeaders);
                TimesheetSheetReport.SetTableView(TimesheetLines);
                TempBlob.CreateOutStream(StatementOutstream);
                if TimesheetSheetReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                    TempBlob.CreateInStream(StatementInstream);
                    Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
                end;
            end;

        end;
    end;

    procedure FnGenerateTimesheetActivityReport(StaffNo: Code[40]; StartDate: Date; EndDate: Date; Project: code[200]; var Base64Txt: Text)
    var
        TimesheetLines: Record "Timesheet Lines";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TimesheetSheetReport: Report 50064;
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        TimesheetLines.Reset;
        TimesheetLines.SetRange("Staff No", StaffNo);
        TimesheetLines.SetRange(Project, Project);
        TimesheetLines.SetFilter(Date, '%1..%2', StartDate, EndDate);
        if TimesheetLines.Find('-') then begin
            TimesheetSheetReport.SetTableView(TimesheetLines);
            TempBlob.CreateOutStream(StatementOutstream);
            if TimesheetSheetReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end;

    procedure FnGenerateTimesheetSummarySMTReport(StaffNo: Code[40]; StartDate: Date; EndDate: Date; var Base64Txt: Text)
    var
        TimesheetHeader: Record "Timesheet Header";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TimesheetSheetReport: Report 50066;
    begin
        TimesheetHeader.Reset;
        TimesheetHeader.SetRange("SMT Lead", StaffNo);

        if TimesheetHeader.Find('-') then begin

            TimesheetSheetReport.SetTableView(TimesheetHeader);
            TempBlob.CreateOutStream(StatementOutstream);
            if TimesheetSheetReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end;

    procedure FnGenerateAppraisalReport(documentNo: Code[40]; var Base64Txt: Text)
    var
        AppraisalHeader: Record "HR Appraisal Header";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        AppraisalReport: Report 50077;
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        AppraisalHeader.Reset;
        AppraisalHeader.SetRange("No.", documentNo);
        if AppraisalHeader.Find('-') then begin
            AppraisalReport.SetTableView(AppraisalHeader);
            TempBlob.CreateOutStream(StatementOutstream);
            if AppraisalReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end;

    procedure FnTimesheetReport(No: Code[20]; StartDate: Date; VAR BigText: Text)
    var
        PurchaseHeader: Record "Purchase Header";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        ImprestReport: Report 50060;
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        TimesheetHeaderNew.RESET;
        TimesheetHeaderNew.SETRANGE("Timesheet Header No", No);
        IF TimesheetHeaderNew.FIND('-') THEN
            ImprestReport.SetTableView(TimesheetHeaderNew);
        TempBlob.CreateOutStream(StatementOutstream);
        if ImprestReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
            TempBlob.CreateInStream(StatementInstream);
            BigText := Base64Convert.ToBase64(StatementInstream, true);
        end;
    end;

    Procedure CheckIfExists(No: Code[250]; Date: Date; Narration: Text) EntryNo: Integer
    var
    begin
        EntryNo := 0;
        TimesheetLinesNew.Reset();
        TimesheetLinesNew.SetRange("Timesheet No", No);
        TimesheetLinesNew.SetRange(Date, Date);
        TimesheetLinesNew.SetRange(TimesheetLinesNew.Narration, Narration);
        if TimesheetLinesNew.Find('-') then begin
            EntryNo := TimesheetLinesNew.Entry;
        end;
        exit(EntryNo);

    end;

    Procedure GetEntryNo(No: Code[250]; Date: Date; Project: Code[250]; Narration: Text) EntryNo: Integer
    var
    begin
        EntryNo := 0;
        TimesheetLinesNew.Reset();
        TimesheetLinesNew.SetRange("Timesheet No", No);
        TimesheetLinesNew.SetRange(Date, Date);
        TimesheetLinesNew.SetRange(TimesheetLinesNew.Project, Project);
        TimesheetLinesNew.SetRange(TimesheetLinesNew.Narration, Narration);
        if TimesheetLinesNew.Find('-') then begin
            EntryNo := TimesheetLinesNew.Entry;
        end;

        exit(EntryNo);

    end;

    procedure fnRejectApprovalRequest(DocumentNumber: Code[50]; ApproverId: Code[100]; comments: Text)
    var
        HRLeaveAppln: Record "HR Leave Application";
        ApprovalEntry: Record "Approval Entry";
    begin

        objHREmployees.Reset();
        objHREmployees.SetRange("No.", ApproverId);
        if objHREmployees.Find('-') then begin
            ObjApprovalEntries.Reset;
            ObjApprovalEntries.SetRange(ObjApprovalEntries."Approver ID", objHREmployees."Employee UserID");
            ObjApprovalEntries.SetRange(ObjApprovalEntries."Document No.", DocumentNumber);
            ObjApprovalEntries.SetRange(ObjApprovalEntries.Status, ObjApprovalEntries.Status::Open);
            if ObjApprovalEntries.FindLast then begin
                ObjApprovalEntries.Comments := comments;
                ObjApprovalEntries.Modify;
                if (not objHRLeaveApplication.Get(DocumentNumber)) then begin
                    purchaseheader.Reset();
                    purchaseheader.SetRange("No.", DocumentNumber);
                    purchaseheader.SetRange(purchaseheader."Document Type", purchaseheader."Document Type"::Quote);
                    if purchaseheader.find('-') then begin
                        purchaseheader.Status := purchaseheader.Status::Open;
                        purchaseheader.Modify();
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange("Document No.", DocumentNumber);
                        if ApprovalEntry.FindSet() then begin
                            repeat
                                ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
                                ApprovalEntry.Modify;
                            until ApprovalEntry.Next() = 0;

                        end;
                    end else begin
                        CUApprovalMgt.RejectApprovalRequests(ObjApprovalEntries);
                    end;

                end else begin
                    objHRLeaveApplication.Status := objHRLeaveApplication.Status::New;
                    objHRLeaveApplication.Modify();
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Document No.", DocumentNumber);
                    if ApprovalEntry.FindSet() then begin
                        repeat
                            ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
                            ObjApprovalEntries.Comments := comments;
                            ApprovalEntry.Modify;
                        until ApprovalEntry.Next() = 0;

                    end else begin
                        CUApprovalMgt.RejectApprovalRequests(ObjApprovalEntries);
                    end;
                end;


            end;
        end;
    end;

    Procedure GetEntryNos(No: Code[250]; Date: Date; Project: Code[250]; Narration: Text) EntryNo: Integer
    var
    begin
        EntryNo := 0;
        TimesheetLinesNew.Reset();
        TimesheetLinesNew.SetRange("Timesheet No", No);
        TimesheetLinesNew.SetRange(Date, Date);
        //TimesheetLinesNew.SetRange(TimesheetLinesNew.Project, Project);
        TimesheetLinesNew.SetRange(TimesheetLinesNew.Narration, Narration);
        if TimesheetLinesNew.Find('-') then begin
            EntryNo := TimesheetLinesNew.Entry;
        end;

        exit(EntryNo);

    end;

    Procedure GetNarration(No: Code[250]; Date: Date; Project: Code[250]) Narration: text
    var
    begin
        Narration := '';
        TimesheetLinesNew.Reset();
        TimesheetLinesNew.SetRange("Timesheet No", No);
        TimesheetLinesNew.SetRange(Date, Date);
        TimesheetLinesNew.SetRange(TimesheetLinesNew.Project, Project);
        if TimesheetLinesNew.Find('-') then begin
            Narration := TimesheetLinesNew.Narration;
        end;
        exit(Narration);

    end;

    Procedure CheckIfProjectExists(No: Code[250]; Date: Date; Project: Code[250]) EntryNo: Integer
    var
    begin
        EntryNo := 0;
        TimesheetLinesNew.Reset();
        TimesheetLinesNew.SetRange("Timesheet No", No);
        TimesheetLinesNew.SetRange(Date, Date);
        TimesheetLinesNew.SetRange(TimesheetLinesNew.Project, Project);
        if TimesheetLinesNew.Find('-') then begin
            EntryNo := TimesheetLinesNew.Entry;
        end;
        exit(EntryNo);

    end;

    procedure FnGenerateImprestSurrenderReport(documentNo: Code[40]; var Base64Txt: Text)
    var
        PurchaseHeader: Record "Purchase Header";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        ImprestSurrenderReport: Report 80052;
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        PurchaseHeader.Reset;
        PurchaseHeader.SetRange("No.", documentNo);
        PurchaseHeader.SetRange(SR, true);
        if PurchaseHeader.Find('-') then begin
            ImprestSurrenderReport.SetTableView(purchaseheader);
            TempBlob.CreateOutStream(StatementOutstream);
            if ImprestSurrenderReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;


        end;
    end;

    procedure GenerateLeaveReport(documentNo: Code[40]; var Base64Txt: Text)
    var
        Leave: Record "HR Leave Application";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        LeaveReport: Report 80075;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        Leave.Reset;
        Leave.SetRange(Leave."Application Code", documentNo);
        if Leave.Find('-') then begin
            LeaveReport.SetTableView(Leave);
            TempBlob.CreateOutStream(StatementOutstream);
            if LeaveReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end;

    procedure GenerateRFQReport(documentNo: Code[40]; var Base64Txt: Text)
    var
        RFQ: Record "Purchase Quote Header";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        RFQReport: Report 17366;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        RFQ.Reset;
        RFQ.SetRange(RFQ."No.", documentNo);
        if RFQ.Find('-') then begin
            RFQReport.SetTableView(RFQ);
            TempBlob.CreateOutStream(StatementOutstream);
            if RFQReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;

        end;
    end;




    //Timesheet
    Procedure fnInsertTimeSheet(FromDate: Date; ToDate: Date; employee: Code[50]) No: Code[10]
    var
    begin

        objHREmployees.Reset();
        objHREmployees.SetRange("No.", employee);
        if objHREmployees.Find('-') then
            TimesheetHeaderNew.RESET;
        TimesheetHeaderNew.SETRANGE("Start Date", FromDate);
        TimesheetHeaderNew.SETRANGE("Staff No", employee);
        IF TimesheetHeaderNew.FINDFIRST THEN BEGIN
            ERROR('you have already created timesheet for this month %1 Timesheet No %2', FromDate, TimesheetHeaderNew."Timesheet Header No");
        END ELSE
            TimesheetHeaderNew.INIT;
        TimesheetHeaderNew."Staff No" := objHREmployees."No.";
        TimesheetHeaderNew."Staff Name" := objHREmployees."First Name" + ' ' + objHREmployees."Middle Name" + ' ' + objHREmployees."Last Name";
        TimesheetHeaderNew."Start Date" := FromDate;
        TimesheetHeaderNew."End Date" := ToDate;
        TimesheetHeaderNew."Timesheet Status" := TimesheetHeaderNew."Timesheet Status"::Open;
        TimesheetHeaderNew."Line Manager" := objHREmployees."Supervisor ID";
        TimesheetHeaderNew."SMT Lead" := objHREmployees."SMT Lead";
        TimesheetHeaderNew."Human Resource manager" := objHREmployees."HR Manager";
        IF TimesheetHeaderNew.INSERT(TRUE) THEN
            No := TimesheetHeaderNew."Timesheet Header No";
        EXIT(No);
    END;

    Procedure fnInsertTimeSheetLines(Project: Code[250]; WorkPlan: Code[250]; Activity
    : Code[250]; Narration: Text; Date: Date; Hours: Decimal; No: Code[50]; EmployeeNo: Code[100]; Entry: Integer)
    var
        WorkPlanHeader: Record 170125;
        ActivitySetup: Record 170126;
        ObjDimensionValue: Record "Dimension Value";
    begin
        IF TimesheetHeaderNew.GET(No) THEN
            TimesheetLinesNew.Reset();
        TimesheetLinesNew.SetRange("Timesheet No", No);
        TimesheetLinesNew.SetRange(Project, Project);
        TimesheetLinesNew.SetRange(Date, Date);
        TimesheetLinesNew.SetRange(Narration, Narration);
        if TimesheetLinesNew.Find('-') then begin
        end else
            //check if date is greater than header end date
            //  if (Date > TimesheetHeaderNew."End Date") then begin
            //  end else
            TimesheetLinesNew.INIT;
        TimesheetLinesNew."Timesheet No" := No;
        TimesheetLinesNew.FieldName := Narration;
        TimesheetLinesNew.Date := Date;
        TimesheetLinesNew."Creatin Date" := Today;
        TimesheetLinesNew."Staff No" := TimesheetHeaderNew."Staff No";
        TimesheetLinesNew."Staff Name" := TimesheetHeaderNew."Staff Name";
        TimesheetLinesNew.Project := Project;
        if (Project = 'LEAVE') then begin
            TimesheetLinesNew."Project decription" := 'Leave';
            TimesheetLinesNew."Workplan " := 'Leave';
            TimesheetLinesNew."Workplan Description" := 'Leave';
            TimesheetLinesNew."Activity Discription" := 'Leave';
            TimesheetLinesNew.Activity := 'Leave';
        end else
            if (Project = 'PUBLICHOLIDAY') then begin
                TimesheetLinesNew."Project decription" := 'Public Holiday';
                TimesheetLinesNew."Workplan " := 'Public Holiday';
                TimesheetLinesNew."Workplan Description" := 'Public Holiday';
                TimesheetLinesNew."Activity Discription" := 'Public Holiday';
                TimesheetLinesNew.Activity := 'Public Holiday';
            end else
                ObjDimensionValue.Reset();
        ObjDimensionValue.SetRange(ObjDimensionValue.Code, Project);
        if ObjDimensionValue.Find('-') then begin
            TimesheetLinesNew."Project decription" := ObjDimensionValue.Name;
            TimesheetLinesNew."Approver ID" := ObjDimensionValue."Approver ID";
        end;
        TimesheetLinesNew."Workplan " := WorkPlan;
        WorkPlanHeader.Reset();
        WorkPlanHeader.SetRange("Workplan Code", WorkPlan);
        if WorkPlanHeader.Find('-') then begin
            TimesheetLinesNew."Workplan Description" := WorkPlanHeader."Workplan Descption";
        end;
        if (WorkPlan = '') then begin
            TimesheetLinesNew."Workplan " := 'GENERAL';
            TimesheetLinesNew."Workplan Description" := 'GENERAL';
        end;

        TimesheetLinesNew.Activity := Activity;
        ActivitySetup.Reset();
        ActivitySetup.SetRange("Activity Code", Activity);
        if ActivitySetup.Find('-') then begin
            TimesheetLinesNew."Activity Discription" := ActivitySetup."Activity Description";
        end;
        if (Activity = '') then begin
            TimesheetLinesNew."Activity Discription" := 'GENERAL';
            TimesheetLinesNew.Activity := 'GENERAL';
        end;
        TimesheetLinesNew.Narration := Narration;
        TimesheetLinesNew.Hours := Hours;
        TimesheetLinesNew."Timesheet Status" := TimesheetLinesNew."Timesheet Status"::Open;
        IF TimesheetLinesNew.Hours > 0 THEN
            IF date <= TimesheetHeaderNew."End Date" THEN begin
                TimesheetLinesNew.Insert();
            end;
    END;


    Procedure fnModifyTimeSheetLines(Project: Code[250]; WorkPlan: Code[250]; Activity: Code[250]; Narration: Text; Date: Date; Hours: Decimal; No: Code[50]; EmployeeNo: Code[100]; Entry: Integer)
    var
        WorkPlanHeader: Record 170125;
        ActivitySetup: Record 170126;
        ObjDimensionValue: Record "Dimension Value";
    begin
        IF TimesheetHeaderNew.GET(No) THEN
            //check if date is greater than header end date
            if (Date > TimesheetHeaderNew."End Date") then begin
            end else
                TimesheetLinesNew.Reset();
        TimesheetLinesNew.SetRange("Timesheet No", No);
        TimesheetLinesNew.SetRange(Entry, Entry);
        TimesheetLinesNew.SetRange(Date, Date);
        if TimesheetLinesNew.Find('-') then begin
            TimesheetLinesNew."Timesheet No" := No;
            TimesheetLinesNew.Entry := Entry;
            TimesheetLinesNew.Date := Date;
            TimesheetLinesNew."Creatin Date" := Today;
            TimesheetLinesNew."Staff No" := TimesheetHeaderNew."Staff No";
            TimesheetLinesNew."Staff Name" := TimesheetHeaderNew."Staff Name";
            TimesheetLinesNew.Project := Project;
            if (Project = 'LEAVE') then begin
                TimesheetLinesNew."Project decription" := 'Leave';
                TimesheetLinesNew."Workplan " := 'Leave';
                TimesheetLinesNew."Workplan Description" := 'Leave';
                TimesheetLinesNew."Activity Discription" := 'Leave';
                TimesheetLinesNew.Activity := 'Leave';
            end else
                if (Project = 'PUBLICHOLIDAY') then begin
                    TimesheetLinesNew."Project decription" := 'Public Holiday';
                    TimesheetLinesNew."Workplan " := 'Public Holiday';
                    TimesheetLinesNew."Workplan Description" := 'Public Holiday';
                    TimesheetLinesNew."Activity Discription" := 'Public Holiday';
                    TimesheetLinesNew.Activity := 'Public Holiday';
                end else begin
                    ObjDimensionValue.Reset();
                    ObjDimensionValue.SetRange(ObjDimensionValue.Code, Project);
                    if ObjDimensionValue.Find('-') then begin
                        TimesheetLinesNew."Project decription" := ObjDimensionValue.Name;
                        TimesheetLinesNew."Approver ID" := ObjDimensionValue."Approver ID";
                    end;
                    TimesheetLinesNew."Workplan " := WorkPlan;
                    WorkPlanHeader.Reset();
                    WorkPlanHeader.SetRange("Workplan Code", WorkPlan);
                    if WorkPlanHeader.Find('-') then begin
                        TimesheetLinesNew."Workplan Description" := WorkPlanHeader."Workplan Descption";
                    end;
                    if (WorkPlan = '') then begin
                        TimesheetLinesNew."Workplan " := 'GENERAL';
                        TimesheetLinesNew."Workplan Description" := 'GENERAL';
                    end;


                    TimesheetLinesNew.Activity := Activity;
                    ActivitySetup.Reset();
                    ActivitySetup.SetRange("Activity Code", Activity);
                    if ActivitySetup.Find('-') then begin
                        TimesheetLinesNew."Activity Discription" := ActivitySetup."Activity Description";
                    end;
                    if (Activity = '') then begin
                        TimesheetLinesNew."Activity Discription" := 'GENERAL';
                        TimesheetLinesNew.Activity := 'GENERAL';
                    end;
                end;
            TimesheetLinesNew.Narration := Narration;
            TimesheetLinesNew.FieldName := Narration;
            TimesheetLinesNew.Hours := Hours;
            TimesheetLinesNew."Timesheet Status" := TimesheetLinesNew."Timesheet Status"::Open;
            ///IF TimesheetLinesNew.Hours > 0 THEN COMMENTED THIS TO SORT DELETION OF FIELD VALUE..DO NOT UNCOMMENT
            IF date <= TimesheetHeaderNew."End Date" THEN begin
                TimesheetLinesNew.Modify();
            end;
        END;
    end;

    procedure DeleteTimesheetRec(TimesheetDate: Date; EntryNo: Integer; TimeSheetCode: Code[250]) Deleted: Boolean
    var
    begin
        Deleted := false;
        TimesheetLinesNew.Reset();
        TimesheetLinesNew.SetRange(Date, TimesheetDate);
        TimesheetLinesNew.SetRange(TimesheetLinesNew.Entry, EntryNo);
        TimesheetLinesNew.SetRange("Timesheet No", TimeSheetCode);
        if TimesheetLinesNew.Find('-') then begin
            TimesheetLinesNew.DeleteAll();
            Deleted := true;
            exit(Deleted);
        end;
    end;

    procedure DeleteTimesheetLine(TimeSheetCode: Code[250]; Project: Code[250]; EmpNo: Code[250]; Narration: Text) Deleted: Boolean
    var
    begin
        Deleted := false;

        TimesheetLinesNew.Reset();
        TimesheetLinesNew.SetRange(Project, Project);
        //TimesheetLinesNew.SetRange("Staff No", EmpNo);
        TimesheetLinesNew.SetRange("Timesheet No", TimeSheetCode);
        TimesheetLinesNew.SetRange(Narration, Narration);
        if TimesheetLinesNew.FindSet() then begin
            repeat
                TimesheetLinesNew.DeleteAll();
            until TimesheetLinesNew.Next = 0;
            Deleted := true;
            exit(Deleted);
        end;
    end;

    procedure FnDeleteTimesheetLine(Project: Code[250]; EmpNo: Code[250]) Deleted: Boolean
    var
    begin
        Deleted := FALSE;
        TimesheetLinesNew.Reset();
        TimesheetLinesNew.SetRange("Staff No", EmpNo);
        TimesheetLinesNew.SetRange("Project", Project);
        if TimesheetLinesNew.Find('-') then begin
            TimesheetLinesNew.DeleteAll();
            Deleted := TRUE;
            EXIT(Deleted);
        end;
    end;


    Procedure fnModifyTimeSheet(FromDate: Date; ToDate: Date; employee: Code[50]; DocNo: Code[100]) No: Code[10]
    var
    begin
        objHREmployees.Reset();
        objHREmployees.SetRange("No.", employee);
        if objHREmployees.Find('-') then
            TimesheetLinesHeader.RESET;
        TimesheetLinesHeader.SETRANGE(Timesheetcode, DocNo);
        IF TimesheetLinesHeader.FIND('-') THEN BEGIN
            TimesheetLinesHeader."Employee No" := objHREmployees."No.";
            TimesheetLinesHeader."Employee Name" := objHREmployees."First Name" + ' ' + objHREmployees."Middle Name" + ' ' + objHREmployees."Last Name";
            TimesheetLinesHeader.From := FromDate;
            TimesheetLinesHeader."To Date" := ToDate;
            TimesheetLinesHeader."Supervisor ID" := objHREmployees."Supervisor ID";
            IF TimesheetLinesHeader.MODIFY(TRUE) THEN
                No := TimesheetLinesHeader.Timesheetcode;
            EXIT(No);
        END;
    END;

    procedure SENDEMAILApproval(email: text; message: Text): Boolean;
    var
        smtp: Codeunit Email;
        smtpsetup: Codeunit "Email Message";
    begin

        smtpsetup.Create(email, 'AFIDEP Timesheet Approval', message, true);
        smtp.Send(smtpsetup);

        exit(true);
    end;

    Procedure fnTimesheetApproval(no: Code[50])
    var
        Message: text;
        Approval: record "Timesheet Lines";
        MessageFormatterd: Text;
    begin
        TimesheetLinesNew.RESET;
        TimesheetLinesNew.SETRANGE(TimesheetLinesNew."Timesheet No", no);
        //TimesheetLinesNew.SetFilter(TimesheetLinesNew.Project, '<>%1,<>%2', 'LEAVE|PUBLICHOLIDAY');
        IF TimesheetLinesNew.FindSet() THEN BEGIN
            repeat
                MessageFormatterd := '';
                Message := '';
                // Approval.Reset();
                // Approval.SetRange("Timesheet No", TimesheetLinesNew."Timesheet No");
                // Approval.SetRange(Project, TimesheetLinesNew.Project);
                // Approval.SetRange("Approval Email Sent", false);
                // Approval.SetRange("Timesheet Status", Approval."Timesheet Status"::Open);
                // if Approval.FindSet() then begin
                //     repeat
                // if Approval."Approval Email Sent" = false then begin
                //     Message := 'Approval for timesheet of %1 (No. %2) requires your attention.';
                //     MessageFormatterd := StrSubstNo(Message, TimesheetHeaderNew."Staff Name", TimesheetHeaderNew."Timesheet Header No");
                //     HREmployees.Reset;
                //     HREmployees.SetRange("Employee UserID", Approval."Approver ID");
                //     if HREmployees.findset then begin
                //         repeat
                //             SENDEMAILApproval(HREmployees."Company E-Mail", MessageFormatterd);
                //         until HREmployees.Next() = 0;
                //     end;
                //     // Approval."Approval Email Sent" := true;
                //     Approval.ModifyAll("Approval Email Sent", true);
                //     Commit();
                //end;
                //     until Approval.next() = 0;
                // end;
                TimesheetLinesNew."Timesheet Status" := TimesheetLinesNew."Timesheet Status"::"Project Manager Approved";
                TimesheetLinesNew.ModifyAll("Timesheet Status", TimesheetLinesNew."Timesheet Status"::"Project Manager Approved");
                Commit();
            until TimesheetLinesNew.next() = 0;
            TimesheetHeaderNew.Reset();
            TimesheetHeaderNew.SetRange("Timesheet Header No", no);
            if TimesheetHeaderNew.FindFirst() then begin
                TimesheetHeaderNew."Timesheet Status" := TimesheetHeaderNew."Timesheet Status"::"Project Manager Approved";
                TimesheetHeaderNew."Date Submitted" := Today;
                TimesheetHeaderNew.Modify(true);
                TimesheetHeaderNew.ModifyAll("Timesheet Status", TimesheetHeaderNew."Timesheet Status"::"Project Manager Approved");
                Commit();

                //Reset to get approver email
                if CheckProjctManagerApprovalFullyApproved(TimesheetHeaderNew."Timesheet Header No") then
                    TimesheetHeaderNew."Timesheet Status" := TimesheetHeaderNew."Timesheet Status"::"Project Manager Approved";
                Message := 'Approval for timesheet of %1 (No. %2) requires your attention. Kindly ' +
                                     '<a href="https://bc.afidep.org:8090/">click here</a> to approve.';
                MessageFormatterd := StrSubstNo(Message, TimesheetHeaderNew."Staff Name", TimesheetHeaderNew."Timesheet Header No");
                HREmployees.Reset;
                HREmployees.SetRange("Employee UserID", TimesheetHeaderNew."Line Manager");
                if HREmployees.findset then begin
                    SENDEMAILApproval(HREmployees."Company E-Mail", MessageFormatterd)
                end;

            end;
        END;
        // TimesheetLinesNew.RESET;
        // TimesheetLinesNew.SETRANGE(TimesheetLinesNew."Timesheet No", no);
        // //TimesheetLinesNew.SetFilter(TimesheetLinesNew.Project, '%1,%2', 'LEAVE|PUBLICHOLIDAY');
        // IF TimesheetLinesNew.FindSet() THEN BEGIN
        //     repeat
        //         MessageFormatterd := '';
        //         Message := '';
        //         Approval.Reset();
        //         Approval.SetRange("Timesheet No", TimesheetLinesNew."Timesheet No");
        //         Approval.SetRange(Project, TimesheetLinesNew.Project);
        //         Approval.SetRange("Approval Email Sent", false);
        //         if Approval.FindSet() then begin
        //             repeat
        //                 if Approval."Approval Email Sent" = false then begin
        //                     Message := 'Approval for timesheet of %1 requires your attention.';
        //                     MessageFormatterd := StrSubstNo(Message, Approval."Staff Name");
        //                     HREmployees.Reset;
        //                     HREmployees.SetRange("supervisor ID", Approval."Approver ID");
        //                     if HREmployees.findset then begin
        //                         repeat
        //                             SENDEMAILApproval(HREmployees."Company E-Mail", MessageFormatterd);
        //                         until HREmployees.Next() = 0;
        //                     end;
        //                     // Approval."Approval Email Sent" := true;
        //                     Approval.ModifyAll("Approval Email Sent", true);
        //                     Commit();
        //                 end;
        //             until Approval.next() = 0;
        //         end;
        //         TimesheetLinesNew."Timesheet Status" := TimesheetLinesNew."Timesheet Status"::"Send Awaiting Approval";
        //         TimesheetLinesNew.ModifyAll("Timesheet Status", TimesheetLinesNew."Timesheet Status"::"Send Awaiting Approval");
        //         Commit();
        //     until TimesheetLinesNew.next() = 0;
        //     TimesheetHeaderNew.Reset();
        //     TimesheetHeaderNew.SetRange("Timesheet Header No", no);
        //     if TimesheetHeaderNew.FindFirst() then begin
        //         TimesheetHeaderNew."Timesheet Status" := TimesheetHeaderNew."Timesheet Status"::"Send Awaiting Approval";
        //         TimesheetHeaderNew.ModifyAll("Timesheet Status", TimesheetHeaderNew."Timesheet Status"::"Send Awaiting Approval");
        //         Commit();

        //         //Reset to get approver email

        //     end;
        // END;
    END;

    procedure PmTimesheetApproval(DocumentNo: Code[250]; Project: Code[250])
    var
        Message: text;
        Approval: record "Timesheet Lines";
        MessageFormatterd: Text;
    begin
        TimesheetLinesNew.RESET;
        TimesheetLinesNew.SETRANGE(TimesheetLinesNew."Timesheet No", DocumentNo);
        TimesheetLinesNew.SetRange(Project, Project);
        IF TimesheetLinesNew.FindSet() THEN BEGIN
            repeat
                TimesheetLinesNew."Timesheet Status" := TimesheetLinesNew."Timesheet Status"::"Project Manager Approved";
                TimesheetLinesNew.Modify(true);
            until TimesheetLinesNew.next() = 0;
            TimesheetHeaderNew.Reset();
            TimesheetHeaderNew.SetRange("Timesheet Header No", DocumentNo);
            if TimesheetHeaderNew.Find('-') then begin
                if CheckProjctManagerApprovalFullyApproved(TimesheetHeaderNew."Timesheet Header No") then
                    TimesheetHeaderNew."Timesheet Status" := TimesheetHeaderNew."Timesheet Status"::"Project Manager Approved";
                Message := 'Approval for timesheet of %1 (No. %2) requires your attention. Kindly ' +
                                     '<a href="https://bc.afidep.org:8090/">click here</a> to approve.';
                MessageFormatterd := StrSubstNo(Message, TimesheetHeaderNew."Staff Name", TimesheetHeaderNew."Timesheet Header No");
                HREmployees.Reset;
                HREmployees.SetRange("Employee UserID", TimesheetHeaderNew."Line Manager");
                if HREmployees.findset then begin
                    SENDEMAILApproval(HREmployees."Company E-Mail", MessageFormatterd)
                end;
                TimesheetHeaderNew."Line Manager Approved Date" := Today;
                TimesheetHeaderNew.Modify(true);

            end;





        end;
    end;

    procedure CheckProjctManagerApprovalFullyApproved(DocumentNo: Code[200]) Approved: Boolean;
    var
        ApprovalStatus: Option Open,"Send Awaiting Approval","Project Manager Approved","Line Manager Approved","SMT Lead Approved","HR Approved","Timesheet Rejected",Approved;
    begin
        TimesheetLinesNew.RESET;
        TimesheetLinesNew.SETRANGE(TimesheetLinesNew."Timesheet No", DocumentNo);
        TimesheetLinesNew.Setfilter(Project, '<>%1|<>%2', 'LEAVE', 'PUBLICHOLIDAY');
        //TimesheetLinesNew.SetRange("Timesheet Status",TimesheetLinesNew."Timesheet Status"::"Project Manager Approved");
        IF TimesheetLinesNew.FindSet() THEN BEGIN
            repeat
                if TimesheetLinesNew."Timesheet Status" = TimesheetLinesNew."Timesheet Status"::"Send Awaiting Approval" then begin
                    Approved := false
                end else
                    Approved := true;

            until TimesheetLinesNew.next() = 0;
        end;
        exit(Approved);
    end;

    procedure LineManagerTimesheetApproval(DocumentNo: Code[250])
    var
        Message: text;
        Approval: record "Timesheet Lines";
        MessageFormatterd: Text;
    begin
        TimesheetLinesNew.RESET;
        TimesheetLinesNew.SETRANGE(TimesheetLinesNew."Timesheet No", DocumentNo);
        IF TimesheetLinesNew.FindSet() THEN BEGIN
            repeat
                TimesheetLinesNew."Timesheet Status" := TimesheetLinesNew."Timesheet Status"::"Line Manager Approved";
                TimesheetLinesNew.Modify(true);
            until TimesheetLinesNew.next() = 0;
            TimesheetHeaderNew.Reset();
            TimesheetHeaderNew.SetRange("Timesheet Header No", DocumentNo);
            if TimesheetHeaderNew.Find('-') then begin
                TimesheetHeaderNew."Timesheet Status" := TimesheetHeaderNew."Timesheet Status"::"Line Manager Approved";
                Message := 'Approval for timesheet of %1 (No. %2) requires your attention. Kindly ' +
                                     '<a href="https://bc.afidep.org:8090/">click here</a> to approve.';
                MessageFormatterd := StrSubstNo(Message, TimesheetHeaderNew."Staff Name", TimesheetHeaderNew."Timesheet Header No");
                HREmployees.Reset;
                HREmployees.SetRange("Employee UserID", TimesheetHeaderNew."SMT Lead");
                if HREmployees.findset then begin
                    SENDEMAILApproval(HREmployees."Company E-Mail", MessageFormatterd)
                end;
                TimesheetHeaderNew."Line Manager Approved Date" := Today;
                TimesheetHeaderNew.Modify(true);
                Commit();
            end;
        end;
    end;

    procedure SMTTimesheetApproval(DocumentNo: Code[250])
    var
        Message: text;
        Approval: record "Timesheet Lines";
        MessageFormatterd: Text;
    begin
        TimesheetLinesNew.RESET;
        TimesheetLinesNew.SETRANGE(TimesheetLinesNew."Timesheet No", DocumentNo);
        IF TimesheetLinesNew.FindSet() THEN BEGIN
            repeat
                TimesheetLinesNew."Timesheet Status" := TimesheetLinesNew."Timesheet Status"::Approved;
                TimesheetLinesNew.Modify(true);
            until TimesheetLinesNew.next() = 0;
            TimesheetHeaderNew.Reset();
            TimesheetHeaderNew.SetRange("Timesheet Header No", DocumentNo);
            if TimesheetHeaderNew.Find('-') then begin
                TimesheetHeaderNew."Timesheet Status" := TimesheetHeaderNew."Timesheet Status"::Approved;
                TimesheetHeaderNew."SMT Lead Approve date" := Today;
                TimesheetHeaderNew.Modify(true);
                Message := 'Your Timesheet has been Approved.';
                MessageFormatterd := StrSubstNo(Message);
                HREmployees.Reset;
                HREmployees.SetRange("No.", TimesheetHeaderNew."Staff No");
                if HREmployees.findset then begin
                    SENDEMAILApproval(HREmployees."Company E-Mail", MessageFormatterd)
                end;


                // Message := 'Approval for timesheet of %1 (No. %2) requires your attention.';
                // MessageFormatterd := StrSubstNo(Message, TimesheetHeaderNew."Staff Name", TimesheetHeaderNew."Timesheet Header No");
                // HREmployees.Reset;
                // HREmployees.SetRange("Employee UserID", TimesheetHeaderNew."Line Manager");
                // if HREmployees.findset then begin
                //     SENDEMAILApproval(HREmployees."Company E-Mail", MessageFormatterd)
                // end;
            end;
        end;
    end;

    procedure HRTimesheetApproval(DocumentNo: Code[250])
    var
        Message: text;
        Approval: record "Timesheet Lines";
        MessageFormatterd: Text;
    begin
        TimesheetLinesNew.RESET;
        TimesheetLinesNew.SETRANGE(TimesheetLinesNew."Timesheet No", DocumentNo);
        IF TimesheetLinesNew.FindSet() THEN BEGIN
            repeat
                TimesheetLinesNew."Timesheet Status" := TimesheetLinesNew."Timesheet Status"::"HR Approved";
                TimesheetLinesNew.Modify(true);
            until TimesheetLinesNew.next() = 0;
            TimesheetHeaderNew.Reset();
            TimesheetHeaderNew.SetRange("Timesheet Header No", DocumentNo);
            if TimesheetHeaderNew.Find('-') then begin
                TimesheetHeaderNew."Timesheet Status" := TimesheetHeaderNew."Timesheet Status"::"HR Approved";
                TimesheetHeaderNew.Modify(true);
                Message := 'Your Timesheet has been Approved.';
                MessageFormatterd := StrSubstNo(Message);
                HREmployees.Reset;
                HREmployees.SetRange("No.", TimesheetHeaderNew."Staff No");
                if HREmployees.findset then begin
                    SENDEMAILApproval(HREmployees."Company E-Mail", MessageFormatterd)
                end;
            end;
        end;
    end;

    procedure RejectTimesheet(DocumentNo: Code[250]; Project: Code[250]; Comments: Text)

    var
        Message: text;
        Approval: record "Timesheet Lines";
        MessageFormatterd: Text;
    begin
        TimesheetLinesNew.RESET;
        TimesheetLinesNew.SETRANGE(TimesheetLinesNew."Timesheet No", DocumentNo);
        IF TimesheetLinesNew.FindSet() THEN BEGIN
            repeat
                TimesheetLinesNew.Comments := Comments;
                TimesheetLinesNew."Timesheet Status" := TimesheetLinesNew."Timesheet Status"::Open;
                TimesheetLinesNew.Modify(true);
                Commit();
                MessageFormatterd := '';
            // Message := '';
            // Approval.Reset();
            // Approval.SetRange("Timesheet No", TimesheetLinesNew."Timesheet No");
            // Approval.SetRange(Project, TimesheetLinesNew.Project);
            // if Approval.FindSet then begin
            //     repeat
            // if Approval."Approval Email Sent" = false then begin
            //     Message := 'Approval for timesheet of %1 (No. %2) requires your attention.';
            //     MessageFormatterd := StrSubstNo(Message, TimesheetHeaderNew."Staff Name", TimesheetHeaderNew."Timesheet Header No");
            //     HREmployees.Reset;
            //     HREmployees.SetRange("Employee UserID", Approval."Approver ID");
            //     if HREmployees.findset then begin
            //         SENDEMAILApproval(HREmployees."Company E-Mail", MessageFormatterd)
            //     end;
            //         //     Approval."Approval Email Sent" := true;
            //         Approval."Timesheet Status" := Approval."Timesheet Status"::"Timesheet Rejected";
            //         Approval.modify(true);

            //     until Approval.next() = 0;
            // end;
            until TimesheetLinesNew.next() = 0;
            TimesheetHeaderNew.Reset();
            TimesheetHeaderNew.SetRange("Timesheet Header No", DocumentNo);
            if TimesheetHeaderNew.Find('-') then begin
                TimesheetHeaderNew."Timesheet Status" := TimesheetHeaderNew."Timesheet Status"::Open;
                TimesheetHeaderNew.Modify(true);
                Message := 'Your Timesheet has been Rejected.';
                MessageFormatterd := StrSubstNo(Message);
                HREmployees.Reset;
                HREmployees.SetRange("No.", TimesheetHeaderNew."Staff No");
                if HREmployees.findset then begin
                    SENDEMAILApproval(HREmployees."Company E-Mail", MessageFormatterd)
                end;
            end;
        end;
    end;

    Procedure fnGetTimesheets(employee: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        objHREmployees.Reset();
        objHREmployees.SetRange("No.", employee);
        if objHREmployees.Find('-') then
            TimesheetHeaderNew.RESET;
        TimesheetHeaderNew.SETRANGE("Staff No", employee);
        IF TimesheetHeaderNew.FIND('-') THEN
            REPEAT

                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Timesheetcode', TimesheetHeaderNew."Timesheet Header No");
                CreateJsonAttribute('From', TimesheetHeaderNew."Start Date");
                CreateJsonAttribute('status', TimesheetHeaderNew."Timesheet Status");
                CreateJsonAttribute('To', TimesheetHeaderNew."End Date");
                CreateJsonAttribute('EmployeeNo', TimesheetHeaderNew."Staff No");
                CreateJsonAttribute('EmployeeName', TimesheetHeaderNew."Staff Name");
                JSONTextWriter.WritePropertyName('Timesheetlines');
                JSONTextWriter.WriteStartArray;
                TimesheetLinesNew.RESET;
                TimesheetLinesNew.SETRANGE("Timesheet No", TimesheetHeaderNew."Timesheet Header No");
                IF TimesheetLinesNew.FIND('-') THEN BEGIN
                    REPEAT

                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('timesheetcode', TimesheetLinesNew."Timesheet No");
                        JSONTextWriter.WritePropertyName('Date');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Date);
                        JSONTextWriter.WritePropertyName('projectCode');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Project);
                        JSONTextWriter.WritePropertyName('ProjectDescription');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Project decription");
                        JSONTextWriter.WritePropertyName('Workplan');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Workplan ");
                        JSONTextWriter.WritePropertyName('Activity');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Activity);
                        JSONTextWriter.WritePropertyName('ActivityDescription');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Activity Discription");
                        JSONTextWriter.WritePropertyName('Narration');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Narration);
                        JSONTextWriter.WritePropertyName('hours');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Hours);
                        JSONTextWriter.WritePropertyName('entryno');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Entry);
                        JSONTextWriter.WritePropertyName('entryno');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Timesheet Status");
                        JSONTextWriter.WriteEndObject;

                    UNTIL TimesheetLinesNew.NEXT = 0;
                END;

                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WriteEndObject;
            UNTIL TimesheetHeaderNew.NEXT = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    Procedure fnGetTimesheetSMTApproval(employee: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        objHREmployees.Reset();
        objHREmployees.SetRange("No.", employee);
        if objHREmployees.Find('-') then
            TimesheetHeaderNew.RESET;
        TimesheetHeaderNew.SETRANGE("SMT Lead", objHREmployees."Employee UserID");
        TimesheetHeaderNew.SetRange("Timesheet Status", TimesheetHeaderNew."Timesheet Status"::"Line Manager Approved");
        IF TimesheetHeaderNew.FIND('-') THEN
            REPEAT

                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Timesheetcode', TimesheetHeaderNew."Timesheet Header No");
                CreateJsonAttribute('From', TimesheetHeaderNew."Start Date");
                CreateJsonAttribute('status', TimesheetHeaderNew."Timesheet Status");
                CreateJsonAttribute('To', TimesheetHeaderNew."End Date");
                CreateJsonAttribute('EmployeeNo', TimesheetHeaderNew."Staff No");
                CreateJsonAttribute('EmployeeName', TimesheetHeaderNew."Staff Name");
                JSONTextWriter.WritePropertyName('Timesheetlines');
                JSONTextWriter.WriteStartArray;
                TimesheetLinesNew.RESET;
                TimesheetLinesNew.SETRANGE("Timesheet No", TimesheetHeaderNew."Timesheet Header No");
                IF TimesheetLinesNew.FIND('-') THEN BEGIN
                    REPEAT

                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('timesheetcode', TimesheetLinesNew."Timesheet No");
                        JSONTextWriter.WritePropertyName('Date');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Date);
                        JSONTextWriter.WritePropertyName('projectCode');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Project);
                        JSONTextWriter.WritePropertyName('ProjectDescription');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Project decription");
                        JSONTextWriter.WritePropertyName('Workplan');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Workplan ");
                        JSONTextWriter.WritePropertyName('Activity');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Activity);
                        JSONTextWriter.WritePropertyName('ActivityDescription');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Activity Discription");
                        JSONTextWriter.WritePropertyName('Narration');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Narration);
                        JSONTextWriter.WritePropertyName('hours');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Hours);
                        JSONTextWriter.WritePropertyName('entryno');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Entry);
                        JSONTextWriter.WritePropertyName('entryno');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Timesheet Status");
                        JSONTextWriter.WriteEndObject;

                    UNTIL TimesheetLinesNew.NEXT = 0;
                END;

                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WriteEndObject;
            UNTIL TimesheetHeaderNew.NEXT = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    Procedure fnGetTimesheetSupervisorApproval(employee: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        objHREmployees.Reset();
        objHREmployees.SetRange("No.", employee);
        if objHREmployees.Find('-') then
            TimesheetHeaderNew.RESET;
        TimesheetHeaderNew.SETRANGE("Line Manager", objHREmployees."Employee UserID");
        TimesheetHeaderNew.SetRange("Timesheet Status", TimesheetHeaderNew."Timesheet Status"::"Project Manager Approved");
        IF TimesheetHeaderNew.FIND('-') THEN
            REPEAT

                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Timesheetcode', TimesheetHeaderNew."Timesheet Header No");
                CreateJsonAttribute('From', TimesheetHeaderNew."Start Date");
                CreateJsonAttribute('status', TimesheetHeaderNew."Timesheet Status");
                CreateJsonAttribute('To', TimesheetHeaderNew."End Date");
                CreateJsonAttribute('EmployeeNo', TimesheetHeaderNew."Staff No");
                CreateJsonAttribute('EmployeeName', TimesheetHeaderNew."Staff Name");
                JSONTextWriter.WritePropertyName('Timesheetlines');
                JSONTextWriter.WriteStartArray;
                TimesheetLinesNew.RESET;
                TimesheetLinesNew.SETRANGE("Timesheet No", TimesheetHeaderNew."Timesheet Header No");
                IF TimesheetLinesNew.FIND('-') THEN BEGIN
                    REPEAT

                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('timesheetcode', TimesheetLinesNew."Timesheet No");
                        JSONTextWriter.WritePropertyName('Date');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Date);
                        JSONTextWriter.WritePropertyName('projectCode');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Project);
                        JSONTextWriter.WritePropertyName('ProjectDescription');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Project decription");
                        JSONTextWriter.WritePropertyName('Workplan');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Workplan ");
                        JSONTextWriter.WritePropertyName('Activity');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Activity);
                        JSONTextWriter.WritePropertyName('ActivityDescription');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Activity Discription");
                        JSONTextWriter.WritePropertyName('Narration');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Narration);
                        JSONTextWriter.WritePropertyName('hours');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Hours);
                        JSONTextWriter.WritePropertyName('entryno');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Entry);
                        JSONTextWriter.WritePropertyName('entryno');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Timesheet Status");
                        JSONTextWriter.WriteEndObject;

                    UNTIL TimesheetLinesNew.NEXT = 0;
                END;

                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WriteEndObject;
            UNTIL TimesheetHeaderNew.NEXT = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    Procedure fnGetTimesheetHRApproval(employee: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        objHREmployees.Reset();
        objHREmployees.SetRange("No.", employee);
        if objHREmployees.Find('-') then
            TimesheetHeaderNew.RESET;
        TimesheetHeaderNew.SETRANGE("Human Resource manager", objHREmployees."Employee UserID");
        TimesheetHeaderNew.SetRange("Timesheet Status", TimesheetHeaderNew."Timesheet Status"::"SMT Lead Approved");
        IF TimesheetHeaderNew.FIND('-') THEN
            REPEAT

                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Timesheetcode', TimesheetHeaderNew."Timesheet Header No");
                CreateJsonAttribute('From', TimesheetHeaderNew."Start Date");
                CreateJsonAttribute('status', TimesheetHeaderNew."Timesheet Status");
                CreateJsonAttribute('To', TimesheetHeaderNew."End Date");
                CreateJsonAttribute('EmployeeNo', TimesheetHeaderNew."Staff No");
                CreateJsonAttribute('EmployeeName', TimesheetHeaderNew."Staff Name");
                JSONTextWriter.WritePropertyName('Timesheetlines');
                JSONTextWriter.WriteStartArray;
                TimesheetLinesNew.RESET;
                TimesheetLinesNew.SETRANGE("Timesheet No", TimesheetHeaderNew."Timesheet Header No");
                IF TimesheetLinesNew.FIND('-') THEN BEGIN
                    REPEAT

                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('timesheetcode', TimesheetLinesNew."Timesheet No");
                        JSONTextWriter.WritePropertyName('Date');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Date);
                        JSONTextWriter.WritePropertyName('projectCode');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Project);
                        JSONTextWriter.WritePropertyName('ProjectDescription');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Project decription");
                        JSONTextWriter.WritePropertyName('Workplan');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Workplan ");
                        JSONTextWriter.WritePropertyName('Activity');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Activity);
                        JSONTextWriter.WritePropertyName('ActivityDescription');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Activity Discription");
                        JSONTextWriter.WritePropertyName('Narration');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Narration);
                        JSONTextWriter.WritePropertyName('hours');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Hours);
                        JSONTextWriter.WritePropertyName('entryno');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Entry);
                        JSONTextWriter.WritePropertyName('entryno');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Timesheet Status");
                        JSONTextWriter.WriteEndObject;

                    UNTIL TimesheetLinesNew.NEXT = 0;
                END;

                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WriteEndObject;
            UNTIL TimesheetHeaderNew.NEXT = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    Procedure ProjectManagerList(employee: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        objHREmployees.Reset();
        objHREmployees.SetRange("No.", employee);
        if objHREmployees.Find('-') then
            TimesheetLinesNew.RESET;
        TimesheetLinesNew.SETRANGE("Approver ID", objHREmployees."Employee UserID");
        TimesheetLinesNew.SetRange("Timesheet Status", TimesheetLinesNew."Timesheet Status"::"Send Awaiting Approval");
        IF TimesheetLinesNew.FIND('-') THEN begin
            TimesheetHeaderNew.Reset();
            TimesheetHeaderNew.SetRange("Timesheet Header No", TimesheetLinesNew."Timesheet No");
            if TimesheetHeaderNew.Find('-') then
                REPEAT

                    JSONTextWriter.WriteStartObject;
                    CreateJsonAttribute('Timesheetcode', TimesheetHeaderNew."Timesheet Header No");
                    CreateJsonAttribute('From', TimesheetHeaderNew."Start Date");
                    CreateJsonAttribute('status', TimesheetHeaderNew."Timesheet Status");
                    CreateJsonAttribute('To', TimesheetHeaderNew."End Date");
                    CreateJsonAttribute('EmployeeNo', TimesheetHeaderNew."Staff No");
                    CreateJsonAttribute('EmployeeName', TimesheetHeaderNew."Staff Name");
                    JSONTextWriter.WritePropertyName('Timesheetlines');
                    JSONTextWriter.WriteStartArray;
                    TimesheetLinesNew.RESET;
                    TimesheetLinesNew.SETRANGE("Timesheet No", TimesheetHeaderNew."Timesheet Header No");
                    IF TimesheetLinesNew.FIND('-') THEN BEGIN
                        REPEAT

                            JSONTextWriter.WriteStartObject;
                            CreateJsonAttribute('timesheetcode', TimesheetLinesNew."Timesheet No");
                            JSONTextWriter.WritePropertyName('Date');
                            JSONTextWriter.WriteValue(TimesheetLinesNew.Date);
                            JSONTextWriter.WritePropertyName('projectCode');
                            JSONTextWriter.WriteValue(TimesheetLinesNew.Project);
                            JSONTextWriter.WritePropertyName('ProjectDescription');
                            JSONTextWriter.WriteValue(TimesheetLinesNew."Project decription");
                            JSONTextWriter.WritePropertyName('Workplan');
                            JSONTextWriter.WriteValue(TimesheetLinesNew."Workplan ");
                            JSONTextWriter.WritePropertyName('Activity');
                            JSONTextWriter.WriteValue(TimesheetLinesNew.Activity);
                            JSONTextWriter.WritePropertyName('ActivityDescription');
                            JSONTextWriter.WriteValue(TimesheetLinesNew."Activity Discription");
                            JSONTextWriter.WritePropertyName('Narration');
                            JSONTextWriter.WriteValue(TimesheetLinesNew.Narration);
                            JSONTextWriter.WritePropertyName('hours');
                            JSONTextWriter.WriteValue(TimesheetLinesNew.Hours);
                            JSONTextWriter.WritePropertyName('entryno');
                            JSONTextWriter.WriteValue(TimesheetLinesNew.Entry);
                            JSONTextWriter.WritePropertyName('entryno');
                            JSONTextWriter.WriteValue(TimesheetLinesNew."Timesheet Status");
                            JSONTextWriter.WriteEndObject;

                        UNTIL TimesheetLinesNew.NEXT = 0;
                    END;

                    JSONTextWriter.WriteEndArray;
                    JSONTextWriter.WriteEndObject;
                UNTIL TimesheetHeaderNew.NEXT = 0;

            JSONTextWriter.WriteEndArray;
            JsonOut := StringBuilder.ToString;
            returnout := JsonOut;
        end;
    end;



    Procedure fnEditTimesheets(No: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        TimesheetHeaderNew.RESET;
        TimesheetHeaderNew.SETRANGE("Timesheet Header No", No);
        IF TimesheetHeaderNew.FIND('-') THEN
            REPEAT

                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Timesheetcode', TimesheetHeaderNew."Timesheet Header No");
                CreateJsonAttribute('From', TimesheetHeaderNew."Start Date");
                CreateJsonAttribute('status', TimesheetHeaderNew."Timesheet Status");
                CreateJsonAttribute('To', TimesheetHeaderNew."End Date");
                CreateJsonAttribute('EmployeeNo', TimesheetHeaderNew."Staff No");
                CreateJsonAttribute('EmployeeName', TimesheetHeaderNew."Staff Name");
                JSONTextWriter.WritePropertyName('Timesheetlines');
                JSONTextWriter.WriteStartArray;
                TimesheetLinesNew.RESET;
                TimesheetLinesNew.SETRANGE("Timesheet No", TimesheetHeaderNew."Timesheet Header No");
                IF TimesheetLinesNew.FIND('-') THEN BEGIN
                    REPEAT

                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('timesheetcode', TimesheetLinesNew."Timesheet No");
                        JSONTextWriter.WritePropertyName('Date');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Date);
                        JSONTextWriter.WritePropertyName('projectCode');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Project);
                        JSONTextWriter.WritePropertyName('ProjectDescription');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Project decription");
                        JSONTextWriter.WritePropertyName('Workplan');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Workplan ");
                        JSONTextWriter.WritePropertyName('Activity');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Activity);
                        JSONTextWriter.WritePropertyName('ActivityDescription');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Activity Discription");
                        JSONTextWriter.WritePropertyName('Narration');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Narration);
                        JSONTextWriter.WritePropertyName('Narrationorg');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.FieldName);
                        JSONTextWriter.WritePropertyName('hours');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Hours);
                        JSONTextWriter.WritePropertyName('entryno');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Entry);
                        JSONTextWriter.WritePropertyName('Status');
                        JSONTextWriter.WriteValue(Format(TimesheetLinesNew."Timesheet Status"));
                        JSONTextWriter.WritePropertyName('TotalHours');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Total Hours");
                        JSONTextWriter.WritePropertyName('TotalDays');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Total Days");
                        JSONTextWriter.WriteEndObject;

                    UNTIL TimesheetLinesNew.NEXT = 0;
                END;

                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WriteEndObject;
            UNTIL TimesheetHeaderNew.NEXT = 0;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    Procedure fnPMEditTimesheets(No: Code[50]; Project: Code[250]) returnout: Text
    var
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        TimesheetHeaderNew.RESET;
        TimesheetHeaderNew.SETRANGE("Timesheet Header No", No);
        IF TimesheetHeaderNew.FIND('-') THEN
            REPEAT

                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Timesheetcode', TimesheetHeaderNew."Timesheet Header No");
                CreateJsonAttribute('From', TimesheetHeaderNew."Start Date");
                CreateJsonAttribute('status', TimesheetHeaderNew."Timesheet Status");
                CreateJsonAttribute('To', TimesheetHeaderNew."End Date");
                CreateJsonAttribute('EmployeeNo', TimesheetHeaderNew."Staff No");
                CreateJsonAttribute('EmployeeName', TimesheetHeaderNew."Staff Name");
                CreateJsonAttribute('Project', Project);
                JSONTextWriter.WritePropertyName('Timesheetlines');
                JSONTextWriter.WriteStartArray;
                TimesheetLinesNew.RESET;
                TimesheetLinesNew.SETRANGE("Timesheet No", TimesheetHeaderNew."Timesheet Header No");
                TimesheetLinesNew.SETRANGE(TimesheetLinesNew.Project, Project);
                IF TimesheetLinesNew.FIND('-') THEN BEGIN
                    REPEAT

                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('timesheetcode', TimesheetLinesNew."Timesheet No");
                        JSONTextWriter.WritePropertyName('Date');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Date);
                        JSONTextWriter.WritePropertyName('projectCode');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Project);
                        JSONTextWriter.WritePropertyName('ProjectDescription');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Project decription");
                        JSONTextWriter.WritePropertyName('Workplan');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Workplan ");
                        JSONTextWriter.WritePropertyName('Activity');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Activity);
                        JSONTextWriter.WritePropertyName('ActivityDescription');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Activity Discription");
                        JSONTextWriter.WritePropertyName('Narration');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Narration);
                        JSONTextWriter.WritePropertyName('hours');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Hours);
                        JSONTextWriter.WritePropertyName('entryno');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Entry);
                        JSONTextWriter.WritePropertyName('Status');
                        JSONTextWriter.WriteValue(Format(TimesheetLinesNew."Timesheet Status"));
                        JSONTextWriter.WritePropertyName('TotalHours');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Total Hours");
                        JSONTextWriter.WritePropertyName('TotalDays');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Total Days");
                        JSONTextWriter.WriteEndObject;

                    UNTIL TimesheetLinesNew.NEXT = 0;
                END;

                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WriteEndObject;
            UNTIL TimesheetHeaderNew.NEXT = 0;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    Procedure fEditGeneraltimesheet(No: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        TimesheetHeaderNew.RESET;
        TimesheetHeaderNew.SETRANGE("Timesheet Header No", No);
        IF TimesheetHeaderNew.FIND('-') THEN
            REPEAT

                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Timesheetcode', TimesheetHeaderNew."Timesheet Header No");
                CreateJsonAttribute('From', TimesheetHeaderNew."Start Date");
                CreateJsonAttribute('status', TimesheetHeaderNew."Timesheet Status");
                CreateJsonAttribute('To', TimesheetHeaderNew."End Date");
                CreateJsonAttribute('EmployeeNo', TimesheetHeaderNew."Staff No");
                CreateJsonAttribute('EmployeeName', TimesheetHeaderNew."Staff Name");
                //CreateJsonAttribute('Project', Project);
                JSONTextWriter.WritePropertyName('Timesheetlines');
                JSONTextWriter.WriteStartArray;
                TimesheetLinesNew.RESET;
                TimesheetLinesNew.SETRANGE("Timesheet No", TimesheetHeaderNew."Timesheet Header No");
                IF TimesheetLinesNew.FIND('-') THEN BEGIN
                    REPEAT

                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('timesheetcode', TimesheetLinesNew."Timesheet No");
                        JSONTextWriter.WritePropertyName('Date');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Date);
                        JSONTextWriter.WritePropertyName('projectCode');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Project);
                        JSONTextWriter.WritePropertyName('ProjectDescription');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Project decription");
                        JSONTextWriter.WritePropertyName('Workplan');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Workplan ");
                        JSONTextWriter.WritePropertyName('Activity');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Activity);
                        JSONTextWriter.WritePropertyName('ActivityDescription');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Activity Discription");
                        JSONTextWriter.WritePropertyName('Narration');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Narration);
                        JSONTextWriter.WritePropertyName('hours');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Hours);
                        JSONTextWriter.WritePropertyName('entryno');
                        JSONTextWriter.WriteValue(TimesheetLinesNew.Entry);
                        JSONTextWriter.WritePropertyName('Status');
                        JSONTextWriter.WriteValue(Format(TimesheetLinesNew."Timesheet Status"));
                        JSONTextWriter.WritePropertyName('TotalHours');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Total Hours");
                        JSONTextWriter.WritePropertyName('TotalDays');
                        JSONTextWriter.WriteValue(TimesheetLinesNew."Total Days");
                        JSONTextWriter.WriteEndObject;

                    UNTIL TimesheetLinesNew.NEXT = 0;
                END;

                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WriteEndObject;
            UNTIL TimesheetHeaderNew.NEXT = 0;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnInsertTimeSheets(name: Code[50]; projectCode: Code[40]; startdate: DateTime; employee: Code[50]; year: Integer; enddate: DateTime; hours: Integer) "code": Integer
    var
        noOfDays: Integer;
        leaveTypes: Record "HR Leave Types";
        date: Date;
        noDaysUp: Integer;
    begin

        noOfDays := CalcDate('+1D', Dt2Date(enddate)) - Dt2Date(startdate);

        date := CalcDate('-1D', Dt2Date(startdate));
        noDaysUp := 1;
        repeat

            TimesheetHeader.Init;
            if leaveTypes.Get(projectCode) then begin
                TimesheetHeader."Leave Type" := projectCode;
                TimesheetHeader.Validate("Leave Type");
            end else begin
                TimesheetHeader."Global Dimension 1 Code" := projectCode;
                TimesheetHeader.Validate("Global Dimension 1 Code");
            end;
            TimesheetHeader.Date := CalcDate('+' + Format(noDaysUp) + 'D', date);
            TimesheetHeader.Validate(Date);
            TimesheetHeader."Employee No" := employee;
            TimesheetHeader.Status := TimesheetHeader.Status::ApprovalPending;
            TimesheetHeader.Hours := hours;
            TimesheetHeader.Validate(Hours);
            TimesheetHeader.Validate("Employee No");

            //smt/supervisor/hr

            if TimesheetHeader.Hours <> 0 then begin

                // TimesheetHeader.FINDLAST;
                TimesheetHeader.Entry := TimesheetHeader.Count() + Random(99999);
                TimesheetHeader.Insert;
                Commit;
            end;
            noOfDays -= 1;
            noDaysUp += 1;
        until noOfDays = 0;
    end;



    procedure fnUnitsOfMeasure() returnout: Text
    var
        ObjDimensionValue: Record "Dimension Value";
        JsonOut: dotnet String;
        HRLeaveTypes: Record "HR Leave Types";
        unitOfMeasures: Record "Unit of Measure";
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        unitOfMeasures.Reset;
        // ObjDimensionValue.SETRANGE("Global Dimension No.",1);
        //ObjDimensionValue.SETRANGE("Fund Code",fundcode);
        if unitOfMeasures.FindFirst then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', unitOfMeasures.Code);
                CreateJsonAttribute('Name', unitOfMeasures.Description);
                JSONTextWriter.WriteEndObject;
            until unitOfMeasures.Next = 0;


        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fninsertimprestnewClaim(JsonData: Text[2048]; emp: Code[50])
    var
        lineNo: Integer;
        departuretime: DateTime;
        arrivalTime: DateTime;
        ModifyLineNo: Integer;
        no: Code[100];
    begin

        /*lJSONString:=JsonData;
        IF lJSONString <> '' THEN
        lJObject:= lJObject.Parse(FORMAT(lJSONString));
        IF FORMAT(lJObject.GetValue('No'))='' THEN BEGIN
        purchaseheader.INIT;
        GenLedgerSetup.GET;
        purchaseheader."No.":=objNumSeries.GetNextNo(GenLedgerSetup."Mission Proposal Nos.",0D,TRUE);
        purchaseheader."No. Series":=GenLedgerSetup."Mission Proposal Nos.";
        purchaseheader."Document Type":=purchaseheader."Document Type"::Quote;
        purchaseheader.MP:=TRUE;
        END
        ELSE
        purchaseheader."No.":=FORMAT(lJObject.GetValue('No'));
        
        purchaseheader."Shortcut Dimension 1 Code":=FORMAT(lJObject.GetValue('ProgramCode'));
        purchaseheader."Shortcut Dimension 2 Code":=FORMAT(lJObject.GetValue('budgetdminesion'));
        purchaseheader.Purpose:=FORMAT(lJObject.GetValue('Purpose'));
        purchaseheader."Posting Description":=FORMAT(lJObject.GetValue('Department'));
        
        purchaseheader."Employee No":=emp;
        purchaseheader.VALIDATE("Employee No");
        // Peformance
        //Travel detials
        lArrayString := lJObject.SelectToken('TravelDetails').ToString;
        CLEAR(lJObject);
        lJsonArray := lJsonArray.Parse(lArrayString);
        {lineNo+=1000;
        IF ModifyLineNo=0 THEN
        purchaseline.INSERT
        ELSE
        purchaseline.MODIFY;}
        lineNo+=1000;
        
        FOREACH lJObject IN lJsonArray DO BEGIN
        EVALUATE(ModifyLineNo, FORMAT(lJObject.GetValue('LineNo')));
        
        IF ModifyLineNo=0 THEN BEGIN
        purchaseline.INIT;
        purchaseline."Line No.":=lineNo;
        END ELSE
        purchaseline."Line No.":=ModifyLineNo;
        purchaseline."Document No.":=purchaseheader."No.";
        purchaseline."Line Type":=purchaseline."Line Type"::ActionPoints;
        
        
        EVALUATE(purchaseline.date, FORMAT(lJObject.GetValue('date')));
        purchaseline.date:=purchaseline.date;
        EVALUATE(departuretime,FORMAT(lJObject.GetValue('departureTime')));
        purchaseline.departureTime:=DT2TIME(departuretime);
        purchaseline.departurePlace:=FORMAT(lJObject.GetValue('departurePlace'));
        purchaseline.arrivalPlace:=FORMAT(lJObject.GetValue('arrivalPlace'));
        EVALUATE(arrivalTime, FORMAT(lJObject.GetValue('arrivalTime')));
        purchaseline.arrivalTime:=DT2TIME(arrivalTime);
        purchaseline.remarks:=FORMAT(lJObject.GetValue('remarks'));
        lineNo+=1000;
        IF ModifyLineNo=0 THEN
        purchaseline.INSERT
        ELSE
        purchaseline.MODIFY;
        
        lineNo+=1000;
        END;
        lJObject:= lJObject.Parse(FORMAT(lJSONString));
        lArrayString := lJObject.SelectToken('AccomodationDetails').ToString;
        CLEAR(lJObject);
        lJsonArray := lJsonArray.Parse(lArrayString);
        
        //Accoumodation detils
        FOREACH lJObject IN lJsonArray DO BEGIN
        EVALUATE(ModifyLineNo, FORMAT(lJObject.GetValue('LineNo')));
        IF ModifyLineNo=0 THEN BEGIN
        purchaseline.INIT;
        purchaseline."Line No.":=lineNo;
        END ELSE
        purchaseline."Line No.":=ModifyLineNo;
        purchaseline."Document No.":=purchaseheader."No.";
        purchaseline."Line Type":=purchaseline."Line Type"::Activity;
        
        
        EVALUATE(purchaseline.dateFrom, FORMAT(lJObject.GetValue('dateFrom')));
        EVALUATE(purchaseline.dateTo, FORMAT(lJObject.GetValue('dateTo')));
        purchaseline.date:=purchaseline.date;
        EVALUATE(purchaseline.accomodtionCatered,FORMAT(lJObject.GetValue('accomodationCatered')));
        purchaseline.locationOfStay:=FORMAT(lJObject.GetValue('locationOfStay'));
        
        EVALUATE(purchaseline.Amount,FORMAT(lJObject.GetValue('amount')));
        EVALUATE(purchaseline.noOfDays, FORMAT(lJObject.GetValue('noOfNights')));
        
        lineNo+=1000;
        IF ModifyLineNo=0 THEN
        purchaseline.INSERT
        ELSE
        purchaseline.MODIFY;
        
        lineNo+=1000;
        END;
        
        /// Meals and incidentals
        lJObject:= lJObject.Parse(FORMAT(lJSONString));
        lArrayString := lJObject.SelectToken('MealsAndIncidentals').ToString;
        CLEAR(lJObject);
        lJsonArray := lJsonArray.Parse(lArrayString);
        
        FOREACH lJObject IN lJsonArray DO BEGIN
        EVALUATE(ModifyLineNo, FORMAT(lJObject.GetValue('LineNo')));
        IF ModifyLineNo=0 THEN BEGIN
        purchaseline.INIT;
        purchaseline."Line No.":=lineNo;
        END ELSE
        purchaseline."Line No.":=ModifyLineNo;
        purchaseline."Document No.":=purchaseheader."No.";
        purchaseline."Line Type":=purchaseline."Line Type"::"Budget Info";
        
        
        EVALUATE(purchaseline.date, FORMAT(lJObject.GetValue('date')));
        
        purchaseline."location.":=FORMAT(lJObject.GetValue('location'));
        purchaseline.Description:=FORMAT(lJObject.GetValue('description'));
        EVALUATE(purchaseline.Amount,FORMAT(lJObject.GetValue('amount')));
        EVALUATE(purchaseline.noOfDays, FORMAT(lJObject.GetValue('noOfDays')));
        
        lineNo+=1000;
        IF ModifyLineNo=0 THEN
        purchaseline.INSERT
        ELSE
        purchaseline.MODIFY;
        
        lineNo+=1000;
        END;
        
        // other expenses
        lJObject:= lJObject.Parse(FORMAT(lJSONString));
        lArrayString := lJObject.SelectToken('OtherExpenses').ToString;
        CLEAR(lJObject);
        lJsonArray := lJsonArray.Parse(lArrayString);
        
        
        FOREACH lJObject IN lJsonArray DO BEGIN
        EVALUATE(ModifyLineNo, FORMAT(lJObject.GetValue('LineNo')));
        IF ModifyLineNo=0 THEN BEGIN
        purchaseline.INIT;
        purchaseline."Line No.":=lineNo;
        END ELSE
        purchaseline."Line No.":=ModifyLineNo;
        purchaseline."Document No.":=purchaseheader."No.";
        purchaseline."Line Type":=purchaseline."Line Type"::"Budget Notes";
        
        
        EVALUATE(purchaseline.date, FORMAT(lJObject.GetValue('date')));
        
        purchaseline."location.":=FORMAT(lJObject.GetValue('location'));
        purchaseline.Description:=FORMAT(lJObject.GetValue('description'));
        EVALUATE(purchaseline.Amount,FORMAT(lJObject.GetValue('amount')));
        
        lineNo+=1000;
        IF ModifyLineNo=0 THEN
        purchaseline.INSERT
        ELSE
        purchaseline.MODIFY;
        lineNo+=1000;
        END;
        IF FORMAT(lJObject.GetValue('No'))='' THEN
        purchaseheader.INSERT
        ELSE
          purchaseheader.MODIFY;
          */

        lJSONString := JsonData;
        if lJSONString <> '' then
            lJObject := lJObject.Parse(Format(lJSONString));

        Evaluate(no, Format(lJObject.GetValue('No')));
        if no = '' then begin
            purchaseheader.Init;
            GenLedgerSetup.Get;
            purchaseheader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Mission Proposal Nos.", 0D, true);
            purchaseheader."No. Series" := GenLedgerSetup."Mission Proposal Nos.";
            purchaseheader."Document Type" := purchaseheader."document type"::Quote;
            purchaseheader.MP := true;
        end
        else
            purchaseheader."No." := Format(lJObject.GetValue('No'));

        purchaseheader."Shortcut Dimension 1 Code" := Format(lJObject.GetValue('ProgramCode'));
        purchaseheader."Shortcut Dimension 2 Code" := Format(lJObject.GetValue('budgetdminesion'));
        purchaseheader.Purpose := Format(lJObject.GetValue('Purpose'));
        purchaseheader."Posting Description" := Format(lJObject.GetValue('Department'));

        purchaseheader."Employee No" := emp;

        purchaseheader.Validate("Employee No");
        lineNo := 10000;
        // Peformance
        //Travel detials
        lJObject := lJObject.Parse(Format(lJSONString));
        lArrayString := lJObject.SelectToken('TravelDetails').ToString;
        if lArrayString <> '' then begin
            Clear(lJObject);
            lJsonArray := lJsonArray.Parse(lArrayString);



            foreach lJObject in lJsonArray do begin
                Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));

                if ModifyLineNo = 0 then begin
                    purchaseline.Init;
                    purchaseline."Line No." := lineNo;
                end else
                    purchaseline."Line No." := ModifyLineNo;
                purchaseline."Document No." := purchaseheader."No.";
                purchaseline."Line Type" := purchaseline."line type"::ActionPoints;


                Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));
                purchaseline.date := purchaseline.date;
                Evaluate(departuretime, Format(lJObject.GetValue('departureTime')));
                purchaseline.departureTime := Dt2Time(departuretime);
                purchaseline.departurePlace := Format(lJObject.GetValue('departurePlace'));
                purchaseline.arrivalPlace := Format(lJObject.GetValue('arrivalPlace'));
                Evaluate(arrivalTime, Format(lJObject.GetValue('arrivalTime')));
                purchaseline.arrivalTime := Dt2Time(arrivalTime);
                purchaseline.remarks := Format(lJObject.GetValue('remarks'));
                lineNo += 1000;
                if ModifyLineNo = 0 then
                    purchaseline.Insert
                else
                    purchaseline.Modify;
            end;
            lineNo += 1000;
        end;
        lJObject := lJObject.Parse(Format(lJSONString));
        lArrayString := lJObject.SelectToken('AccomodationDetails').ToString;
        Clear(lJObject);
        if lArrayString <> '' then begin
            lJsonArray := lJsonArray.Parse(lArrayString);

            //Accoumodation detils
            foreach lJObject in lJsonArray do begin
                Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
                if ModifyLineNo = 0 then begin
                    purchaseline.Init;
                    purchaseline."Line No." := lineNo;
                end else
                    purchaseline."Line No." := ModifyLineNo;
                purchaseline."Document No." := purchaseheader."No.";
                purchaseline."Line Type" := purchaseline."line type"::Activity;


                Evaluate(purchaseline.dateFrom, Format(lJObject.GetValue('dateFrom')));
                Evaluate(purchaseline.dateTo, Format(lJObject.GetValue('dateTo')));
                purchaseline.date := purchaseline.date;
                Evaluate(purchaseline.accomodtionCatered, Format(lJObject.GetValue('accomodationCatered')));
                purchaseline.locationOfStay := Format(lJObject.GetValue('locationOfStay'));
                Evaluate(purchaseline."Amount Spent", Format(lJObject.GetValue('amountSpent')));
                Evaluate(purchaseline.amountToRefund, Format(lJObject.GetValue('amountToRefund')));
                Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));
                Evaluate(purchaseline.noOfDays, Format(lJObject.GetValue('noOfNights')));

                purchaseline."Travel Line Total" := purchaseline.Amount * purchaseline.noOfDays;
                purchaseline."Amount Spent" := purchaseline."Amount Spent" * purchaseline.noOfDays;
                lineNo += 1000;
                if ModifyLineNo = 0 then
                    purchaseline.Insert
                else
                    purchaseline.Modify;
            end;
            lineNo += 1000;
        end;

        /// Meals and incidentals
        lJObject := lJObject.Parse(Format(lJSONString));
        lArrayString := lJObject.SelectToken('MealsAndIncidentals').ToString;
        if lArrayString <> '' then begin
            Clear(lJObject);
            lJsonArray := lJsonArray.Parse(lArrayString);

            foreach lJObject in lJsonArray do begin
                Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
                if ModifyLineNo = 0 then begin
                    purchaseline.Init;
                    purchaseline."Line No." := lineNo;
                end else
                    purchaseline."Line No." := ModifyLineNo;
                purchaseline."Document No." := purchaseheader."No.";
                purchaseline."Line Type" := purchaseline."line type"::"Budget Info";


                Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));
                Evaluate(purchaseline.amountToRefund, Format(lJObject.GetValue('amountToRefund')));
                Evaluate(purchaseline."Amount Spent", Format(lJObject.GetValue('amount')));
                purchaseline."location." := Format(lJObject.GetValue('location'));
                purchaseline.Description := Format(lJObject.GetValue('description'));
                Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));
                Evaluate(purchaseline.noOfDays, Format(lJObject.GetValue('noOfDays')));
                purchaseline."Travel Line Total" := purchaseline.Amount * purchaseline.noOfDays;
                purchaseline."Amount Spent" := purchaseline."Amount Spent" * purchaseline.noOfDays;
                lineNo += 1000;
                if ModifyLineNo = 0 then
                    purchaseline.Insert
                else
                    purchaseline.Modify;
            end;
            lineNo += 1000;
        end;

        // other expenses
        lJObject := lJObject.Parse(Format(lJSONString));
        lArrayString := lJObject.SelectToken('OtherExpenses').ToString;
        if lArrayString <> '' then begin
            Clear(lJObject);
            lJsonArray := lJsonArray.Parse(lArrayString);


            foreach lJObject in lJsonArray do begin
                Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
                if ModifyLineNo = 0 then begin
                    purchaseline.Init;
                    purchaseline."Line No." := lineNo;
                end else
                    purchaseline."Line No." := ModifyLineNo;
                purchaseline."Document No." := purchaseheader."No.";
                purchaseline."Line Type" := purchaseline."line type"::"Budget Notes";


                Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));
                Evaluate(purchaseline.amountToRefund, Format(lJObject.GetValue('amountToRefund')));
                Evaluate(purchaseline."Amount Spent", Format(lJObject.GetValue('amount')));
                purchaseline."location." := Format(lJObject.GetValue('location'));
                purchaseline.Description := Format(lJObject.GetValue('description'));
                Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));
                purchaseline."Travel Line Total" := purchaseline.Amount;
                purchaseline."Amount Spent" := purchaseline."Amount Spent";
                lineNo += 1000;
                if ModifyLineNo = 0 then
                    purchaseline.Insert
                else
                    purchaseline.Modify;
                lineNo += 1000;
            end;
        end;
        if no = '' then
            purchaseheader.Insert
        else
            purchaseheader.Modify;

    end;

    procedure fninsertimprestnewAccounting(JsonData: Text[2048]; emp: Code[50])
    var
        lineNo: Integer;
        departuretime: DateTime;
        arrivalTime: DateTime;
        ModifyLineNo: Integer;
    begin

        lJSONString := JsonData;
        if lJSONString <> '' then
            lJObject := lJObject.Parse(Format(lJSONString));
        if Format(lJObject.GetValue('No')) = '' then begin
            purchaseheader.Init;
            GenLedgerSetup.Get;
            purchaseheader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Mission Proposal Nos.", 0D, true);
            purchaseheader."No. Series" := GenLedgerSetup."Mission Proposal Nos.";
            purchaseheader."Document Type" := purchaseheader."document type"::Quote;
        end
        else
            purchaseheader."No." := Format(lJObject.GetValue('No'));

        purchaseheader."Shortcut Dimension 1 Code" := Format(lJObject.GetValue('ProgramCode'));
        purchaseheader."Shortcut Dimension 2 Code" := Format(lJObject.GetValue('budgetdminesion'));
        purchaseheader.Purpose := Format(lJObject.GetValue('Purpose'));
        purchaseheader."Posting Description" := Format(lJObject.GetValue('Department'));
        purchaseheader.MP := true;
        purchaseheader."Employee No" := emp;
        purchaseheader.Validate("Employee No");
        // Peformance
        //Travel detials
        lArrayString := lJObject.SelectToken('TravelDetails').ToString;
        Clear(lJObject);
        lJsonArray := lJsonArray.Parse(lArrayString);

        if ModifyLineNo = 0 then
            purchaseline.Insert
        else
            purchaseline.Modify;

        foreach lJObject in lJsonArray do begin
            Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));

            if ModifyLineNo = 0 then begin
                purchaseline.Init;
                purchaseline."Line No." := lineNo;
            end else
                purchaseline."Line No." := ModifyLineNo;
            purchaseline."Document No." := purchaseheader."No.";
            purchaseline."Line Type" := purchaseline."line type"::ActionPoints;


            Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));
            purchaseline.date := purchaseline.date;
            Evaluate(departuretime, Format(lJObject.GetValue('departureTime')));
            purchaseline.departureTime := Dt2Time(departuretime);
            purchaseline.departurePlace := Format(lJObject.GetValue('departurePlace'));
            purchaseline.arrivalPlace := Format(lJObject.GetValue('arrivalPlace'));
            Evaluate(arrivalTime, Format(lJObject.GetValue('arrivalTime')));
            purchaseline.arrivalTime := Dt2Time(arrivalTime);
            purchaseline.remarks := Format(lJObject.GetValue('remarks'));

            if ModifyLineNo = 0 then
                purchaseline.Insert
            else
                purchaseline.Modify;

            lineNo += 1000;
        end;
        lJObject := lJObject.Parse(Format(lJSONString));
        lArrayString := lJObject.SelectToken('AccomodationDetails').ToString;
        Clear(lJObject);
        lJsonArray := lJsonArray.Parse(lArrayString);

        //Accoumodation detils
        foreach lJObject in lJsonArray do begin
            Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
            if ModifyLineNo = 0 then begin
                purchaseline.Init;
                purchaseline."Line No." := lineNo;
            end else
                purchaseline."Line No." := ModifyLineNo;
            purchaseline."Document No." := purchaseheader."No.";
            purchaseline."Line Type" := purchaseline."line type"::Activity;


            Evaluate(purchaseline.dateFrom, Format(lJObject.GetValue('dateFrom')));
            Evaluate(purchaseline.dateTo, Format(lJObject.GetValue('dateTo')));
            purchaseline.date := purchaseline.date;
            Evaluate(purchaseline.accomodtionCatered, Format(lJObject.GetValue('accomodationCatered')));
            purchaseline.locationOfStay := Format(lJObject.GetValue('locationOfStay'));

            Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));
            Evaluate(purchaseline.noOfDays, Format(lJObject.GetValue('noOfNights')));


            if ModifyLineNo = 0 then
                purchaseline.Insert
            else
                purchaseline.Modify;

            lineNo += 1000;
        end;

        /// Meals and incidentals
        lJObject := lJObject.Parse(Format(lJSONString));
        lArrayString := lJObject.SelectToken('MealsAndIncidentals').ToString;
        Clear(lJObject);
        lJsonArray := lJsonArray.Parse(lArrayString);

        foreach lJObject in lJsonArray do begin
            Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
            if ModifyLineNo = 0 then begin
                purchaseline.Init;
                purchaseline."Line No." := lineNo;
            end else
                purchaseline."Line No." := ModifyLineNo;
            purchaseline."Document No." := purchaseheader."No.";
            purchaseline."Line Type" := purchaseline."line type"::"Budget Info";


            Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));

            purchaseline."location." := Format(lJObject.GetValue('location'));
            purchaseline.Description := Format(lJObject.GetValue('description'));
            Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));
            Evaluate(purchaseline.noOfDays, Format(lJObject.GetValue('noOfDays')));


            if ModifyLineNo = 0 then
                purchaseline.Insert
            else
                purchaseline.Modify;

            lineNo += 1000;
        end;

        // other expenses
        lJObject := lJObject.Parse(Format(lJSONString));
        lArrayString := lJObject.SelectToken('OtherExpenses').ToString;
        Clear(lJObject);
        lJsonArray := lJsonArray.Parse(lArrayString);


        foreach lJObject in lJsonArray do begin
            Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
            if ModifyLineNo = 0 then begin
                purchaseline.Init;
                purchaseline."Line No." := lineNo;
            end else
                purchaseline."Line No." := ModifyLineNo;
            purchaseline."Document No." := purchaseheader."No.";
            purchaseline."Line Type" := purchaseline."line type"::"Budget Notes";


            Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));

            purchaseline."location." := Format(lJObject.GetValue('location'));
            purchaseline.Description := Format(lJObject.GetValue('description'));
            Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));


            if ModifyLineNo = 0 then
                purchaseline.Insert
            else
                purchaseline.Modify;
            lineNo += 1000;
        end;
        if Format(lJObject.GetValue('No')) = '' then
            purchaseheader.Insert
        else
            purchaseheader.Modify;
    end;

    // trigger Ljobject::PropertyChanged(sender: Variant; e: dotnet PropertyChangedEventArgs)
    // begin
    // end;

    // trigger Ljobject::PropertyChanging(sender: Variant; e: dotnet PropertyChangingEventArgs)
    // begin
    // end;

    // trigger Ljobject::ListChanged(sender: Variant; e: dotnet ListChangedEventArgs)
    // begin
    // end;

    // trigger Ljobject::AddingNew(sender: Variant; e: dotnet AddingNewEventArgs)
    // begin
    // end;

    // trigger Ljobject::CollectionChanged(sender: Variant; e: dotnet NotifyCollectionChangedEventArgs)
    // begin
    // end;

    // trigger Ljsonarray::ListChanged(sender: Variant; e: dotnet ListChangedEventArgs)
    // begin
    // end;

    // trigger Ljsonarray::AddingNew(sender: Variant; e: dotnet AddingNewEventArgs)
    // begin
    // end;

    // trigger Ljsonarray::CollectionChanged(sender: Variant; e: dotnet NotifyCollectionChangedEventArgs)
    // begin
    // end;
    Procedure fnGetVehicle(employee: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        Vehicleheader.RESET;
        Vehicleheader.SETRANGE("Officer Requesting", employee);
        IF Vehicleheader.FIND('-') THEN BEGIN
            REPEAT
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('code', Vehicleheader."Task Order No");
                CreateJsonAttribute('purpose', Vehicleheader.Reasons);
                CreateJsonAttribute('destination', Vehicleheader.Destination);
                CreateJsonAttribute('Duration', Vehicleheader."Hours Duration");
                CreateJsonAttribute('DateRequired', Vehicleheader."Time Required");
                CreateJsonAttribute('ReturnDate', Vehicleheader."Return Hour");
                CreateJsonAttribute('Status', Vehicleheader.Status);
                CreateJsonAttribute('NoOfStaff', Vehicleheader."No of Staff");
                CreateJsonAttribute('EmployeeNo', Vehicleheader."Officer Requesting");
                CreateJsonAttribute('EmployeeName', Vehicleheader."Name of the officer");
                CreateJsonAttribute('Branch', Vehicleheader."Global Dimension 1");
                CreateJsonAttribute('Project', Vehicleheader."Global Dimension 2");
                CreateJsonAttribute('VehicleAllocated', Vehicleheader."Vehicle Allocated");
                CreateJsonAttribute('vehicleno', Vehicleheader."Vehicle Required");
                JSONTextWriter.WriteEndObject; // End the current JSON object here
            UNTIL Vehicleheader.NEXT = 0;
        END;
        JSONTextWriter.WriteEndArray; // End the JSON array here
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    Procedure FnGetVehicleEdit(employee: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        Vehicleheader.RESET;
        Vehicleheader.SETRANGE("Task Order No", employee);
        IF Vehicleheader.FIND('-') THEN BEGIN
            REPEAT
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('code', Vehicleheader."Task Order No");
                CreateJsonAttribute('purpose', Vehicleheader.Reasons);
                CreateJsonAttribute('destination', Vehicleheader.Destination);
                CreateJsonAttribute('Duration', Vehicleheader."Hours Duration");
                CreateJsonAttribute('DateRequired', Vehicleheader."Time Required");
                CreateJsonAttribute('ReturnDate', Vehicleheader."Return Hour");
                CreateJsonAttribute('Status', Vehicleheader.Status);
                CreateJsonAttribute('NoOfStaff', Vehicleheader."No of Staff");
                CreateJsonAttribute('EmployeeNo', Vehicleheader."Officer Requesting");
                CreateJsonAttribute('EmployeeName', Vehicleheader."Name of the officer");
                CreateJsonAttribute('Branch', Vehicleheader."Global Dimension 1");
                CreateJsonAttribute('Project', Vehicleheader."Global Dimension 2");
                CreateJsonAttribute('VehicleAllocated', Vehicleheader."Vehicle Allocated");
                CreateJsonAttribute('vehicleno', Vehicleheader."Vehicle Required");
                JSONTextWriter.WriteEndObject; // End the current JSON object here
            UNTIL Vehicleheader.NEXT = 0;
        END;
        JSONTextWriter.WriteEndArray; // End the JSON array here
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnInsertVehicle(employee: Code[50]; Purpose: Text; Destination: Text; noOfStaff: Integer; DateRequired: DateTime; Duration: code[250]; Project: Code[250]; Branch: code[250]) DocumentNo: Code[50]
    var
    begin
        objHREmployees.reset();
        objHREmployees.setrange("No.", employee);
        if objHREmployees.find('-') THEN BEGIN
            Vehicleheader.RESET;
            Vehicleheader.SETRANGE("Time Required", DateRequired);
            Vehicleheader.SetRange("Officer Requesting", objHREmployees.Travelaccountno);
            IF Vehicleheader.FINDFIRST THEN BEGIN
                ERROR('Another Vehicle Request already exists Request No %1', Vehicleheader."Task Order No");
            END ELSE
                Vehicleheader.INIT;
            Vehicleheader."Driver Name" := objHREmployees."First Name" + ' ' + objHREmployees."Middle Name" + ' ' + objHREmployees."Last Name";
            Vehicleheader.Driver := employee;
            Vehicleheader."Officer Requesting" := objHREmployees."No.";
            Vehicleheader."Name of the officer" := objHREmployees."First Name" + ' ' + objHREmployees."Middle Name" + ' ' + objHREmployees."Last Name";
            Vehicleheader.Reasons := Purpose;
            Vehicleheader.Destination := Destination;
            Vehicleheader."No of Staff" := noOfStaff;
            Vehicleheader."Global Dimension 1" := Branch;
            Vehicleheader."Global Dimension 2" := Project;
            Vehicleheader."Date Created" := Today;
            Vehicleheader."Date Requested" := Today;
            Vehicleheader."Time Required" := DateRequired;
            Vehicleheader."Hours Duration" := Duration;
            Vehicleheader.validate("Hours Duration");
            Vehicleheader.Status := Vehicleheader.Status::Open;
            IF Vehicleheader.INSERT(TRUE) THEN
                DocumentNo := Vehicleheader."Task Order No";
            EXIT(DocumentNo);
        END;
    end;


    procedure fnModifyVehicle(No: Code[50]; Purpose: Text; Destination: Text; noOfStaff: Integer; DateRequired: DateTime; Duration: Code[250]; Project: Code[250]; Branch: code[250]) MileageCode: Code[50]
    var
    begin
        Vehicleheader.RESET;
        Vehicleheader.SETRANGE("Task Order No", No);
        IF Vehicleheader.FIND('-') THEN BEGIN

            Vehicleheader.Reasons := Purpose;
            Vehicleheader.Destination := Destination;
            Vehicleheader."No of Staff" := noOfStaff;
            Vehicleheader."Global Dimension 1" := Branch;
            Vehicleheader."Global Dimension 2" := Project;
            Vehicleheader."Date Created" := Today;
            Vehicleheader."Date Requested" := Today;
            Vehicleheader."Time Required" := DateRequired;
            Vehicleheader."Hours Duration" := Duration;
            Vehicleheader.validate("Hours Duration");
            Vehicleheader.Status := Vehicleheader.Status::Open;
            IF Vehicleheader.MODIFY(TRUE) THEN
                MileageCode := Vehicleheader."Task Order No";
            EXIT(MileageCode);
        END;
    end;


    procedure fnVehicleApproval(no: Code[50])
    var
    begin
        Vehicleheader.RESET;
        Vehicleheader.SETRANGE("Task Order No", no);
        IF Vehicleheader.FIND('-') THEN BEGIN
            TimesheetRec := Vehicleheader;
            IF CustomApprovals.CheckApprovalsWorkflowEnabled(TimesheetRec) THEN
                CustomApprovals.OnSendDocForApproval(TimesheetRec);
        END;
    end;

    procedure FnGetEmployeeNo(Email: text) EmpNo: Code[100]

    var
        EmailUper: Text;
        EmailLower: Text;
    begin
        EmailLower := '';
        EmailUper := '';
        EmailLower := LowerCase(Email);
        EmailUper := UpperCase(Email);
        HREmployees.Reset();
        HREmployees.SetRange("Company E-Mail", EmailLower);
        if HREmployees.FindFirst() then begin
            EmpNo := HREmployees."No.";
        end;
        exit(EmpNo);
    end;

    procedure FnGetUserID(Email: text) EmpNo: Code[100]

    var
        EmailUper: Text;
        EmailLower: Text;
    begin
        EmailLower := '';
        EmailUper := '';
        EmailLower := LowerCase(Email);
        EmailUper := UpperCase(Email);
        HREmployees.Reset();
        HREmployees.SetRange("Company E-Mail", EmailLower);
        if HREmployees.FindFirst() then begin
            EmpNo := HREmployees."Employee UserID";
        end;
        exit(EmpNo);
    end;





    procedure GetRecord(jsontext: Text; No: Code[250]): Text
    var
        Customer: Record Customer;
        Item: Record Item;
        JSONManagementV2: Codeunit JsonFunctions;
        RecordRef: RecordRef;
        mJsonArray: JsonArray;
        JsonObject: JsonObject;
        NameToken: JsonToken;
        NameRecord: Text;
        Output: Text;
    begin


        NameRecord := jsontext;

        case NameRecord of
            'Purchase':
                begin

                    purchaseheader.Reset();
                    purchaseheader.SetRange("Employee No", No);
                    purchaseheader.SetRange("Document Type", purchaseheader."Document Type"::Quote);
                    purchaseheader.FindSet();
                    repeat
                        mJsonArray.Add(JSONManagementV2.RecordToJson(purchaseheader));
                    until purchaseheader.Next() = 0;
                end;
        //  'PurchaseLine':
        // begin
        //     purchaseline.Reset();
        //     purchaseline.SetRange("Docu", No);
        //     purchaseline.FindSet();
        //     repeat
        //         mJsonArray.Add(JSONManagementV2.RecordToJson(purchaseline));
        //     until purchaseline.Next() = 0;
        // end;
        end;
    end;

    Procedure fnGetMyRecords(employee: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        purchaseheader.RESET;
        purchaseheader.SETRANGE("Employee No", employee);
        IF purchaseheader.FIND('-') THEN BEGIN
            REPEAT
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', purchaseheader."No.");
                CreateJsonAttribute('DocumentDate', Format(purchaseheader."Document Date"));
                CreateJsonAttribute('ShortcutDimension1Code', purchaseheader."Shortcut Dimension 1 Code");
                CreateJsonAttribute('ShortcutDimension2Code', purchaseheader."Shortcut Dimension 2 Code");
                CreateJsonAttribute('PayeeNaration', purchaseheader."Payee Naration");
                CreateJsonAttribute('Amount', Format(purchaseheader."Amount Including VAT"));
                CreateJsonAttribute('Status', purchaseheader.Status);
                CreateJsonAttribute('AUFormType', purchaseheader."AU Form Type");
                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WriteEndObject;
            UNTIL purchaseheader.NEXT = 0;
        END;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    Procedure fnGetFinance(employee: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;

        objHREmployees.Reset();
        objHREmployees.SetRange("No.", employee);
        if objHREmployees.Find('-') then
            purchaseheader.RESET;
        purchaseheader.SETRANGE("Employee No", employee);
        IF purchaseheader.FIND('-') THEN
            REPEAT
                purchaseheader.CalcFields("Travel Total", "Net Amount in foreign Currency");
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', purchaseheader."No.");
                CreateJsonAttribute('DocumentDate', Format(purchaseheader."Document Date"));
                CreateJsonAttribute('ShortcutDimension1Code', purchaseheader."Shortcut Dimension 1 Code");
                CreateJsonAttribute('ShortcutDimension2Code', purchaseheader."Shortcut Dimension 2 Code");
                CreateJsonAttribute('PayeeNaration', purchaseheader.Purpose);
                CreateJsonAttribute('Amount', purchaseheader."Travel Total");
                CreateJsonAttribute('AmountForeign', purchaseheader."Net Amount in foreign Currency");
                CreateJsonAttribute('Status', purchaseheader.Status);
                CreateJsonAttribute('NetAmountinforeignCurrency', purchaseheader."Net Amount in foreign Currency");
                CreateJsonAttribute('AUFormType', purchaseheader."AU Form Type");
                JSONTextWriter.WritePropertyName('relationships');
                JSONTextWriter.WriteStartArray;
                TimesheetLinesNew.RESET;
                TimesheetLinesNew.SETRANGE("Timesheet No", TimesheetHeaderNew."Timesheet Header No");
                IF TimesheetLinesNew.FIND('-') THEN BEGIN
                    REPEAT

                        JSONTextWriter.WriteStartObject;



                        JSONTextWriter.WriteEndObject;

                    UNTIL TimesheetLinesNew.NEXT = 0;
                END;

                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WriteEndObject;
            UNTIL purchaseheader.NEXT = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    Procedure fnEditFinance(No: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        purchaseheader.RESET;
        purchaseheader.SETRANGE("No.", No);
        IF purchaseheader.FIND('-') THEN
            REPEAT
                purchaseheader.CalcFields("Travel Total");
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('No', purchaseheader."No.");
                CreateJsonAttribute('DocumentDate', Format(purchaseheader."Document Date"));
                CreateJsonAttribute('ShortcutDimension1Code', purchaseheader."Shortcut Dimension 1 Code");
                CreateJsonAttribute('ShortcutDimension2Code', purchaseheader."Shortcut Dimension 2 Code");
                CreateJsonAttribute('ShortcutDimension3Code', purchaseheader."Shortcut Dimension 3 Code");
                CreateJsonAttribute('ShortcutDimension4Code', purchaseheader."Shortcut Dimension 4 Code");
                CreateJsonAttribute('PayeeNaration', purchaseheader.Purpose);
                // CreateJsonAttribute('Amount', purchaseheader."Travel Total");
                CreateJsonAttribute('Status', purchaseheader.Status);
                CreateJsonAttribute('AUFormType', purchaseheader."AU Form Type");
                CreateJsonAttribute('fromDate', purchaseheader.fromDate);
                CreateJsonAttribute('DueDate', purchaseheader."Due Date");
                CreateJsonAttribute('CurrencyCode', purchaseheader."Currency Code");
                CreateJsonAttribute('PostingDate', purchaseheader."Posting Date");
                JSONTextWriter.WritePropertyName('relationships');
                JSONTextWriter.WriteStartArray;
                purchaseline.RESET;
                purchaseline.SETRANGE("Document No.", purchaseheader."No.");
                IF purchaseline.FIND('-') THEN BEGIN
                    REPEAT

                        JSONTextWriter.WriteStartObject;
                        CreateJsonAttribute('ExpenseCategory', purchaseline."Expense Category");
                        JSONTextWriter.WritePropertyName('Type');
                        JSONTextWriter.WriteValue(Format(purchaseline.Type));
                        JSONTextWriter.WritePropertyName('No');
                        JSONTextWriter.WriteValue(purchaseline."No.");
                        JSONTextWriter.WritePropertyName('Description');
                        JSONTextWriter.WriteValue(purchaseline.Description);
                        JSONTextWriter.WritePropertyName('Description2');
                        JSONTextWriter.WriteValue(purchaseline."Description 2");
                        JSONTextWriter.WritePropertyName('Quantity');
                        JSONTextWriter.WriteValue(FORMAT(ROUND(purchaseline.Quantity, 0.01, '>')));
                        JSONTextWriter.WritePropertyName('ActivityDescription');
                        JSONTextWriter.WriteValue(purchaseline.Rate);
                        JSONTextWriter.WritePropertyName('DirectUnitCost');
                        JSONTextWriter.WriteValue(FORMAT(ROUND(purchaseline."Direct Unit Cost", 0.01, '>')));
                        JSONTextWriter.WritePropertyName('Amount');
                        JSONTextWriter.WriteValue(FORMAT(ROUND(purchaseline.Amount, 0.01, '>')));
                        JSONTextWriter.WritePropertyName('LineNo');
                        JSONTextWriter.WriteValue(purchaseline."Line No.");
                        JSONTextWriter.WritePropertyName('DocumentNo');
                        JSONTextWriter.WriteValue(purchaseline."Document No.");
                        JSONTextWriter.WritePropertyName('Rate');
                        JSONTextWriter.WriteValue(purchaseline.Rate);
                        JSONTextWriter.WritePropertyName('ClaimType');
                        JSONTextWriter.WriteValue(Format(purchaseline."Claim Type"));
                        JSONTextWriter.WritePropertyName('ShortcutDimCode4');
                        JSONTextWriter.WriteValue(purchaseline."ShortcutDimCode[4]");
                        JSONTextWriter.WritePropertyName('ShortcutDimCode3');
                        JSONTextWriter.WriteValue(purchaseline."ShortcutDimCode[3]");
                        JSONTextWriter.WritePropertyName('date');
                        JSONTextWriter.WriteValue(purchaseline.date);
                        JSONTextWriter.WriteEndObject;

                    UNTIL purchaseline.NEXT = 0;
                END;

                JSONTextWriter.WriteEndArray;
                JSONTextWriter.WriteEndObject;
            UNTIL purchaseheader.NEXT = 0;
        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    Procedure GetFirstName(EmpNo: Code[250]) Name: text
    var
    begin
        objHREmployees.Reset();
        objHREmployees.SetRange("Employee UserID", EmpNo);
        if objHREmployees.Find('-') then begin
            Name := objHREmployees."First Name";
            exit(Name);
        end;

    end;

    Procedure fnGetHelbDesk(employee: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        HelbDesk.RESET;
        HelbDesk.SETRANGE(HelbDesk."Member No", employee);
        IF HelbDesk.FIND('-') THEN BEGIN
            REPEAT
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('code', HelbDesk.No);
                CreateJsonAttribute('Description', HelbDesk.Description);
                CreateJsonAttribute('Department', HelbDesk.Department);
                CreateJsonAttribute('contactmode', HelbDesk."Contact Mode");
                CreateJsonAttribute('DateRequired', HelbDesk."Application Date");
                CreateJsonAttribute('Status', HelbDesk.Status);
                CreateJsonAttribute('CaseType', HelbDesk."Type of Cases");
                CreateJsonAttribute('EmployeeNo', HelbDesk."Member No");
                CreateJsonAttribute('EmployeeName', HelbDesk."Member Name");
                CreateJsonAttribute('Escalatedto', HelbDesk."Caller Reffered To");
                JSONTextWriter.WriteEndObject;
            UNTIL HelbDesk.NEXT = 0;
        END;
        JSONTextWriter.WriteEndArray; // End the JSON array here
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    Procedure FnGetHelbDeskEdit(No: Code[50]) returnout: Text
    var
        JsonOut: dotnet String;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        HelbDesk.RESET;
        HelbDesk.SETRANGE(No, No);
        IF HelbDesk.FIND('-') THEN BEGIN
            REPEAT
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('code', HelbDesk.No);
                CreateJsonAttribute('Description', HelbDesk.Description);
                CreateJsonAttribute('Department', HelbDesk.Department);
                CreateJsonAttribute('contactmode', HelbDesk."Contact Mode");
                CreateJsonAttribute('DateRequired', HelbDesk."Application Date");
                CreateJsonAttribute('Status', HelbDesk.Status);
                CreateJsonAttribute('CaseType', HelbDesk."Type of Cases");
                CreateJsonAttribute('EmployeeNo', HelbDesk."Member No");
                CreateJsonAttribute('EmployeeName', HelbDesk."Member Name");
                CreateJsonAttribute('Escalatedto', HelbDesk."Caller Reffered To");
                JSONTextWriter.WriteEndObject; // End the current JSON object here
            UNTIL HelbDesk.NEXT = 0;
        END;
        JSONTextWriter.WriteEndArray; // End the JSON array here
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure fnInsertHelbDesk(employee: Code[50]; Description: Text; Department: code[30]; ContactMode: Integer; CaseType: code[250]; EscalateTo: Code[250]) DocumentNo: Code[50]
    var
    begin
        objHREmployees.reset();
        objHREmployees.setrange("No.", employee);
        if objHREmployees.find('-') THEN BEGIN
            if HREmployees.Get(EscalateTo) then
                HelbDesk.INIT;
            HelbDesk."Member Name" := objHREmployees."First Name" + ' ' + objHREmployees."Middle Name" + ' ' + objHREmployees."Last Name";
            HelbDesk."Member No" := employee;
            HelbDesk."Caller Reffered To" := HREmployees."No.";
            HelbDesk."Escalated User Email" := HREmployees."Company E-Mail";
            HelbDesk.Description := Description;
            HelbDesk.Department := Department;
            HelbDesk."Contact Mode" := ContactMode;
            HelbDesk."Type of Cases" := CaseType;
            HelbDesk."Date Sent" := Today;
            HelbDesk."Application Date" := Today;
            HelbDesk.Status := HelbDesk.Status::New;
            IF HelbDesk.INSERT(TRUE) THEN
                DocumentNo := HelbDesk.No;
            EXIT(DocumentNo);
        END;
    end;

    procedure fnModifyHelbDesk(No: Code[50]; Description: Text; Department: code[30]; ContactMode: Integer; CaseType: code[250]; EscalateTo: Code[250]) DocumentNo: Code[50]
    var
    begin
        HelbDesk.reset();
        HelbDesk.setrange(No, No);
        if HelbDesk.find('-') THEN BEGIN
            if HREmployees.Get(EscalateTo) then
                HelbDesk."Caller Reffered To" := HREmployees."No.";
            HelbDesk."Escalated User Email" := HREmployees."Company E-Mail";
            HelbDesk.Description := Description;
            HelbDesk.Department := Department;
            HelbDesk."Contact Mode" := ContactMode;
            HelbDesk."Type of Cases" := CaseType;
            HelbDesk."Date Sent" := Today;
            HelbDesk."Application Date" := Today;
            HelbDesk.Status := HelbDesk.Status::New;
            IF HelbDesk.Modify(TRUE) THEN
                DocumentNo := HelbDesk.No;
            EXIT(DocumentNo);
        END;
    end;


    procedure fnGetCrmCaseType() returnout: Text
    var
        ObjDimensionValue: Record "CRM Case Types";
        JsonOut: dotnet String;
    begin

        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartArray;
        ObjDimensionValue.Reset;
        if ObjDimensionValue.FindSet() then
            repeat
                JSONTextWriter.WriteStartObject;
                CreateJsonAttribute('Code', ObjDimensionValue.Code);
                CreateJsonAttribute('Name', ObjDimensionValue.Code + ' - ' + ObjDimensionValue.Description);
                JSONTextWriter.WriteEndObject;
            until ObjDimensionValue.Next = 0;

        JSONTextWriter.WriteEndArray;
        JsonOut := StringBuilder.ToString;
        returnout := JsonOut;
    end;

    procedure FnSendToICT(no: Code[50])
    var
    begin
        HelbDesk.RESET;
        HelbDesk.SETRANGE(No, no);
        IF HelbDesk.FIND('-') THEN BEGIN
            HelbDesk.Status := HelbDesk.Status::Pending;
            HelbDesk.Modify();
        END;
    end;



}