report 80071 "Bank Account Reconciliation"
{
    // version Payment ProcessesV1.0(Surestep Systems)

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Bank Acc. Reconciliation.rdlc';
    Caption = 'Bank Reconciliation Custom';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Bank Acc. Reconciliation"; "Bank Acc. Reconciliation")
        {
            RequestFilterFields = "Statement No.";
            column(BankCode; BankCode)
            {
            }
            column(BankAccountNo_BankAccReconciliation; "Bank Acc. Reconciliation"."Bank Account No.")
            {
            }
            column(RequesterDate; RequesterDate) { }
            column(RequesterName; RequesterName) { }
            column(Requester_Signature; "Requester Signature") { }
            column(Approver1Name; Approver1Name) { }
            column(Approver1Date; Approver1Date) { }
            column(Approver1Signature; Approver1Signature) { }
            column(Approver2Name; Approver2Name) { }
            column(Approver2Date; Approver2Date) { }
            column(Approver2Signature; Approver2Signature) { }
            column(StatementNo_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement No.")
            {
            }
            column(StatementDate_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement Date")
            {
            }
            column(TotalBalanceonBankAccount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Balance on Bank Account")
            {
            }
            column(TotalAppliedAmount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Applied Amount")
            {
            }
            column(TotalTransactionAmount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Transaction Amount")
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(StatementEndingBalance_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement Ending Balance")
            {
            }
            column(BankName; BankName)
            {
            }
            column(DoneByname; DoneByname) { }
            column(BankAccountBalanceasperCashBook; BankAccountBalanceasperCashBook)
            {
            }
            column(UnpresentedChequesTotal; UnpresentedChequesTotal)
            {
            }
            column(UncreditedBanking; UncreditedBanking)
            {
            }
            column(ReconciliationStatement; ReconciliationStatement)
            {
            }
            column(CompanyInformation_Pic; CompanyInformation.Picture) { }
            column(CompanyInformation_address; CompanyInformation.Address) { }
            column(CompanyInformation_Phone; CompanyInformation."Phone No.") { }
            column(CompanyInformation_name; CompanyInformation.Name) { }
            column(CompanyInformation_Address2; CompanyInformation."Address 2") { }
            column(CompanyInformation_homepage; CompanyInformation."Home Page") { }
            column(CompanyInformation_Email; CompanyInformation."E-Mail") { }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            dataitem("Bank Acc. Reconciliation Line"; "Bank Acc. Reconciliation Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE("Applied Entries" = CONST(0), "Statement Amount" = FILTER(< 0));
                column(CheckNo_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Check No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Transaction Date")
                {
                }
                column(StatementLineNo_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Statement Line No.")
                {
                }
                column(Description_BankAccReconciliationLine; "Bank Acc. Reconciliation Line".Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Statement Amount")
                {
                }
                // column(OpenType_BankAccReconciliationLine;"Bank Acc. Reconciliation Line"."Open Type")
                // {
                // }
            }
            dataitem("<Bank Acc. Reconciliation Ln1>"; "Bank Acc. Reconciliation Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE("Applied Entries" = CONST(0), "Statement Amount" = FILTER(> 0));
                column(CheckNo_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>"."Check No.")
                {
                }
                column(StatementLineNo_BankAccReconciliationLn1; "<Bank Acc. Reconciliation Ln1>"."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>"."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>"."Transaction Date")
                {
                }
                column(Description_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>".Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>"."Statement Amount")
                {
                }
                // column(OpenType_BankAccReconciliationLine1;"<Bank Acc. Reconciliation Ln1>"."Open Type")
                // {
                // }

            }

            trigger OnAfterGetRecord()
            begin
                BankCode := '';
                BankAccountNo := '';
                BankName := '';
                DoneByname := '';
                BankAccountBalanceasperCashBook := 0;
                UnpresentedChequesTotal := 0;
                UncreditedBanking := 0;
                HRemployee.Reset();
                HRemployee.SetRange(HRemployee."Employee UserID", RequesterName);
                if HRemployee.FindFirst() then begin
                    //  DoneByname := HRemployee."First Name" + ' ' + HRemployee."Middle Name" + ' ' + HRemployee."Last Name";
                    HRemployee.CALCFIELDS(Signature);
                    "Bank Acc. Reconciliation"."Requester Signature" := HRemployee.Signature;
                    ApprovalEntry.Reset;
                    ApprovalEntry.SetRange("Document No.", "Bank Acc. Reconciliation"."Bank Account No.");
                    ApprovalEntry.SetRange(Amount, "Bank Acc. Reconciliation"."Statement Ending Balance");
                    ApprovalEntry.SetRange("Sequence No.", 1);
                    if ApprovalEntry.FindFirst then begin
                        "Bank Acc. Reconciliation".RequesterDate := DT2Date(ApprovalEntry."Date-Time Sent for Approval");
                        "Bank Acc. Reconciliation".Modify(true);
                        Commit();
                    end;
                    // "Bank Acc. Reconciliation".Modify(true);
                    // Commit();
                end;

                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Document No.", "Bank Acc. Reconciliation"."Bank Account No.");
                ApprovalEntry.SetRange("Sequence No.", 1);
                ApprovalEntry.SetRange(Amount, "Bank Acc. Reconciliation"."Statement Ending Balance");
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst then begin
                    HRemployee.Reset;
                    HRemployee.SetRange(HRemployee."Employee UserID", ApprovalEntry."Approver ID");
                    if HRemployee.FindFirst then begin
                        HRemployee.CALCFIELDS(Signature);
                        "Bank Acc. Reconciliation".Approver1Signature := HRemployee.Signature;
                        "Bank Acc. Reconciliation".Approver1Name := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                        "Bank Acc. Reconciliation".Approver1Date := ApprovalEntry."Last Date-Time Modified";
                        "Bank Acc. Reconciliation".Modify(true);
                        Commit();
                    end;
                end;
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Document No.", "Bank Acc. Reconciliation"."Bank Account No.");
                ApprovalEntry.SetRange("Sequence No.", 2);
                ApprovalEntry.SetRange(Amount, "Bank Acc. Reconciliation"."Statement Ending Balance");
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst then begin
                    HREmployee.Reset;
                    HREmployee.SetRange(HREmployee."Employee UserID", ApprovalEntry."Approver ID");
                    if HREmployee.FindFirst then begin
                        HREmployee.CALCFIELDS(Signature);
                        "Bank Acc. Reconciliation".Approver2Signature := HREmployee.Signature;
                        "Bank Acc. Reconciliation".Approver2Name := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                        "Bank Acc. Reconciliation".Approver2Date := ApprovalEntry."Last Date-Time Modified";
                        "Bank Acc. Reconciliation".Modify(true);
                        Commit();
                    end;
                end;
                //unreconcilled items start
                BankStatementLine1.Reset;
                BankStatementLine1.SetRange(BankStatementLine1."Bank Account No.", Bank."No.");
                BankStatementLine1.SetRange(BankStatementLine1."Statement No.", "Statement No.");
                //BankStatementLine1.SetRange(BankStatementLine1.IsApplied(0));
                if BankStatementLine1.Find('-') then
                    repeat
                        //if BankStatementLine."Statement Amount" < 0 then
                        if BankStatementLine1.IsApplied() = true then
                            UnpresentedChequesTotal := UnpresentedChequesTotal + BankStatementLine1.Amount
                        else
                            // if BankStatementLine."Statement Amount" > 0 then
                            if BankStatementLine1.IsApplied() <> true then
                                UncreditedBanking := UncreditedBanking + BankStatementLine1.Amount;
                    until BankStatementLine1.Next = 0;
                //Message(('Niko Hapa'));
                //unreconcilleditems end

                TotalDiffFunc();

                Bank.Reset;
                Bank.SetRange(Bank."No.", "Bank Account No.");
                if Bank.Find('-') then begin
                    BankCode := Bank."No.";
                    BankAccountNo := Bank."Bank Account No.";
                    BankName := Bank.Name;
                    Bank.SetRange(Bank."Date Filter", 0D, "Statement Date");
                    Bank.CalcFields(Bank."Net Change");
                    //BankAccountBalanceasperCashBook := Bank."Net Change";

                    BankStatementLine.Reset;
                    BankStatementLine.SetRange(BankStatementLine."Bank Account No.", Bank."No.");
                    BankStatementLine.SetRange(BankStatementLine."Statement No.", "Statement No.");
                    BankStatementLine.SetRange(BankStatementLine."Applied Entries", 0);
                    if BankStatementLine.Find('-') then
                        repeat
                            //if BankStatementLine."Statement Amount" < 0 then
                            if BankStatementLine."Applied Entries" = 0 then
                                //UnpresentedChequesTotal := UnpresentedChequesTotal + BankStatementLine."Statement Amount"
                                // else
                                // if BankStatementLine."Statement Amount" > 0 then
                                if BankStatementLine."Applied Entries" = 0 then
                                    UncreditedBanking := UncreditedBanking + BankStatementLine."Statement Amount";
                        until BankStatementLine.Next = 0;
                    //Message(('Niko Hapa'));

                    UnpresentedChequesTotal := UnpresentedChequesTotal * -1;

                    BankStatBalance := "Bank Acc. Reconciliation"."Statement Ending Balance";
                    BankAccountBalanceasperCashBook := "Statement Ending Balance" + UncreditedBanking;
                    HRemployee.Reset();
                    HRemployee.SetRange(HRemployee."Employee UserID", UserId);
                    if HRemployee.FindFirst() then begin
                        DoneByname := HRemployee."First Name" + ' ' + HRemployee."Middle Name" + ' ' + HRemployee."Last Name";
                    end;




                    Clear(RecAmt);
                    BankAccReconLine.Reset;
                    BankAccReconLine.SetRange(BankAccReconLine."Bank Account No.", "Bank Account No.");
                    BankAccReconLine.SetRange(BankAccReconLine."Statement No.", "Statement No.");
                    if BankAccReconLine.Find('-') then begin
                        repeat
                            if BankAccReconLine."Applied Entries" = '1' then
                                RecAmt := RecAmt + BankAccReconLine."Applied Amount"
                        until BankAccReconLine.Next = 0;
                    end;

                    BankDiff := 0;
                    BankDiff := ("Statement Ending Balance" - "Balance Last Statement");

                    if BankDiff = RecAmt then
                        ReconciliationStatement := 'The bank reconciliation is complete!'
                    else
                        ReconciliationStatement := ' The reconciliation is incomplete! The net change between statement ending balance and balance last statement does not equal the reconciled amounts';
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);

                ReconciliationStatement := 'Reconciliation is incomplete please go through it again';

                HRemployee.CalcFields(Signature);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Bank: Record "Bank Account";
        BankCode: Code[20];
        BankAccountNo: Code[20];
        BankName: Text;
        DoneByname: Text;
        HRemployee: Record "HR Employees";
        ApprovalEntry: Record "Approval Entry";
        BankAccountBalanceasperCashBook: Decimal;
        UnpresentedChequesTotal: Decimal;
        UncreditedBanking: Decimal;
        BankStatementLine: Record "Bank Acc. Reconciliation Line";
        BankStatementLine1: Record "Bank Account Ledger Entry";
        CompanyInfo: Record "Company Information";
        CompanyInformation: Record "Company Information";
        ReconciliationStatement: Text;
        TotalDifference: Decimal;
        BankRecPresented: Record "Bank Acc. Reconciliation Line";
        BankRecUnPresented: Record "Bank Acc. Reconciliation Line";
        BankStatBalance: Decimal;
        RecAmt: Decimal;
        BankDiff: Decimal;
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";

    procedure TotalDiffFunc()
    begin
        BankRecPresented.Reset;
        BankRecPresented.SetRange(BankRecPresented."Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
        BankRecPresented.SetRange(BankRecPresented."Statement No.", "Bank Acc. Reconciliation"."Statement No.");
        //BankRecPresented.SETRANGE(BankRecPresented.Reconciled,TRUE);
        if BankRecPresented.Find('-') then begin
            repeat
                TotalDifference := TotalDifference + BankRecPresented.Difference;
            //MESSAGE('%1',TotalDifference);
            until BankRecPresented.Next = 0;
        end;
    end;
}

