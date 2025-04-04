Page 80048 "HR Leave Application Card"
{
    DeleteAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Comments';
    SourceTable = "HR Leave Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application Code"; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                    Editable = false;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee No.';
                    Editable = true;
                    ShowMandatory = true;
                    Importance = Promoted;
                }

                field(EmpName; EmpName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Applicant Name';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Job Tittle"; Rec."Job Tittle")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    Editable = false;
                    Caption = 'Department Code';
                }
                field("Responsibility Center Name"; Rec."Responsibility Center Name")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    Caption = 'Department Name';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    Editable = true;
                    Caption = 'Branch Code';
                }
                field(Supervisor; Rec.Supervisor)
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        //GET THE APPROVER NAMES
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."User ID", Rec.Supervisor);
                        if HREmp.Find('-') then begin
                            SupervisorName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                        end else begin
                            SupervisorName := '';
                        end;
                    end;
                }
                field("Supervisor Name"; Rec.SupervisorName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor Name';
                    Editable = false;
                }
                field(SupervisorName; SupervisorName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor Name';
                    Editable = false;
                    Visible = false;
                }
                field("Supervisor Email"; Rec."Supervisor Email")
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor Email';
                    Editable = false;
                    Visible = false;
                }
                field(Reliever; Rec.Reliever)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reliever Employee No';
                    Editable = RelieverEditable;
                    ShowMandatory = true;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = Basic;
                    Editable = "Leave TypeEditable";
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        GetLeaveStats(Rec."Leave Type");
                        //  CurrPage.UPDATE;

                        HREmp.Get(Rec."Employee No");
                        if Rec."Leave Type" = 'ANNUAL' then begin
                            if Rec."Days Applied" > dLeft then
                                Error('Days applied cannot exceed leave balance for this leave');
                        end else begin
                            HRLeaveTypes.Reset;
                            HRLeaveTypes.SetRange(HRLeaveTypes.Code, Rec."Leave Type");
                            HRLeaveTypes.SetFilter(HRLeaveTypes.Code, '<>%1', 'CTO');
                            if HRLeaveTypes.Find('-') then begin
                                if Rec."Days Applied" > HRLeaveTypes.Days then
                                    Error('Days applied cannot exceed leave balance for this leave');
                            end;
                        end;
                        /*
                        IF HREmp.GET("Employee No") THEN BEGIN
                        IF HREmp."Working Sunday"=TRUE THEN
                        SETRANGE("Leave Type",'ANNUAL_W');
                        END;
                        */
                        HRLeaveApplication.Reset;
                        HRLeaveApplication.SetRange("Employee No", Rec."Employee No");
                        HRLeaveApplication.SetRange(Status, HRLeaveApplication.Status::"Pending Approval");
                        HRLeaveApplication.SetRange("Leave Type", Rec."Leave Type");
                        if HRLeaveApplication.Find('-') then
                            Error('You have another % leave pending approval', Rec."Leave Type");


                        HRLeaveApplication.Reset;
                        HRLeaveApplication.SetRange("Employee No", Rec."Employee No");
                        HRLeaveApplication.SetRange(Status, HRLeaveApplication.Status::Posted);
                        HRLeaveApplication.SetRange("Start Date", Rec."Start Date");
                        if HRLeaveApplication.Find('-') then
                            Error('You have another leave starting on %1', Rec."Start Date");
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."User ID", Rec.Supervisor);
                        if HREmp.Find('-') then begin
                            SupervisorName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                        end

                    end;
                }
                field("Is reimbursement"; Rec."Is reimbursement")
                {
                    ApplicationArea = Basic;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = Basic;
                    Editable = "Days AppliedEditable";
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        HREmp.Get(Rec."Employee No");
                        if Rec."Leave Type" = 'ANNUAL' then begin
                            if Rec."Days Applied" > dLeft then
                                Error('Days applied cannot exceed leave balance for this leave');
                        end else begin
                            HRLeaveTypes.Reset;
                            HRLeaveTypes.SetRange(HRLeaveTypes.Code, Rec."Leave Type");
                            HRLeaveTypes.SetFilter(HRLeaveTypes.Code, '<>%1', 'CTO');
                            if HRLeaveTypes.Find('-') then begin
                                if Rec."Days Applied" > HRLeaveTypes.Days then
                                    Error('Days applied cannot exceed leave balance for this leave');
                            end;

                        end;
                    end;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("End Date"; Rec."End Date")
                {
                    Editable = false;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Request Leave Allowance"; Rec."Request Leave Allowance")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                label("Employee Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Details';
                    Style = StrongAccent;
                    StyleExpr = true;
                    Visible = false;
                }

                field("Approved days"; Rec."Approved days")
                {
                    ApplicationArea = Basic;
                }
                label(Control1102755082)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19010232;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(dEarnd; dEarnd)
                {
                    ApplicationArea = Basic;
                    Caption = 'Earned Leave Days';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(dTaken; dTaken)
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Leave Taken';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(dLeft; dLeft)
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Balance';
                    Editable = false;
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = true;
                }
                label(Control1000000000)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text1;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Reliever Name"; Rec."Reliever Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Pending Tasks"; Rec."Pending Tasks")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
            }
            group("More Leave Details")
            {
                Caption = 'More Leave Details';
                field("Cell Phone Number"; Rec."Cell Phone Number")
                {
                    ApplicationArea = Basic;
                    Editable = "Cell Phone NumberEditable";
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("E-mail Address"; Rec."E-mail Address")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Details of Examination"; Rec."Details of Examination")
                {
                    ApplicationArea = Basic;
                    Editable = "Details of ExaminationEditable";
                    Importance = Promoted;
                    Visible = false;
                }
                field("Date of Exam"; Rec."Date of Exam")
                {
                    ApplicationArea = Basic;
                    Editable = "Date of ExamEditable";
                    Importance = Promoted;
                    Visible = false;
                }
                field("Number of Previous Attempts"; Rec."Number of Previous Attempts")
                {
                    ApplicationArea = Basic;
                    Editable = NumberofPreviousAttemptsEditab;
                    Importance = Promoted;
                    Visible = false;
                }
            }
            group("Exam Dates")
            {
                Caption = 'Exam Dates';
                Visible = false;
                field("Date Of Exam 1"; Rec."Date Of Exam 1")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 2"; Rec."Date Of Exam 2")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 3"; Rec."Date Of Exam 3")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 4"; Rec."Date Of Exam 4")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 5"; Rec."Date Of Exam 5")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 6"; Rec."Date Of Exam 6")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Exam 7"; Rec."Date Of Exam 7")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000003; "HR Employees Factbox")
            {
                SubPageLink = "No." = field("Employee No");
            }
            systempart(s; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(Attachments)
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page Documents;
                    RunPageLink = "Doc No." = field("Application Code");
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := DocumentType::" ";
                        ApprovalEntries.SetRecordFilters(DATABASE::"HR Leave Application", DocumentType, Rec."Application Code");
                        ApprovalEntries.RUN;

                        ApprovalEntry.Reset;


                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Rec."Leave Type");
                        Rec.TestField(Rec."Days Applied");
                        Rec.TestField(Rec.Reliever);
                        // Rec.TestField(Rec."Cell Phone Number");
                        // Rec.TestField(Rec."E-mail Address");

                        Rec.TestField(Rec.Status, Rec.Status::New);//

                        varrvariant := Rec;

                        if CustomApprovalsCodeunit.CheckApprovalsWorkflowEnabled(varrvariant) then
                            CustomApprovalsCodeunit.OnSendDocForApproval(varrvariant);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalMgt.CancelBatchAppr(Rec,TRUE,TRUE) THEN;
                        //varrvariant:=Rec;
                        //CustomApprovalsCodeunit.OnCancelDocApprovalRequest(varrvariant);
                        ApprovalEntry.Reset;
                        ApprovalEntry.SetRange("Document No.", Rec."Application Code");
                        if ApprovalEntry.FindSet then begin
                            repeat
                                ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                                ApprovalEntry.Modify;
                            until ApprovalEntry.Next = 0;
                        end;
                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                    end;
                }
                action("Re-Open")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-Open';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRLeaveApp.Reset;
                        HRLeaveApp.SetRange(HRLeaveApp."Application Code", Rec."Application Code");
                        if HRLeaveApp.Find('-') then
                            Report.Run(80075, true, true, HRLeaveApp);
                    end;
                }
                action("Create Leave Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Leave Ledger Entries';
                    Image = CreateLinesFromJob;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CreateLeaveLedgerEntries;

                    end;
                }
                action("&Post Leave Application")
                {
                    ApplicationArea = Basic;
                    Caption = '&Post Leave Application';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //IF Status=Status::"10" THEN ERROR('This Leave application has already been posted');
                        if Rec.Status <> Rec.Status::Approved then
                            Error('The Leave Status must be Approved')
                        else
                            HRLeaveApp.Reset;
                        HRLeaveApp.SetRange(HRLeaveApp."Application Code", Rec."Application Code");
                        if HRLeaveApp.Find('-') then begin
                            HRLeaveApp.CreateLeaveLedgerEntries;

                        end;

                        //Status:=Status::"10";Rec.
                        /*
                             //Dave---To notify leave applicant
                        IF CONFIRM('Do you wish to notify the employee',FALSE)=TRUE THEN BEGIN
                        HREmp.GET("Employee No");
                        HREmp.TESTFIELD(HREmp."Company E-Mail");
                        
                        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
                        HREmailParameters.RESET;
                        HREmailParameters.SETRANGE(HREmailParameters."Associate With",HREmailParameters."Associate With"::"Interview Invitations");
                        IF HREmailParameters.FIND('-') THEN
                        BEGIN
                             HREmp.TESTFIELD(HREmp."Company E-Mail");
                             SMTP.CreateMessage(HREmailParameters."Sender Name",HREmailParameters."Sender Address",HREmp."Company E-Mail",
                             HREmailParameters.Subject,'Dear'+' '+ HREmp."First Name" +' '+
                             HREmailParameters.Body+' '+"Application Code"+' '+ HREmailParameters."Body 2",TRUE);
                             SMTP.Send();
                        END;
                        MESSAGE('Leave applicant has been notified successfully');
                        END;*/

                    end;
                }
                action("Attach ")
                {
                    ApplicationArea = Basic;
                    Enabled = true;
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = true;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EmpDept := '';
        //PASS VALUES TO VARIABLES ON THE FORM
        FillVariables;
        //GET LEAVE STATS FOR THIS EMPLOYEE FROM THE EMPLOYEE TABLE
        GetLeaveStats(Rec."Leave Type");
        //TO PREVENT USER FROM SEEING OTHER PEOPLES LEAVE APPLICATIONS
        Rec.SetFilter(Rec."User ID", UserId);

        Updatecontrols;

        SupervisorName := '';
        HREmp2.Get(Rec."Employee No");
        if HREmp3.Get(Rec.Supervisor) then begin

            //Rec."Supervisor Email":= HREmp3."Company E-Mail";
            SupervisorName := HREmp3."First Name" + ' ' + HREmp3."Middle Name" + ' ' + HREmp3."Last Name";
            Rec.SupervisorName := SupervisorName;
            Rec.Modify(true);
        end;

        Commit;
    end;

    trigger OnInit()
    begin
        NumberofPreviousAttemptsEditab := true;
        "Date of ExamEditable" := true;
        "Details of ExaminationEditable" := true;
        "Cell Phone NumberEditable" := true;
        SupervisorEditable := true;
        RequestLeaveAllowanceEditable := true;
        RelieverEditable := true;
        "Leave Allowance AmountEditable" := true;
        "Start DateEditable" := true;
        "Responsibility CenterEditable" := true;
        "Days AppliedEditable" := true;
        "Leave TypeEditable" := true;
        "Application CodeEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := 'FINANCE';
        Rec."User ID" := UserId;

        /*IF UserSetup.GET(USERID) THEN
          Supervisor:=UserSetup."Approver ID";Rec.*/
        HREmp2.Get(Rec."Employee No");
        if HREmp3.Get(Rec.Supervisor) then begin

            //  Rec."Employee Name" := HREmp3."First Name" + ' ' + HREmp3."Middle Name" + ' ' + HREmp3."Last Name";
            SupervisorName := HREmp3."First Name" + ' ' + HREmp3."Middle Name" + ' ' + HREmp3."Last Name";
        end;

    end;

    var
        HREmp: Record "HR Employees";
        EmpJobDesc: Text[50];
        HRJobs: Record "HR Jobss";
        SupervisorName: Text[60];
        //SMTP: Codeunit "SMTP Mail";
        URL: Text[500];
        dAlloc: Decimal;
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Decimal;
        HRSetup: Record "HR Setup";
        EmpDept: Text[30];
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        HRLeaveApp: Record "HR Leave Application";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,Leave;
        ApprovalEntries: Page "Approval Entries";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        EmpName: Text[70];
        ApprovalComments: Page "Approval Comments";

        [InDataSet]
        "Application CodeEditable": Boolean;
        [InDataSet]
        "Leave TypeEditable": Boolean;
        [InDataSet]
        "Days AppliedEditable": Boolean;
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Start DateEditable": Boolean;
        [InDataSet]
        "Leave Allowance AmountEditable": Boolean;
        [InDataSet]
        RelieverEditable: Boolean;
        [InDataSet]
        RequestLeaveAllowanceEditable: Boolean;
        [InDataSet]
        SupervisorEditable: Boolean;
        [InDataSet]
        "Cell Phone NumberEditable": Boolean;
        [InDataSet]
        "Details of ExaminationEditable": Boolean;
        [InDataSet]
        "Date of ExamEditable": Boolean;
        [InDataSet]
        NumberofPreviousAttemptsEditab: Boolean;
        Text19010232: label 'Leave Statistics';
        Text1: label 'Reliver Details';
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        LeaveGjline: Record "HR Journal Line";
        "LineNo.": Integer;
        sDate: Record Date;
        HRLeavePeriods: Record "HR Leave Periods";
        HRJournalBatch: Record "HR Leave Journal Batch";
        HRLeaveApplication: Record "HR Leave Application";
        CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
        varrvariant: Variant;
        ApprovalEntry: Record "Approval Entry";
        HREmp2: Record "HR Employees";
        HREmp3: Record "HR Employees";


    procedure FillVariables()
    begin
        //GET THE APPLICANT DETAILS

        HREmp.Reset;
        if HREmp.Get(Rec."Employee No") then begin
            EmpName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            EmpDept := HREmp."Global Dimension 2 Code";
            Rec."Job Tittle" := HREmp."Job Title";
        end else begin
            EmpDept := '';
        end;

        //GET THE JOB DESCRIPTION FRON THE HR JOBS TABLE AND PASS IT TO THE VARIABLE
        HRJobs.Reset;
        if HRJobs.Get(Rec."Job Tittle") then begin
            EmpJobDesc := HRJobs."Job Description";

        end else begin
            EmpJobDesc := '';
        end;

        //GET THE APPROVER NAMES
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", Rec.Supervisor);
        if HREmp.Find('-') then begin
            SupervisorName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        end else begin
            SupervisorName := '';
        end;
    end;


    procedure GetLeaveStats(LeaveType: Text[50])
    begin
        dAlloc := 0;
        dEarnd := 0;
        dTaken := 0;
        dLeft := 0;
        cReimbsd := 0;
        cPerDay := 0;
        cbf := 0;
        if HREmp.Get(Rec."Employee No") then begin
            HREmp.SetFilter(HREmp."Leave Type Filter", LeaveType);
            HREmp.CalcFields(HREmp."Allocated Leave Days");
            dAlloc := HREmp."Allocated Leave Days";
            HREmp.Validate(HREmp."Allocated Leave Days");
            dEarnd := HREmp."Total (Leave Days)";
            HREmp.CalcFields(HREmp."Total Leave Taken");
            dTaken := HREmp."Total Leave Taken";
            dLeft := HREmp."Leave Balance";
            cReimbsd := HREmp."Cash - Leave Earned";
            cPerDay := HREmp."Cash per Leave Day";
            HREmp.CalcFields(HREmp."Reimbursed Leave Days");
            cbf := HREmp."Reimbursed Leave Days";
        end;
    end;


    procedure TESTFIELDS()
    begin
        Rec.TestField(Rec."Leave Type");
        Rec.TestField(Rec."Days Applied");
        Rec.TestField(Rec."Start Date");
        //Rec.TestField(Rec.Reliever);
        //Rec.TestField(Rec.Supervisor);
    end;


    procedure Updatecontrols()
    begin

        if Rec.Status = Rec.Status::New then begin
            "Application CodeEditable" := true;
            "Leave TypeEditable" := true;
            "Days AppliedEditable" := true;
            "Responsibility CenterEditable" := true;
            "Start DateEditable" := true;
            "Leave Allowance AmountEditable" := true;
            RelieverEditable := true;
            RequestLeaveAllowanceEditable := true;
            SupervisorEditable := true;
            "Cell Phone NumberEditable" := true;
            //CurrForm."E-mail Address".EDITABLE:=TRUE;
            "Details of ExaminationEditable" := true;
            "Date of ExamEditable" := true;
            NumberofPreviousAttemptsEditab := true;
        end else begin
            "Application CodeEditable" := false;
            "Leave TypeEditable" := false;
            "Days AppliedEditable" := false;
            "Responsibility CenterEditable" := false;
            "Start DateEditable" := false;
            "Leave Allowance AmountEditable" := false;
            RelieverEditable := false;
            RequestLeaveAllowanceEditable := false;
            SupervisorEditable := false;
            "Cell Phone NumberEditable" := false;
            //CurrForm."E-mail Address".EDITABLE:=FALSE;
            "Details of ExaminationEditable" := false;
            "Date of ExamEditable" := false;
            NumberofPreviousAttemptsEditab := false;
        end;
    end;


    procedure TestLeaveFamily()
    var
        Employees: Record "HR Employees";
    begin
        /*LeaveFamilyEmployees.SETRANGE(LeaveFamilyEmployees."Employee No","Employee No");
        IF LeaveFamilyEmployees.FINDSET THEN //find the leave family employee is associated with
        REPEAT
          LeaveFamily.SETRANGE(LeaveFamily.Code,LeaveFamilyEmployees.Family);
          LeaveFamily.SETFILTER(LeaveFamily."Max Employees On Leave",'>0');
          IF LeaveFamily.FINDSET THEN //find the status other employees on the same leave family
            BEGIN
              Employees.SETRANGE(Employees."No.",LeaveFamilyEmployees."Employee No");
              Employees.SETRANGE(Employees."Leave Status",Employees."Leave Status"::" ");
              IF Employees.COUNT>LeaveFamily."Max Employees On Leave" THEN
              ERROR('The Maximum number of employees on leave for this family has been exceeded, Contact th HR manager for more information');
            END
        UNTIL LeaveFamilyEmployees.NEXT = 0;*/

    end;


    procedure DetermineLeaveReturnDate(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    begin
        /*varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        REPEAT
          IF DetermineIfIncludesNonWorking("Leave Type") =FALSE THEN BEGIN
            fReturnDate := CALCDATE('1D', fReturnDate);
            IF DetermineIfIsNonWorking(fReturnDate) THEN
              varDaysApplied := varDaysApplied + 1
            ELSE
              varDaysApplied := varDaysApplied;
            varDaysApplied := varDaysApplied - 1
          END
          ELSE BEGIN
            fReturnDate := CALCDATE('1D', fReturnDate);
            varDaysApplied := varDaysApplied - 1;
          END;
        UNTIL varDaysApplied = 0;
        EXIT(fReturnDate);
               */

    end;


    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[10]): Boolean
    begin
        if HRLeaveTypes.Get(fLeaveCode) then begin
            if HRLeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
        end;
    end;


    procedure DetermineIfIsNonWorking(var bcDate: Date) Isnonworking: Boolean
    begin

        HRSetup.Find('-');
        HRSetup.TestField(HRSetup."Base Calendar");
        BaseCalendarChange.SetFilter(BaseCalendarChange."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendarChange.SetRange(BaseCalendarChange.Date, bcDate);

        if BaseCalendarChange.Find('-') then begin
            if BaseCalendarChange.Nonworking = false then
                Error('Start date can only be a Working Day Date');
            exit(true);
        end;

        /*
        Customized.RESET;
        Customized.SETRANGE(Customized.Date,bcDate);
        IF Customized.FIND('-') THEN BEGIN
            IF Customized."Non Working" = TRUE THEN
            EXIT(TRUE)
            ELSE
            EXIT(FALSE);
        END;
         */

    end;


    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    begin
        /*ReturnDateLoop := TRUE;
        fEndDate := fDate;
        IF fEndDate <> 0D THEN BEGIN
          fEndDate := CALCDATE('-1D', fEndDate);
          WHILE (ReturnDateLoop) DO BEGIN
          IF DetermineIfIsNonWorking(fEndDate) THEN
            fEndDate := CALCDATE('-1D', fEndDate)
           ELSE
            ReturnDateLoop := FALSE;
          END
          END;
        EXIT(fEndDate);
         */

    end;


    procedure CreateLeaveLedgerEntries()
    begin
        Rec.TestField(Rec."Approved days");
        HRSetup.Reset;
        if HRSetup.Find('-') then begin

            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            LeaveGjline.DeleteAll;
            //Dave
            //HRSetup.TESTFIELD(HRSetup."Leave Template");
            //HRSetup.TESTFIELD(HRSetup."Leave Batch");

            HREmp.Get(Rec."Employee No");
            HREmp.TestField(HREmp."Company E-Mail");

            //POPULATE JOURNAL LINES

            "LineNo." := 10000;
            LeaveGjline.Init;
            LeaveGjline."Journal Template Name" := HRSetup."Leave Template";
            LeaveGjline."Journal Batch Name" := HRSetup."Leave Batch";
            LeaveGjline."Line No." := "LineNo.";
            LeaveGjline."Leave Period" := 'CY';
            LeaveGjline."Document No." := Rec."Application Code";
            LeaveGjline."Staff No." := Rec."Employee No";
            LeaveGjline.Validate(LeaveGjline."Staff No.");
            LeaveGjline."Posting Date" := Today;
            LeaveGjline."Leave Entry Type" := LeaveGjline."leave entry type"::Negative;
            LeaveGjline."Leave Approval Date" := Today;
            LeaveGjline.Description := 'Leave Taken';
            LeaveGjline."Leave Type" := Rec."Leave Type";
            //------------------------------------------------------------
            //HRSetup.RESET;
            //HRSetup.FIND('-');
            HRSetup.TestField(HRSetup."Leave Posting Period[FROM]");
            HRSetup.TestField(HRSetup."Leave Posting Period[TO]");
            //------------------------------------------------------------
            LeaveGjline."Leave Period Start Date" := HRSetup."Leave Posting Period[FROM]";
            LeaveGjline."Leave Period End Date" := HRSetup."Leave Posting Period[TO]";
            LeaveGjline."No. of Days" := Rec."Approved days";
            if LeaveGjline."No. of Days" <> 0 then
                LeaveGjline.Insert(true);

            //Post Journal
            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            if LeaveGjline.Find('-') then begin
                //Codeunit.Run(Codeunit::Codeunit55560,LeaveGjline);
            end;
            Rec.Status := Rec.Status::Posted;
            Rec.Modify;

            /*END ELSE BEGIN
            ERROR('You must specify no of days');
            END;
            END;*/
            //NotifyApplicant;
        end;

    end;


    procedure NotifyApplicant()
    begin
        /*HREmp.GET("Employee No");
        HREmp.TESTFIELD(HREmp."Company E-Mail");
        
        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        HREmailParameters.RESET;
        HREmailParameters.SETRANGE(HREmailParameters."Associate With",HREmailParameters."Associate With"::"Interview Invitations");
        IF HREmailParameters.FIND('-') THEN
        BEGIN
        
        
             HREmp.TESTFIELD(HREmp."Company E-Mail");
             SMTP.CreateMessage(HREmailParameters."Sender Name",HREmailParameters."Sender Address",HREmp."Company E-Mail",
             HREmailParameters.Subject,'Dear'+' '+ HREmp."First Name" +' '+
             HREmailParameters.Body+' '+"Application Code"+' '+ HREmailParameters."Body 2",TRUE);
             SMTP.Send();
        
        
        MESSAGE('Leave applicant has been notified successfully');
        END;*/

    end;
}

