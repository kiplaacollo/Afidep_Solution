codeunit 50000 Postcodeunit
{
    trigger OnRun()
    begin

    end;

    var
        GenJnlLine: Record "Gen. Journal Line";

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLin(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin

        GLEntry."Currency Code 3" := GenJournalLine."Currency Code";
        GLEntry."Currency Factor3" := GenJournalLine."Currency Factor";
        GLEntry.Country3 := GenJournalLine.Country2;




    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInitGLEntry', '', false, false)]
    procedure OnBeforeInitGLEntry(var GenJournalLine: Record "Gen. Journal Line")
    var
        GLEntry: Record "G/L Entry";
        Purchase: Record "Purchase Header";
        purhase: Record "Purchase Line";
    begin
        //IsHandled := false;
        //GLEntry.Init();

        GLEntry."Currency Code 3" := GenJournalLine."Currency Code";
        GLEntry."Currency Factor3" := GenJournalLine."Currency Factor";
        GLEntry.Country3 := GenJournalLine.Country2;
        GLEntry.Payee2 := GenJournalLine.Payee;
        GLEntry.BudgetLineDescription2 := GenJournalLine."Budget Line Description";


        //LEntry.Insert();

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInitBankAccLedgEntry', '', false, false)]
    procedure OnBeforeInitBankAccLedgEntry(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    begin
        //BankAccountLedgerEntry."Bank Narration" := GenJnlLine."Bank Narration";
    end;
}