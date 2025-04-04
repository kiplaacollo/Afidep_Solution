Report 80023 "HR Leave Adjustment"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HR Employees";"HR Employees")
        {
            DataItemTableView = where(Status=const(Active));
            RequestFilterFields = "No.",Position,"Global Dimension 2 Code",Gender;
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //TESTFIELD(Gender);
                
                //Get current leave period
                HRLeavePeriods.Reset;
                //HRLeavePeriods.SETRANGE(HRLeavePeriods."New Fiscal Year",TRUE);
                HRLeavePeriods.SetRange(HRLeavePeriods.Closed,false);
                HRLeavePeriods.SetRange(HRLeavePeriods."Date Locked",false);
                if HRLeavePeriods.Find('-') then
                begin
                      HRLeaveTypes.Reset;
                      if LeaveTypeFilter <> '' then
                      begin
                          HRLeaveTypes.SetRange(HRLeaveTypes.Code,LeaveTypeFilter);
                      end;
                
                      if HRLeaveTypes.Find('-') then
                      begin
                          repeat
                                HRLeaveLedger.SetRange(HRLeaveLedger."Staff No.","No.");
                                HRLeaveLedger.SetFilter(HRLeaveLedger."Leave Type",'%1','ANNUALADD');
                                HRLeaveLedger.SetRange(HRLeaveLedger."Leave Entry Type",LeaveEntryType);
                                HRLeaveLedger.SetRange(HRLeaveLedger."Leave Period",HRLeavePeriods."Period Code");
                                if not HRLeaveLedger.Find('-') then
                                begin
                                    OK:=CheckGender("HR Employees",HRLeaveTypes);
                                    if OK then
                                    begin
                                          with HRJournalLine do
                                          begin
                
                                       /*  IF HRLeaveTypes.Code<> 'ANNUAL'  THEN BEGIN
                
                                            INIT;
                                             "Journal Template Name":=Text0001;
                                              VALIDATE("Journal Template Name");
                
                                              "Journal Batch Name":='DEFAULT';
                                              VALIDATE("Journal Batch Name");
                
                                              "Line No.":="Line No."+1000;
                
                                              "Leave Period":=HRLeavePeriods."Period Code";
                                              VALIDATE("Leave Period");
                
                                              "Leave Period Start Date":=HRLeavePeriods."Starting Date";
                                             VALIDATE("Leave Period Start Date");
                
                                            "Staff No.":="No.";
                                               VALIDATE("Staff No.");
                
                                             "Posting Date":=TODAY;
                                             "Document No.":=PostingDescription;
                                             Description:='Previous Year Days forfeited';
                                             "Leave Entry Type":="Leave Entry Type"::Negative;
                                             "Leave Type":=HRLeaveTypes.Code;
                                              Grade:=Grade;
                                              "Document No.":=HRLeavePeriods."Period Code";
                                              "Global Dimension 1 Code":="Global Dimension 1 Code";
                                              "Global Dimension 2 Code":="Global Dimension 2 Code";
                
                                            "HR Employees".CALCFIELDS("Maternity Leave Acc.", "Paternity Leave Acc.", "Annual Leave Account", "Compassionate Leave Acc.","Sick Leave Acc.", "Study Leave Acc","CTO  Leave Acc.");
                                            IF HRLeaveTypes.Code='COMPASSIONATE' THEN
                                              "No. of Days":=-1*"HR Employees"."Compassionate Leave Acc.";
                                            IF HRLeaveTypes.Code='EXAM' THEN
                                              "No. of Days":=-1*("HR Employees"."Study Leave Acc");
                                            IF HRLeaveTypes.Code='MATERNITY' THEN
                                              "No. of Days":=-1*("HR Employees"."Maternity Leave Acc.");
                                            IF HRLeaveTypes.Code='PATERNITY' THEN
                                              "No. of Days":=-1*("HR Employees"."Paternity Leave Acc.");
                
                                            IF HRLeaveTypes.Code='SICK' THEN
                                              "No. of Days":=-1*("HR Employees"."Sick Leave Acc.");
                                            IF HRLeaveTypes.Code='CTO' THEN
                                              "No. of Days":=-1*("HR Employees"."CTO  Leave Acc.");
                
                                              INSERT;
                
                */
                
                
                
                
                                              Init;
                                             "Journal Template Name":=Text0001;
                                              Validate("Journal Template Name");
                
                                              "Journal Batch Name":='DEFAULT';
                                              Validate("Journal Batch Name");
                
                                              "Line No.":="Line No."+1000;
                
                                              "Leave Period":=HRLeavePeriods."Period Code";
                                              Validate("Leave Period");
                
                                              "Leave Period Start Date":=HRLeavePeriods."Starting Date";
                                             Validate("Leave Period Start Date");
                
                                            "Staff No.":="No.";
                                               Validate("Staff No.");
                
                                             "Posting Date":=Today;
                                             "Document No.":=PostingDescription;
                                             Description:='Earned Leave Days';
                                             "Leave Entry Type":=LeaveEntryType;
                                             "Leave Type":=HRLeaveTypes.Code;
                                              Grade:=Grade;
                                              "Document No.":=HRLeavePeriods."Period Code";
                                              "Global Dimension 1 Code":="Global Dimension 1 Code";
                                              "Global Dimension 2 Code":="Global Dimension 2 Code";
                                              "No. of Days":=HRLeaveTypes.Days;
                
                                              Insert;
                
                                              HRJournalLine2.SetRange("Journal Template Name",'LEAVE');
                                              HRJournalLine2.SetRange("Journal Batch Name",'DEFAULT');
                                             // CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post",HRJournalLine2);
                                             end; /*ELSE BEGIN
                                              INIT;
                                             "Journal Template Name":=Text0001;
                                              VALIDATE("Journal Template Name");
                
                                              "Journal Batch Name":='DEFAULT';
                                              VALIDATE("Journal Batch Name");
                
                                              "Line No.":="Line No."+1000;
                
                                              "Leave Period":=HRLeavePeriods."Period Code";
                                              VALIDATE("Leave Period");
                
                                              "Leave Period Start Date":=HRLeavePeriods."Starting Date";
                                             VALIDATE("Leave Period Start Date");
                
                                            "Staff No.":="No.";
                                               VALIDATE("Staff No.");
                
                                             "Posting Date":=TODAY;
                                             "Document No.":=PostingDescription;
                                             "Leave Entry Type":="Leave Entry Type"::Negative;
                                             "Leave Type":=HRLeaveTypes.Code;
                                              Grade:=Grade;
                                              "Document No.":=HRLeavePeriods."Period Code";
                                              "Global Dimension 1 Code":="Global Dimension 1 Code";
                                              "Global Dimension 2 Code":="Global Dimension 2 Code";
                                              Description:='Previous Year Days forfeited';
                                              "HR Employees".CALCFIELDS("Annual Leave Account");
                                              "No. of Days":=-1*("HR Employees"."Annual Leave Account");
                                              INSERT;
                
                
                                              INIT;
                                             "Journal Template Name":=Text0001;
                                              VALIDATE("Journal Template Name");
                
                                              "Journal Batch Name":='DEFAULT';
                                              VALIDATE("Journal Batch Name");
                
                                              "Line No.":="Line No."+1000;
                
                                              "Leave Period":=HRLeavePeriods."Period Code";
                                              VALIDATE("Leave Period");
                
                                              "Leave Period Start Date":=HRLeavePeriods."Starting Date";
                                             VALIDATE("Leave Period Start Date");
                
                                            "Staff No.":="No.";
                                               VALIDATE("Staff No.");
                
                                             "Posting Date":=TODAY;
                                             "Document No.":=PostingDescription;
                                             "Leave Entry Type":="Leave Entry Type"::Positive;
                                             "Leave Type":=HRLeaveTypes.Code;
                                              Grade:=Grade;
                                              "Document No.":=HRLeavePeriods."Period Code";
                                              "Global Dimension 1 Code":="Global Dimension 1 Code";
                                              "Global Dimension 2 Code":="Global Dimension 2 Code";
                                              Description:='Days Carried Forward';
                                              "HR Employees".CALCFIELDS("Annual Leave Account");
                                              IF  "HR Employees"."Annual Leave Account"<HRLeaveTypes."Max Carry Forward Days" THEN
                                              "No. of Days":=("HR Employees"."Annual Leave Account")
                                              ELSE
                                                "No. of Days":= HRLeaveTypes."Max Carry Forward Days";
                                              INSERT;
                
                
                
                
                
                
                                              INIT;
                                             "Journal Template Name":=Text0001;
                                              VALIDATE("Journal Template Name");
                
                                              "Journal Batch Name":='DEFAULT';
                                              VALIDATE("Journal Batch Name");
                
                                              "Line No.":="Line No."+1000;
                
                                              "Leave Period":=HRLeavePeriods."Period Code";
                                              VALIDATE("Leave Period");
                
                                              "Leave Period Start Date":=HRLeavePeriods."Starting Date";
                                             VALIDATE("Leave Period Start Date");
                
                                            "Staff No.":="No.";
                                               VALIDATE("Staff No.");
                
                                             "Posting Date":=TODAY;
                                             "Document No.":=PostingDescription;
                                             "Leave Entry Type":=LeaveEntryType;
                                             "Leave Type":=HRLeaveTypes.Code;
                                              Grade:=Grade;
                                              "Document No.":=HRLeavePeriods."Period Code";
                                              "Global Dimension 1 Code":="Global Dimension 1 Code";
                                              "Global Dimension 2 Code":="Global Dimension 2 Code";
                                              Description:='Earned Leave Days';
                                              "No. of Days":=HRLeaveTypes.Days;
                                              INSERT;
                
                                              HRJournalLine2.SETRANGE("Journal Template Name",'LEAVE');
                                              HRJournalLine2.SETRANGE("Journal Batch Name",'DEFAULT');
                
                                               END;
                                          END;*/
                                     end;
                               end else
                               begin
                                // IF HRLeaveTypes.Code='ANNUAL' THEN BEGIN
                                   OK:=CheckGender("HR Employees",HRLeaveTypes);
                                    if OK then
                                    begin
                                          with HRJournalLine do
                                          begin
                
                                             // CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post",HRJournalLine2);
                
                                          end;
                                     end;
                                //   END ELSE BEGIN
                                  //ERROR('Allocation has already been done');
                                    // END;
                               end;
                            until HRLeaveTypes.Next=0;
                
                     end else
                     begin
                          Error('No Leave Type found within the applied filters [%1]',"Leave Type Filter");
                     end;
                
                
                
                end;

            end;
        }
        dataitem("HR Leave Types";"HR Leave Types")
        {
            RequestFilterFields = "Code";
            column(ReportForNavId_2; 2)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(LeaveEntryType;LeaveEntryType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Entry Type';
                }
                field(PostingDescription;PostingDescription)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Description';
                }
                field(BatchName;BatchName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Batch Name';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Message('Process complete');
    end;

    trigger OnPreReport()
    begin

        //IF PostingDescription = '' THEN ERROR('Posting description must have value');

        with HRJournalLine do
        begin
            if not IsEmpty then
            begin
                if Confirm(Text0002 + Text0003,false,Count,UpperCase(TableCaption),Text0001,BatchName) = true then
                begin
                    DeleteAll;
                end else
                begin
                     Error('Process aborted');
                end;
            end;
        end;

        //Get Leave type filter
        LeaveTypeFilter:="HR Leave Types".GetFilter("HR Leave Types".Code);
    end;

    var
        HRLeavePeriods: Record "HR Leave Periods";
        AllocationDone: Boolean;
        HRLeaveTypes: Record "HR Leave Types";
        HRLeaveLedger: Record "HR Leave Ledger Entries";
        LeaveEntryType: Option Postive,Negative,Reimbursement;
        OK: Boolean;
        HRJournalLine: Record "HR Journal Line";
        PostingDescription: Text;
        BatchName: Option POSITIVE,NEGATIVE;
        JournalTemplate: Code[20];
        Text0001: label 'LEAVE';
        Text0002: label 'There are [%1] entries in [%2  TABLE], Journal Template Name - [%3], Journal Batch Name [%4]';
        Text0003: label '\\Do you want to proceed and overwite these entries?';
        LeaveTypeFilter: Text;
        i: Integer;
        HRLeaveLedger2: Record "HR Leave Ledger Entries";
        HRLeaveLedger3: Record "HR Leave Ledger Entries";
        HRJournalLine2: Record "HR Journal Line";
        HRLeaveJnlPostBatch: Codeunit "HR Leave Jnl.-Post Batch";


    procedure CheckGender(Emp: Record "HR Employees";LeaveType: Record "HR Leave Types") Allocate: Boolean
    begin
        if Emp.Gender = Emp.Gender::Male then
        begin
         if LeaveType.Gender=LeaveType.Gender::Male then   Allocate:=true;
        end;

        if Emp.Gender=Emp.Gender::Female then
        begin
         if LeaveType.Gender=LeaveType.Gender::Female then  Allocate:=true;
        end;

        if LeaveType.Gender=LeaveType.Gender::Both then Allocate:=true;
        exit(Allocate);

        if Emp.Gender<>LeaveType.Gender then Allocate:=false;

        exit(Allocate);
    end;
}

