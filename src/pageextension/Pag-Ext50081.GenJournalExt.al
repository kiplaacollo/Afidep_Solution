pageextension 50081 "General Journal Ext" extends "General Journal"
{

    layout
    {
        addafter(Amount)
        {
            field("VAT Base Amount"; Rec."VAT Base Amount")
            {
                ApplicationArea = Basic;
            }
            // field("VAT Amount_"; Rec."VAT Amount")
            // {
            //     ApplicationArea = Basic;
            // }
        }
        addafter("Currency Code")
        {
            field("Currency Factor"; Rec."Currency Factor")
            {
                ApplicationArea = Basic;
                Editable = true;
            }
            // field("Approval Status"; Rec."Approval Status")
            // {
            //     ApplicationArea = Basic;
            // }
        }
    }
    actions
    {

        addafter(Post)
        {
            action(PostNew)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost New';
                Image = PostOrder;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                begin
                    // Rec.SendToPosting(Codeunit::"Gen. Jnl.-Post");
                    // CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                    // if IsSimplePage then
                    //     if GeneralLedgerSetup."Post with Job Queue" then
                    //         NewDocumentNo()
                    //     else
                    //         SetDataForSimpleModeOnPost();
                    // SetJobQueueVisibility();
                    // CurrPage.Update(false);
                end;
            }
        }

        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                AdjustSmallRoundingDifference(Rec);
            end;
        }
    }

    procedure AdjustSmallRoundingDifference(GenJournalLine: Record "Gen. Journal Line")
    var
        GenJnlLineLocal: Record "Gen. Journal Line";
        TotalAmount: Decimal;
        AdjustmentAmount: Decimal;
    begin
        TotalAmount := 0;

        // Loop through lines for the same document
        GenJnlLineLocal.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        GenJnlLineLocal.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        GenJnlLineLocal.SetRange("Document No.", GenJournalLine."Document No.");
        GenJnlLineLocal.SetRange("Posting Date", GenJournalLine."Posting Date");

        if GenJnlLineLocal.FindSet() then begin
            repeat
                if GenJnlLineLocal."Amount" <> 0 then
                    TotalAmount += GenJnlLineLocal."Amount";
            until GenJnlLineLocal.Next() = 0;
        end;

        // Check if out of balance by a small rounding difference (within +/-5)
        if (Abs(TotalAmount) > 0) and (Abs(TotalAmount) <= 5) then begin
            AdjustmentAmount := -TotalAmount;

            // Apply adjustment to the first line
            if GenJnlLineLocal.FindFirst() then begin
                GenJnlLineLocal."Amount" := GenJnlLineLocal."Amount" + AdjustmentAmount;

                // Adjust Debit or Credit accordingly
                if GenJnlLineLocal."Debit Amount" <> 0 then
                    GenJnlLineLocal."Debit Amount" := GenJnlLineLocal."Debit Amount" + AdjustmentAmount
                else
                    if GenJnlLineLocal."Credit Amount" <> 0 then
                        GenJnlLineLocal."Credit Amount" := GenJnlLineLocal."Credit Amount" + (-AdjustmentAmount);

                // Optional: Also adjust VAT Base Amount if needed (use same logic as amount)
                GenJnlLineLocal."VAT Base Amount" := GenJnlLineLocal."VAT Base Amount" + AdjustmentAmount;

                GenJnlLineLocal.Modify();
            end;
        end;
    end;

}




