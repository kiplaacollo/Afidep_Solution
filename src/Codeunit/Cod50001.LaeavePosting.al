codeunit 50001 "Laeave Posting"
{
    trigger OnRun()
    begin
        LastDay := CALCDATE('-CM+27D', TODAY);
        YearBegin := CALCDATE('-CY', TODAY);
        IF TODAY = LastDay THEN BEGIN
            AccruedLeavePosting();
        END;
        IF Today = YearBegin then begin
            // PostOtherTypesofLeave();
        end;
    end;

    var
        LastDay: Date;
        YearBegin: Date;

    procedure AccruedLeavePosting()
    var
        LineNo: Integer;
        HRSetup: Record "HR Setup";
        HRLeaveTypes: Record "HR Leave Types";
        HrJournalLine: Record "HR Journal Line";
        HrEmployees: Record "HR Employees";
        HRLeavePeriods: Record "HR Leave Periods";
    begin
        HRSetup.RESET;
        IF HRSetup.FIND('-') THEN BEGIN

            HrJournalLine.RESET;
            HrJournalLine.SETRANGE("Journal Template Name", HRSetup."Leave Template");
            HrJournalLine.SETRANGE("Journal Batch Name", HRSetup."Leave Batch");
            HrJournalLine.DELETEALL;

            HRLeaveTypes.Reset();
            HRLeaveTypes.SetFilter(HRLeaveTypes.Code, '%1', 'ANNUAL');
            IF HRLeaveTypes.Find('-') THEN begin

                HrEmployees.RESET;
                HrEmployees.SETRANGE(HrEmployees.Status, HrEmployees.Status::Active);
                IF HrEmployees.FIND('-') THEN BEGIN
                    REPEAT
                        LineNo := LineNo + 10000;
                        HrJournalLine.INIT;
                        HrJournalLine."Journal Template Name" := HRSetup."Leave Template";
                        HrJournalLine."Journal Batch Name" := HRSetup."Leave Batch";
                        HrJournalLine."Line No." := LineNo;
                        HrJournalLine."Leave Period" := '2025';
                        HrJournalLine."Leave Application No." := HrEmployees."No.";
                        HrJournalLine."Document No." := HrEmployees."No.";
                        HrJournalLine."Staff No." := HrEmployees."No.";
                        HrJournalLine.VALIDATE(HrJournalLine."Staff No.");
                        HrJournalLine."Posting Date" := TODAY;
                        HrJournalLine."Leave Entry Type" := HrJournalLine."Leave Entry Type"::Positive;
                        HrJournalLine."Leave Approval Date" := TODAY;
                        HrJournalLine.Description := 'Days Earned for ' + FORMAT(HrJournalLine."Posting Date");
                        HrJournalLine."Leave Type" := HRLeaveTypes.Code;
                        //------------------------------------------------------------
                        //HRSetup.RESET;
                        //HRSetup.FIND('-');
                        HRSetup.TESTFIELD(HRSetup."Leave Posting Period[FROM]");
                        HRSetup.TESTFIELD(HRSetup."Leave Posting Period[TO]");
                        //------------------------------------------------------------
                        HrJournalLine."Leave Period Start Date" := HRSetup."Leave Posting Period[FROM]";
                        HrJournalLine."Leave Period End Date" := HRSetup."Leave Posting Period[TO]";
                        HrJournalLine."No. of Days" := HRSetup."Days Accrued Monthly";
                        IF HrJournalLine."No. of Days" <> 0 THEN
                            HrJournalLine.INSERT(TRUE);
                    UNTIL HrEmployees.NEXT = 0;
                END;
            END;
            //Post Journal
            HrJournalLine.RESET;
            HrJournalLine.SETRANGE("Journal Template Name", HRSetup."Leave Template");
            HrJournalLine.SETRANGE("Journal Batch Name", HRSetup."Leave Batch");
            IF HrJournalLine.FIND('-') THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post", HrJournalLine);
            END;
        END;
    end;

    procedure PostOtherTypesofLeave()
    var
        LineNo: Integer;
        HRSetup: Record "HR Setup";
        HrJournalLine: Record "HR Journal Line";
        HRLeaveTypes: Record "HR Leave Types";
        HrEmployees: Record "HR Employees";
        HRLeavePeriods: Record "HR Leave Periods";
    begin
        HRSetup.RESET;
        IF HRSetup.FIND('-') THEN BEGIN

            HrJournalLine.RESET;
            HrJournalLine.SETRANGE("Journal Template Name", HRSetup."Leave Template");
            HrJournalLine.SETRANGE("Journal Batch Name", HRSetup."Leave Batch");
            HrJournalLine.DELETEALL;

            HRLeaveTypes.Reset();
            HRLeaveTypes.SetFilter(HRLeaveTypes.Code, '<>%1', 'ANNUAL');
            IF HRLeaveTypes.Find('-') THEN begin
                HrEmployees.RESET;
                HrEmployees.SETRANGE(HrEmployees.Status, HrEmployees.Status::Active);
                IF HrEmployees.FIND('-') THEN BEGIN
                    REPEAT
                        LineNo := LineNo + 10000;
                        HrJournalLine.INIT;
                        HrJournalLine."Journal Template Name" := HRSetup."Leave Template";
                        HrJournalLine."Journal Batch Name" := HRSetup."Leave Batch";
                        HrJournalLine."Line No." := LineNo;
                        HrJournalLine."Leave Period" := HRLeavePeriods.Name;
                        HrJournalLine."Leave Application No." := HrEmployees."No.";
                        HrJournalLine."Document No." := HrEmployees."No.";
                        HrJournalLine."Staff No." := HrEmployees."No.";
                        HrJournalLine.VALIDATE(HrJournalLine."Staff No.");
                        HrJournalLine."Posting Date" := TODAY;
                        HrJournalLine."Leave Entry Type" := HrJournalLine."Leave Entry Type"::Positive;
                        HrJournalLine."Leave Approval Date" := TODAY;
                        HrJournalLine.Description := 'Days Earned for ' + FORMAT(HrJournalLine."Posting Date");
                        HrJournalLine."Leave Type" := HRLeaveTypes.Code;
                        //------------------------------------------------------------
                        //HRSetup.RESET;
                        //HRSetup.FIND('-');
                        HRSetup.TESTFIELD(HRSetup."Leave Posting Period[FROM]");
                        HRSetup.TESTFIELD(HRSetup."Leave Posting Period[TO]");
                        //------------------------------------------------------------
                        HrJournalLine."Leave Period Start Date" := HRSetup."Leave Posting Period[FROM]";
                        HrJournalLine."Leave Period End Date" := HRSetup."Leave Posting Period[TO]";
                        HrJournalLine."No. of Days" := HRLeaveTypes.Days;
                        IF HrJournalLine."No. of Days" <> 0 THEN
                            HrJournalLine.INSERT(TRUE);
                    UNTIL HrEmployees.NEXT = 0;
                END;
            END;
            //Post Journal
            HrJournalLine.RESET;
            HrJournalLine.SETRANGE("Journal Template Name", HRSetup."Leave Template");
            HrJournalLine.SETRANGE("Journal Batch Name", HRSetup."Leave Batch");
            IF HrJournalLine.FIND('-') THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post", HrJournalLine);
            END;
        END;

    end;
}