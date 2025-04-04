Codeunit 80009 "AU factory"
{

    trigger OnRun()
    begin
    end;


    procedure FnInsertJournalLines(JTemplate: Code[20]; JBatch: Code[20]; DocumentNo: Code[20]; ExtDocumentNo: Code[20]; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee; AccountNo: Code[20]; SourceNo: Code[20]; PostingDate: Date; Description: Text[150]; Dim1: Code[10]; Dim2: Code[10]; Amount: Decimal; LineNo: Integer; BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee; BalAccountNo: Code[20]; Period: Date; Ammenity: Code[40]; Property: Code[40])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := JTemplate;
        GenJournalLine."Journal Batch Name" := JBatch;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."External Document No." := ExtDocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Source No." := SourceNo;
        GenJournalLine."Posting Date" := PostingDate;
        GenJournalLine.Description := Description;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine."Shortcut Dimension 1 Code" := Dim1;
        GenJournalLine."Shortcut Dimension 2 Code" := Dim2;
        GenJournalLine.Amount := Amount;
        GenJournalLine."Bal. Account Type" := BalAccountType;
        GenJournalLine."Bal. Account No." := BalAccountNo;
        GenJournalLine.Period := Period;

        GenJournalLine.Property := Property;
        GenJournalLine.Ammenity := Ammenity;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    procedure GetGLfromBugetLine(BudgetLine: Code[250]) GlNo: Code[250];
    var

    begin
        GlNo := '';
        DimensionValue.Reset();
        DimensionValue.SetRange(DimensionValue.Code, BudgetLine);
        if DimensionValue.FindFirst() then begin
            GlNo := DimensionValue."G/L Account";

        end;
        exit(GlNo);
    end;

    procedure PostFundsTransfer("Funds Transfer Header": Record "Funds Transfer Header"; "Journal Template": Code[20]; "Journal Batch": Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        FundsLine: Record "Funds Transfer Line";
        FundsHeader: Record "Funds Transfer Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        FundsLine2: Record "Funds Transfer Line";
        GenBatch: Record 232;
        FundsHeader2: Record "Funds Transfer Header";
    begin
        FundsHeader.TransferFields("Funds Transfer Header", true);
        SourceCode := 'TRANSJNL';

        //insert if not availabe
        GenBatch.Reset();
        GenBatch.SetRange("Journal Template Name", "Journal Template");
        GenBatch.SetRange(Name, "Journal Batch");
        if GenBatch.FindFirst() = false then begin
            GenBatch."Journal Template Name" := "Journal Template";
            GenBatch.Name := "Journal Batch";
            GenBatch.Description := "Journal Batch";
            GenBatch.Insert(true);
        end;
        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo := 1000;
        //********************************************Add to Bank(Payment Header)*******************************************************//
        FundsHeader.CalcFields(FundsHeader."Total Line Amount");
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := FundsHeader."Posting Date";
        GenJnlLine."Document No." := FundsHeader."No.";
        GenJnlLine.Description := FundsHeader.Description;

        GenJnlLine."External Document No." := FundsHeader."Cheque/Doc. No";
        GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
        GenJnlLine."Account No." := FundsHeader."Paying Bank Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Amount := -(FundsHeader."Total Line Amount");  //Credit Amount
        GenJnlLine.Validate(GenJnlLine.Amount);

        FundsLine.Reset;
        FundsLine.SetRange(FundsLine."Document No", FundsHeader."No.");
        FundsLine.SetFilter(FundsLine."Amount to Receive", '<>%1', 0);
        if FundsLine.FindSet then begin
            GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"Bank Account";
            GenJnlLine."Bal. Account No." := FundsLine."Receiving Bank Account";
            GenJnlLine."Currency Factor" := FundsLine."Currency Factor";
        end;
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := FundsHeader."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := FundsHeader."Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, FundsHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, FundsHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, FundsHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, FundsHeader."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, FundsHeader."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, FundsHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := UpperCase(CopyStr(FundsHeader.Description, 1, 50));

        GenJnlLine.Validate(GenJnlLine.Description);
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
        //************************************************End Add to Bank***************************************************************//
        // Message('Journals Inserted successfully');
        // exit;


        // //Now Post the Journal Lines
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnlLine);
        //***************************************************End Posting****************************************************************//
        Commit;
        //*************************************************Update Document**************************************************************//
        BankLedgers.Reset;
        BankLedgers.SetRange(BankLedgers."Document No.", FundsHeader."No.");
        if BankLedgers.FindFirst then begin
            FundsHeader2.Reset;
            FundsHeader2.SetRange(FundsHeader2."No.", FundsHeader."No.");
            if FundsHeader2.FindFirst then begin
                FundsHeader2.Status := FundsHeader2.Status::Posted;
                FundsHeader2.Posted := true;
                FundsHeader2."Posted By" := UserId;
                FundsHeader2."Date Posted" := Today;
                FundsHeader2."Time Posted" := Time;
                FundsHeader2.Modify;

                FundsLine2.Reset;
                FundsLine2.SetRange(FundsLine2."Document No", FundsHeader2."No.");
                if FundsLine2.FindSet then begin
                    repeat
                        FundsLine2.Status := FundsLine2.Status::Posted;
                        FundsLine2.Posted := true;
                        FundsLine2."Posted By" := UserId;
                        FundsLine2."Date Posted" := Today;
                        FundsLine2."Time Posted" := Time;
                        FundsLine2.Modify;
                    until FundsLine2.Next = 0;
                end;
            end;
        end;

        Message('Transfer of funds were successfully done');

        //*************************************End add Line NetAmounts**********************************************************//
    end;

    var
        DimensionValue: Record "Dimension Value";

}

