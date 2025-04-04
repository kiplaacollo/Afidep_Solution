report 80072 "Posted Bank Re Report"
{
    // version Payment ProcessesV1.0(Surestep Systems)

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/PostedbankRec.rdlc';
    Caption = 'Posted Bank Rec Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            RequestFilterFields = "Statement No.";
            column(BankCode; BankCode)
            {
            }
            column(BankAccountNo_BankAccReconciliation; "Bank Account Statement"."Bank Account No.")
            {
            }
            column(StatementNo_BankAccReconciliation; "Bank Account Statement"."Statement No.")
            {
            }
            column(StatementDate_BankAccReconciliation; "Bank Account Statement"."Statement Date")
            {
            }
            column(TotalBalanceonBankAccount_BankAccReconciliation; "Bank Account Statement"."Balance Last Statement")
            {
            }
            column(TotalAppliedAmount_BankAccReconciliation; "Bank Account Statement"."Balance Last Statement")
            {
            }
            column(TotalTransactionAmount_BankAccReconciliation; "Bank Account Statement"."Statement Ending Balance")
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(StatementEndingBalance_BankAccReconciliation; "Bank Account Statement"."Statement Ending Balance")
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
            column(RequesterName; RequesterName) { }
            column(RequesterDate; RequesterDate) { }
            column(Requester_Signature; "Requester Signature") { }
            column(Approver1Name; Approver1Name) { }
            column(Approver1Date; Approver1Date) { }
            column(Approver1Signature; Approver1Signature) { }
            column(Approver2Name; Approver2Name) { }
            column(Approver2Date; Approver2Date) { }
            column(Approver2Signature; Approver2Signature) { }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE("Applied Entries" = CONST(0), "Statement Amount" = FILTER(< 0));
                column(CheckNo_BankAccReconciliationLine; "Bank Account Statement Line"."Check No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine; "Bank Account Statement Line"."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine; "Bank Account Statement Line"."Transaction Date")
                {
                }
                column(StatementLineNo_BankAccReconciliationLine; "Bank Account Statement Line"."Statement Line No.")
                {
                }
                column(Description_BankAccReconciliationLine; "Bank Account Statement Line".Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine; "Bank Account Statement Line"."Statement Amount")
                {
                }
                // column(OpenType_BankAccReconciliationLine;"Bank Account Statement Line"."Open Type")
                // {
                // }
            }
            dataitem("<Bank Account Statement Ln1>"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE("Applied Entries" = CONST(0), "Statement Amount" = FILTER(> 0));
                column(CheckNo_BankAccReconciliationLine1; "<Bank Account Statement Ln1>"."Check No.")
                {
                }
                column(StatementLineNo_BankAccReconciliationLn1; "<Bank Account Statement Ln1>"."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine1; "<Bank Account Statement Ln1>"."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine1; "<Bank Account Statement Ln1>"."Transaction Date")
                {
                }
                column(Description_BankAccReconciliationLine1; "<Bank Account Statement Ln1>".Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine1; "<Bank Account Statement Ln1>"."Statement Amount")
                {
                }
                // column(OpenType_BankAccReconciliationLine1;"<Bank Account Statement Ln1>"."Open Type")
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
                HRemployee.SetRange(HRemployee."Employee UserID", UserId);
                if HRemployee.FindFirst() then begin
                    DoneByname := HRemployee."First Name" + ' ' + HRemployee."Middle Name" + ' ' + HRemployee."Last Name";
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

                    BankStatBalance := "Bank Account Statement"."Statement Ending Balance";
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

                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Document No.", "Bank Account Statement"."Bank Account No.");
                ApprovalEntry.SetRange("Sequence No.", 1);
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst then begin
                    HREmployee.Reset;
                    HREmployee.SetRange(HREmployee."Employee UserID", ApprovalEntry."Approver ID");
                    if HREmployee.FindFirst then begin
                        HREmployee.CALCFIELDS(Signature);
                        "Bank Account Statement".Approver1Signature := HREmployee.Signature;
                        "Bank Account Statement".Approver1Name := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                        "Bank Account Statement".Approver1Date := ApprovalEntry."Last Date-Time Modified";
                    end;
                end;

                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Document No.", "Bank Account Statement"."Bank Account No.");
                ApprovalEntry.SetRange("Sequence No.", 2);
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst then begin
                    HREmployee.Reset;
                    HREmployee.SetRange(HREmployee."Employee UserID", ApprovalEntry."Approver ID");
                    if HREmployee.FindFirst then begin
                        HREmployee.CALCFIELDS(Signature);
                        "Bank Account Statement".Approver2Signature := HREmployee.Signature;
                        "Bank Account Statement".Approver2Name := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                        "Bank Account Statement".Approver2Date := ApprovalEntry."Last Date-Time Modified";
                    end;
                end;

                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Document No.", "Bank Account Statement"."Bank Account No.");
                // ApprovalEntry.SetRange("Sequence No.", 1);
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst then begin
                    HREmployee.Reset;
                    HREmployee.SetRange(HREmployee."Employee UserID", ApprovalEntry."Sender ID");
                    if HREmployee.FindFirst then begin
                        HREmployee.CALCFIELDS(Signature);
                        "Bank Account Statement"."Requester Signature" := HREmployee.Signature;
                        "Bank Account Statement".RequesterName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                        "Bank Account Statement".RequesterDate := DT2Date(ApprovalEntry."Date-Time Sent for Approval");
                    end;
                end;

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);

                //  HREmployees.Get();
                HREmployee.CalcFields(Signature);

                ReconciliationStatement := 'Reconciliation is incomplete please go through it again';
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
        BankAccountBalanceasperCashBook: Decimal;
        UnpresentedChequesTotal: Decimal;
        UncreditedBanking: Decimal;
        BankStatementLine: Record "Bank Account Statement Line";
        BankStatementLine1: Record "Bank Account Ledger Entry";
        CompanyInfo: Record "Company Information";
        CompanyInformation: Record "Company Information";
        ReconciliationStatement: Text;
        TotalDifference: Decimal;
        BankRecPresented: Record "Bank Account Statement Line";
        BankRecUnPresented: Record "Bank Account Statement Line";
        BankStatBalance: Decimal;
        RecAmt: Decimal;
        BankDiff: Decimal;
        BankAccReconLine: Record "Bank Account Statement Line";
        ApprovalEntry: Record "Approval Entry";

    procedure TotalDiffFunc()
    begin
        BankRecPresented.Reset;
        BankRecPresented.SetRange(BankRecPresented."Bank Account No.", "Bank Account Statement"."Bank Account No.");
        BankRecPresented.SetRange(BankRecPresented."Statement No.", "Bank Account Statement"."Statement No.");
        //BankRecPresented.SETRANGE(BankRecPresented.Reconciled,TRUE);
        if BankRecPresented.Find('-') then begin
            repeat
                TotalDifference := TotalDifference + BankRecPresented.Difference;
            //MESSAGE('%1',TotalDifference);
            until BankRecPresented.Next = 0;
        end;
    end;
}

