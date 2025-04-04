Report 80017 "Payroll Journal Transfer"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payroll Employee_AU"; "Payroll Employee_AU")
        {
            RequestFilterFields = "No.", "Period Filter", "Global Dimension 1";
            column(ReportForNavId_6207; 6207)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // EmployerPension := 0;
                // objEmp.Reset();
                // objEmp.SetRange(objEmp."No.", "Payroll Employee_AU"."No.");
                // if objEmp.Find('-') then begin
                //     strEmpName := '[' + objEmp."No." + '] ' + objEmp.Lastname + ' ' + objEmp.Firstname + ' ' + objEmp.Surname;
                //     GlobalDim1 := objEmp."Global Dimension 1";
                //     GlobalDim2 := objEmp."Global Dimension 2";//objEmp.Office;
                //     EmployerPension := objEmp."Pension %-Employer" / 100 * objEmp."Basic Pay";


                // end;

                LineNumber := LineNumber + 10;


                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."No.", "Payroll Employee_AU"."No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Transaction Name", '<>%1&<>%2&<>%3&<>%4', 'Education Allowance', 'Education Allowance deduction', 'Excess Pension', 'Salary Arrears Excess Pension'); // Corrected syntax
                if PeriodTrans.Find('-') then begin
                    repeat

                        IF PeriodTrans."Account No" <> '' THEN BEGIN
                            AmountToDebit := 0;
                            AmountToCredit := 0;
                            if PeriodTrans."Posting Type" = PeriodTrans."posting type"::Debit then
                                AmountToDebit := PeriodTrans.Amount;

                            if PeriodTrans."Posting Type" = PeriodTrans."posting type"::Credit then
                                AmountToCredit := PeriodTrans.Amount * 1;

                            if PeriodTrans."Account Type" = 1 then
                                IntegerPostAs := 0;
                            if PeriodTrans."Account Type" = 2 then
                                IntegerPostAs := 1;
                            //Negative NPay
                            if (PeriodTrans."Posting Type" = PeriodTrans."posting type"::Credit) and (PeriodTrans.Amount < 0) then begin

                                AmountToDebit := AmountToCredit * -1;
                                AmountToCredit := 0;
                                CreateJnlEntry(IntegerPostAs, PeriodTrans."Account No",
                                GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No.", AmountToDebit, AmountToCredit,
                                PeriodTrans."posting type"::Debit, PeriodTrans."Loan Number", SaccoTransactionType, "Payroll Employee_AU"."No.");
                            end else begin

                                CreateJnlEntry(IntegerPostAs, PeriodTrans."Account No",
                                GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No.", AmountToDebit, AmountToCredit,
                                PeriodTrans."Posting Type", PeriodTrans."Loan Number", SaccoTransactionType, "Payroll Employee_AU"."No.");
                            end;

                            //Pension
                            // if PeriodTrans."Co-Op parameters" = PeriodTrans."co-op parameters"::Pension then begin
                            //     //Get from Employer Deduction
                            //     EmployerDed.Reset;
                            //     EmployerDed.SetRange(EmployerDed."Employee Code", PeriodTrans."No.");
                            //     EmployerDed.SetRange(EmployerDed."Transaction Code", PeriodTrans."Transaction Code");
                            //     EmployerDed.SetRange(EmployerDed."Payroll Period", PeriodTrans."Payroll Period");
                            //     if EmployerDed.Find('-') then begin
                            //         //Credit Payables
                            //         CreateJnlEntry(0, PostingGroup."Pension Employee Acc",
                            //         GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No.", 0,
                            //         EmployerDed.Amount, PeriodTrans."Posting Type", '', SaccoTransactionType, "Payroll Employee_AU"."No.");
                            //     end;
                            //     //Debit Staff Expense
                            //     CreateJnlEntry(0, PostingGroup."Pension Employer Acc",
                            //     GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No.", EmployerDed.Amount, 0, 1, '',
                            //     SaccoTransactionType, "Payroll Employee_AU"."No.");


                            //   end;

                            //NSSF Employer Deduction*****Amos*****
                            //
                            if PeriodTrans."Transaction Code" = 'NSSF' then begin//Pension Contrib

                                PostingGroup.Reset;
                                PostingGroup.SetRange(PostingGroup."Posting Code", "Payroll Employee_AU"."Posting Group");
                                if PostingGroup.Find('-') then begin
                                    PostingGroup.TestField("SSF Employer Account");
                                    PostingGroup.TestField("SSF Employee Account");
                                    PostingGroup.TestField("Pension Employer Acc");
                                    PostingGroup.TestField("Pension Employee Acc");


                                end;

                                CreateJnlEntry(0, PostingGroup."SSF Employee Account",
                                GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No." + '' + 'EmpDed', 0, PeriodTrans.Amount,
                                PeriodTrans."Posting Type", '', SaccoTransactionType, "Payroll Employee_AU"."No.");


                                // Error('Iko');



                                //Debit Staff Expense
                                CreateJnlEntry(0, PostingGroup."SSF Employer Account",
                                GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No." + '' + 'EmpDed', PeriodTrans.Amount, 0, 1, '',
                                SaccoTransactionType, "Payroll Employee_AU"."No.");
                            end;
                            // if PeriodTrans."Transaction Code" = 'Pension Contrib' then begin//Pension Contrib

                            //     PostingGroup.Reset;
                            //     PostingGroup.SetRange(PostingGroup."Posting Code", "Payroll Employee_AU"."Posting Group");
                            //     if PostingGroup.Find('-') then begin
                            //         PostingGroup.TestField("SSF Employer Account");
                            //         PostingGroup.TestField("SSF Employee Account");
                            //         PostingGroup.TestField("Pension Employer Acc");
                            //         PostingGroup.TestField("Pension Employee Acc");


                            //     end;

                            //     CreateJnlEntry(0, PostingGroup."SSF Employee Account",
                            //     GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No." + '' + 'EmpDed', 0, PeriodTrans.Amount,
                            //     PeriodTrans."Posting Type", '', SaccoTransactionType, "Payroll Employee_AU"."No.");

                            //     //Debit Staff Expense
                            //     CreateJnlEntry(0, PostingGroup."Pension Employer Acc",
                            //     GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No." + '' + 'EmpDed', PeriodTrans.Amount, 0, 1, '',
                            //     SaccoTransactionType, "Payroll Employee_AU"."No.");
                            // end;
                            // EmployerPension := 0;
                            // if PeriodTrans."Transaction Code" = 'BPAY' then begin
                            //     objEmp.SetRange(objEmp."No.", "Payroll Employee_AU"."No.");
                            //     if objEmp.Find('-') then begin
                            //         EmployerPension := objEmp."Pension %-Employer" / 100 * PeriodTrans.Amount;
                            //     end;

                            // end;
                            //Message('Recived%1', EmployerPension);
                            //   if EmployerPension > 0 then begin
                            if (PeriodTrans."Transaction Code" = 'BPAY') then begin
                                objEmp.Reset();
                                objEmp.SetRange(objEmp."No.", "Payroll Employee_AU"."No.");
                                // objEmp.SetFilter(objEmp."No.", '<>%1', 'EMP229');
                                if objEmp.Find('-') then begin

                                    EmployerPension := objEmp."Pension %-Employer" / 100 * PeriodTrans.Amount;
                                    //Message('Pension :%1', EmployerPension);

                                end;
                                PostingGroup.Reset;
                                PostingGroup.SetRange(PostingGroup."Posting Code", "Payroll Employee_AU"."Posting Group");
                                if PostingGroup.Find('-') then begin
                                    PostingGroup.TestField("SSF Employer Account");
                                    PostingGroup.TestField("SSF Employee Account");
                                    PostingGroup.TestField("Pension Employer Acc");
                                    PostingGroup.TestField("Pension Employee Acc");
                                    //Message('Recived%1', EmployerPension);

                                    CreateJnlEntry(0, PostingGroup."Pension Employee Acc",
                                    GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No." + '' + 'EmpDed', 0, round(EmployerPension, 1, '='),
                                    2, '', SaccoTransactionType, "Payroll Employee_AU"."No.");

                                    //Debit Staff Expense
                                    CreateJnlEntry(0, PostingGroup."Pension Employer Acc",
                                    GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No." + '' + 'EmpDed', round(EmployerPension, 1, '='), 0, 1, '',
                                    SaccoTransactionType, "Payroll Employee_AU"."No.");


                                end;
                            end;
                            if (PeriodTrans."Transaction Code" = 'E004') then begin
                                objEmp.Reset();
                                objEmp.SetRange(objEmp."No.", "Payroll Employee_AU"."No.");
                                if objEmp.Find('-') then begin

                                    EmployerPension1 := objEmp."Pension %-Employer" / 100 * PeriodTrans.Amount;
                                    //  Message('Pension :%1', EmployerPension);

                                end;
                                PostingGroup.Reset;
                                PostingGroup.SetRange(PostingGroup."Posting Code", "Payroll Employee_AU"."Posting Group");
                                if PostingGroup.Find('-') then begin
                                    PostingGroup.TestField("SSF Employer Account");
                                    PostingGroup.TestField("SSF Employee Account");
                                    PostingGroup.TestField("Pension Employer Acc");
                                    PostingGroup.TestField("Pension Employee Acc");
                                    //Message('Recived%1', EmployerPension);

                                    CreateJnlEntry(0, PostingGroup."Pension Employee Acc",
                                    GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No." + '' + 'EmpDed', 0, round(EmployerPension1, 1, '='),
                                    2, '', SaccoTransactionType, "Payroll Employee_AU"."No.");

                                    //Debit Staff Expense
                                    CreateJnlEntry(0, PostingGroup."Pension Employer Acc",
                                    GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No." + '' + 'EmpDed', round(EmployerPension1, 1, '='), 0, 1, '',
                                    SaccoTransactionType, "Payroll Employee_AU"."No.");


                                end;
                            end;
                        end;
                        if PeriodTrans."Transaction Code" = 'HL' then begin
                            PostingGroup.Reset;
                            PostingGroup.SetRange(PostingGroup."Posting Code", "Payroll Employee_AU"."Posting Group");
                            if PostingGroup.Find('-') then begin

                                PostingGroup.TestField("Housing Employee");
                                PostingGroup.TestField("Housing Employer");

                            end;
                            //

                            CreateJnlEntry(0, PostingGroup."Housing Employee",
                             GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No." + '' + 'EmpDed', 0, Round(PeriodTrans.Amount, 1, '='),
                             2, '', SaccoTransactionType, "Payroll Employee_AU"."No.");

                            //Debit Staff Expense
                            CreateJnlEntry(0, PostingGroup."Housing Employer",
                            GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No." + '' + 'EmpDed', Round(PeriodTrans.Amount, 1, '='), 0, 1, '',
                            SaccoTransactionType, "Payroll Employee_AU"."No.");
                        end;

                        if PeriodTrans."Transaction Code" = 'SHIF' then begin
                            PostingGroup.Reset;
                            PostingGroup.SetRange(PostingGroup."Posting Code", "Payroll Employee_AU"."Posting Group");
                            if PostingGroup.Find('-') then begin

                                PostingGroup.TestField("SHIF Employee");
                                PostingGroup.TestField("SHIF Employer");

                            end;
                            //

                            CreateJnlEntry(0, PostingGroup."SHIF Employee",
                             GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No." + '' + 'EmpDed', 0, Round(PeriodTrans.Amount, 1, '='),
                             2, '', SaccoTransactionType, "Payroll Employee_AU"."No.");

                            //Debit Staff Expense
                            CreateJnlEntry(0, PostingGroup."SHIF Employer",
                            GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No." + '' + 'EmpDed', Round(PeriodTrans.Amount, 1, '='), 0, 1, '',
                            SaccoTransactionType, "Payroll Employee_AU"."No.");
                        end;
                        //Pension Employer Deduction*****Amos*****


                        //K.U Pension Employer Deduction*****Amos*****
                        if PeriodTrans."Transaction Code" = 'PENSION BENEFIT  bb' then begin
                            //Credit Payables
                            //Credit Payables
                            CreateJnlEntry(0, PostingGroup."Pension Employee Acc",
                            GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No." + '' + 'EmpDed', 0, PeriodTrans.Amount * 2,
                            PeriodTrans."Posting Type", '', SaccoTransactionType, "Payroll Employee_AU"."No.");

                            //Debit Staff Expense
                            CreateJnlEntry(0, PostingGroup."Pension Employer Acc",
                            GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."No." + '' + 'EmpDed', PeriodTrans.Amount * 2, 0, 1, '',
                            SaccoTransactionType, "Payroll Employee_AU"."No.");
                            //END;
                            //Pension
                            //
                        end;
                    // end;
                    until PeriodTrans.Next = 0;
                end;
                // BAL2 := 0;
                // GeneraljnlLine.RESET;
                // GeneraljnlLine.SetRange(GeneraljnlLine."Journal Template Name", 'GENERAL');
                // GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'SALARIES');
                // IF GeneraljnlLine.FINDSET THEN BEGIN
                //     REPEAT
                //         BAL2 := BAL2 + GeneraljnlLine."Amount (LCY)";
                //     UNTIL GeneraljnlLine.NEXT = 0;
                // END;

                BAL := 0;
                GeneraljnlLine.RESET;
                GeneraljnlLine.SetRange(GeneraljnlLine."Journal Template Name", 'GENERAL');
                GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'SALARIES');
                IF GeneraljnlLine.FINDSET THEN BEGIN
                    REPEAT
                        BAL := BAL + GeneraljnlLine."Amount (LCY)";
                    UNTIL GeneraljnlLine.NEXT = 0;
                END;
                ///Message('ba%1', BAL);


                IF (BAL < 0) AND (BAL > -1) THEN BEGIN
                    GeneraljnlLine.RESET;
                    GeneraljnlLine.SetRange(GeneraljnlLine."Journal Template Name", 'GENERAL');
                    GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'SALARIES');
                    GeneraljnlLine.SETFILTER("Amount (LCY)", '<%1', 0);
                    IF GeneraljnlLine.FINDFIRST THEN BEGIN
                        GeneraljnlLine.VALIDATE("Amount (LCY)", GeneraljnlLine."Amount (LCY)" + ABS(BAL));
                        GeneraljnlLine.MODIFY(TRUE);
                    END;
                END;

                IF (BAL > 0) AND (BAL < 1) THEN BEGIN
                    GeneraljnlLine.RESET;
                    GeneraljnlLine.SetRange(GeneraljnlLine."Journal Template Name", 'GENERAL');
                    GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'SALARIES');
                    GeneraljnlLine.SETFILTER("Amount (LCY)", '<%1', 0);
                    IF GeneraljnlLine.FINDFIRST THEN BEGIN
                        GeneraljnlLine.VALIDATE("Amount (LCY)", GeneraljnlLine."Amount (LCY)" - BAL);
                        GeneraljnlLine.MODIFY(TRUE);
                    END;
                END;
                COMMIT;


                // IF (BAL2 < 0) AND (BAL2 > -1) THEN BEGIN
                //     GeneraljnlLine.RESET;
                //     GeneraljnlLine.SetRange(GeneraljnlLine."Journal Template Name", 'GENERAL');
                //     GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'SALARIES');
                //     GeneraljnlLine.SETFILTER("Amount (LCY)", '<%1', 0);
                //     IF GeneraljnlLine.FINDFIRST THEN BEGIN
                //         GeneraljnlLine.VALIDATE("Amount (LCY)", GeneraljnlLine."Amount (LCY)" + ABS(BAL));
                //         GeneraljnlLine.MODIFY(TRUE);
                //     END;
                // END;

                // IF (BAL2 > 0) AND (BAL2 < 1) THEN BEGIN
                //     GeneraljnlLine.RESET;
                //     GeneraljnlLine.SetRange(GeneraljnlLine."Journal Template Name", 'GENERAL');
                //     GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'SALARIES');
                //     GeneraljnlLine.SETFILTER("Amount (LCY)", '<%1', 0);
                //     IF GeneraljnlLine.FINDFIRST THEN BEGIN
                //         GeneraljnlLine.VALIDATE("Amount (LCY)", GeneraljnlLine."Amount (LCY)" - BAL);
                //         GeneraljnlLine.MODIFY(TRUE);
                //     END;
                // END;
                // COMMIT;


            end;

            trigger OnPostDataItem()
            begin
                Message('Journals Created Successfully');
            end;

            trigger OnPreDataItem()
            begin
                //  "Payroll Employee_AU".SetRange("Payroll Employee_AU".Status, "Payroll Employee_AU".Status::Active);
                LineNumber := 10000;

                //Create batch*****************************************************************************
                GenJnlBatch.Reset;
                GenJnlBatch.SetRange(GenJnlBatch."Journal Template Name", 'GENERAL');
                GenJnlBatch.SetRange(GenJnlBatch.Name, 'SALARIES');
                if GenJnlBatch.Find('-') = false then begin
                    GenJnlBatch.Init;
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'SALARIES';
                    GenJnlBatch.Insert;
                end;
                // End Create Batch

                // Clear the journal Line
                GeneraljnlLine.Reset;
                GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'SALARIES');
                if GeneraljnlLine.Find('-') then
                    GeneraljnlLine.DeleteAll;

                objPeriod.Reset();
                objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
                if objPeriod.Find('-') then begin
                    "Slip/Receipt No" := UpperCase(objPeriod."Period Name");
                    Currenc := Round(objPeriod."Currency Code", 0.01, '=');
                end;

                PostingGroup.Reset;
                PostingGroup.SetRange(PostingGroup."Posting Code", "Payroll Employee_AU"."Posting Group");
                if PostingGroup.Find('-') then begin
                    PostingGroup.TestField("SSF Employer Account");
                    PostingGroup.TestField("SSF Employee Account");
                    PostingGroup.TestField("Pension Employer Acc");
                    PostingGroup.TestField("Pension Employee Acc");

                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(PeriodDate; PeriodDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period Date';
                    TableRelation = "Payroll Calender_AU"."Date Opened";
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

    trigger OnPreReport()
    begin
        /*
        PeriodFilter:=PeriodDate;//"prSalary Card".GETFILTER("Period Filter");
        IF PeriodFilter='' THEN ERROR('You must specify the period filter');
                     */

        if PeriodDate = 0D then Error('You must specify the period filter');
        SelectedPeriod := PeriodDate;//"prSalary Card".GETRANGEMIN("Period Filter");
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";

        PostingDate := CALCDATE('1M-1D', SelectedPeriod);
        PostingDate := CalcDate('CM', SelectedPeriod);

    end;

    var
        PeriodTrans: Record "Payroll Monthly Trans_AU";
        objEmp: Record "Payroll Employee_AU";
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        EmployerPension: Decimal;
        EmployerPension1: Decimal;
        BAL2: Decimal;
        SelectedPeriod: Date;
        objPeriod: Record "Payroll Calender_AU";
        strEmpName: Text[150];
        BAL: Decimal;
        GeneraljnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        "Slip/Receipt No": Code[50];
        Currenc: Decimal;
        LineNumber: Integer;
        "Salary Card": Record "Payroll Employee_AU";
        TaxableAmount: Decimal;
        PostingGroup: Record "Payroll Posting Groups_AU";
        GlobalDim1: Code[10];
        GlobalDim2: Code[10];
        TransCode: Record "Payroll Transaction Code_AU";
        PostingDate: Date;
        AmountToDebit: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        AmountToCredit: Decimal;
        IntegerPostAs: Integer;
        SaccoTransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2";
        EmployerDed: Record "Payroll Employer Deductions_AU";
        PeriodDate: Date;
        GLS: Record "General Ledger Setup";
        GLAC: Code[30];
        PayrollProjectAllocation: Record "Payroll Project Allocation";
        RoundingAmount: Decimal;
        TotalDebit: Decimal;
        TotalCredit: Decimal;
        RoundingAccount: Code[20];

    // procedure CreateJnlEntry(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[50]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2"; "Employee Code": Code[100])
    // var
    //     TotalDebit: Decimal;
    //     TotalCredit: Decimal;
    //     RoundingAmount: Decimal;
    //     RoundingAccount: Code[20];
    // begin
    //     TotalDebit := 0;
    //     TotalCredit := 0;

    //     PayrollProjectAllocation.RESET;
    //     PayrollProjectAllocation.SETRANGE("Employee No", "Payroll Employee_AU"."No.");
    //     PayrollProjectAllocation.SETRANGE(Period, PeriodDate);
    //     IF PayrollProjectAllocation.FINDSET THEN BEGIN
    //         REPEAT
    //             LineNumber := LineNumber + 100;
    //             GeneraljnlLine.Init;
    //             GeneraljnlLine."Journal Template Name" := 'GENERAL';
    //             GeneraljnlLine."Journal Batch Name" := 'SALARIES';
    //             GeneraljnlLine."Line No." := LineNumber;
    //             GeneraljnlLine."Document No." := "Slip/Receipt No";
    //             GeneraljnlLine."Posting Date" := PostingDate;
    //             GeneraljnlLine."Account Type" := AccountType;
    //             GeneraljnlLine."Account No." := AccountNo;
    //             GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
    //             GeneraljnlLine."Currency Code" := "Payroll Employee_AU"."Currency Code";
    //             GeneraljnlLine."Currency Factor" := Currenc;
    //             GeneraljnlLine.Description := "Slip/Receipt No";

    //             if PostAs = PostAs::Debit then begin
    //                 GeneraljnlLine.Amount := Round(DebitAmount * (PayrollProjectAllocation.Allocation / 100), 0.00001);
    //                 GeneraljnlLine."Debit Amount" := GeneraljnlLine.Amount;
    //                 TotalDebit += GeneraljnlLine.Amount;
    //             end else begin
    //                 GeneraljnlLine.Amount := -1 * Round(CreditAmount * (PayrollProjectAllocation.Allocation / 100), 0.00001);
    //                 GeneraljnlLine."Credit Amount" := Abs(GeneraljnlLine.Amount);
    //                 TotalCredit += Abs(GeneraljnlLine.Amount);
    //             end;

    //             GeneraljnlLine."Shortcut Dimension 1 Code" := GlobalDime1;
    //             GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 1 Code");
    //             GeneraljnlLine."Shortcut Dimension 2 Code" := PayrollProjectAllocation."Project Code";
    //             GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 2 Code");

    //             GeneraljnlLine.Validate(GeneraljnlLine.Amount);
    //             if GeneraljnlLine.Amount <> 0 then
    //                 GeneraljnlLine.Insert;

    //         UNTIL PayrollProjectAllocation.Next() = 0;

    //         // Calculate Rounding Difference
    //         RoundingAmount := TotalDebit - TotalCredit;
    //         if Abs(RoundingAmount) > 0.00001 then begin
    //             // Insert Rounding Adjustment Line
    //             RoundingAccount := '3620'; // Replace with actual rounding account
    //             LineNumber := LineNumber + 100;
    //             GeneraljnlLine.Init;
    //             GeneraljnlLine."Journal Template Name" := 'GENERAL';
    //             GeneraljnlLine."Journal Batch Name" := 'SALARIES';
    //             GeneraljnlLine."Line No." := LineNumber;
    //             GeneraljnlLine."Document No." := "Slip/Receipt No";
    //             GeneraljnlLine."Posting Date" := PostingDate;
    //             GeneraljnlLine."Account Type" := GeneraljnlLine."Account Type"::"G/L Account";
    //             GeneraljnlLine."Account No." := RoundingAccount;
    //             GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
    //             GeneraljnlLine.Description := 'Rounding Adjustment';
    //             GeneraljnlLine.Amount := -RoundingAmount;

    //             GeneraljnlLine."Shortcut Dimension 1 Code" := GlobalDime1;
    //             GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 1 Code");
    //             GeneraljnlLine."Shortcut Dimension 2 Code" := GlobalDime2;
    //             GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 2 Code");

    //             GeneraljnlLine.Validate(GeneraljnlLine.Amount);
    //             GeneraljnlLine.Insert();
    //         end;
    //     end;
    // end;


    procedure CreateJnlEntry(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[50]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2"; "Employee Code": Code[100])
    begin
        PayrollProjectAllocation.RESET;
        PayrollProjectAllocation.SETRANGE("Employee No", "Payroll Employee_AU"."No.");
        PayrollProjectAllocation.SETRANGE(Period, PeriodDate);
        IF PayrollProjectAllocation.FINDSET THEN BEGIN
            REPEAT

                LineNumber := LineNumber + 100;
                GeneraljnlLine.Init;
                GeneraljnlLine."Journal Template Name" := 'GENERAL';
                GeneraljnlLine."Journal Batch Name" := 'SALARIES';
                GeneraljnlLine."Line No." := LineNumber;
                GeneraljnlLine."Document No." := "Slip/Receipt No";
                GeneraljnlLine."Posting Date" := PostingDate;
                // GeneraljnlLine."Posting Date":=TODAY;
                GeneraljnlLine."Account Type" := AccountType;
                GeneraljnlLine."Account No." := AccountNo;
                GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
                GeneraljnlLine."Currency Code" := "Payroll Employee_AU"."Currency Code";
                GeneraljnlLine."Currency Factor" := Currenc;
                GeneraljnlLine.Description := "Employee Code" + ' ' + "Slip/Receipt No";
                if PostAs = Postas::Debit then begin

                    GeneraljnlLine.Amount := Round(DebitAmount * (Round(PayrollProjectAllocation.Allocation, 0.01) / 100), 0.01);
                    GeneraljnlLine."Debit Amount" := DebitAmount * (Round(PayrollProjectAllocation.Allocation, 0.01) / 100);
                    //  GeneraljnlLine."Amount (LCY)" := Round((CurrExchRate.ExchangeAmtFCYToLCY(SelectedPeriod, "Payroll Employee_AU"."Currency Code", GeneraljnlLine.Amount, GeneraljnlLine."Currency Factor")), 0.01);

                end else begin
                    GeneraljnlLine.Amount := -1 * Round((CreditAmount * (Round(PayrollProjectAllocation.Allocation, 0.01) / 100)), 0.01);
                    GeneraljnlLine."Credit Amount" := (CreditAmount * (Round(PayrollProjectAllocation.Allocation, 0.01) / 100));
                    // GeneraljnlLine."Amount (LCY)" := Round((CurrExchRate.ExchangeAmtFCYToLCY(SelectedPeriod, "Payroll Employee_AU"."Currency Code", GeneraljnlLine.Amount, GeneraljnlLine."Currency Factor")), 0.01);


                end;

                GeneraljnlLine."Shortcut Dimension 1 Code" := 'KENYA';

                GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 1 Code");


                GeneraljnlLine."Shortcut Dimension 2 Code" := PayrollProjectAllocation."Project Code";

                GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 2 Code");

                // GeneraljnlLine.ValidateShortcutDimCode(3, PayrollProjectAllocation."Donor Code");

                // GeneraljnlLine.ValidateShortcutDimCode(4, PayrollProjectAllocation."Programme Code");

                // GeneraljnlLine.ValidateShortcutDimCode(5, PayrollProjectAllocation."Employee No");

                // GeneraljnlLine.Country := PayrollProjectAllocation."Country Code";

                GeneraljnlLine.Validate(GeneraljnlLine.Amount);
                if GeneraljnlLine.Amount <> 0 then
                    GeneraljnlLine.Insert;




            until PayrollProjectAllocation.Next() = 0;
        end;

    end;

    trigger OnPostReport()
    begin
        // BAL := 0;
        // GeneraljnlLine.RESET;
        // GeneraljnlLine.SetRange(GeneraljnlLine."Journal Template Name", 'GENERAL');
        // GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'SALARIES');
        // IF GeneraljnlLine.FINDSET THEN BEGIN
        //     REPEAT
        //         BAL := BAL + GeneraljnlLine."Amount (LCY)";
        //     UNTIL GeneraljnlLine.NEXT = 0;
        // END;



        // IF (BAL < 0) AND (BAL > -1) THEN BEGIN
        //     GeneraljnlLine.RESET;
        //     GeneraljnlLine.SetRange(GeneraljnlLine."Journal Template Name", 'GENERAL');
        //     GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'SALARIES');
        //     GeneraljnlLine.SETFILTER("Amount (LCY)", '<%1', 0);
        //     IF GeneraljnlLine.FINDFIRST THEN BEGIN
        //         GeneraljnlLine.VALIDATE("Amount (LCY)", GeneraljnlLine."Amount (LCY)" + ABS(BAL));
        //         GeneraljnlLine.MODIFY(TRUE);
        //     END;
        // END;

        // IF (BAL > 0) AND (BAL < 1) THEN BEGIN
        //     GeneraljnlLine.RESET;
        //     GeneraljnlLine.SetRange(GeneraljnlLine."Journal Template Name", 'GENERAL');
        //     GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'SALARIES');
        //     GeneraljnlLine.SETFILTER("Amount (LCY)", '<%1', 0);
        //     IF GeneraljnlLine.FINDFIRST THEN BEGIN
        //         GeneraljnlLine.VALIDATE("Amount (LCY)", GeneraljnlLine."Amount (LCY)" - BAL);
        //         GeneraljnlLine.MODIFY(TRUE);
        //     END;
        // END;
        // COMMIT;

    end;
}

