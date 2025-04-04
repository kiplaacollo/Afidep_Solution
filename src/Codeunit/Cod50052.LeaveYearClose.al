//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50052 "Leave Year-Close"
{
    TableNo = "HR Leave Periods";

    trigger OnRun()
    begin
        AccountingPeriod.Copy(Rec);
        //  Code;
        UpdateLeaveBalancesForNewYear(2025);
        // Rec := AccountingPeriod;
    end;

    var
        Text001: label 'You must create a new fiscal year before you can close the old year.';
        Text002: label 'This function closes the fiscal year from %1 to %2. ';
        Text003: label 'Once the fiscal year is closed it cannot be opened again, and the periods in the fiscal year cannot be changed.\\';
        Text004: label 'Do you want to close the fiscal year?';
        AccountingPeriod: Record "HR Leave Periods";
        AccountingPeriod2: Record "HR Leave Periods";
        AccountingPeriod3: Record "HR Leave Periods";
        FiscalYearStartDate: Date;
        FiscalYearEndDate: Date;

    local procedure "Code"()
    begin
        with AccountingPeriod do begin
            AccountingPeriod2.SetRange(Closed, false);
            AccountingPeriod2.Find('-');

            FiscalYearStartDate := AccountingPeriod2."Starting Date";
            AccountingPeriod := AccountingPeriod2;
            TestField("New Fiscal Year", true);

            AccountingPeriod2.SetRange("New Fiscal Year", true);
            if AccountingPeriod2.Find('>') then begin
                FiscalYearEndDate := CalcDate('<-1D>', AccountingPeriod2."Starting Date");

                AccountingPeriod3 := AccountingPeriod2;
                AccountingPeriod2.SetRange("New Fiscal Year");
                AccountingPeriod2.Find('<');
            end else
                Error(Text001);

            if not
               Confirm(
                 Text002 +
                 Text003 +
                 Text004, false,
                 FiscalYearStartDate, FiscalYearEndDate)
            then
                exit;

            Reset;

            SetRange("Starting Date", FiscalYearStartDate, AccountingPeriod2."Starting Date");
            ModifyAll(Closed, true);

            SetRange("Starting Date", FiscalYearStartDate, AccountingPeriod3."Starting Date");
            ModifyAll("Date Locked", true);

            Reset;
        end;
    end;

    procedure UpdateLeaveBalancesForNewYear(NewYear: Integer)
    var
        Employee: Record "HR Employees";
        LeaveLedger: Record "HR Leave Ledger Entries";
        MaxEntryNo: Decimal;
        CarryForwardDays: Decimal;
    begin
        // Loop through all employees
        Employee.Reset();
        if Employee.FindSet() then
            repeat
                Employee.CalcFields("Annual Leave Account");

                // Only process Annual Leave
                CarryForwardDays := Employee."Annual Leave Account" - 2;

                // Get the maximum Entry No. and increment it
                if LeaveLedger.FindLast() then
                    MaxEntryNo := LeaveLedger."Entry No."
                else
                    MaxEntryNo := 0;

                // Insert a ledger entry for carry-forward
                LeaveLedger.Init();
                LeaveLedger."Entry No." := MaxEntryNo + 1;
                LeaveLedger."Leave Period" := Format(NewYear);
                LeaveLedger."Staff No." := Employee."No.";
                LeaveLedger."Staff Name" := Employee."First Name" + ' ' + Employee."Last Name";
                LeaveLedger."Leave Type" := 'ANNUAL';
                LeaveLedger."Posting Date" := DMY2Date(1, 1, NewYear);
                LeaveLedger."No. of days" := CarryForwardDays;
                LeaveLedger."Leave Entry Type" := LeaveLedger."Leave Entry Type"::CarryFoward;
                LeaveLedger."Leave Posting Description" := Format(NewYear) + ' Leave Posting';
                LeaveLedger.Insert();

                // Update employee's Annual Leave balance
                Employee."Annual Leave Account" := CarryForwardDays;
                Employee.Modify();
            until Employee.Next() = 0;

        Message('Annual leave balances have been updated successfully.');
    end;



    procedure fnLeavebalance(lvApplicationcode: Code[10]; lvLeavetype: Code[10]; lvStaffno: Code[10]; lvBalance: Decimal)
    var
        lvLeavebalance: Record "HR Employees";
        HRLeaveTypes: Record "HR Leave Types";
    begin
        /*IF Balance = 0 THEN EXIT;
        WITH fnLeavebalance DO BEGIN
            INIT;
            "No.":= Staffno;
            "Transaction Code" := TCode;
            "Group Text" := TGroup;
            "Transaction Name" := Description;
            INSERT;
           //Update the prEmployee Transactions  with the Amount
           fnLeavebalance( "No.","Transaction Code",Amount,"Period Month","Period Year","Payroll Period");
        END;
         */

        lvLeavebalance.Reset;
        lvLeavebalance.SetRange(lvLeavebalance."No.", lvStaffno);
        lvLeavebalance.SetRange(lvLeavebalance."Leave Type Filter", lvLeavetype);
        if lvLeavebalance.Find('-') then begin
            if lvLeavebalance."Leave Balance" >= HRLeaveTypes."Max Carry Forward Days" then begin
                lvLeavebalance."Reimbursed Leave Days" := HRLeaveTypes."Max Carry Forward Days";
            end else
                if
       lvLeavebalance."Leave Balance" < HRLeaveTypes."Max Carry Forward Days" then
                    lvLeavebalance."Reimbursed Leave Days" := lvLeavebalance."Leave Balance";
            lvLeavebalance.Modify;


            /*SETFILTER("Leave Type Filter","HR Employees".GETFILTER("HR Employees"."Leave Type Filter"));

            HRLeaveTypes.GET("HR Employees".GETFILTER("Leave Type Filter"));

            VALIDATE("Allocated Leave Days");

            IF "HR Employees"."Leave Balance" >=  HRLeaveTypes."Max Carry Forward Days" THEN BEGIN
            "HR Employees"."Reimbursed Leave Days":=HRLeaveTypes."Max Carry Forward Days";
            END ELSE IF
            "HR Employees"."Leave Balance" < HRLeaveTypes."Max Carry Forward Days" THEN
            "HR Employees"."Reimbursed Leave Days":="HR Employees"."Leave Balance";
            "HR Employees".MODIFY;
              */
        end;

    end;
}




