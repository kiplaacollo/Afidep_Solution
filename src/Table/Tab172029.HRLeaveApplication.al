Table 172029 "HR Leave Application" //172029
{

    fields
    {
        field(1; "Application Code"; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if "Application Code" <> xRec."Application Code" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Leave Application Nos.");
                    "No series" := '';
                end;
            end;
        }
        field(3; "Leave Type"; Code[30])
        {
            TableRelation = "HR Leave Types".Code;

            trigger OnValidate()
            begin
                HRLeaveTypes.Reset;
                HRLeaveTypes.SetRange(HRLeaveTypes.Code, "Leave Type");
                if HRLeaveTypes.Find('-') then begin
                    HREmp.Reset;
                    HREmp.SetRange(HREmp."No.", "Employee No");
                    HREmp.SetRange(HREmp.Gender, HRLeaveTypes.Gender);
                    if HREmp.Find('-') then
                        exit
                    // else
                    //     if HRLeaveTypes.Gender <> HRLeaveTypes.Gender::Other then
                    //         Error('This leave type is restricted to the ' + Format(HRLeaveTypes.Gender) + ' gender');
                end;
            end;
        }
        field(4; "Days Applied"; Decimal)
        {

            trigger OnValidate()
            begin

                HREmployees.Reset;
                HREmployees.SetRange("No.", "Employee No");
                if HREmployees.Find('-') then begin
                    HREmployees.CalcFields("Maternity Leave Acc..", "Paternity Leave Acc.", "Annual Leave Account", "Compassionate Leave Acc.", "Sick Leave Acc.", "Study Leave Acc", "CTO  Leave Acc.", "Special  Leave Acc.");
                    if "Leave Type" = 'COMPASSIONATE' then
                        balance := HREmployees."Compassionate Leave Acc.";
                    if "Leave Type" = 'EXAM' then
                        balance := HREmployees."Study Leave Acc";
                    if "Leave Type" = 'MATERNITY' then
                        balance := HREmployees."Maternity Leave Acc..";
                    if "Leave Type" = 'PATERNITY' then
                        balance := HREmployees."Paternity Leave Acc.";
                    if "Leave Type" = 'ANNUAL' then
                        balance := HREmployees."Annual Leave Account";
                    if "Leave Type" = 'SICK' then
                        balance := HREmployees."Sick Leave Acc.";
                    if "Leave Type" = 'CTO' then
                        balance := HREmployees."CTO  Leave Acc.";
                    if "Leave Type" = 'SPECIAL' then
                        balance := HREmployees."Special  Leave Acc.";
                end;

                if ("Is reimbursement" = false) and (balance < "Days Applied") then
                    Error('you cannot apply for more that %1 days, Unless it is reimbursement', balance);

                CalcFields("Available Days");
                if (("Available Days" = 0) or ("Days Applied" > "Available Days")) then begin
                    //ERROR('Applied days must not be more than leave balance.');
                    Error('%1,%2', "Employee No", "Days Applied");
                end;
                if ("Days Applied" <> 0) and ("Start Date" <> 0D) then begin
                    Validate("Start Date")
                end;
                "Approved days" := "Days Applied";

            end;
        }
        field(5; "Start Date"; Date)
        {

            trigger OnValidate()
            begin

                //new start date validation
                dates.Reset;
                dates.SetRange(dates."Period Start", "Start Date");
                dates.SetFilter(dates."Period Type", '=%1', dates."period type"::Date);
                if dates.Find('-') then
                    if ((dates."Period Name" = 'Sunday') or (dates."Period Name" = 'Saturday') and ("Is reimbursement" = false)) then begin
                        if (dates."Period Name" = 'Sunday') and ("Is reimbursement" = false) then
                            Error('You can not start your leave on a Sunday')
                        else
                            if (dates."Period Name" = 'Saturday') then Error('You can not start your leave on a Saturday')
                    end;

                BaseCalendar.Reset;
                BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
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
                BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
                BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."recurring system"::"Annual Recurring");
                if BaseCalendar.Find('-') then begin
                    repeat
                        //IF ((DATE2DMY("Start Date",1)=BaseCalendar."Date Day") AND (DATE2DMY("Start Date",2)=BaseCalendar."Date Month")) THEN BEGIN
                        if "Start Date" = BaseCalendar.Date then begin

                            if BaseCalendar.Nonworking = true then begin
                                if BaseCalendar.Description <> '' then
                                    Error('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                                else
                                    Error('You can not start your Leave on a Holiday');
                            end;
                        end;
                    until BaseCalendar.Next = 0;
                end;
                if "Days Applied" = 1 then begin
                    "End Date" := "Start Date";
                    "Return Date" := CalcReturnDate("End Date");
                end;
                if "Days Applied" < 1 then begin
                    "End Date" := "Start Date";
                    "Return Date" := "Start Date";
                end;

                if ("Days Applied" > 1) and ("Start Date" <> 0D) then begin
                    "End Date" := CalcEndDate("Start Date", "Days Applied");
                    "Return Date" := CalcReturnDate("End Date");
                    //"Approved End Date":="End Date";

                end;




                HRLeaveApp.Reset;
                HRLeaveApp.SetRange("Employee No", "Employee No");
                HRLeaveApp.SetRange("Leave Type", "Leave Type");
                //HRLeaveApp.SETRANGE(Status,HRLeaveApp.Status::Posted);
                HRLeaveApp.SetFilter("Application Code", '<>%1', "Application Code");
                if HRLeaveApp.FindSet then begin
                    repeat
                        if "Start Date" < HRLeaveApp."End Date" then
                            if "Start Date" > HRLeaveApp."Start Date" then
                                Error('You have another ' + HRLeaveApp."Leave Type" + ' leave that is starting on ' + Format(HRLeaveApp."Start Date") +
                                ' and ending on ' + Format(HRLeaveApp."End Date"));
                    until HRLeaveApp.Next = 0;
                end;

            end;
        }
        field(6; "Return Date"; Date)
        {
            Caption = 'Return Date';
            Editable = true;
        }
        field(7; "Application Date"; Date)
        {
        }
        field(12; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,HOD Approval,HR Approval,Final Approval,Rejected,Canceled,Approved,On leave,Resumed,Posted';
            OptionMembers = New,"Pending Approval","HOD Approval","HR Approval",MDApproval,Rejected,Canceled,Approved,"On leave",Resumed,Posted;

            trigger OnValidate()
            begin
                // if Status = Status::Approved then begin
                //     intEntryNo := 0;

                //     HRLeaveEntries.Reset;
                //     HRLeaveEntries.SetRange(HRLeaveEntries."Entry No.");
                //     if HRLeaveEntries.Find('-') then intEntryNo := HRLeaveEntries."Entry No.";

                //     intEntryNo := intEntryNo + 1;

                //     HRLeaveEntries.Init;
                //     HRLeaveEntries."Entry No." := intEntryNo;
                //     HRLeaveEntries."Staff No." := "Employee No";
                //     HRLeaveEntries."Staff Name" := Names;
                //     HRLeaveEntries."Posting Date" := Today;
                //     HRLeaveEntries."Leave Entry Type" := HRLeaveEntries."leave entry type"::Negative;
                //     HRLeaveEntries."Leave Approval Date" := "Application Date";
                //     HRLeaveEntries."Document No." := "Application Code";
                //     HRLeaveEntries."External Document No." := "Employee No";
                //     //HRLeaveEntries."Job ID":="Job Tittle";
                //     HRLeaveEntries."No. of days" := "Days Applied";
                //     HRLeaveEntries."Leave Start Date" := "Start Date";
                //     HRLeaveEntries."Leave Posting Description" := 'Leave';
                //     HRLeaveEntries."Leave End Date" := "End Date";
                //     HRLeaveEntries."Leave Return Date" := "Return Date";
                //     HRLeaveEntries."User ID" := "User ID";
                //     HRLeaveEntries."Leave Type" := "Leave Type";
                //     HRLeaveEntries.Insert;
                //end;
            end;
        }
        field(15; "Applicant Comments"; Text[250])
        {
        }
        field(17; "No series"; Code[30])
        {
        }
        // field(18; Gender; Enum "Employee Gender")
        // {
        //     Editable = false;

        // }
        field(24; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(28; Selected; Boolean)
        {
        }
        field(31; "Current Balance"; Decimal)
        {
        }
        field(36; "Department Code"; Code[220])
        {

            trigger OnValidate()
            begin
                /*IF SalCard.GET("No.") THEN BEGIN
                SalCard.Department:="Department Code";
                SalCard.MODIFY;
                END;
                */

            end;
        }
        field(3900; "End Date"; Date)
        {
            Editable = false;
        }
        field(3901; "Total Taken"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(3921; "E-mail Address"; Text[60])
        {
            Editable = false;
            ExtendedDatatype = EMail;
        }
        field(3924; "Entry No"; Integer)
        {
        }
        field(3929; "Start Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(3936; "Cell Phone Number"; Text[50])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(3937; "Request Leave Allowance"; Boolean)
        {

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Employee No");
                if HREmp.Find('-') then begin
                    if HREmp."Leave Allowance Claimed" = true then
                        Error('Leave Allowance has been claimed');
                    Allowance := HREmp."Leave Allowance Amount";
                    if "Request Leave Allowance" = true then begin
                        "Leave Allowance Amount" := Allowance;

                    end
                    else begin
                        "Leave Allowance Amount" := 0;


                    end;
                    //HREmp."Leave Allowance Claimed":=TRUE;
                    //HREmp.MODIFY;

                end;
            end;
        }
        field(3939; Picture; Blob)
        {
        }
        field(3940; Names; Text[100])
        {
        }
        field(3942; "Leave Allowance Entittlement"; Decimal)
        {
            CalcFormula = lookup("HR Employees"."Leave Allowance Amount" where("No." = field("Employee No")));
            FieldClass = FlowField;
        }
        field(3943; "Leave Allowance Amount"; Decimal)
        {
        }
        field(3945; "Details of Examination"; Text[200])
        {
        }
        field(3947; "Date of Exam"; Date)
        {
        }
        field(3949; Reliever; Code[250])
        {
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                //DISPLAY RELIEVERS NAME
                if Reliever = "Employee No" then
                    Error('Employee cannot relieve him/herself');

                if HREmp.Get(Reliever) then
                    "Reliever Name" := HREmp.FullName;
            end;
        }
        field(3950; "Reliever Name"; Text[100])
        {
        }
        field(3952; Description; Text[230])
        {
        }
        field(3955; "Supervisor Email"; Text[50])
        {
        }
        field(3956; "Number of Previous Attempts"; Text[200])
        {
        }
        field(3958; "Job Tittle"; Text[250])
        {
        }
        field(3959; "User ID"; Code[250])
        {
        }
        field(3961; "Employee No"; Code[200])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmp.RESET;
                HREmp.SETRANGE(HREmp."No.", "Employee No");
                IF HREmp.FIND('-') THEN BEGIN
                    "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Responsibility Center" := HREmp."Responsibility Center";
                    "Responsibility Center Name" := HREmp."Responsibility Center Name";
                    Gender := HREmp.Gender;
                    "Application Date" := Today;
                    "User ID" := UserId;
                    "Cell Phone Number" := HREmp."Cell Phone Number";
                    "E-mail Address" := HREmp."Company E-Mail";
                    "Job Tittle" := HREmp."Job Title";
                    HREmp.CalcFields(HREmp.Picture);
                    Picture := HREmp.Picture;
                end;
                /*HREmp.RESET;
                HREmp.SETRANGE(HREmp."No.","Employee No");
                IF HREmp.FIND('-') THEN BEGIN
                "Employee Name":=HREmp."First Name"+ ' ' +HREmp."Middle Name"+ ' ' +HREmp."Last Name";
                  MODIFY;
                END
                */

            end;
        }
        field(3962; Supervisor; Code[250])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(3969; "Responsibility Center"; Code[220])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(3970; "Approved days"; Integer)
        {

            trigger OnValidate()
            begin
                if "Approved days" > "Days Applied" then
                    Error(TEXT001);
            end;
        }
        field(3971; Attachments; Integer)
        {
            Editable = false;
        }
        field(3972; Emergency; Boolean)
        {
            Description = 'This is used to ensure one can apply annual leave which is emergency';
        }
        field(3973; "Approver Comments"; Text[200])
        {
        }
        field(3974; "Available Days"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where("Staff No." = field("Employee No")));
            FieldClass = FlowField;
        }
        field(3975; Reliever2; Code[50])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                //DISPLAY RELEIVERS NAME
                if Reliever2 = "Employee No" then
                    Error('Employee cannot relieve him/herself');

                if HREmp.Get(Reliever2) then
                    "Reliever Name2" := HREmp.FullName;
            end;
        }
        field(3976; "Reliever Name2"; Text[100])
        {
            Editable = false;
        }
        field(3977; "Date Of Exam 1"; Date)
        {

            trigger OnValidate()
            begin
                //IF "Date Of Exam 1"<"Application Date"THEN
                //ERROR('You cannot Start your leave before the application date');


                if "Date Of Exam 1" = "Date Of Exam 7" then
                    Error('Date already assigned');
                if "Date Of Exam 1" = "Date Of Exam 3" then
                    Error('Date already assigned');

                if "Date Of Exam 1" = "Date Of Exam 4" then
                    Error('Date already assigned');

                if "Date Of Exam 1" = "Date Of Exam 5" then
                    Error('Date already assigned');

                if "Date Of Exam 1" = "Date Of Exam 6" then
                    Error('Date already assigned');

                if "Date Of Exam 1" = "Date Of Exam 2" then
                    Error('Date already assigned');
            end;
        }
        field(3978; "Date Of Exam 2"; Date)
        {

            trigger OnValidate()
            begin
                // IF "Date Of Exam 2"<"Application Date"THEN
                //ERROR('You cannot Start your leave before the application date');

                if "Date Of Exam 2" = "Date Of Exam 1" then
                    Error('Date already assigned');
                if "Date Of Exam 2" = "Date Of Exam 3" then
                    Error('Date already assigned');

                if "Date Of Exam 2" = "Date Of Exam 4" then
                    Error('Date already assigned');

                if "Date Of Exam 2" = "Date Of Exam 5" then
                    Error('Date already assigned');

                if "Date Of Exam 2" = "Date Of Exam 6" then
                    Error('Date already assigned');

                if "Date Of Exam 2" = "Date Of Exam 7" then
                    Error('Date already assigned');
            end;
        }
        field(3979; "Date Of Exam 3"; Date)
        {

            trigger OnValidate()
            begin
                //IF "Date Of Exam 3"<"Application Date"THEN
                //ERROR('You cannot Start your leave before the application date');

                if "Date Of Exam 3" = "Date Of Exam 1" then
                    Error('Date already assigned');
                if "Date Of Exam 3" = "Date Of Exam 2" then
                    Error('Date already assigned');

                if "Date Of Exam 3" = "Date Of Exam 4" then
                    Error('Date already assigned');

                if "Date Of Exam 3" = "Date Of Exam 5" then
                    Error('Date already assigned');

                if "Date Of Exam 3" = "Date Of Exam 6" then
                    Error('Date already assigned');

                if "Date Of Exam 3" = "Date Of Exam 7" then
                    Error('Date already assigned');
            end;
        }
        field(3980; "Date Of Exam 4"; Date)
        {

            trigger OnValidate()
            begin
                // IF "Date Of Exam 4"<"Application Date"THEN
                //ERROR('You cannot Start your leave before the application date');

                if "Date Of Exam 4" = "Date Of Exam 1" then
                    Error('Date already assigned');
                if "Date Of Exam 4" = "Date Of Exam 3" then
                    Error('Date already assigned');

                if "Date Of Exam 4" = "Date Of Exam 2" then
                    Error('Date already assigned');

                if "Date Of Exam 4" = "Date Of Exam 5" then
                    Error('Date already assigned');

                if "Date Of Exam 4" = "Date Of Exam 6" then
                    Error('Date already assigned');

                if "Date Of Exam 4" = "Date Of Exam 7" then
                    Error('Date already assigned');
            end;
        }
        field(3981; "Date Of Exam 5"; Date)
        {

            trigger OnValidate()
            begin
                // IF "Date Of Exam 5"<"Application Date"THEN
                //ERROR('You cannot Start your leave before the application date');

                if "Date Of Exam 5" = "Date Of Exam 1" then
                    Error('Date already assigned');
                if "Date Of Exam 5" = "Date Of Exam 3" then
                    Error('Date already assigned');

                if "Date Of Exam 5" = "Date Of Exam 4" then
                    Error('Date already assigned');

                if "Date Of Exam 5" = "Date Of Exam 2" then
                    Error('Date already assigned');

                if "Date Of Exam 5" = "Date Of Exam 6" then
                    Error('Date already assigned');

                if "Date Of Exam 5" = "Date Of Exam 7" then
                    Error('Date already assigned');
            end;
        }
        field(3982; "Date Of Exam 6"; Date)
        {

            trigger OnValidate()
            begin


                if "Date Of Exam 6" = "Date Of Exam 1" then
                    Error('Date already assigned');
                if "Date Of Exam 6" = "Date Of Exam 3" then
                    Error('Date already assigned');

                if "Date Of Exam 6" = "Date Of Exam 4" then
                    Error('Date already assigned');

                if "Date Of Exam 6" = "Date Of Exam 5" then
                    Error('Date already assigned');

                if "Date Of Exam 6" = "Date Of Exam 2" then
                    Error('Date already assigned');

                if "Date Of Exam 6" = "Date Of Exam 7" then
                    Error('Date already assigned');
            end;
        }
        field(3983; "Date Of Exam 7"; Date)
        {

            trigger OnValidate()
            begin
                //IF "Date Of Exam 7"<"Application Date"THEN
                //ERROR('You cannot Start your leave before the application date');

                if "Date Of Exam 7" = "Date Of Exam 1" then
                    Error('Date already assigned');
                if "Date Of Exam 7" = "Date Of Exam 3" then
                    Error('Date already assigned');

                if "Date Of Exam 7" = "Date Of Exam 4" then
                    Error('Date already assigned');

                if "Date Of Exam 7" = "Date Of Exam 5" then
                    Error('Date already assigned');

                if "Date Of Exam 7" = "Date Of Exam 6" then
                    Error('Date already assigned');

                if "Date Of Exam 7" = "Date Of Exam 2" then
                    Error('Date already assigned');
            end;
        }
        field(3984; "Employee Name"; Text[150])
        {
        }
        field(3985; "Address No."; Text[280])
        {
        }
        field(3986; "Leave No"; Code[250])
        {
            TableRelation = "HR Leave Application"."Application Code" where("Employee No" = field("Employee No"),
                                                                             "Leave Type" = field("Leave Type"));

            trigger OnValidate()
            begin

                if HRLeaveApplication5.Get("Leave No") then begin
                    "Leave Type" := HRLeaveApplication5."Leave Type";
                    "Days Applied" := HRLeaveApplication5."Days Applied";
                    "Approved days" := HRLeaveApplication5."Approved days";
                    "Start Date" := HRLeaveApplication5."Start Date";
                    "End Date" := HRLeaveApplication5."End Date";
                    "Return Date" := HRLeaveApplication5."Return Date";
                end;
            end;
        }
        field(3987; "Is reimbursement"; Boolean)
        {
        }
        field(3988; "Pending Tasks"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(3989; "Responsibility Center Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3990; "Leave Balance Per Category"; Decimal)
        {

        }
        field(3991; SupervisorName; Text[200])
        {

        }
        field(4000; "Branch Code"; Code[250])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            trigger OnValidate()
            var
            begin
                HREmp.Reset();
                HREmp.SetRange("No.", "Employee No");
                if HREmp.Find('-') then begin
                    "Branch Code" := HREmp."Global Dimension 1 Code";
                end

            end;


        }
        field(4001; "Apply Half day"; Decimal)
        {

        }
    }

    keys
    {
        key(Key1; "Application Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Application Code", "Leave Type", "Days Applied", "Start Date")
        {
        }
    }

    trigger OnDelete()
    begin
        //IF Status<>Status::New THEN ERROR('You cannot delete this leave application');
    end;

    trigger OnInsert()
    begin
        //No. Series
        if "Application Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Leave Application Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.", xRec."No series", 0D, "Application Code", "No series");
        end;

        HREmp.Reset;
        HREmp.SetRange(HREmp."Employee UserID", UserId);
        if HREmp.Find('-') then begin
            //HREmp.TestField(HREmp."Date Of Join");

            Calendar.Reset;
            Calendar.SetRange("Period Type", Calendar."period type"::Month);
            Calendar.SetRange("Period Start", HREmp."Date Of Join", Today);
            empMonths := Calendar.Count;


            //Populate fields
            "Employee No" := HREmp."No.";
            Validate("Employee No");
            "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            "Responsibility Center" := HREmp."Responsibility Center";
            "Responsibility Center Name" := HREmp."Responsibility Center Name";
            Gender := HREmp.Gender;
            "Application Date" := Today;
            "User ID" := UserId;
            "Cell Phone Number" := HREmp."Cell Phone Number";
            "E-mail Address" := HREmp."Company E-Mail";
            "Job Tittle" := HREmp."Job Title";
            HREmp.CalcFields(HREmp.Picture);
            Picture := HREmp.Picture;
            //Approver details
            GetApplicantSupervisor(UserId);
        end else begin
            Error('UserID' + ' ' + '[' + UserId + ']' + ' has not been assigned to any employee. Please consult the HR officer for assistance')
        end;
    end;

    var
        TEXT001: label 'Days Approved cannot be more than applied days';
        Text002: label 'You cannot apply for leave until your are over [%1] months old in the company';
        Text003: label 'UserID [%1] does not exist in [%2]';
        Allowance: Decimal;
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmp: Record "HR Employees";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        //SMTP: Codeunit "SMTP Mail";
        LeaveGjline: Record "HR Journal Line";
        "LineNo.": Integer;
        ApprovalComments: Record "Approval Comment Line";
        URL: Text[500];
        sDate: Record Date;
        HRLeavePeriods: Record "HR Leave Periods";
        HRJournalBatch: Record "HR Leave Journal Batch";
        HRLeaveEntries: Record "HR Leave Ledger Entries";
        intEntryNo: Integer;
        Calendar: Record Date;
        empMonths: Integer;
        HRLeaveApp: Record "HR Leave Application";
        mWeekDay: Integer;
        empGender: Option Female;
        mMinDays: Integer;
        dates: Record Date;
        BaseCalendar: Record "Base Calendar Change";
        GeneralOptions: Record "HR Setup";
        LeaveTypes: Record "HR Leave Types";
        HRE: Record "HR Employees";
        HRLeaveApplication5: Record "HR Leave Application";
        HREmployees: Record "HR Employees";
        balance: Decimal;


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


    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[10]): Boolean
    begin
        if LeaveTypes.Get(fLeaveCode) then begin
            if LeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
        end;
    end;


    procedure DetermineLeaveReturnDate(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    var
        ltype: Record "HR Leave Types";
    begin
        ltype.Reset;
        if ltype.Get("Leave Type") then begin
        end;
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        repeat
            if DetermineIfIncludesNonWorking("Leave Type") = false then begin
                fReturnDate := CalcDate('1D', fReturnDate);
                if DetermineIfIsNonWorking(fReturnDate, ltype) then begin
                    varDaysApplied := varDaysApplied + 1;
                end else
                    varDaysApplied := varDaysApplied;
                varDaysApplied := varDaysApplied + 1
            end
            else begin
                fReturnDate := CalcDate('1D', fReturnDate);
                varDaysApplied := varDaysApplied - 1;
            end;
        until varDaysApplied = 0;
        exit(fReturnDate);
    end;


    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    var
        ltype: Record "HR Leave Types";
    begin
        if ltype.Get("Leave Type") then begin
        end;
        ReturnDateLoop := true;
        fEndDate := fDate;
        if fEndDate <> 0D then begin
            fEndDate := CalcDate('1D', fEndDate);
            while (ReturnDateLoop) do begin
                if DetermineIfIsNonWorking(fEndDate, ltype) then
                    fEndDate := CalcDate('-1D', fEndDate)
                else
                    ReturnDateLoop := false;
            end
        end;
        exit(fEndDate);
    end;


    procedure CreateLeaveLedgerEntries()
    begin
        if Status = Status::Posted then Error('Leave Already posted');
        TestField("Approved days");
        HRSetup.Reset;
        if HRSetup.Find('-') then begin

            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            LeaveGjline.DeleteAll;
            //Dave
            HRSetup.TestField(HRSetup."Leave Template");
            HRSetup.TestField(HRSetup."Leave Batch");

            HREmp.Get("Employee No");
            //HREmp.TESTFIELD(HREmp."E-Mail");

            //POPULATE JOURNAL LINES

            "LineNo." := 10000;
            LeaveGjline.Init;
            LeaveGjline."Journal Template Name" := HRSetup."Leave Template";
            LeaveGjline."Journal Batch Name" := HRSetup."Leave Batch";
            LeaveGjline."Line No." := "LineNo.";
            LeaveGjline."Leave Period" := Format(Date2dmy(Today, 3));
            LeaveGjline."Leave Application No." := "Application Code";
            LeaveGjline."Document No." := "Application Code";
            LeaveGjline."Staff No." := "Employee No";
            LeaveGjline.Validate(LeaveGjline."Staff No.");
            LeaveGjline."Posting Date" := Today;
            if "Is reimbursement" = false then begin
                LeaveGjline."Leave Entry Type" := LeaveGjline."leave entry type"::Negative;
                LeaveGjline."Leave Approval Date" := Today;
                LeaveGjline.Description := 'Leave Taken';
                LeaveGjline."No. of Days" := "Approved days" * -1;
            end;
            if "Is reimbursement" = true then begin
                LeaveGjline."Leave Entry Type" := LeaveGjline."leave entry type"::Reimbursement;
                LeaveGjline."Leave Approval Date" := Today;
                LeaveGjline.Description := 'Leave Reimbursed';
                LeaveGjline."No. of Days" := "Approved days";
            end;
            LeaveGjline."Leave Type" := "Leave Type";
            //------------------------------------------------------------
            //HRSetup.RESET;
            //HRSetup.FIND('-');
            HRSetup.TestField(HRSetup."Leave Posting Period[FROM]");
            HRSetup.TestField(HRSetup."Leave Posting Period[TO]");
            //------------------------------------------------------------
            LeaveGjline."Leave Period Start Date" := HRSetup."Leave Posting Period[FROM]";
            LeaveGjline."Leave Period End Date" := HRSetup."Leave Posting Period[TO]";
            if LeaveGjline."No. of Days" <> 0 then
                LeaveGjline.Insert(true);

            //Post Journal
            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            if LeaveGjline.Find('-') then begin
                Codeunit.Run(Codeunit::"HR Leave Jnl.-Post", LeaveGjline);  //here
            end;
            Status := Status::Posted;
            NotifyApplicant("Employee No");
            NotifyApplicantApproved(Reliever);
            Modify;


        end;

    end;



    procedure NotifyApplicant(EmployeeCode: Code[50])
    var
        EmailTextBuilder: TextBuilder;
        Salutation: Label 'Dear %1';
        EmailBody: Label '<p>Your leave application no<strong> %2 </strong> has been approved you can proceed to go on leave<p>';
        Regards: Label '<P>Kind Regards</p> <br>%3</br> Human Resource';
        Subject: Label 'Leave Applicaton Approval';
        EmailTosend: Text;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        FormatedBody: Text;
        companyInformation: Record "Company Information";
    begin
        HREmp.Get(EmployeeCode);
        HREmp.TestField(HREmp."Company E-Mail");
        companyInformation.Get;
        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        EmailTextBuilder.Clear();
        EmailTextBuilder.Append(Salutation);
        EmailTextBuilder.Append(EmailBody);
        EmailTextBuilder.Append(Regards);

        EmailTosend := EmailTextBuilder.ToText();

        FormatedBody := StrSubstNo(EmailTosend, HREmp."First Name" + ' ' + HREmp."Last Name", Rec."Application Code", companyInformation.Name);

        EmailMessage.create(HREmp."Company E-Mail", Subject, FormatedBody, true);
        Email.Send(EmailMessage);

        MESSAGE('Leave applicant has been notified successfully');
    END;


    procedure NotifyApplicantApproved(Reliever: Code[50])
    var
        EmailTextBuilder: TextBuilder;
        Salutation: Label 'Dear %1';
        EmailBody: Label '<p>Leave application of<strong> %2 </strong> has been approved. Kindly note you are the reliver <p>';
        Regards: Label '<P>Kind Regards</p> <br>%3</br> Human Resource';
        Subject: Label 'Leave Reliver';
        EmailTosend: Text;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        FormatedBody: Text;
        ApprovalEntries: Record "Approval Entry";
        Approvername: Text;
        companyInformation: Record "Company Information";
    begin
        HREmp.Get(Reliever);
        HREmp.TestField(HREmp."Company E-Mail");
        companyInformation.Get;
        //get Approver
        Approvername := '';
        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Document No.", "Application Code");
        if ApprovalEntries.FindLast() then begin

            HREmp.Reset();
            HREmp.SetRange("Employee UserID", Rec.Reliever);
            if HREmp.Find('-') then begin
                Approvername := HREmp."First Name" + ' ' + HREmp."Last Name";
            end;
        end;
        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        EmailTextBuilder.Clear();
        EmailTextBuilder.Append(Salutation);
        EmailTextBuilder.Append(EmailBody);
        EmailTextBuilder.Append(Regards);

        EmailTosend := EmailTextBuilder.ToText();

        FormatedBody := StrSubstNo(EmailTosend, HREmp."First Name" + ' ' + HREmp."Last Name", Rec."Employee Name", Approvername + ' ' + companyInformation.Name);

        EmailMessage.create(HREmp."Company E-Mail", Subject, FormatedBody, true);
        Email.Send(EmailMessage);




        MESSAGE('Leave reliever has been notified successfully');
    END;




    local procedure GetApplicantSupervisor(EmpUserID: Code[50]) SupervisorID: Code[10]
    var
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        HREmp2: Record "HR Employees";
    begin
        /*SupervisorID:='';
        
        UserSetup.RESET;
        IF UserSetup.GET(EmpUserID) THEN
        BEGIN
            UserSetup.TESTFIELD(UserSetup."Approver ID");
        
            //Get supervisor e-mail
            UserSetup2.RESET;
            IF UserSetup2.GET(UserSetup."Approver ID") THEN
            BEGIN
                UserSetup2.TESTFIELD(UserSetup2."E-Mail");
                "Supervisor Email":=UserSetup2."E-Mail";
            END;
        
        END ELSE
        BEGIN
            ERROR(Text003,EmpUserID,UserSetup.TABLECAPTION);
        END;
          */

    end;

    procedure CalcEndDate(SDate: Date; LDays: Integer) LEndDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
        ltype: Record "HR Leave Types";
    begin
        ltype.Reset;
        if ltype.Get("Leave Type") then begin
            // Additional logic for leave type can be added here if needed
        end;

        EndLeave := false;
        DayCount := 0; // Start counting from 0
        while not EndLeave do begin
            if not DetermineIfIsNonWorking(SDate, ltype) then
                DayCount := DayCount + 1;

            if DayCount = LDays then
                EndLeave := true
            else
                SDate := SDate + 1;
        end;

        LEndDate := SDate;

        // Adjust the end date if it falls on a non-working day
        while DetermineIfIsNonWorking(LEndDate, ltype) do begin
            LEndDate := LEndDate + 1;
        end;

        exit(LEndDate);
    end;

    // procedure CalcEndDate(SDate: Date; LDays: Integer) LEndDate: Date
    // var
    //     EndLeave: Boolean;
    //     DayCount: Integer;
    //     ltype: Record "HR Leave Types";
    // begin
    //     ltype.Reset;
    //     if ltype.Get("Leave Type") then begin
    //     end;
    //     SDate := SDate - 1;
    //     EndLeave := false;
    //     while EndLeave = false do begin
    //         if not DetermineIfIsNonWorking(SDate, ltype) then
    //             DayCount := DayCount + 1;
    //         SDate := SDate + 1;
    //         if DayCount > LDays then
    //             EndLeave := true;
    //     end;
    //     LEndDate := SDate - 1;

    //     while DetermineIfIsNonWorking(LEndDate, ltype) = true do begin
    //         LEndDate := LEndDate + 1;
    //     end;
    // end;


    procedure CalcReturnDate(EndDate: Date) RDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
        LEndDate: Date;
        ltype: Record "HR Leave Types";
    begin
        if ltype.Get("Leave Type") then begin
        end;
        /* EndLeave:=FALSE;
         EndDate:=EndDate+1;
         LEndDate:=EndDate;
         CLEAR(DayCount);
         WHILE EndLeave=FALSE DO BEGIN
         IF NOT DetermineIfIsNonWorking(EndDate,ltype) THEN BEGIN
         DayCount:=DayCount+1;
         EndDate:=EndDate+1;

         END ELSE BEGIN
         EndLeave:=TRUE;
         END;
         END;
           */
        RDate := EndDate + 1;
        while DetermineIfIsNonWorking(RDate, ltype) = true do begin
            RDate := RDate + 1;
        end;

    end;


    procedure GetDate(var Applied_Dayes: Integer; var Start_Date: Date)
    var
        DaysCount: Integer;
        NewDate: Date;
        Last_is_WotkingDay: Boolean;
    begin
        /*clear(DaysCount);
        clear(NewDate);
         NewDate:=Start_Date;
        repeat
        DaysCount:=DaysCount+1;
        Last_is_WotkingDay:=false;
        
        until (() AND ()) */

    end;


    procedure ItsHolliday(var Start_Date: Date) holliday: Boolean
    var
        baseCal: Record "Base Calendar Change";
        days: Integer;
        Months: Integer;
        bool_Non_Working: Boolean;
    begin
        Clear(days);
        Clear(Months);
        Clear(bool_Non_Working);
        days := Date2dmy(Start_Date, 1);
        Months := Date2dmy(Start_Date, 2);
        baseCal.Reset;
        baseCal.SetFilter(baseCal."Recurring System", '=%1', baseCal."recurring system"::"Annual Recurring");
        if baseCal.Find('-') then begin
            repeat
                if ((Months = Date2dmy(baseCal.Date, 1)) and (days = Date2dmy(baseCal.Date, 1))) then bool_Non_Working := true;
            until ((((Months = Date2dmy(baseCal.Date, 1)) and (days = Date2dmy(baseCal.Date, 1)))) or (baseCal.Next = 0))
        end;
    end;


    procedure ItsSunday(var Start_Date: Date; var LeaveType: Integer)
    var
        leave_types: Record "HR Leave Types";
        dates: Record Date;
    begin
    end;
}

