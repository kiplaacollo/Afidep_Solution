Codeunit 80006 "HR Leave Jnl.-Post Line"
{
    Permissions = TableData "Ins. Coverage Ledger Entry"=rimd,
                  TableData "Insurance Register"=rimd;
    TableNo = "HR Journal Line";

    trigger OnRun()
    begin
        GLSetup.Get;
        /*TempJnlLineDim2.RESET;
        TempJnlLineDim2.DELETEALL;
        IF "Shortcut Dimension 1 Code" <> '' THEN BEGIN
          TempJnlLineDim2."Table ID" := DATABASE::"Insurance Journal Line";
          TempJnlLineDim2."Journal Template Name" := "Journal Template Name";
          TempJnlLineDim2."Journal Batch Name" := "Journal Batch Name";
          TempJnlLineDim2."Journal Line No." := "Line No.";
          TempJnlLineDim2."Dimension Code" := GLSetup."Global Dimension 1 Code";
          TempJnlLineDim2."Dimension Value Code" := "Shortcut Dimension 1 Code";
          TempJnlLineDim2.INSERT;
        END;
        IF "Shortcut Dimension 2 Code" <> '' THEN BEGIN
          TempJnlLineDim2."Table ID" := DATABASE::"HR Journal Line";
          TempJnlLineDim2."Journal Template Name" := "Journal Template Name";
          TempJnlLineDim2."Journal Batch Name" := "Journal Batch Name";
          TempJnlLineDim2."Journal Line No." := "Line No.";
          TempJnlLineDim2."Dimension Code" := GLSetup."Global Dimension 2 Code";
          TempJnlLineDim2."Dimension Value Code" := "Shortcut Dimension 2 Code";
          TempJnlLineDim2.INSERT;
        END;*/
        RunWithCheck(Rec);

    end;

    var
        GLSetup: Record "General Ledger Setup";
        FA: Record "HR Employees";
        Insurance: Record "HR Leave Application";
        InsuranceJnlLine: Record "HR Journal Line";
        InsCoverageLedgEntry: Record "HR Leave Ledger Entries";
        InsCoverageLedgEntry2: Record "HR Leave Ledger Entries";
        InsuranceReg: Record "HR Leave Register";
        InsuranceJnlCheckLine: Codeunit "HR Leave Jnl.-Check Line";
        DimMgt: Codeunit DimensionManagement;
        NextEntryNo: Integer;


    procedure RunWithCheck(var InsuranceJnlLine2: Record "HR Journal Line")
    begin
        InsuranceJnlLine.Copy(InsuranceJnlLine2);
        /*TempJnlLineDim.RESET;
        TempJnlLineDim.DELETEALL;*/
        //DimMgt.CopyJnlLineDimToJnlLineDim(TempJnlLineDim2,TempJnlLineDim);
        Code(true);
        InsuranceJnlLine2 := InsuranceJnlLine;

    end;


    procedure RunWithOutCheck(var InsuranceJnlLine2: Record "HR Journal Line")
    begin
        InsuranceJnlLine.Copy(InsuranceJnlLine2);
        
        /*TempJnlLineDim.RESET;
        TempJnlLineDim.DELETEALL;*/
        //DimMgt.CopyJnlLineDimToJnlLineDim(TempJnlLineDim2,TempJnlLineDim);
        
        Code(false);
        InsuranceJnlLine2 := InsuranceJnlLine;

    end;

    local procedure "Code"(CheckLine: Boolean)
    begin
        with InsuranceJnlLine do begin
          if "Document No." = '' then
            exit;
          if CheckLine then
        //    InsuranceJnlCheckLine.RunCheck(InsuranceJnlLine,TempJnlLineDim);
          Insurance.Reset;
          //Insurance.SETRANGE("Leave Application No.",
         // Insurance.GET("Document No.");
          FA.Get("Staff No.");
          CopyFromJnlLine(InsCoverageLedgEntry,InsuranceJnlLine);
          //MakeInsCoverageLedgEntry.CopyFromInsuranceCard(InsCoverageLedgEntry,Insurance);
        end;
        if NextEntryNo = 0 then begin
          InsCoverageLedgEntry.LockTable;
          if InsCoverageLedgEntry2.Find('+') then
            NextEntryNo := InsCoverageLedgEntry2."Entry No.";
          InsuranceReg.LockTable;
          if InsuranceReg.Find('+') then
            InsuranceReg."No." := InsuranceReg."No." + 1
          else
            InsuranceReg."No." := 1;
          InsuranceReg.Init;
          InsuranceReg."From Entry No." := NextEntryNo + 1;
          InsuranceReg."Creation Date" := Today;
          InsuranceReg."Source Code" := InsuranceJnlLine."Source Code";
          InsuranceReg."Journal Batch Name" := InsuranceJnlLine."Journal Batch Name";
          InsuranceReg."User ID" := UserId;
        end;
        NextEntryNo := NextEntryNo + 1;
        InsCoverageLedgEntry."Entry No." := NextEntryNo;
        InsCoverageLedgEntry.Insert;
        /*
        DimMgt.MoveJnlLineDimToLedgEntryDim(
          TempJnlLineDim,DATABASE::"Ins. Coverage Ledger Entry",
          InsCoverageLedgEntry."Entry No.");
        */
        if InsuranceReg."To Entry No." = 0 then begin
          InsuranceReg."To Entry No." := NextEntryNo;
          InsuranceReg.Insert;
        end else begin
          InsuranceReg."To Entry No." := NextEntryNo;
          InsuranceReg.Modify;
        end;

    end;

    local procedure CopyFromJnlLine(var InsCoverageLedgEntry: Record "HR Leave Ledger Entries";var InsuranceJnlLine: Record "HR Journal Line")
    begin
        with InsCoverageLedgEntry do begin
          "User ID" := UserId;
          "Leave Period" := InsuranceJnlLine."Leave Period";
          "Staff No." := InsuranceJnlLine."Staff No.";
          "Staff Name" := InsuranceJnlLine."Staff Name";
          "Posting Date" := InsuranceJnlLine."Posting Date";
          "Leave Recalled No.":=InsuranceJnlLine."Leave Recalled No.";
          "Leave Entry Type" := InsuranceJnlLine."Leave Entry Type";
          "Leave Type":=InsuranceJnlLine."Leave Type";
          "Leave Approval Date" := InsuranceJnlLine."Leave Approval Date";
          "Leave Type":=InsuranceJnlLine."Leave Type";
          if "Leave Approval Date" = 0D then
          "Leave Approval Date" := "Posting Date";
          "Document No." :=  InsuranceJnlLine."Document No.";
          "External Document No." := InsuranceJnlLine."External Document No.";
          "No. of days" := InsuranceJnlLine."No. of Days";
          "Leave Posting Description" := InsuranceJnlLine.Description;
          "Global Dimension 1 Code" := InsuranceJnlLine."Shortcut Dimension 1 Code";
          "Global Dimension 2 Code" := InsuranceJnlLine."Shortcut Dimension 2 Code";
          "Source Code" := InsuranceJnlLine."Source Code";
          "Journal Batch Name" := InsuranceJnlLine."Journal Batch Name";
          "Reason Code" := InsuranceJnlLine."Reason Code";
          //Closed := SetDisposedFA(InsCoverageLedgEntry."Staff No.");
          "No. Series" := InsuranceJnlLine."Posting No. Series";
        end;
    end;
}

