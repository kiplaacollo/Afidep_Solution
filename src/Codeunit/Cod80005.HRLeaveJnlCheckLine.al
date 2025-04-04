Codeunit 80005 "HR Leave Jnl.-Check Line"
{
    TableNo = "HR Journal Line";

    trigger OnRun()
    begin
        GLSetup.Get;
        
        /*IF "Shortcut Dimension 1 Code" <> '' THEN BEGIN
          TempJnlLineDim."Table ID" := DATABASE::"HR Journal Line";
          TempJnlLineDim."Journal Template Name" := "Journal Template Name";
          TempJnlLineDim."Journal Batch Name" := "Journal Batch Name";
          TempJnlLineDim."Journal Line No." := "Line No.";
          TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 1 Code";
          TempJnlLineDim."Dimension Value Code" := "Shortcut Dimension 1 Code";
          TempJnlLineDim.INSERT;
        END;
        IF "Shortcut Dimension 2 Code" <> '' THEN BEGIN
          TempJnlLineDim."Table ID" := DATABASE::"HR Journal Line";
          TempJnlLineDim."Journal Template Name" := "Journal Template Name";
          TempJnlLineDim."Journal Batch Name" := "Journal Batch Name";
          TempJnlLineDim."Journal Line No." := "Line No.";
          TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 2 Code";
          TempJnlLineDim."Dimension Value Code" := "Shortcut Dimension 2 Code";
          TempJnlLineDim.INSERT;
        END;
        
        RunCheck(Rec,TempJnlLineDim);*/

    end;

    var
        Text000: label 'The combination of dimensions used in %1 %2, %3, %4 is blocked. %5';
        Text001: label 'A dimension used in %1 %2, %3, %4 has caused an error. %5';
        GLSetup: Record "General Ledger Setup";
        FASetup: Record "HR Setup";
        DimMgt: Codeunit DimensionManagement;
        CallNo: Integer;
        Text002: label 'The Posting Date Must be within the open leave periods';
        Text003: label 'The Posting Date Must be within the allowed Setup date';
        LeaveEntries: Record "HR Leave Ledger Entries";
        Text004: label 'The Allocation of Leave days has been done for the period';


    procedure ValidatePostingDate(var InsuranceJnlLine: Record "HR Journal Line")
    begin
        with InsuranceJnlLine do begin
           if "Leave Entry Type"="leave entry type"::Negative then begin
          TestField("Leave Period");
         end;
          TestField("Document No.");
          TestField("Posting Date");
          TestField("Staff No.");
          if ("Posting Date"<"Leave Period Start Date") or
             ("Posting Date">"Leave Period End Date")  then
            // ERROR(FORMAT(Text002));
        
        FASetup.Get();
        if (FASetup."Leave Posting Period[FROM]"<>0D) and (FASetup."Leave Posting Period[TO]"<>0D) then begin
          if ("Posting Date"<FASetup."Leave Posting Period[FROM]") or
             ("Posting Date">FASetup."Leave Posting Period[TO]")  then
             Error(Format(Text003));
        end;
        /*
             LeaveEntries.RESET;
             LeaveEntries.SETRANGE(LeaveEntries."Leave Type","Leave Type Code");
            IF LeaveEntries.FIND('-') THEN BEGIN
         IF LeaveEntries."Leave Transaction Type"=LeaveEntries."Leave Transaction Type"::"Leave Allocation" THEN BEGIN
         IF (LeaveEntries."Posting Date"<"Leave Period Start Date") OR
             (LeaveEntries."Posting Date">"Leave Period End Date")  THEN
             ERROR(FORMAT(Text004));
                     END;
           END;
        */
        end;

    end;


    procedure RunCheck(var InsuranceJnlLine: Record "HR Journal Line")
    var
        TableID: array [10] of Integer;
        No: array [10] of Code[20];
    begin
        with InsuranceJnlLine do begin
           if "Leave Entry Type"="leave entry type"::Negative then begin
          TestField("Leave Application No.");
         end;
          TestField("Document No.");
          TestField("Posting Date");
          TestField("Staff No.");
          CallNo := 1;
        
         /* IF NOT DimMgt.CheckJnlLineDimComb(JnlLineDim) THEN
            ERROR(
              Text000,
              TABLECAPTION,"Journal Template Name","Journal Batch Name","Line No.",
              DimMgt.GetDimCombErr);
          */
        //  TableID[1] := DATABASE::Table56175;
          TableID[1] := Database::"HR Journal Line";
          No[1] := "Leave Application No.";
         /* IF NOT DimMgt.CheckJnlLineDimValuePosting(JnlLineDim,TableID,No) THEN
            IF "Line No." <> 0 THEN
              ERROR(
                Text001,
                TABLECAPTION,"Journal Template Name","Journal Batch Name","Line No.",
                DimMgt.GetDimValuePostingErr)
            ELSE
              ERROR(DimMgt.GetDimValuePostingErr); */
        end;
        ValidatePostingDate(InsuranceJnlLine);

    end;

    local procedure JTCalculateCommonFilters()
    begin
    end;
}

