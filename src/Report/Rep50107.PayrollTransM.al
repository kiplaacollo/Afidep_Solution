Report 50107 "Payroll Journal TransM"
{
    ProcessingOnly = true;
    Caption = 'Payroll Journal Transfer Malawi';

    dataset
    {
        dataitem("Payroll Employee_AU"; "Payroll Employee_AU")
        {
            RequestFilterFields = "Global Dimension 1", "No.", "Period Filter";
            column(ReportForNavId_6207; 6207)
            {
            }

            trigger OnAfterGetRecord()
            begin
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
                // GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'MALAWI SALARIES');
                // IF GeneraljnlLine.FINDSET THEN BEGIN
                //     REPEAT
                //         BAL2 := BAL2 + GeneraljnlLine."Amount (LCY)";
                //     UNTIL GeneraljnlLine.NEXT = 0;
                // END;

                BAL := 0;
                GeneraljnlLine.RESET;
                GeneraljnlLine.SetRange(GeneraljnlLine."Journal Template Name", 'GENERAL');
                GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'MALAWI SALARIES');
                IF GeneraljnlLine.FINDSET THEN BEGIN
                    REPEAT
                        BAL := BAL + GeneraljnlLine."Amount (LCY)";
                    UNTIL GeneraljnlLine.NEXT = 0;
                END;
                ///Message('ba%1', BAL);


                IF (BAL < 0) AND (BAL > -1) THEN BEGIN
                    GeneraljnlLine.RESET;
                    GeneraljnlLine.SetRange(GeneraljnlLine."Journal Template Name", 'GENERAL');
                    GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'MALAWI SALARIES');
                    GeneraljnlLine.SETFILTER("Amount (LCY)", '<%1', 0);
                    IF GeneraljnlLine.FINDFIRST THEN BEGIN
                        GeneraljnlLine.VALIDATE("Amount (LCY)", GeneraljnlLine."Amount (LCY)" + ABS(BAL));
                        GeneraljnlLine.MODIFY(TRUE);
                    END;
                END;

                IF (BAL > 0) AND (BAL < 1) THEN BEGIN
                    GeneraljnlLine.RESET;
                    GeneraljnlLine.SetRange(GeneraljnlLine."Journal Template Name", 'GENERAL');
                    GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'MALAWI SALARIES');
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
                //     GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'MALAWI SALARIES');
                //     GeneraljnlLine.SETFILTER("Amount (LCY)", '<%1', 0);
                //     IF GeneraljnlLine.FINDFIRST THEN BEGIN
                //         GeneraljnlLine.VALIDATE("Amount (LCY)", GeneraljnlLine."Amount (LCY)" + ABS(BAL));
                //         GeneraljnlLine.MODIFY(TRUE);
                //     END;
                // END;

                // IF (BAL2 > 0) AND (BAL2 < 1) THEN BEGIN
                //     GeneraljnlLine.RESET;
                //     GeneraljnlLine.SetRange(GeneraljnlLine."Journal Template Name", 'GENERAL');
                //     GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'MALAWI SALARIES');
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
                GenJnlBatch.SetRange(GenJnlBatch.Name, 'MALAWI SALARIES');
                if GenJnlBatch.Find('-') = false then begin
                    GenJnlBatch.Init;
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'MALAWI SALARIES';
                    GenJnlBatch.Insert;
                end;
                // End Create Batch

                // Clear the journal Line
                GeneraljnlLine.Reset;
                GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'MALAWI SALARIES');
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

        //PostingDate:=CALCDATE('1M-1D',SelectedPeriod);
        PostingDate := CalcDate('CM', SelectedPeriod);

    end;

    trigger OnPostReport()
    begin

    end;

    var
        PeriodTrans: Record "Payroll Monthly Trans_Malawi";
        objEmp: Record "Payroll Employee_AU";
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        SelectedPeriod: Date;
        objPeriod: Record "Payroll CalenderMalawi";
        strEmpName: Text[150];
        GeneraljnlLine: Record "Gen.Journl Copy";
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
        AmountToCredit: Decimal;
        Amt: Decimal;
        IntegerPostAs: Integer;
        SaccoTransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2";
        EmployerDed: Record "Payroll Employer Deductions_AU";
        PeriodDate: Date;
        GLS: Record "General Ledger Setup";
        GLAC: Code[30];
        GeneraljnlLine2: Record "Gen.Journl Copy";
        PayrollProjectAllocation: Record "Payroll Project Allocation";
        RealGeneraljnlLine: Record "Gen. Journal Line";
        GLAccount: Record 15;
        EmployerPension1: Decimal;
        BAL2: Decimal;
        EmployerPension: Decimal;
        BAL: Decimal;


    procedure CreateJnlEntry(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[50]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2"; "Employee Code": Code[100])
    begin
        PayrollProjectAllocation.RESET;
        PayrollProjectAllocation.SETRANGE("Employee No", "Employee Code");
        PayrollProjectAllocation.SETRANGE(Period, PeriodDate);
        IF PayrollProjectAllocation.FINDSET THEN BEGIN
            REPEAT
                LineNumber := LineNumber + 100;
                GeneraljnlLine.Init;
                GeneraljnlLine."Journal Template Name" := 'GENERAL';
                GeneraljnlLine."Journal Batch Name" := 'MALAWI SALARIES';
                GeneraljnlLine."Line No." := LineNumber;
                GeneraljnlLine."Document No." := "Slip/Receipt No";
                GeneraljnlLine."Posting Date" := PostingDate;
                GeneraljnlLine."Account Type" := AccountType;
                GeneraljnlLine."Account No." := AccountNo;
                GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
                GeneraljnlLine.Description := Description;
                // Calculate the allocation percentage amount
                IF DebitAmount <> 0 THEN BEGIN
                    // Calculate Debit Amount based on project allocation percentage
                    GeneraljnlLine."Debit Amount" := ROUND(DebitAmount * (PayrollProjectAllocation.Allocation / 100), 0.00001);
                    //  GeneraljnlLine.Validate(GeneraljnlLine."Debit Amount");
                    GeneraljnlLine.Amount := GeneraljnlLine."Debit Amount"; // Set the calculated amount
                    GeneraljnlLine.Validate(GeneraljnlLine.Amount);
                END ELSE
                    IF CreditAmount <> 0 THEN BEGIN
                        // Calculate Credit Amount based on project allocation percentage
                        GeneraljnlLine."Credit Amount" := ROUND(CreditAmount * (PayrollProjectAllocation.Allocation / 100), 0.00001);
                        // GeneraljnlLine.Validate(GeneraljnlLine."Credit Amount");
                        GeneraljnlLine.Amount := -GeneraljnlLine."Credit Amount"; // Set the calculated amount
                        GeneraljnlLine.Validate(GeneraljnlLine.Amount);
                    END;

                GeneraljnlLine."Shortcut Dimension 1 Code" := GlobalDime1;
                GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 1 Code");

                //  GeneraljnlLine."Shortcut Dimension 1 Code":=PayrollProjectAllocation."Project Code";
                //  GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 1 Code");

                GeneraljnlLine."Shortcut Dimension 2 Code" := PayrollProjectAllocation."Project Code";
                GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 2 Code");

                GeneraljnlLine."Amount (LCY)" := GeneraljnlLine.Amount / Currenc;
                // GeneraljnlLine.Validate(GeneraljnlLine."Amount (LCY)");

                GeneraljnlLine.Amount := GeneraljnlLine.Amount;
                //  GeneraljnlLine.Validate(GeneraljnlLine.Amount);

                IF (GeneraljnlLine.Amount <> 0) and (GeneraljnlLine."Account No." <> '') THEN
                    GeneraljnlLine.INSERT;
                Commit();
            UNTIL PayrollProjectAllocation.NEXT = 0;
        END;

        // if GeneraljnlLine.Amount <> 0 then
        //     GeneraljnlLine.Insert;
    end;

    procedure CreateRealJournal()
    begin

        RealGeneraljnlLine.RESET;
        RealGeneraljnlLine.SETRANGE("Journal Template Name", 'GENERAL');
        RealGeneraljnlLine.SETRANGE("Journal Batch Name", 'MALAWI SALARIES');
        if RealGeneraljnlLine.Find('-') then begin
            RealGeneraljnlLine.DeleteAll();
        end;
        GeneraljnlLine.RESET;
        GeneraljnlLine.SETRANGE("Journal Template Name", 'GENERAL');
        GeneraljnlLine.SETRANGE("Journal Batch Name", 'MALAWI SALARIES');

        IF GeneraljnlLine.FINDSET THEN BEGIN
            REPEAT
                Amt := 0;
                GeneraljnlLine2.RESET;
                GeneraljnlLine2.SETRANGE("Journal Template Name", 'GENERAL');
                GeneraljnlLine2.SETRANGE("Journal Batch Name", 'MALAWI SALARIES');
                GeneraljnlLine2.SETRANGE("Account No.", GeneraljnlLine."Account No.");
                // GeneraljnlLine2.SETRANGE("Shortcut Dimension 1 Code", GeneraljnlLine."Shortcut Dimension 1 Code");
                // GeneraljnlLine2.SETRANGE("Shortcut Dimension 2 Code", GeneraljnlLine."Shortcut Dimension 2 Code");
                IF GeneraljnlLine2.FINDSET THEN BEGIN
                    REPEAT
                        Amt := Amt + GeneraljnlLine2.Amount
                     UNTIL GeneraljnlLine2.NEXT = 0;
                    //  GeneraljnlLine2.CALCSUMS(Amount);
                END;
                LineNumber := LineNumber + 100;
                RealGeneraljnlLine.INIT;
                RealGeneraljnlLine."Journal Template Name" := 'GENERAL';
                RealGeneraljnlLine."Journal Batch Name" := 'MALAWI SALARIES';
                RealGeneraljnlLine."Line No." := LineNumber;
                RealGeneraljnlLine."Document No." := GeneraljnlLine."Document No.";
                RealGeneraljnlLine."Posting Date" := GeneraljnlLine."Posting Date";
                RealGeneraljnlLine."Account Type" := GeneraljnlLine."Account Type";
                RealGeneraljnlLine."Account No." := GeneraljnlLine."Account No.";
                RealGeneraljnlLine.VALIDATE(RealGeneraljnlLine."Account No.");
                //GLAccount.GET(GeneraljnlLine."Account No.");
                RealGeneraljnlLine.Description := GeneraljnlLine."Document No." + ' ' + GLAccount.Name;
                RealGeneraljnlLine.Amount := GeneraljnlLine.Amount;
                //RealGeneraljnlLine.VALIDATE(RealGeneraljnlLine.Amount);
                RealGeneraljnlLine."Amount (LCY)" := GeneraljnlLine."Amount (LCY)";
                // RealGeneraljnlLine.VALIDATE(RealGeneraljnlLine."Amount (LCY)");
                RealGeneraljnlLine."Shortcut Dimension 1 Code" := GeneraljnlLine."Shortcut Dimension 1 Code";
                RealGeneraljnlLine.VALIDATE(RealGeneraljnlLine."Shortcut Dimension 1 Code");
                RealGeneraljnlLine."Shortcut Dimension 2 Code" := GeneraljnlLine."Shortcut Dimension 2 Code";
                RealGeneraljnlLine.VALIDATE(RealGeneraljnlLine."Shortcut Dimension 2 Code");
                IF RealGeneraljnlLine.Amount <> 0 THEN
                    RealGeneraljnlLine.INSERT;


                //END; 
                GeneraljnlLine2.RESET;
                GeneraljnlLine2.SETRANGE("Journal Template Name", 'GENERAL');
                GeneraljnlLine2.SETRANGE("Journal Batch Name", 'MALAWI SALARIES');
                GeneraljnlLine2.SETRANGE("Account No.", GeneraljnlLine."Account No.");
                GeneraljnlLine2.SETRANGE("Shortcut Dimension 1 Code", GeneraljnlLine."Shortcut Dimension 1 Code");
                GeneraljnlLine2.SETRANGE("Shortcut Dimension 2 Code", GeneraljnlLine."Shortcut Dimension 2 Code");
                IF GeneraljnlLine2.FINDSET THEN BEGIN
                    GeneraljnlLine2.DELETEALL;
                END;

            UNTIL GeneraljnlLine.NEXT = 0;
        END;



    end;
}

