Codeunit 80000 "Payroll Management_AU"
{

    trigger OnRun()
    begin
    end;

    var
        PersonalRelief: Decimal;
        "PersonalRelief(LCY)": Decimal;
        MAximumPremium: Decimal;
        InsuranceRelief: Decimal;
        NHIFRATE: Decimal;
        EmployeehousingLeavy: Decimal;
        EmployeehousingLeavyC: Decimal;
        PensionEmployer: Decimal;
        "InsuranceRelief(LCY)": Decimal;
        MorgageRelief: Decimal;
        "MorgageRelief(LCY)": Decimal;
        MaximumRelief: Decimal;
        "MaximumRelief(LCY)": Decimal;
        NssfEmployee: Decimal;
        "NssfEmployee(LCY)": Decimal;
        NssfEmployerFactor: Decimal;
        "NssfEmployerFactor(LCY)": Decimal;
        NHIFBasedOn: Option Gross,Basic,"Taxable Pay";
        NSSFBasedOn: Option Gross,Basic,"Taxable Pay";
        MaxPensionContrib: Decimal;
        "MaxPensionContrib(LCY)": Decimal;
        RateTaxExPension: Decimal;
        "RateTaxExPension(LCY)": Decimal;
        OOIMaxMonthlyContrb: Decimal;
        "OOIMaxMonthlyContrb(LCY)": Decimal;
        OOIDecemberDedc: Decimal;
        "OOIDecemberDedc(LCY)": Decimal;
        LoanMarketRate: Decimal;
        "LoanMarketRate(LCY)": Decimal;
        LoanCorpRate: Decimal;
        "LoanCorpRate(LCY)": Decimal;
        NSSFBaseAmount: Decimal;
        "NSSFBaseAmount(LCY)": Decimal;
        NHIFBaseAmount: Decimal;
        "NHIFBaseAmount(LCY)": Decimal;
        EmpBasicPay: Decimal;
        "EmpBasicPay(LCY)": Decimal;
        EmpEarning: Decimal;
        "EmpEarning(LCY)": Decimal;
        EmpDeduction: Decimal;
        "EmpDeduction(LCY)": Decimal;
        PremiumAmount: Decimal;
        EmpPaye: Decimal;
        "EmpPaye(LCY)": Decimal;
        EmpPayeBenefit: Decimal;
        "EmpPayeBenefit(LCY)": Decimal;
        EmpGrossPay: Decimal;
        "EmpGrossPay(LCY)": Decimal;
        EmpGrossTaxable: Decimal;
        "EmpGrossTaxable(LCY)": Decimal;
        EmpBenefits: Decimal;
        "EmpBenefits(LCY)": Decimal;
        EmpValueOfQuarters: Decimal;
        "EmpValueOfQuarters(LCY)": Decimal;
        EmpTaxableEarning: Decimal;
        "EmpTaxableEarning(LCY)": Decimal;
        EmpPersonalRelief: Decimal;
        "EmpPersonalRelief(LCY)": Decimal;
        EmpPersonalRelief2: Decimal;
        "EmpPersonalRelief(LCY)2": Decimal;

        MaximumNonTaxablePension: Decimal;
        EmpUnusedRelief: Decimal;
        "EmpUnusedRelief(LCY)": Decimal;
        EmpNetPay: Decimal;
        "EmpNetPay(LCY)": Decimal;
        EmpTotDed: Decimal;
        "EmpTotDed(LCY)": decimal;
        currentAmount: Decimal;
        "currentAmount(LCY)": Decimal;
        Description: Text[100];
        "Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        "Account No.": Code[20];
        "Posting Type": Option " ",Debit,Credit;
        "Transaction Code": Code[20];
        "Transaction Type": Code[50];
        Grouping: Integer;
        SubGrouping: Integer;
        TransDescription: Text[100];
        ExchangeRateDate: Date;
        CurrExchRate: Record "Currency Exchange Rate";
        PayrollPostingGroup: Record "Payroll Posting Groups_AU";
        PayrollGenSetup: Record "Payroll General Setup_AU";
        EmployeeTransactions: Record "Payroll Employee Trans_AU";
        EmpTotalAllowances: Decimal;
        "EmpTotalAllowances(LCY)": Decimal;
        PayrollTransactions: Record "Payroll Transaction Code_AU";
        TransFormula: Text[250];
        CurBalance: Decimal;
        "CurBalance(LCY)": Decimal;
        EmpTotalNonTaxAllowances: Decimal;
        "EmpTotalNonTaxAllowances(LCY)": Decimal;
        Customer: Record Customer;
        TALLOWANCE: label 'ALLOWANCE';
        CurMonth: Integer;
        CurYear: Integer;
        TCODE_BPAY: label 'BPAY';
        TTYPE_BPAY: label 'Basic Pay';
        TotalSalaryArrears: Decimal;

        PensionBenefit: Decimal;
        SHIF: Decimal;
        GroupLifeAssuarance: Decimal;
        PensionAdministrativeFee: Decimal;
        VatOnPension: Decimal;
        TotalPensionBenefit: Decimal;

        PensionAddedBack: Decimal;
        currentGrossPay: Decimal;
        "currentGrossPay(LCY)": Decimal;
        EmpSalaryArrear: Decimal;
        "EmpSalaryArrear(LCY)": Decimal;
        TCODE_GPAY: label 'GPAY';
        TTYPE_GPAY: label 'Gross Pay';
        EmpPAYEArrears: Decimal;
        "EmpPAYEArrears(LCY)": Decimal;
        "Salary Arrears": Record "Payroll Salary Arrears_AU";
        TCODE_SARREARS: label 'ARREARS';
        TTYPE_SARREARS: label 'Salary Arrears';
        TCODE_PARREARS: label 'PYAR';
        TTYPE_STATUTORIES: label 'STATUTORIES';
        EmpLoan: Decimal;
        "EmpLoan(LCY)": Decimal;
        EmpFringeBenefit: Decimal;
        TCODE_NSSF: label 'NSSF';
        TCODE_NSSFEMP: label 'NSSFEMP';
        "EmpFringeBenefit(LCY)": Decimal;
        TCODE_NHIF: label 'NHIF';
        EmpDefinedContrib: Decimal;
        "EmpDefinedContrib(LCY)": Decimal;
        EmpStaffPension: Decimal;
        "EmpStaffPension(LCY)": Decimal;
        EmpLessAllowanceNSSF: Decimal;
        "EmpLessAllowanceNSSF(LCY)": Decimal;
        EmpLessAllowanceNHIF: Decimal;
        "EmpLessAllowanceNHIF(LCY)": Decimal;
        EmpPensionStaff: Decimal;
        "EmpPensionStaff(LCY)": Decimal;
        EmpOOI: Decimal;
        "EmpOOI(LCY)": Decimal;
        EmpHOSP: Decimal;
        "EmpHOSP(LCY)": Decimal;
        EmpNonTaxable: Decimal;
        "EmpNonTaxable(LCY)": Decimal;
        EmpTaxCharged: Decimal;
        "EmpTaxCharged(LCY)": Decimal;
        InsuranceReliefAmount: Decimal;
        "InsuranceReliefAmount(LCY)": Decimal;
        UnusedRelief: Record "Employee Unused Relief_AU";
        EmpNSSF: Decimal;
        "EmpNSSF(LCY)": Decimal;
        EmpNHIF: Decimal;
        "EmpNHIF(LCY)": Decimal;
        EmpTotalDeductions: Decimal;
        "EmpTotalDeductions(LCY)": Decimal;
        ProvidentAmount: Decimal;
        "co-op": Option "None",Shares,Loan,"Loan Interest","Emergency Loan","Emergency Loan Interest","School Fees Loan","School Fees Loan Interest",Welfare,Pension,NSSF,Overtime,WSS;
        LoanNo: Code[10];
        PrEmployee: Record "Payroll Employee_AU";
        TCODE_PFUND: label 'PROVIDENT';
        TCODE_SHIF: label 'SHIF';
        curTotalDeductions: Decimal;
        ExcessPension: Decimal;
        curPensionStaff: Decimal;
        TotEmpBenefit: Decimal;
        InsuranceAmount: Decimal;
        NSSFTOUSE: Decimal;
        CURRTOUSE: Decimal;
        PayrollMonthly: Record "Payroll Employee Trans_AU";
        PrEmployee2: Record "Payroll Employee_AU";
        NSSFtoUSE2: Decimal;
        PayrollMonthlyTrans_AU: Record "Payroll Monthly Trans_AU";
        "Mortgage Relief": Decimal;
        PayrollTransactionCode_AU: Record "Payroll Transaction Code_AU";
        PayrollEmployeeTrans_AU6: Record "Payroll Employee Trans_AU";
        def: Decimal;
        Voluntaryp: Decimal;
        p10: Record P10;


    procedure ProcessPayroll("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; PaysPAYE: Boolean; PaysNHIF: Boolean; PaysNSSF: Boolean; GetsPAYERelief: Boolean; GetsPAYEBenefit: Boolean; Secondary: Boolean; PayeBenefitPercent: Decimal)
    var
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
    begin
        InsuranceAmount := 0;


        Initialize("Payroll Period");
        //Basic Pay
        ProcessBasicPay("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);

        ProcessPension("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                         BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //SalaryArrears
        ProcessSalaryArrears("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //Earnings
        ProcessEarnings("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //GrossPay
        ProcessGrossPay("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //Deductions
        ProcessDeductions("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //NSSF
        if "Global Dimension 1 Code" = 'KENYA' then begin
            if PaysNSSF = true then begin
                ProcessEmployeeNSSF("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                                BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, PaysNSSF);
                ProcessEmployerNSSF("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                                BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, PaysNSSF);
            end;
        END;
        // if "Global Dimension 1 Code" = 'KENYA' then begin

        //     ProcessMalawiPension("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
        //                          BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, PaysNSSF);
        // end;
        //group Life Assurance 
        // ProcesSGroupLifeAssuarance("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
        //                          BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, PaysNSSF);
        // //administrative fee
        // ProcesSAdministrativeFee("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
        // BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, PaysNSSF);
        // // process provident
        CalculateSpecialTrans("Employee No", CurMonth, CurYear, Specialtranstype::"Defined Contribution", false);
        ProcessEmployerProvident("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                           BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);


        // process benefit
        CalculatePrescribedBenefit("Employee No", CurMonth, CurYear, Specialtranstype::"Defined Contribution", false);
        ProcessEmployerProvident("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                           BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);


        ProcessEmployerProvident("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                           BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);


        //NHIF
        IF "Global Dimension 1 Code" = 'KENYA' THEN begin
            if PaysNHIF = true then begin
                ProcessNHIF("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                                BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, PaysNHIF);
            end;
        END;
        CalculateInsuranceRelief("Employee No", CurMonth, CurYear, Specialtranstype::"Defined Contribution", false);
        //Gross Taxable
        ProcessGrossTaxable();

        //Taxable Pay
        ProcessTaxablePay("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        EmpPaye := 0;
        if EmpTaxableEarning > 0 then begin //...Addition

            //PAYE
            IF "Global Dimension 1 Code" = 'KENYA' THEN begin
                if PaysPAYE then begin
                    //Personal Relief

                    ProcessPersonalRelief("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                                  BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);

                    ProcessEmpPAYE("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                                    BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, Secondary, GetsPAYEBenefit, PayeBenefitPercent);
                end else begin
                    EmpPaye := 0;
                end;
            end;
        END;
        EmpTotDed := 0;
        //NetPay
        ProcessTotalDeds("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);

        //End
        EmpNetPay := 0;
        //NetPay
        ProcessNetPay("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);

        //End
    end;


    procedure ProcessPartTimePayroll("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; PaysPAYE: Boolean; PaysNHIF: Boolean; PaysNSSF: Boolean; GetsPAYERelief: Boolean; GetsPAYEBenefit: Boolean; Secondary: Boolean; PayeBenefitPercent: Decimal)
    var
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
    begin
        InsuranceAmount := 0;



        Initialize("Payroll Period");
        //Basic Pay
        ProcessBasicPay("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);

        ProcessPension("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                         BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //SalaryArrears
        ProcessSalaryArrears("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //Earnings
        ProcessEarnings("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //GrossPay
        ProcessGrossPay("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //Deductions
        ProcessDeductions("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);
        //NSSF
        if PaysNSSF = true then begin
            ProcessEmployeeNSSF("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                            BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, PaysNSSF);
            ProcessEmployerNSSF("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                            BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, PaysNSSF);
        end;

        // process provident
        CalculateSpecialTrans("Employee No", CurMonth, CurYear, Specialtranstype::"Defined Contribution", false);
        ProcessEmployerProvident("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                           BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);

        // process benefit
        CalculatePrescribedBenefit("Employee No", CurMonth, CurYear, Specialtranstype::"Defined Contribution", false);
        ProcessEmployerProvident("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                           BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);

        CalculateInsuranceRelief("Employee No", CurMonth, CurYear, Specialtranstype::"Defined Contribution", false);
        ProcessEmployerProvident("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                           BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);

        //NHIF
        if PaysNHIF = true then begin
            ProcessNHIF("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                            BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, PaysNHIF);
        end;

        //Gross Taxable
        ProcessGrossTaxable();

        //Taxable Pay
        ProcessTaxablePay("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);

        //PAYE
        if PaysPAYE then begin


            ProcessPartTimeEmpPAYE("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                           BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department, Secondary, GetsPAYEBenefit, PayeBenefitPercent);
        end else begin
            EmpPaye := 0;
        end;
        EmpTotDed := 0;
        //NetPay
        ProcessTotalDeds("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);

        //End
        //NetPay
        ProcessNetPay("Employee No", "Payroll Period", "Posting Group", BasicPay, "BasicPay(LCY)", "Currency Code", "Currency Factor", "Joining Date", "Leaving Date",
                        BasedOnTimeSheet, "Global Dimension 1 Code", "Global Dimension 2 Code", Department);

        //End
    end;

    local procedure Initialize("Payroll Period": Date)
    begin
        CurMonth := Date2dmy("Payroll Period", 2);
        CurYear := Date2dmy("Payroll Period", 3);
        //Constants
        PayrollGenSetup.Get;

        PersonalRelief := PayrollGenSetup."Tax Relief";
        MaximumNonTaxablePension := PayrollGenSetup."Maximum Taxable Pension";
        InsuranceRelief := PayrollGenSetup."Insurance Relief";
        MorgageRelief := PayrollGenSetup."Mortgage Relief";
        MaximumRelief := PayrollGenSetup."Max Relief";
        NssfEmployee := PayrollGenSetup."NSSF Employee";
        NssfEmployerFactor := PayrollGenSetup."NSSF Employer Factor";
        NHIFBasedOn := PayrollGenSetup."NHIF Based on";
        NSSFBasedOn := PayrollGenSetup."NSSF Based on";
        MaxPensionContrib := PayrollGenSetup."Max Pension Contribution";
        RateTaxExPension := PayrollGenSetup."Tax On Excess Pension";
        OOIMaxMonthlyContrb := PayrollGenSetup."OOI Deduction";
        OOIDecemberDedc := PayrollGenSetup."OOI December";
        LoanMarketRate := PayrollGenSetup."Loan Market Rate";
        LoanCorpRate := PayrollGenSetup."Loan Corporate Rate";
        NHIFRATE := PayrollGenSetup."NHIF %";
        EmployeehousingLeavyC := PayrollGenSetup."Zakayo Leavy";
    end;

    local procedure ProcessBasicPay("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    var
        DaysInMonth: Integer;
        DaysWorked: Integer;
    begin
        //Setup Constants
        "Transaction Code" := TCODE_BPAY;
        "Transaction Type" := TTYPE_BPAY;
        TransDescription := 'Basic Pay';
        Grouping := 1;
        SubGrouping := 1;
        EmpBasicPay := 0;
        "EmpBasicPay(LCY)" := 0;
        currentAmount := 0;
        "currentAmount(LCY)" := 0;

        //Calculate the Basic Pay
        EmpBasicPay := BasicPay;
        "EmpBasicPay(LCY)" := "BasicPay(LCY)";
        /*
                //If Based on Timesheet then Prorate
                PayrollGenSetup.Get;
                if BasedOnTimeSheet then begin
                    DaysInMonth := GetDaysInMonth("Payroll Period");
                    DaysWorked := GetDaysWorkedTimesheet("Employee No", "Payroll Period");
                    EmpBasicPay := CalculateProratedAmount("Employee No", EmpBasicPay, Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                    "EmpBasicPay(LCY)" := CalculateProratedAmount("Employee No", "EmpBasicPay(LCY)", Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                    //End Based on Timesheet
                end else begin
                    //If Employed on this Payroll Period then Prorate Amount
                    if (Date2dmy("Joining Date", 2) = Date2dmy("Payroll Period", 2)) and (Date2dmy("Joining Date", 3) = Date2dmy("Payroll Period", 3)) then begin
                        DaysInMonth := GetDaysInMonth("Joining Date");
                        DaysWorked := GetDaysWorked("Joining Date", false);
                        EmpBasicPay := CalculateProratedAmount2("Employee No", EmpBasicPay, Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                        "EmpBasicPay(LCY)" := CalculateProratedAmount2("Employee No", "EmpBasicPay(LCY)", Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                    end;
                    //If Terminated on this Payroll Period then Prorate Amount
                    if "Leaving Date" <> 0D then
                        if (Date2dmy("Leaving Date", 2) = Date2dmy("Payroll Period", 2)) and (Date2dmy("Leaving Date", 3) = Date2dmy("Payroll Period", 3)) then begin
                            DaysInMonth := GetDaysInMonth("Joining Date");
                            DaysWorked := GetDaysWorked("Joining Date", true);
                            EmpBasicPay := CalculateProratedAmount2("Employee No", EmpBasicPay, Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                            "EmpBasicPay(LCY)" := CalculateProratedAmount2("Employee No", "EmpBasicPay(LCY)", Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);

                        end;
                end;
          */      //Insert Into Monthly Transactions
        currentAmount := Round(EmpBasicPay, 0.01, '=');
        "currentAmount(LCY)" := Round("EmpBasicPay(LCY)", 0.01, '=');

        if PayrollPostingGroup.Get("Posting Group") then begin
            "Account Type" := "account type"::"G/L Account";
            "Account No." := PayrollPostingGroup."Salary Account";
        end;
        "co-op" := "co-op"::None;

        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
        TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
        "Account No.", "posting type"::Debit, "Global Dimension 1 Code", "Global Dimension 2 Code", EmployeeTransactions.Membership,
        EmployeeTransactions."Reference No", Department, "co-op", LoanNo);


        //insertp10
        P10.RESET;
        P10.SETRANGE(P10."Employee No", "Employee No");
        P10.SETRANGE(P10."Payroll Preriod", "Payroll Period");
        IF not P10.FIND('-') THEN BEGIN
            P10.INIT;
            P10."Employee No" := "Employee No";
            P10."Payroll Preriod" := "Payroll Period";
            P10."Payroll Month" := CurMonth;
            P10."Payroll Year" := CurYear;
            P10."Basic Salary" := EmpBasicPay;
            if not P10.Insert(true) then P10.Modify(true);
        end;
    end;
    // end;

    local procedure ProcessPension("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    var
        DaysInMonth: Integer;
        DaysWorked: Integer;
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
    begin
        curPensionStaff := CalculateSpecialTrans("Employee No", CurMonth, CurYear, Specialtranstype::"Defined Contribution", false);
        if curPensionStaff > 0 then begin
            if curPensionStaff > MaxPensionContrib then
                currentAmount := MaxPensionContrib
            //ExcessPension:=MaxPensionContrib-curPensionStaff
            else
                currentAmount := Round(curPensionStaff, 0.01, '=');





            "Transaction Code" := 'PNSR';
            TransDescription := 'Pension Relief';
            "Transaction Type" := 'TAX CALCULATIONS';
            Grouping := 6;
            SubGrouping := 1;
            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
            TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "account type"::"G/L Account",
            '', "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
            '', Department, "co-op", LoanNo);

            ExcessPension := 0;
            if curPensionStaff > MaxPensionContrib then
                ExcessPension := curPensionStaff - MaxPensionContrib
            else
                ExcessPension := 0;


            currentAmount := Round(ExcessPension, 0.01, '=');


            InsertMonthlyTransactions("Employee No", 'EXCPNS', 'TAX CALCULATIONS', Grouping, 8,
            'Taxable Pension', ExcessPension, currentAmount, 0, 0, "Payroll Period", CurMonth, CurYear, "account type"::"G/L Account",
            '', "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
            '', Department, "co-op", LoanNo);
            //END;
        end;
    end;

    local procedure ProcessBenefits("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    var
        DaysInMonth: Integer;
        DaysWorked: Integer;
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
    begin
    end;

    local procedure ProcessSalaryArrears("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    begin
        //Salary Arrears
        /* "Salary Arrears".RESET;
         "Salary Arrears".SETRANGE("Salary Arrears"."Employee Code","Employee No");
         "Salary Arrears".SETRANGE("Salary Arrears"."Period Month",CurMonth);
         "Salary Arrears".SETRANGE("Salary Arrears"."Period Year",CurYear);
         IF "Salary Arrears".FINDFIRST THEN BEGIN
            //Salary Arrears------------------------------------------------------------------------------------------------------------
              //Setup Constants
              "Transaction Code":=TCODE_SARREARS;
              "Transaction Type":=TTYPE_SARREARS;
              TransDescription:=FORMAT(TTYPE_SARREARS)+':'+FORMAT("Payroll Period");
              Grouping:=1;SubGrouping:=2;
              currentAmount:=0;
              "currentAmount(LCY)":=0;
              SalaryArrear:=0;
              "SalaryArrear(LCY)":=0;
        
              SalaryArrear:="Salary Arrears"."Salary Arrears";
              "SalaryArrear(LCY)":="Salary Arrears"."Salary Arrears(LCY)";
        
              currentAmount:=SalaryArrears;
              "currentAmount(LCY)":="SalaryArrears(LCY)";
        
              IF PayrollPostingGroup.GET("Posting Group") THEN BEGIN
                 "Account Type":="Account Type"::"G/L Account";
                 "Account No.":=PayrollPostingGroup."Salary Account";
              END;
        
              //Insert Into Monthly Transactions
              InsertMonthlyTransactions("Employee No","Transaction Code","Transaction Type",Grouping,SubGrouping,
               TransDescription,currentAmount,"currentAmount(LCY)",0,0,"Payroll Period",CurMonth, CurYear,"Account Type",
               "Account No.","Posting Type"::Debit,"Global Dimension 1 Code","Global Dimension 2 Code",'',
               '',Department);
            //End Salary Arrears--------------------------------------------------------------------------------------------------------
        
            //PAYE Arrears--------------------------------------------------------------------------------------------------------------
        
              //Setup Constants
              "Transaction Code":=TCODE_PARREARS;
              "Transaction Type":=TTYPE_PARREARS;
              TransDescription:=FORMAT(TTYPE_PARREARS)+':'+FORMAT("Payroll Period");
              Grouping:=7;SubGrouping:=4;
              currentAmount:=0;
              "currentAmount(LCY)":=0;
              PAYEArrear:=0;
              "PAYEArrear(LCY)":=0;
        
        
              PAYEArrear:="Salary Arrears"."PAYE Arrears";
              "PAYEArrear(LCY)":="Salary Arrears"."PAYE Arrears(LCY)";
              currentAmount:=PAYEArrears;
              "currentAmount(LCY)":="PAYEArrears(LCY)";
        
              IF PayrollPostingGroup.GET("Posting Group") THEN BEGIN
                 "Account Type":="Account Type"::"G/L Account";
                 "Account No.":=PayrollPostingGroup."Income Tax Account";
              END;
        
              //Insert Into Monthly Transactions
              InsertMonthlyTransactions("Employee No","Transaction Code","Transaction Type",Grouping,SubGrouping,
               TransDescription,currentAmount,"currentAmount(LCY)",0,0,"Payroll Period",CurMonth, CurYear,"Account Type",
               "Account No.","Posting Type"::Debit,"Global Dimension 1 Code","Global Dimension 2 Code",'',
               '',Department);
        
             //End PAYE Arrears----------------------------------------------------------------------------------------------------------
         END;
         */

    end;

    local procedure ProcessEarnings("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimesheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    var
        DaysInMonth: Integer;
        DaysWorked: Integer;
    begin
        EmpTotalAllowances := 0;
        "EmpTotalAllowances(LCY)" := 0;
        EmpTotalNonTaxAllowances := 0;
        "EmpTotalNonTaxAllowances(LCY)" := 0;

        //Get Earnings
        EmployeeTransactions.Reset;
        EmployeeTransactions.SetRange(EmployeeTransactions."No.", "Employee No");
        EmployeeTransactions.SetRange(EmployeeTransactions."Period Month", CurMonth);
        EmployeeTransactions.SetRange(EmployeeTransactions."Period Year", CurYear);
        EmployeeTransactions.SetRange(EmployeeTransactions."Transaction Type", EmployeeTransactions."transaction type"::Income);
        if EmployeeTransactions.FindSet then begin
            repeat
                currentAmount := 0;
                "currentAmount(LCY)" := 0;
                CurBalance := 0;
                TransDescription := '';
                TransFormula := '';
                "Transaction Code" := '';
                Grouping := 0;
                SubGrouping := 0;

                PayrollTransactions.Reset;
                PayrollTransactions.SetRange(PayrollTransactions."Transaction Code", EmployeeTransactions."Transaction Code");
                if PayrollTransactions.FindFirst then begin
                    if PayrollTransactions."Is Formulae" then begin
                        TransFormula := ExpandFormula("Employee No", CurMonth, CurYear, PayrollTransactions.Formulae);
                        currentAmount := FormulaResult(TransFormula);
                        "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '=');
                    end else begin
                        currentAmount := EmployeeTransactions.Amount;
                        "currentAmount(LCY)" := EmployeeTransactions."Amount(LCY)";
                    end;
                    //If Based on Timesheet then Prorate
                    PayrollGenSetup.Get;
                    if BasedOnTimesheet then begin
                        DaysInMonth := GetDaysInMonth("Payroll Period");
                        DaysWorked := GetDaysWorkedTimesheet("Employee No", "Payroll Period");
                        currentAmount := CalculateProratedAmount("Employee No", currentAmount, Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                        "currentAmount(LCY)" := CalculateProratedAmount("Employee No", "currentAmount(LCY)", Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                        //End Based on Timesheet
                    end else begin
                        //If Employed on this Payroll Period then Prorate Amount
                        if EmployeeTransactions."Not Prorate" = false then
                            if (Date2dmy("Joining Date", 2) = Date2dmy("Payroll Period", 2)) and (Date2dmy("Joining Date", 3) = Date2dmy("Payroll Period", 3)) then begin
                                DaysInMonth := GetDaysInMonth("Joining Date");
                                DaysWorked := GetDaysWorked("Joining Date", false);
                                currentAmount := CalculateProratedAmount("Employee No", currentAmount, Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                                "currentAmount(LCY)" := CalculateProratedAmount("Employee No", "currentAmount(LCY)", Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                            end;
                        //If Terminated on this Payroll Period then Prorate Amount
                        if "Leaving Date" <> 0D then
                            if (Date2dmy("Leaving Date", 2) = Date2dmy("Payroll Period", 2)) and (Date2dmy("Leaving Date", 3) = Date2dmy("Payroll Period", 3)) then begin
                                DaysInMonth := GetDaysInMonth("Joining Date");
                                DaysWorked := GetDaysWorked("Joining Date", true);
                                currentAmount := CalculateProratedAmount("Employee No", currentAmount, Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                                "currentAmount(LCY)" := CalculateProratedAmount("Employee No", "currentAmount(LCY)", Date2dmy("Payroll Period", 2), Date2dmy("Payroll Period", 3), DaysInMonth, DaysWorked);
                            end;
                    end;
                    //Calculate Transaction Balances
                    if PayrollTransactions."Balance Type" = PayrollTransactions."balance type"::None then begin  //Balance Type None
                        CurBalance := 0;
                        "CurBalance(LCY)" := 0;
                    end;
                    if PayrollTransactions."Balance Type" = PayrollTransactions."balance type"::Increasing then begin//Balance Type Increasing
                        CurBalance := EmployeeTransactions.Balance + currentAmount;
                        "CurBalance(LCY)" := EmployeeTransactions."Balance(LCY)" + "currentAmount(LCY)";
                    end;
                    if PayrollTransactions."Balance Type" = PayrollTransactions."balance type"::Reducing then begin//Balance Type Decreasing
                        CurBalance := EmployeeTransactions.Balance - currentAmount;
                        "CurBalance(LCY)" := EmployeeTransactions."Balance(LCY)" - "currentAmount(LCY)";
                    end;
                    //Sum All NonTaxable Allowances
                    if (not PayrollTransactions.Taxable) and (PayrollTransactions."Special Transaction" = PayrollTransactions."special transaction"::Ignore) then begin
                        EmpTotalNonTaxAllowances := EmpTotalNonTaxAllowances + currentAmount;
                        "EmpTotalNonTaxAllowances(LCY)" := "EmpTotalNonTaxAllowances(LCY)" + "currentAmount(LCY)";
                    end;
                    //Exclude Special transaction that are not taxable in list of Allowances
                    if (not PayrollTransactions.Taxable) and (PayrollTransactions."Special Transaction" <> PayrollTransactions."special transaction"::Ignore) then begin
                        currentAmount := 0;
                        "currentAmount(LCY)" := 0;
                    end;
                    //Sum All Allowances
                    EmpTotalAllowances := Round(EmpTotalAllowances + currentAmount, 0.01, '=');
                    "EmpTotalAllowances(LCY)" := Round("EmpTotalAllowances(LCY)" + "currentAmount(LCY)", 0.01, '=');

                    TransDescription := PayrollTransactions."Transaction Name";
                    "Transaction Type" := TALLOWANCE;
                    Grouping := 3;
                    SubGrouping := 0;

                    //Posting Details
                    if PayrollTransactions.SubLedger <> PayrollTransactions.Subledger::" " then begin
                        if PayrollTransactions.SubLedger = PayrollTransactions.Subledger::Customer then begin
                            Customer.Reset;
                            Customer.SetRange(Customer."No.", "Employee No");
                            if Customer.FindFirst then begin
                                "Account Type" := "account type"::Member;
                                "Account No." := Customer."No.";
                            end;
                        end;


                    end else
                        if PayrollTransactions.SubLedger = PayrollTransactions.Subledger::Vendor then begin
                            Customer.Reset;
                            // Customer.SETRANGE(Customer."Payroll/Staff No","Employee No");
                            //IF Customer.FIND('-') THEN BEGIN
                            //  "Account Type":="Account Type"::Vendor;
                            //  "Account No.":=Customer."FOSA Account";
                            // "co-op":=PayrollTransactions."Co-Op Parameters";

                            // END;


                        end else begin
                            "Account Type" := "account type"::"G/L Account";
                            "Account No." := PayrollTransactions."G/L Account";
                        end;
                    //End posting Details
                    "co-op" := "co-op"::None;
                    InsertMonthlyTransactions("Employee No", PayrollTransactions."Transaction Code", "Transaction Type", Grouping, SubGrouping,
                     TransDescription, currentAmount, "currentAmount(LCY)", CurBalance, "CurBalance(LCY)", "Payroll Period", CurMonth, CurYear, "Account Type",
                     "Account No.", "posting type"::Debit, "Global Dimension 1 Code", "Global Dimension 2 Code", EmployeeTransactions.Membership,
                     EmployeeTransactions."Reference No", Department, "co-op", LoanNo);

                end;
            until EmployeeTransactions.Next = 0;
        end;
    end;

    local procedure ProcessGrossPay("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    var
        PayrollEmployee_AU: Record "Payroll Employee_AU";
    begin
        //Set Variables
        "Transaction Code" := TCODE_GPAY;
        "Transaction Type" := TTYPE_GPAY;
        TransDescription := 'Gross Pay';
        Grouping := 4;
        SubGrouping := 0;
        EmpGrossPay := 0;
        "EmpGrossPay(LCY)" := 0;
        currentAmount := 0;
        "currentAmount(LCY)" := 0;


        EmpGrossPay := (EmpBasicPay + EmpTotalAllowances + EmpSalaryArrear);
        "EmpGrossPay(LCY)" := ("EmpBasicPay(LCY)" + "EmpTotalAllowances(LCY)" + "EmpSalaryArrear(LCY)");

        currentAmount := Round(EmpGrossPay, 0.01, '=');
        "currentAmount(LCY)" := Round("EmpGrossPay(LCY)", 0.01, '=');
        // "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", EmpGrossPay, "Currency Factor"), 0.01, '<');
        "co-op" := "co-op"::None;
        //Insert into Monthly Transaction
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
        TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
        "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
         '', Department, "co-op", LoanNo);
        //insert housing leavy
        //Get Earnings
        if ("Global Dimension 1 Code" = 'KENYA') THEN begin
            EmployeeTransactions.RESET;
            EmployeeTransactions.SETRANGE(EmployeeTransactions."No.", "Employee No");
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Month", CurMonth);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Year", CurYear);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Transaction Type", EmployeeTransactions."Transaction Type"::Deduction);
            EmployeeTransactions.SETFILTER("Transaction Code", '%1', 'HL');
            IF EmployeeTransactions.FINDSET THEN BEGIN
                EmployeeTransactions.DELETE;
            END;
            if PayrollEmployee_AU.Get("Employee No") then
                if PayrollEmployee_AU.Secondary = false then begin

                    EmployeeTransactions.RESET;
                    EmployeeTransactions.SETRANGE(EmployeeTransactions."No.", "Employee No");
                    EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Month", CurMonth);
                    EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Year", CurYear);
                    EmployeeTransactions.SETRANGE(EmployeeTransactions."Transaction Type", EmployeeTransactions."Transaction Type"::Income);
                    EmployeeTransactions.SetRange("Inclusive housing Leavy", true);
                    IF EmployeeTransactions.FINDSET THEN BEGIN
                        repeat
                            EmployeehousingLeavy += EmployeeTransactions.Amount;
                        until EmployeeTransactions.Next() = 0;
                    end;
                    EmployeeTransactions.RESET;
                    EmployeeTransactions.SETRANGE(EmployeeTransactions."No.", "Employee No");
                    EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Month", CurMonth);
                    EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Year", CurYear);

                    EmployeeTransactions.SETRANGE(EmployeeTransactions."Transaction Type", EmployeeTransactions."Transaction Type"::Deduction);
                    EmployeeTransactions.SETFILTER("Transaction Code", '%1', 'HL');
                    IF NOT EmployeeTransactions.FIND('-') THEN BEGIN
                        EmployeeTransactions.INIT;
                        EmployeeTransactions."No." := "Employee No";
                        EmployeeTransactions."Period Month" := CurMonth;
                        EmployeeTransactions."Period Year" := CurYear;
                        EmployeeTransactions."Payroll Period" := "Payroll Period";
                        EmployeeTransactions."Transaction Code" := 'HL';
                        EmployeeTransactions."Transaction Name" := 'Housing Levy';
                        EmployeeTransactions.Amount := (EmployeehousingLeavy + EmpBasicPay) * EmployeehousingLeavyC / 100;
                        EmployeeTransactions.validate(Amount);
                        EmployeeTransactions."Transaction Type" := EmployeeTransactions."Transaction Type"::Deduction;
                        EmployeeTransactions.INSERT;
                    END;
                end;
        END;
        //end insertion
    end;

    local procedure ProcessDeductions("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimesheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    begin

        EmpDeduction := 0;
        "EmpDeduction(LCY)" := 0;

        //Get Earnings
        EmployeeTransactions.Reset;
        EmployeeTransactions.SetRange(EmployeeTransactions."No.", "Employee No");
        EmployeeTransactions.SetRange(EmployeeTransactions."Period Month", CurMonth);
        EmployeeTransactions.SetRange(EmployeeTransactions."Period Year", CurYear);
        EmployeeTransactions.SetRange(EmployeeTransactions."Transaction Type", EmployeeTransactions."transaction type"::Deduction);
        if EmployeeTransactions.Find('-') then begin
            curTotalDeductions := 0;
            repeat

                currentAmount := 0;
                "currentAmount(LCY)" := 0;
                CurBalance := 0;
                TransDescription := '';
                TransFormula := '';
                "Transaction Code" := '';
                Grouping := 0;
                SubGrouping := 0;

                PayrollTransactions.Reset;
                PayrollTransactions.SetRange(PayrollTransactions."Transaction Code", EmployeeTransactions."Transaction Code");
                if PayrollTransactions.Find('-') then begin

                    if PayrollTransactions."Is Formulae" then begin
                        TransFormula := ExpandFormula("Employee No", CurMonth, CurYear, PayrollTransactions.Formulae);
                        currentAmount := Round(FormulaResult(TransFormula), 0.01, '=');
                        "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');
                        //Message('%1', currentAmount);
                    end else begin
                        currentAmount := EmployeeTransactions.Amount;
                        "currentAmount(LCY)" := EmployeeTransactions."Amount(LCY)";
                    end;

                    PayrollGenSetup.Get;
                    if (PayrollTransactions."Special Transaction" = PayrollTransactions."special transaction"::"Life Insurance") and (PayrollTransactions."Deduct Premium" = false) then begin
                        PrEmployee2.Get("Employee No");
                        if PrEmployee2."Include Insurance deduction" = false then begin
                            currentAmount := 0;
                            "currentAmount(LCY)" := 0;
                        end;
                    end;

                    if (PayrollTransactions."Special Transaction" = PayrollTransactions."special transaction"::Morgage) and (PayrollTransactions."Deduct Mortgage" = false) then begin
                        currentAmount := 0;
                        "currentAmount(LCY)" := 0;
                    end;

                    //IF PayrollTransactions.GET()
                    //Posting Details
                    if PayrollTransactions.SubLedger <> PayrollTransactions.Subledger::" " then begin
                        /* IF PayrollTransactions.SubLedger=PayrollTransactions.SubLedger::Customer THEN BEGIN
                             Customer.RESET;
                             Customer.SETRANGE(Customer."Payroll/Staff No","Employee No");
                             IF Customer.FIND('-') THEN BEGIN
                                "Account Type":="Account Type"::Member;
                                "Account No.":=Customer."No.";
                                "co-op":=PayrollTransactions."Co-Op Parameters";

                             END;*/
                        //END;
                    end else
                        if PayrollTransactions.SubLedger = PayrollTransactions.Subledger::Vendor then begin
                            Customer.Reset;
                            //  Customer.SETRANGE(Customer."Payroll/Staff No","Employee No");
                            // IF Customer.FIND('-') THEN BEGIN
                            //  "Account Type":="Account Type"::Vendor;
                            //  "Account No.":=Customer."FOSA Account";
                            // "co-op":=PayrollTransactions."Co-Op Parameters";

                            //END;
                        end else begin
                            "Account Type" := "account type"::"G/L Account";
                            "Account No." := PayrollTransactions."G/L Account";
                        end;
                    //End posting Details

                    //Amortized Loan Calculation
                    if (PayrollTransactions."Special Transaction" = PayrollTransactions."special transaction"::"Staff Loan") and
                       (PayrollTransactions."Repayment Method" = PayrollTransactions."repayment method"::Amortized) then begin

                        currentAmount := 0;
                        "currentAmount(LCY)" := 0;
                        EmpLoan := 0;
                        "EmpLoan(LCY)" := 0;
                        EmpLoan := CalculateLoanInterest("Employee No", EmployeeTransactions."Transaction Code",
                                     PayrollTransactions."Interest Rate", PayrollTransactions."Repayment Method",
                                     EmployeeTransactions."Original Amount", EmployeeTransactions.Balance, "Payroll Period", false);
                        if "Currency Code" <> '' then
                            "EmpLoan(LCY)" := CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", EmpLoan, "Currency Factor")
                        else
                            "EmpLoan(LCY)" := 0;
                        LoanNo := EmployeeTransactions."Loan Number";
                        //Post the Interest
                        if (EmpLoan <> 0) then begin
                            currentAmount := EmpLoan;
                            curTotalDeductions := curTotalDeductions + currentAmount;
                            "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');

                            EmpDeduction := EmpDeduction + currentAmount;
                            "EmpDeduction(LCY)" := "EmpDeduction(LCY)" + "currentAmount(LCY)";

                            CurBalance := 0;
                            "CurBalance(LCY)" := 0;

                            "Transaction Code" := EmployeeTransactions."Transaction Code" + '-INT';
                            TransDescription := EmployeeTransactions."Transaction Name" + 'Interest';
                            "Transaction Type" := 'DEDUCTIONS';
                            Grouping := 8;
                            SubGrouping := 1;
                            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
                                TransDescription, currentAmount, "currentAmount(LCY)", round(CurBalance, 0.01, '='), Round("CurBalance(LCY)", 0.01, '='), "Payroll Period", CurMonth, CurYear, "Account Type",
                                "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '', '', Department, "co-op", LoanNo);

                        end;
                        currentAmount := EmployeeTransactions."Amtzd Loan Repay Amt" - EmpLoan;
                        "currentAmount(LCY)" := EmployeeTransactions."Amtzd Loan Repay Amt(LCY)" - "EmpLoan(LCY)";
                    end;
                    //End Amortized Loan

                    //Calculate Transaction Balances
                    if PayrollTransactions."Balance Type" = PayrollTransactions."balance type"::None then begin  //Balance Type None
                        CurBalance := 0;
                        "CurBalance(LCY)" := 0;
                    end;
                    if PayrollTransactions."Balance Type" = PayrollTransactions."balance type"::Increasing then begin//Balance Type Increasing
                        CurBalance := EmployeeTransactions.Balance + currentAmount;
                        "CurBalance(LCY)" := EmployeeTransactions."Balance(LCY)" + "currentAmount(LCY)";
                    end;
                    if PayrollTransactions."Balance Type" = PayrollTransactions."balance type"::Reducing then begin//Balance Type Decreasing

                        if EmployeeTransactions.Balance < EmployeeTransactions.Amount then begin
                            currentAmount := EmployeeTransactions.Balance;
                            "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');
                            CurBalance := 0;
                            "CurBalance(LCY)" := 0;
                        end else begin
                            CurBalance := EmployeeTransactions.Balance - currentAmount;
                            "CurBalance(LCY)" := EmployeeTransactions."Balance(LCY)" - "currentAmount(LCY)";
                        end;
                        if CurBalance < 0 then begin
                            currentAmount := 0;
                            "currentAmount(LCY)" := 0;
                            CurBalance := 0;
                            "CurBalance(LCY)" := 0;
                        end;
                    end;
                    EmpDeduction := EmpDeduction + currentAmount;
                    curTotalDeductions := Round(curTotalDeductions + EmpDeduction, 0.01, '=');
                    "EmpDeduction(LCY)" := Round("EmpDeduction(LCY)" + "currentAmount(LCY)", 0.01, '=');
                    LoanNo := EmployeeTransactions."Loan Number";
                    "Transaction Code" := PayrollTransactions."Transaction Code";
                    TransDescription := PayrollTransactions."Transaction Name";
                    "Transaction Type" := 'DEDUCTIONS';
                    Grouping := 8;
                    SubGrouping := 0;
                    InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
                          TransDescription, currentAmount, "currentAmount(LCY)", CurBalance, "CurBalance(LCY)", "Payroll Period", CurMonth, CurYear, "Account Type",
                          "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '', '', Department, "co-op", LoanNo);

                    //If transaction is loan. Do Loan Calculation
                    if (PayrollTransactions."Special Transaction" = PayrollTransactions."special transaction"::"Staff Loan") and
                       (PayrollTransactions."Repayment Method" <> PayrollTransactions."repayment method"::Amortized) then begin

                        EmpLoan := CalculateLoanInterest("Employee No", EmployeeTransactions."Transaction Code",
                                     PayrollTransactions."Interest Rate", PayrollTransactions."Repayment Method",
                                     EmployeeTransactions."Original Amount", EmployeeTransactions.Balance, "Payroll Period", false);
                        if "Currency Code" <> '' then
                            "EmpLoan(LCY)" := CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", EmpLoan, "Currency Factor")
                        else
                            "EmpLoan(LCY)" := 0;

                        if EmpLoan > 0 then begin
                            currentAmount := EmpLoan;
                            "currentAmount(LCY)" := Round("EmpLoan(LCY)", 0.01, '=');
                            curTotalDeductions := Round(curTotalDeductions + currentAmount, 0.01, '=');
                            EmpDeduction := Round(EmpDeduction + currentAmount, 0.01, '=');
                            "EmpDeduction(LCY)" := Round("EmpDeduction(LCY)" + "currentAmount(LCY)", 0.01, '=');
                            LoanNo := EmployeeTransactions."Loan Number";
                            CurBalance := 0;
                            "Transaction Code" := EmployeeTransactions."Transaction Code" + '-INT';
                            TransDescription := EmployeeTransactions."Transaction Name" + ' ' + 'Interest';
                            "Transaction Type" := 'DEDUCTIONS';
                            Grouping := 8;
                            SubGrouping := 1;
                            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
                                    TransDescription, currentAmount, "currentAmount(LCY)", CurBalance, "CurBalance(LCY)", "Payroll Period", CurMonth, CurYear, "Account Type",
                                    "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '', '', Department, "co-op", LoanNo);

                        end;
                    end;
                    //End Loan Calculation
                    //Fringe Benefits and Low interest Benefits
                    if PayrollTransactions."Fringe Benefit" = true then begin
                        if PayrollTransactions."Interest Rate" < LoanMarketRate then begin
                            EmpFringeBenefit := (((LoanMarketRate - PayrollTransactions."Interest Rate") * LoanCorpRate) / 1200) * EmployeeTransactions.Balance;
                            "EmpFringeBenefit(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", EmpFringeBenefit, "Currency Factor"));
                        end;
                    end else begin
                        EmpFringeBenefit := 0;
                    end;
                    if EmpFringeBenefit > 0 then
                        InsertEmployerDeductions("Employee No", EmployeeTransactions."Transaction Code" + '-FRG',
                                'EMP', Grouping, SubGrouping, 'Fringe Benefit Tax', EmpFringeBenefit, "EmpFringeBenefit(LCY)", 0, 0, CurMonth, CurYear,
                                 EmployeeTransactions.Membership, EmployeeTransactions."Reference No", "Payroll Period", '');

                    //End Fringe Benefits

                    //Create Employer Deduction
                    if (PayrollTransactions."Employer Deduction") or (PayrollTransactions."Include Employer Deduction") then begin

                        if PayrollTransactions."Formulae for Employer" <> '' then begin
                            TransFormula := ExpandFormula("Employee No", CurMonth, CurYear, PayrollTransactions."Formulae for Employer");
                            currentAmount := FormulaResult(TransFormula);
                            "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"));
                        end else begin
                            ProvidentAmount := (1.5 * EmployeeTransactions."Employer Amount");
                            currentAmount := EmployeeTransactions."Employer Amount";
                            "currentAmount(LCY)" := EmployeeTransactions."Employer Amount(LCY)";
                        end;
                        if currentAmount > 0 then
                            InsertEmployerDeductions("Employee No", EmployeeTransactions."Transaction Code",
                                    'EMP', Grouping, SubGrouping, 'DEDUCTION', currentAmount, "currentAmount(LCY)", 0, 0, CurMonth, CurYear,
                                       EmployeeTransactions.Membership, EmployeeTransactions."Reference No", "Payroll Period", '');

                        if ProvidentAmount > 0 then
                            InsertEmployerDeductions("Employee No", EmployeeTransactions."Transaction Code",
                                   'EMP', Grouping, SubGrouping, 'PROV DEDUCTION', ProvidentAmount, "currentAmount(LCY)", 0, 0, CurMonth, CurYear,
                                    EmployeeTransactions.Membership, EmployeeTransactions."Reference No", "Payroll Period", '');

                    end;
                    //Employer deductions
                end;
            until EmployeeTransactions.Next = 0;
        end;

    end;

    local procedure ProcessEmployeeNSSF("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; PayesNSSF: Boolean)
    var
        NSSFAmt: Decimal;
        "NSSFAmt(LCY)": Decimal;
        PayrollEmployee: Record "Payroll Employee_AU";
    begin
        NSSFBaseAmount := 0;
        "NSSFBaseAmount(LCY)" := 0;
        EmpNSSF := 0;
        "EmpNSSF(LCY)" := 0;
        currentAmount := 0;
        "currentAmount(LCY)" := 0;

        if PayesNSSF = true then begin
            if NSSFBasedOn = Nssfbasedon::Gross then begin
                NSSFBaseAmount := EmpGrossPay;
                "NSSFBaseAmount(LCY)" := "EmpGrossPay(LCY)";
            end;
            if NSSFBasedOn = Nssfbasedon::Basic then begin
                NSSFBaseAmount := EmpBasicPay;
                "NSSFBaseAmount(LCY)" := "EmpBasicPay(LCY)";
            end;
            EmpNSSF := CalculateEmployeeNSSF(NSSFBaseAmount);
            "EmpNSSF(LCY)" := CalculateEmployeeNSSF("NSSFBaseAmount(LCY)");

            if EmpGrossPay < 18000 then begin
                EmpNSSF := Round(0.06 * EmpGrossPay, 0.01, '=');
                "EmpNSSF(LCY)" := Round(0.06 * EmpGrossPay, 0.01, '=');
                NSSFtoUSE2 := 0;
                NSSFtoUSE2 := EmpNSSF;
            end;

            currentAmount := EmpNSSF;
            "currentAmount(LCY)" := "EmpNSSF(LCY)";
            //"currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');


            "Transaction Code" := TCODE_NSSF;
            TransDescription := 'N.S.S.F';
            "Transaction Type" := TTYPE_STATUTORIES;
            Grouping := 7;
            SubGrouping := 1;
            if PayrollPostingGroup.Get("Posting Group") then begin
                "Account Type" := "account type"::"G/L Account";
                "Account No." := PayrollPostingGroup."SSF Employee Account";
            end;

        end else begin
            currentAmount := 0;
        end;

        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
        TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
        "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
        '', Department, "co-op", LoanNo);


        EmpDefinedContrib := 0;
        "Transaction Code" := 'DEFCON';
        "Transaction Type" := 'TAX CALCULATIONS';
        TransDescription := 'Defined Contributions';
        Grouping := 6;
        SubGrouping := 1;







        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
        TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "account type"::"G/L Account",
        '', "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
        '', Department, "co-op", LoanNo);
        //END;

        PensionBenefit := 0;
        PrEmployee.RESET;
        PrEmployee.SETRANGE(PrEmployee."No.", "Employee No");
        IF PrEmployee.FIND('-') THEN BEGIN
            //MESSAGE('%1-%2',EmpGrossPay,PayrollEmployee_AU."Pension %");
            PensionBenefit := Round((PrEmployee."Basic Pay" + EmployeehousingLeavy) * PrEmployee."Pension %-Employee" / 100, 0.01, '=');//+ EmpNSSF;
            "Transaction Code" := 'Pension Benefit';
            TransDescription := 'Pension Benefit Relief';
            "Transaction Type" := 'TAX CALCULATIONS';


            Grouping := 6;
            SubGrouping := 9;


            // InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
            //         TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
            //         "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
            //         '', Department, "co-op", LoanNo);
            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
       'Pension Contribution ', PensionBenefit, PensionBenefit, 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
       "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
       '', Department, "co-op", LoanNo);//rkk

        END;



        SHIF := 0;
        PrEmployee.RESET;
        PrEmployee.SETRANGE(PrEmployee."No.", "Employee No");
        IF PrEmployee.FIND('-') THEN BEGIN
            //MESSAGE('%1-%2',EmpGrossPay,PayrollEmployee_AU."Pension %");
            SHIF := Round(PrEmployee."Basic Pay" * 2.75 / 100, 0.01, '=');//+ EmpNSSF;
            "Transaction Code" := 'SHIF';
            TransDescription := 'Social Health Insuarance Fund';
            "Transaction Type" := 'TAX CALCULATIONS';


            Grouping := 6;
            SubGrouping := 11;


            // InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
            //         TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
            //         "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
            //         '', Department, "co-op", LoanNo);
            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
       'SHIF Contribution ', SHIF, SHIF, 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
       "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
       '', Department, "co-op", LoanNo);//Kiplaa 0n 24/10/2024

        end;
        //insertp10
        P10.RESET;
        P10.SETRANGE(P10."Employee No", "Employee No");
        P10.SETRANGE(P10."Payroll Preriod", "Payroll Period");
        IF P10.FIND('-') THEN BEGIN

            P10.NSSF := currentAmount;
            P10.Modify(true);
        end;

    end;

    local procedure ProcessMalawiPension("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; PayesNSSF: Boolean)
    var
        NSSFAmt: Decimal;
        "NSSFAmt(LCY)": Decimal;
        PayrollEmployee: Record "Payroll Employee_AU";
    begin
        PensionBenefit := 0;
        PrEmployee.RESET;
        PrEmployee.SETRANGE(PrEmployee."No.", "Employee No");
        IF PrEmployee.FIND('-') THEN BEGIN

            PensionBenefit := Round((PrEmployee."Basic Pay" + EmployeehousingLeavy) * PrEmployee."Pension %-Employee" / 100, 0.01, '=');//+EmpNSSF;
            "Transaction Code" := 'Pension Benefit';
            TransDescription := 'Pension Benefit Relief';
            "Transaction Type" := 'TAX CALCULATIONS';


            Grouping := 8;
            SubGrouping := 1;
            //Message('%1', PensionBenefit);
            EmployeeTransactions.RESET;
            EmployeeTransactions.SETRANGE(EmployeeTransactions."No.", "Employee No");
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Month", CurMonth);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Year", CurYear);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Transaction Type", EmployeeTransactions."Transaction Type"::Deduction);
            EmployeeTransactions.SETFILTER("Transaction Code", '%1', 'D009');//E003
            IF EmployeeTransactions.FIND('-') THEN BEGIN
                EmployeeTransactions.DeleteAll();
            end;
            EmployeeTransactions.RESET;
            EmployeeTransactions.SETRANGE(EmployeeTransactions."No.", "Employee No");
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Month", CurMonth);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Year", CurYear);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Transaction Type", EmployeeTransactions."Transaction Type"::Deduction);
            EmployeeTransactions.SETFILTER("Transaction Code", '%1', 'D004');//E003
            IF EmployeeTransactions.FIND('-') THEN BEGIN
                EmployeeTransactions.DeleteAll();
            end;
            EmployeeTransactions.RESET;
            EmployeeTransactions.SETRANGE(EmployeeTransactions."No.", "Employee No");
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Month", CurMonth);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Year", CurYear);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Transaction Type", EmployeeTransactions."Transaction Type"::Deduction);
            EmployeeTransactions.SETFILTER("Transaction Code", '%1', 'D004');//E003
            IF NOT EmployeeTransactions.FIND('-') THEN BEGIN
                EmployeeTransactions.INIT;
                EmployeeTransactions."No." := "Employee No";
                EmployeeTransactions."Period Month" := CurMonth;
                EmployeeTransactions."Period Year" := CurYear;
                EmployeeTransactions."Payroll Period" := "Payroll Period";
                EmployeeTransactions."Transaction Code" := 'D004';
                EmployeeTransactions."Transaction Name" := 'Pension';
                EmployeeTransactions.Amount := PensionBenefit;
                EmployeeTransactions.validate(Amount);
                EmployeeTransactions."Transaction Type" := EmployeeTransactions."Transaction Type"::Deduction;
                EmployeeTransactions.INSERT(true);
            END;
            //END;

            //         InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
            //    'Pension Contribution ', PensionBenefit, PensionBenefit, 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
            //    "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
            //    '', Department, "co-op", LoanNo);//rkk


        END;

    end;

    local procedure ProcesSGroupLifeAssuarance("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; PayesNSSF: Boolean)
    var
        NSSFAmt: Decimal;
        "NSSFAmt(LCY)": Decimal;
        PayrollEmployee: Record "Payroll Employee_AU";
    begin
        GroupLifeAssuarance := 0;
        PensionAdministrativeFee := 0;
        PrEmployee.RESET;
        PrEmployee.SETRANGE(PrEmployee."No.", "Employee No");
        IF PrEmployee.FIND('-') THEN BEGIN
            //MESSAGE('%1-%2',EmpGrossPay,PayrollEmployee_AU."Pension %");
            GroupLifeAssuarance := Round(PrEmployee."Basic Pay" * PrEmployee."Group Life Assuarance" / 100, 0.01, '=');//+EmpNSSF;

            "Transaction Code" := 'Group Life As';
            TransDescription := 'Group Life As';
            "Transaction Type" := 'TAX CALCULATIONS';


            Grouping := 6;
            SubGrouping := 1;


            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
       'Group Life Assuarance ', GroupLifeAssuarance, GroupLifeAssuarance, 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
       "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
       '', Department, "co-op", LoanNo);//rkk


        END;

    end;

    local procedure ProcesSAdministrativeFee("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; PayesNSSF: Boolean)
    var
        NSSFAmt: Decimal;
        "NSSFAmt(LCY)": Decimal;
        PayrollEmployee: Record "Payroll Employee_AU";
    begin
        GroupLifeAssuarance := 0;
        PensionAdministrativeFee := 0;
        PrEmployee.RESET;
        PrEmployee.SETRANGE(PrEmployee."No.", "Employee No");
        IF PrEmployee.FIND('-') THEN BEGIN
            //MESSAGE('%1-%2',EmpGrossPay,PayrollEmployee_AU."Pension %");

            PensionAdministrativeFee := Round(PrEmployee."Basic Pay" * PrEmployee."Pension Administrative Fee" / 100, 0.01, '=');
            VatOnPension := Round(PensionAdministrativeFee * PrEmployee."VAT Administrative Fee" / 100, 0.01, '=');
            "Transaction Code" := 'Pension Admin Fee';
            TransDescription := 'Pension Admin Fee';
            "Transaction Type" := 'TAX CALCULATIONS';


            Grouping := 6;
            SubGrouping := 1;


            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
       'Pension Admin Fee ', PensionAdministrativeFee, PensionAdministrativeFee, 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
       "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
       '', Department, "co-op", LoanNo);//rkk

            InsertMonthlyTransactions("Employee No", 'VAT ON PENSION', "Transaction Type", Grouping, SubGrouping,
                'VAT on Pension ', VatOnPension, VatOnPension, 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
                "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
                '', Department, "co-op", LoanNo);//rkk

        END;

    end;


    local procedure ProcessEmployerNSSF("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; PayesNSSF: Boolean)
    var
        NSSFAmt: Decimal;
        ExpenseAccount: Code[20];
        "NSSFAmt(LCY)": Decimal;
        curProvident: Decimal;
        curProvTransAmount: Decimal;
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
        TransAmount: Decimal;
        PayrollEmployee: Record "Payroll Employee_AU";
    begin


    end;

    local procedure ProcessEmployerProvident("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    var
        NSSFAmt: Decimal;
        ExpenseAccount: Code[20];
        "NSSFAmt(LCY)": Decimal;
        curProvident: Decimal;
        curProvTransAmount: Decimal;
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
        TransAmount: Decimal;
    begin
        BasicPay := 0;
        currentAmount := 0;
        "currentAmount(LCY)" := 0;

        //IF PayesNSSF THEN BEGIN
        if PrEmployee.Get("Employee No") then
            BasicPay := PrEmployee."Basic Pay";

        currentAmount := Round(BasicPay * 0.15, 0.01, '=');
        "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');

        "Transaction Code" := TCODE_PFUND;
        TransDescription := 'PROVIDENT';
        "Transaction Type" := TCODE_PFUND;
        Grouping := 8;
        SubGrouping := 1;
        if PayrollPostingGroup.Get("Posting Group") then begin
            "Account Type" := "account type"::"G/L Account";
            "Account No." := PayrollPostingGroup."Provident Employee Acc";
            ExpenseAccount := PayrollPostingGroup."Provident Employer Acc"
        end;

        RemoveEmployerDeduction("Employee No", "Transaction Code", CurMonth, CurYear);
        //Insert Employer Deductions
        InsertEmployerDeductions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
        TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, CurMonth, CurYear, '', '', "Payroll Period", '');



    end;

    local procedure ProcessSHIF("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    var
        SHIFAmt: Decimal;
        ExpenseAccount: Code[20];
        "SHIFAmt(LCY)": Decimal;
        curSHIF: Decimal;
        curSHIFTransAmount: Decimal;
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
        TransAmount: Decimal;
    begin
        BasicPay := 0;
        currentAmount := 0;
        "currentAmount(LCY)" := 0;

        //IF PayesNSSF THEN BEGIN
        if PrEmployee.Get("Employee No") then
            BasicPay := PrEmployee."Basic Pay";

        currentAmount := Round(BasicPay * (2.75 / 100), 0.01, '=');
        "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');
        // Error('iko hapa: %1', currentAmount);
        "Transaction Code" := 'SHIF';
        TransDescription := 'Social Insuarance Fund';
        "Transaction Type" := 'TAX CALCULATIONS';
        Grouping := 8;
        SubGrouping := 7;
        if PayrollPostingGroup.Get("Posting Group") then begin
            "Account Type" := "account type"::"G/L Account";
            "Account No." := PayrollPostingGroup."SHIF Employee";
            ExpenseAccount := PayrollPostingGroup."SHIF Employer";
        end;

        // RemoveEmployerDeduction("Employee No", "Transaction Code", CurMonth, CurYear);
        //Insert Employer Deductions
        InsertEmployerDeductions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
        TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, CurMonth, CurYear, '', '', "Payroll Period", '');



    end;

    local procedure ProcessNHIF("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; PayesNHIF: Boolean)
    var
        NHIFAmt: Decimal;
        "NHIFAmt(LCY)": Decimal;
        PayrollEmployee: Record "Payroll Employee_AU";
        PremiumAmount1: Decimal;
    begin

        NHIFBaseAmount := 0;
        "NHIFBaseAmount(LCY)" := 0;
        EmpNHIF := 0;
        "EmpNHIF(LCY)" := 0;
        currentAmount := 0;
        "currentAmount(LCY)" := 0;

        if PayesNHIF = true then begin
            if NHIFBasedOn = Nhifbasedon::Gross then begin
                NHIFBaseAmount := EmpGrossPay;
                "NHIFBaseAmount(LCY)" := "EmpGrossPay(LCY)";
            end;
            if NHIFBasedOn = Nhifbasedon::Basic then begin
                NHIFBaseAmount := EmpBasicPay;
                "NHIFBaseAmount(LCY)" := "EmpBasicPay(LCY)";
            end;
            // EmpNHIF := CalculateNHIF(NHIFBaseAmount);
            // "EmpNHIF(LCY)" := CalculateNHIF("NHIFBaseAmount(LCY)");
            // currentAmount := EmpNHIF;
            // "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');
            // if PayesNHIF = false then EmpNHIF := 0;
            // "Transaction Code" := TCODE_NHIF;
            // TransDescription := 'N.H.I.F';
            // "Transaction Type" := TTYPE_STATUTORIES;
            // Grouping := 7;
            // SubGrouping := 2;
            // if PayrollPostingGroup.Get("Posting Group") then begin
            //     "Account Type" := "account type"::"G/L Account";
            //     "Account No." := PayrollPostingGroup."NHIF Employee Account";
            // end;

            // //Insert Into Monthly Transactions
            // InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
            // TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
            // "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
            // '', Department, "co-op", LoanNo);



            //premium calculation
            PremiumAmount1 := 0;
            PayrollEmployee.Reset;
            PayrollEmployee.SetRange(PayrollEmployee."No.", "Employee No");
            PayrollEmployee.SetRange("Suspend Pay", false);
            if PayrollEmployee.Find('-') then begin
                PremiumAmount1 := Round(PayrollEmployee.Premium * PayrollEmployee."Premium %" / 100, 0.01, '=');
            end;
            if PayrollPostingGroup.Get("Posting Group") then begin
                "Account Type" := "account type"::"G/L Account";
                "Account No." := PayrollPostingGroup."Premium Account";
            end;
            "Transaction Code" := 'Premium';
            TransDescription := 'Premium Amount';
            "Transaction Type" := TTYPE_STATUTORIES;
            Grouping := 7;
            SubGrouping := 2;

            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
            TransDescription, PremiumAmount1, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
            "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
            '', Department, "co-op", LoanNo);
        end;
    end;

    local procedure ProcessGrossTaxable()
    var
        PayrollEmployee_AU: Record "Payroll Employee_AU";
    begin
        EmpGrossTaxable := 0;
        "EmpGrossTaxable(LCY)" := 0;
        PayrollEmployee_AU.Reset();
        if PayrollEmployee_AU.Secondary = true then begin
            EmpGrossTaxable := EmpGrossPay;
            "EmpGrossTaxable(LCY)" := "EmpGrossPay(LCY)";
        end else
            //Get the Gross taxable amount
            EmpGrossTaxable := Round(EmpGrossPay + EmpBenefits + EmpValueOfQuarters, 0.01, '=');
        "EmpGrossTaxable(LCY)" := Round("EmpGrossPay(LCY)" + "EmpBenefits(LCY)" + "EmpValueOfQuarters(LCY)", 0.01, '=');

        //If EmpGrossTaxable = 0 Then DefinedContrib ToPost = 0
        if EmpGrossTaxable = 0 then EmpDefinedContrib := 0;
        if "EmpGrossTaxable(LCY)" = 0 then "EmpDefinedContrib(LCY)" := 0;
    end;

    local procedure ProcessPersonalRelief("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    var
        PayrollEmployee_AU: Record "Payroll Employee_AU";
    begin
        "Transaction Code" := 'PSNR';
        "Transaction Type" := 'TAX CALCULATIONS';
        Grouping := 6;
        SubGrouping := 9;
        TransDescription := 'Personal Relief';
        EmpPersonalRelief := 0;
        "EmpPersonalRelief(LCY)" := 0;

        EmpPersonalRelief := PersonalRelief + EmpUnusedRelief;
        "EmpPersonalRelief(LCY)" := "PersonalRelief(LCY)" + "EmpUnusedRelief(LCY)";

        if PayrollEmployee_AU.Get("Employee No") then
            //     EmpPersonalRelief := PayrollEmployee_AU."Personal Relief AMount";
            // "EmpPersonalRelief(LCY)" := PayrollEmployee_AU."Personal Relief AMount";

            // EmpPersonalRelief := EmpPersonalRelief;//+PayrollEmployee_AU."Mortgage Relief";
            // "EmpPersonalRelief(LCY)" := "EmpPersonalRelief(LCY)";//+PayrollEmployee_AU."Mortgage Relief";
            if PayrollEmployee_AU.Secondary = true then begin
                currentAmount := 0;
                "currentAmount(LCY)" := 0;
            end else begin


                currentAmount := EmpPersonalRelief;
                "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');
            end;
        "Account Type" := "account type"::"G/L Account";
        "Account No." := '';
        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
         TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
         "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
         '', Department, "co-op", LoanNo);


        // //insertp10
        P10.RESET;
        P10.SETRANGE(P10."Employee No", "Employee No");
        P10.SETRANGE(P10."Payroll Preriod", "Payroll Period");
        IF P10.FIND('-') THEN BEGIN

            P10."Personal Relief" := currentAmount;
            P10.Modify(true);
        end;


        //morgage relief
        "Transaction Code" := 'Mortgage';
        "Transaction Type" := 'TAX CALCULATIONS';
        Grouping := 6;
        SubGrouping := 9;
        TransDescription := 'Mortgage Relief';
        EmpPersonalRelief2 := 0;
        "EmpPersonalRelief(LCY)2" := 0;

        // EmpPersonalRelief := PersonalRelief + EmpUnusedRelief;
        // "EmpPersonalRelief(LCY)" := "PersonalRelief(LCY)" + "EmpUnusedRelief(LCY)";//rkk

        if PayrollEmployee_AU.Get("Employee No") then
            EmpPersonalRelief2 := PayrollEmployee_AU."Mortgage Relief";
        "EmpPersonalRelief(LCY)2" := PayrollEmployee_AU."Mortgage Relief";

        // EmpPersonalRelief := EmpPersonalRelief;//+PayrollEmployee_AU."Mortgage Relief";
        // "EmpPersonalRelief(LCY)" := "EmpPersonalRelief(LCY)";//+PayrollEmployee_AU."Mortgage Relief";


        currentAmount := EmpPersonalRelief2;
        "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');

        "Account Type" := "account type"::"G/L Account";
        "Account No." := '';
        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
         TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
         "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
         '', Department, "co-op", LoanNo);



        //   // //insertp10
        // P10.RESET;
        // P10.SETRANGE(P10."Employee No", "Employee No");
        // P10.SETRANGE(P10."Payroll Preriod", "Payroll Period");
        // IF P10.FIND('-') THEN BEGIN

        //     P10."Personal Relief" := currentAmount;
        //     P10.Modify(true);
        // end;
    end;

    local procedure ProcessTaxablePay("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    var
        PayrollEmployee: Record "Payroll Employee_AU";
        ExcessPensio: Decimal;
    begin
        ///MESSAGE(FORMAT(MaxPensionContrib));
        "Transaction Code" := 'TXBP';
        "Transaction Type" := 'TAX CALCULATIONS';
        Grouping := 6;
        SubGrouping := 6;
        TransDescription := 'Taxable Pay';
        EmpTaxableEarning := 0;
        "EmpTaxableEarning(LCY)" := 0;
        ExcessPensio := 0;



        ///   ProcessPersonalRelief("Employee No","Payroll Period","Posting Group",BasicPay,"BasicPay(LCY)","Currency Code","Currency Factor","Joining Date","Leaving Date",
        // BasedOnTimeSheet,"Global Dimension 1 Code","Global Dimension 2 Code",Department);









        if curPensionStaff > MaxPensionContrib then
            EmpTaxableEarning := EmpGrossTaxable - (EmpSalaryArrear + EmpDefinedContrib + EmpOOI + EmpHOSP + EmpNonTaxable + EmployeehousingLeavy)//+ MaxPensionContrib 

        else
            //ERROR(FORMAT(EmpGrossTaxable));
        EmpTaxableEarning := EmpGrossTaxable - (EmpSalaryArrear + EmpDefinedContrib + curPensionStaff + EmpOOI + EmpHOSP + EmpNonTaxable + EmployeehousingLeavy);


        // Message('%1', EmpTaxableEarning);
        EmployeeTransactions.Reset;
        EmployeeTransactions.SetRange("No.", "Employee No");
        EmployeeTransactions.SetRange("Payroll Period", "Payroll Period");
        EmployeeTransactions.SetRange("Transaction Code", 'PENSION');
        if EmployeeTransactions.FindFirst then
            EmpTaxableEarning := EmpTaxableEarning - EmployeeTransactions.Amount;


        if "Currency Code" <> '' then
            "EmpTaxableEarning(LCY)" := CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", EmpTaxableEarning, "Currency Factor")
        else
            "EmpTaxableEarning(LCY)" := EmpTaxableEarning;


        //deal with pension
        PrEmployee.Get("Employee No");

        //cater for employer pernsion max of 19,600
        //Message('non taxa%1', MaximumNonTaxablePension);
        if PrEmployee."Global Dimension 1" = 'KENYA' THEN begin
            PensionBenefit := 0;
            PensionEmployer := 0;
            PensionAddedBack := 0;
            TotalPensionBenefit := 0;
            PensionBenefit := (PrEmployee."Pension %-Employee" / 100) * (PrEmployee."Basic Pay");
            PensionEmployer := (PrEmployee."Pension %-Employer" / 100) * (PrEmployee."Basic Pay");//+ EmpNSSF;
            TotalPensionBenefit := PensionBenefit + PensionEmployer;//+ (EmpNSSF) * 2;
            if TotalPensionBenefit > MaxPensionContrib then begin
                PensionAddedBack := TotalPensionBenefit - MaxPensionContrib;
            end;
            if (PensionBenefit + (EmpNSSF)) > MaxPensionContrib then begin
                ExcessPensio := (PensionEmployer + (EmpNSSF));//- MaxPensionContrib;
            end else
                ExcessPensio := 0;
            //   Message('Excess Pension %1 - Pension%2-%3', ExcessPensio, TotalPensionBenefit, MaxPensionContrib);


            //CREATE INCOME AND DEDUCTION
            EmployeeTransactions.RESET;
            EmployeeTransactions.SETRANGE(EmployeeTransactions."No.", "Employee No");
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Month", CurMonth);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Year", CurYear);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Transaction Type", EmployeeTransactions."Transaction Type"::Income);
            EmployeeTransactions.SETFILTER("Transaction Code", '%1', 'E003');//E003
            IF EmployeeTransactions.FIND('-') THEN BEGIN
                EmployeeTransactions.Delete();
            END;
            EmployeeTransactions.RESET;
            EmployeeTransactions.SETRANGE(EmployeeTransactions."No.", "Employee No");
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Month", CurMonth);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Year", CurYear);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Transaction Type", EmployeeTransactions."Transaction Type"::Income);
            EmployeeTransactions.SETFILTER("Transaction Code", '%1', 'E003');//E003
            IF NOT EmployeeTransactions.FIND('-') THEN BEGIN
                EmployeeTransactions.INIT;
                EmployeeTransactions."No." := "Employee No";
                EmployeeTransactions."Period Month" := CurMonth;
                EmployeeTransactions."Period Year" := CurYear;
                EmployeeTransactions."Payroll Period" := "Payroll Period";
                EmployeeTransactions."Transaction Code" := 'E003';
                EmployeeTransactions."Transaction Name" := 'Pension Excess';
                EmployeeTransactions.Amount := ExcessPensio;
                EmployeeTransactions.validate(Amount);
                EmployeeTransactions."Transaction Type" := EmployeeTransactions."Transaction Type"::Income;
                if not EmployeeTransactions.INSERT(true) then EmployeeTransactions.Modify(true);
            END;
            //end earning

            EmployeeTransactions.RESET;
            EmployeeTransactions.SETRANGE(EmployeeTransactions."No.", "Employee No");
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Month", CurMonth);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Year", CurYear);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Transaction Type", EmployeeTransactions."Transaction Type"::Deduction);
            EmployeeTransactions.SETFILTER("Transaction Code", '%1', 'D009');//E003
            IF EmployeeTransactions.FIND('-') THEN BEGIN
                EmployeeTransactions.Delete();
            END;

            EmployeeTransactions.RESET;
            EmployeeTransactions.SETRANGE(EmployeeTransactions."No.", "Employee No");
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Month", CurMonth);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Year", CurYear);
            EmployeeTransactions.SETRANGE(EmployeeTransactions."Transaction Type", EmployeeTransactions."Transaction Type"::Deduction);
            EmployeeTransactions.SETFILTER("Transaction Code", '%1', 'D009');//E003
            IF NOT EmployeeTransactions.FIND('-') THEN BEGIN
                EmployeeTransactions.INIT;
                EmployeeTransactions."No." := "Employee No";
                EmployeeTransactions."Period Month" := CurMonth;
                EmployeeTransactions."Period Year" := CurYear;
                EmployeeTransactions."Payroll Period" := "Payroll Period";
                EmployeeTransactions."Transaction Code" := 'D009';
                EmployeeTransactions."Transaction Name" := 'Pension Excess';
                EmployeeTransactions.Amount := ExcessPensio;
                EmployeeTransactions.validate(Amount);
                EmployeeTransactions."Transaction Type" := EmployeeTransactions."Transaction Type"::Deduction;
                if not EmployeeTransactions.INSERT(true) then EmployeeTransactions.Modify(true);
            END;
        END;
        //edn dedudction
        Voluntaryp := 0;
        PayrollTransactionCode_AU.Reset;
        PayrollTransactionCode_AU.SetRange("Is Pension", true);
        if PayrollTransactionCode_AU.FindSet then begin
            repeat
                PayrollEmployeeTrans_AU6.Reset;
                PayrollEmployeeTrans_AU6.SetRange("No.", "Employee No");
                PayrollEmployeeTrans_AU6.SetRange("Transaction Code", PayrollTransactionCode_AU."Transaction Code");
                if PayrollEmployeeTrans_AU6.FindFirst then
                    Voluntaryp := Voluntaryp + PayrollEmployeeTrans_AU6.Amount;
            until PayrollTransactionCode_AU.Next = 0;
        end;

        if PrEmployee."Global Dimension 1" = 'KENYA' THEN begin

            if PrEmployee.Secondary = true then begin
                EmpTaxableEarning := Round(EmpTaxableEarning, 0.01, '=');

            end else
                //Message('%1-%2-%3-%4', EmpTaxableEarning, TotalPensionBenefit, MaxPensionContrib, PensionBenefit);
                if PensionBenefit > MaxPensionContrib then begin
                    EmpTaxableEarning := Round(EmpTaxableEarning - (MaxPensionContrib + SHIF), 0.01, '=')//+ EmpNSSF
                end else
                    EmpTaxableEarning := Round(EmpTaxableEarning - (PensionBenefit + EmpNSSF + SHIF), 0.01, '=');
        END;
        if PrEmployee."Global Dimension 1" = 'MALAWI' THEN begin
            EmpTaxableEarning := Round(EmpTaxableEarning, 0.01, '=');
        END;


        PrEmployee.Get("Employee No");
        EmpTaxableEarning := EmpTaxableEarning - PrEmployee."Mortgage Relief";








        currentAmount := EmpTaxableEarning;
        "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');



        PayrollMonthlyTrans_AU.Reset;
        PayrollMonthlyTrans_AU.SetRange(PayrollMonthlyTrans_AU."No.", "Employee No");
        PayrollMonthlyTrans_AU.SetRange(PayrollMonthlyTrans_AU."Payroll Period", "Payroll Period");
        PayrollMonthlyTrans_AU.SetRange(PayrollMonthlyTrans_AU."Transaction Code", 'NSSF');
        if PayrollMonthlyTrans_AU.Find('-') then begin
            // "EmpTaxableEarning(LCY)" := "EmpTaxableEarning(LCY)" - PayrollMonthlyTrans_AU.Amount;
            // EmpTaxableEarning := EmpTaxableEarning - PayrollMonthlyTrans_AU.Amount;
            // currentAmount := currentAmount - PayrollMonthlyTrans_AU.Amount;
            //"currentAmount(LCY)" := "currentAmount(LCY)" - PayrollMonthlyTrans_AU.Amount;
            //MESSAGE('%1',PayrollMonthly.Amount);
            // CommuterAllowance:=PayrollMonthly.Amount;
        end;



        PayrollMonthly.Reset;
        PayrollMonthly.SetRange(PayrollMonthly."No.", "Employee No");
        PayrollMonthly.SetRange(PayrollMonthly."Payroll Period", "Payroll Period");
        PayrollMonthly.SetRange(PayrollMonthly."Transaction Code", 'OOII');
        if PayrollMonthly.Find('-') then begin
            currentAmount := currentAmount - PayrollMonthly.Amount;
            "currentAmount(LCY)" := "currentAmount(LCY)" - PayrollMonthly.Amount;
            //MESSAGE('%1',PayrollMonthly.Amount);
            // CommuterAllowance:=PayrollMonthly.Amount;
        end;

        PayrollMonthly.Reset;
        PayrollMonthly.SetRange(PayrollMonthly."No.", "Employee No");
        PayrollMonthly.SetRange(PayrollMonthly."Payroll Period", "Payroll Period");
        PayrollMonthly.SetRange(PayrollMonthly."Transaction Code", 'HL');
        if PayrollMonthly.Find('-') then begin
            currentAmount := currentAmount - PayrollMonthly.Amount;
            "currentAmount(LCY)" := "currentAmount(LCY)" - PayrollMonthly."Amount(LCY)";
            //MESSAGE('%1',PayrollMonthly.Amount);
            // CommuterAllowance:=PayrollMonthly.Amount;
            PrEmployee.Get("Employee No");
            EmpTaxableEarning := EmpTaxableEarning - PayrollMonthly.Amount;
        end;




        "Account Type" := "account type"::"G/L Account";
        "Account No." := '';

        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
        TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
        "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
        '', Department, "co-op", LoanNo);



        Grouping := 6;
        SubGrouping := 9;
        if "Global Dimension 1 Code" = 'KENYA' then begin
            if InsuranceAmount > 0 then
                InsertMonthlyTransactions("Employee No", 'INSRLF', "Transaction Type", Grouping, SubGrouping,
                'Insurance Relief ', InsuranceAmount, InsuranceAmount, 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
                "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
                '', Department, "co-op", LoanNo);
        end;



        //insertp10
        P10.RESET;
        P10.SETRANGE(P10."Employee No", "Employee No");
        P10.SETRANGE(P10."Payroll Preriod", "Payroll Period");
        IF P10.FIND('-') THEN BEGIN

            P10."Insurance Relief" := InsuranceAmount;
            P10.Modify(true);
        end;
        // Message('%1-%2', EmpTaxableEarning, "Employee No");
    end;


    local procedure ProcessPartTimeEmpPAYE("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; Secondary: Boolean; GetsPayeBenefit: Boolean; PayeBenefitPercent: Decimal)
    var
        PayrollEmployee: Record "Payroll Employee_AU";
    begin
        //Get the Tax charged for the month


        "Transaction Code" := 'TXCHRG';
        "Transaction Type" := 'TAX CALCULATIONS';
        Grouping := 6;
        SubGrouping := 7;
        TransDescription := 'Tax Charged';
        EmpTaxCharged := 0;
        "EmpTaxCharged(LCY)" := 0;

        //Message('%1-%2', EmpTaxableEarning, "Employee No");
        EmpTaxCharged := CalculatePartTimePAYE(EmpTaxableEarning, true);

        if "Currency Code" <> '' then
            "EmpTaxCharged(LCY)" := CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", EmpTaxCharged, "Currency Factor")
        else
            "EmpTaxCharged(LCY)" := EmpTaxCharged;

        currentAmount := (EmpTaxCharged);
        "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');

        "Account Type" := "account type"::"G/L Account";
        "Account No." := '';
        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
        TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
        "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
        '', Department, "co-op", LoanNo);

        //Insert PAYE amount to post for the month
        "Transaction Code" := 'PAYE';
        "Transaction Type" := 'STATUTORIES';
        Grouping := 7;
        SubGrouping := 3;
        TransDescription := 'P.A.Y.E';
        EmpPaye := 0;
        "EmpPaye(LCY)" := 0;

        if (EmpPersonalRelief + InsuranceReliefAmount) > MaximumRelief then begin
            EmpPaye := Round(EmpTaxCharged - MaximumRelief, 0.01, '=');
            "EmpPaye(LCY)" := Round("EmpTaxCharged(LCY)" - "MaximumRelief(LCY)", 1, '=');
        end else begin

            EmpPaye := Round(EmpTaxCharged - (EmpPersonalRelief + InsuranceRelief + InsuranceAmount), 0.01, '=');
            "EmpPaye(LCY)" := Round("EmpTaxCharged(LCY)" - ("EmpPersonalRelief(LCY)" + InsuranceRelief + InsuranceAmount), 0.01, '=');
        end;

        //If EmpPaye>0 then "Insert into MonthlyTrans table
        if EmpPaye > 0 then begin
            currentAmount := Round(EmpPaye, 0.01, '=');
            "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');

            if PayrollPostingGroup.Get("Posting Group") then begin
                "Account Type" := "account type"::"G/L Account";
                "Account No." := PayrollPostingGroup."Income Tax Account";
            end;
            //Insert Into Monthly Transactions
            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
             TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
             "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
             '', Department, "co-op", LoanNo);

            //insertp10
            P10.RESET;
            P10.SETRANGE(P10."Employee No", "Employee No");
            P10.SETRANGE(P10."Payroll Preriod", "Payroll Period");
            IF P10.FIND('-') THEN BEGIN

                P10.PAYE := currentAmount;
                P10.Modify(true);
            end;
        end;

        //If EmpPaye<0 then "Insert into Uuused Relif table
        if EmpPaye < 0 then begin
            UnusedRelief.Reset;
            UnusedRelief.SetRange(UnusedRelief."Employee No.", "Employee No");
            UnusedRelief.SetRange(UnusedRelief."Period Month", CurMonth);
            UnusedRelief.SetRange(UnusedRelief."Period Year", CurYear);
            if UnusedRelief.FindSet then
                UnusedRelief.Delete;

            UnusedRelief.Reset;
            with UnusedRelief do begin
                Init;
                "Employee No." := "Employee No";
                "Unused Relief" := EmpPaye;
                "Unused Relief(LCY)" := "EmpPaye(LCY)";
                "Period Month" := CurMonth;
                "Period Year" := CurYear;
                Insert;
            end;
        end;

        //PAYE Benefit
        if GetsPayeBenefit then begin
            "Transaction Code" := 'PAYEBEN';
            "Transaction Type" := 'STATUTORIES';
            Grouping := 7;
            SubGrouping := 10;
            TransDescription := 'P.A.Y.E Benefit';
            EmpPayeBenefit := 0;
            "EmpPayeBenefit(LCY)" := 0;

            EmpPayeBenefit := Round(EmpPaye * (PayeBenefitPercent / 100), 0.01, '=');
            "EmpPayeBenefit(LCY)" := Round("EmpPaye(LCY)" * (PayeBenefitPercent / 100), 0.01, '=');

            currentAmount := (EmpPayeBenefit);
            "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');
            if PayrollPostingGroup.Get("Posting Group") then begin
                "Account Type" := "account type"::"G/L Account";
                "Account No." := PayrollPostingGroup."PAYE Benefit A/C";
            end;
            //Insert Into Monthly Transactions
            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
             TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
             "Account No.", "posting type"::Debit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
             '', Department, "co-op", LoanNo);
        end;
        //insertp10
        P10.RESET;
        P10.SETRANGE(P10."Employee No", "Employee No");
        P10.SETRANGE(P10."Payroll Preriod", "Payroll Period");
        IF P10.FIND('-') THEN BEGIN

            P10.PAYE := currentAmount;
            P10.Modify(true);
        end;
    end;

    local procedure ProcessEmpPAYE("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20]; Secondary: Boolean; GetsPayeBenefit: Boolean; PayeBenefitPercent: Decimal)
    var
        PayrollEmployee: Record "Payroll Employee_AU";
    begin
        //Get the Tax charged for the month


        "Transaction Code" := 'TXCHRG';
        "Transaction Type" := 'TAX CALCULATIONS';
        Grouping := 6;
        SubGrouping := 7;
        TransDescription := 'Tax Charged';
        EmpTaxCharged := 0;
        "EmpTaxCharged(LCY)" := 0;

        //EmpTaxCharged := 0.05 * EmpGrossPay;
        // Message('%1', EmpTaxableEarning);
        if Secondary = false then begin
            EmpTaxCharged := CalculatePAYE(EmpTaxableEarning, false);
        end else begin
            EmpTaxCharged := CalculatePAYES(EmpTaxableEarning, false);
        end;

        currentAmount := Round((EmpTaxCharged), 0.01, '=');
        "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');

        "Account Type" := "account type"::"G/L Account";
        "Account No." := '';
        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
        TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
        "Account No.", "posting type"::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", '',
        '', Department, "co-op", LoanNo);

        //Insert PAYE amount to post for the month
        "Transaction Code" := 'PAYE';
        "Transaction Type" := 'STATUTORIES';
        Grouping := 7;
        SubGrouping := 3;
        TransDescription := 'P.A.Y.E';
        EmpPaye := 0;
        "EmpPaye(LCY)" := 0;
        if Secondary = true then begin
            EmpPaye := round(EmpTaxCharged, 0.01, '=');
        end else
            EmpPaye := round(EmpTaxCharged - EmpPersonalRelief - InsuranceAmount, 0.01, '=');
        currentAmount := Round(EmpPaye, 0.01, '=');
        "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');


        if PayrollPostingGroup.Get("Posting Group") then begin
            "Account Type" := "account type"::"G/L Account";
            "Account No." := PayrollPostingGroup."Income Tax Account";
        end;
        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
         TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
         "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
         '', Department, "co-op", LoanNo);
        //END;


        //PAYE Benefit
        if GetsPayeBenefit then begin
            "Transaction Code" := 'PAYEBEN';
            "Transaction Type" := 'STATUTORIES';
            Grouping := 7;
            SubGrouping := 10;
            TransDescription := 'P.A.Y.E Benefit';
            EmpPayeBenefit := 0;
            "EmpPayeBenefit(LCY)" := 0;

            EmpPayeBenefit := EmpPaye * (PayeBenefitPercent / 100);
            "EmpPayeBenefit(LCY)" := "EmpPaye(LCY)" * (PayeBenefitPercent / 100);

            currentAmount := Round(EmpPayeBenefit, 0.01, '=');
            "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');
            if PayrollPostingGroup.Get("Posting Group") then begin
                "Account Type" := "account type"::"G/L Account";
                "Account No." := PayrollPostingGroup."PAYE Benefit A/C";
            end;
            //Insert Into Monthly Transactions
            InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
             TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
             "Account No.", "posting type"::Debit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
             '', Department, "co-op", LoanNo);
        end;
        //insertp10
        P10.RESET;
        P10.SETRANGE(P10."Employee No", "Employee No");
        P10.SETRANGE(P10."Payroll Preriod", "Payroll Period");
        IF P10.FIND('-') THEN BEGIN

            P10.PAYE := currentAmount;
            P10.Modify(true);
        end;
    end;

    local procedure ProcessTotalDeds("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    var
        PayrollEmployee: Record "Payroll Employee_AU";
    begin
        "Transaction Code" := 'Tot_Ded';
        "Transaction Type" := 'Deductions';
        Grouping := 8;
        SubGrouping := 9;
        TransDescription := 'Total Deductions';
        EmpTotDed := 0;
        "EmpTotDed(LCY)" := 0;

        PayrollEmployee.Reset;
        PayrollEmployee.SetRange(PayrollEmployee."No.", "Employee No");
        PayrollEmployee.SetRange(PayrollEmployee."Pays NSSF", true);
        if PayrollEmployee.FindFirst then begin
            EmpNSSF := EmpNSSF;

        end else begin
            EmpNSSF := 0;
        end;

        PayrollEmployee.Reset;
        PayrollEmployee.SetRange(PayrollEmployee."No.", "Employee No");
        PayrollEmployee.SetRange(PayrollEmployee."Pays NHIF", true);
        if PayrollEmployee.FindFirst then begin
            EmpNHIF := EmpNHIF;

        end else begin
            EmpNHIF := 0;
        end;

        EmpTotDed := Round(EmpNSSF, 0.01, '=') + Round(EmpNHIF, 0.01, '=') + Round(EmpPaye, 0.01, '=') + Round(EmpPAYEArrears, 0.01, '=') + Round(EmpDeduction, 0.01, '=');// + Round(TotEmpBenefit, 0.01, '='));//+ Round(PensionBenefit, 1, '=')
        "EmpTotDed(LCY)" := Round("EmpNSSF(LCY)", 0.01, '=') + Round("EmpNHIF(LCY)", 0.01, '=') + Round("EmpPaye(LCY)", 0.01, '=') + Round("EmpPAYEArrears(LCY)", 0.01, '=') + Round("EmpDeduction(LCY)", 0.01, '=');

        //Subtract net pay
        // EmployeeTransactions.Reset;
        // EmployeeTransactions.SetRange("No.", "Employee No");
        // EmployeeTransactions.SetRange("Transaction Code", 'EXCESS PEN');
        // EmployeeTransactions.SetRange("Payroll Period", "Payroll Period");
        // if EmployeeTransactions.FindFirst then begin
        //     //IF "Employee No"='0049' THEN MESSAGE('%1',EmployeeTransactions.Amount);
        //     EmpNetPay := Round(EmpNetPay - EmployeeTransactions.Amount, 1, '=');
        //     "EmpNetPay(LCY)" := "EmpNetPay(LCY)" - EmployeeTransactions.Amount;
        // end;


        currentAmount := EmpTotDed;
        "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');
        //Error('%1 Empded, %2 empded(LCY)', EmpTotDed, "EmpTotDed(LCY)");
        if PayrollPostingGroup.Get("Posting Group") then begin
            "Account Type" := "account type"::"G/L Account";
            "Account No." := PayrollPostingGroup.TotalDed;
        end;
        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
           TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
           "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
           '', Department, "co-op", LoanNo);
    end;


    local procedure ProcessNetPay("Employee No": Code[20]; "Payroll Period": Date; "Posting Group": Code[20]; BasicPay: Decimal; "BasicPay(LCY)": Decimal; "Currency Code": Code[20]; "Currency Factor": Decimal; "Joining Date": Date; "Leaving Date": Date; BasedOnTimeSheet: Boolean; "Global Dimension 1 Code": Code[20]; "Global Dimension 2 Code": Code[20]; Department: Code[20])
    var
        PayrollEmployee: Record "Payroll Employee_AU";
    begin
        "Transaction Code" := 'NPAY';
        "Transaction Type" := 'NET PAY';
        Grouping := 9;
        SubGrouping := 0;
        TransDescription := 'Net Pay';
        EmpNetPay := 0;
        "EmpNetPay(LCY)" := 0;

        PayrollEmployee.Reset;
        PayrollEmployee.SetRange(PayrollEmployee."No.", "Employee No");
        PayrollEmployee.SetRange(PayrollEmployee."Pays NSSF", true);
        if PayrollEmployee.FindFirst then begin
            EmpNSSF := EmpNSSF;

        end else begin
            EmpNSSF := 0;
        end;

        EmpNetPay := EmpGrossPay - (Round(EmpNSSF, 0.01, '=') + Round(EmpNHIF, 0.01, '=') + Round(EmpPaye, 0.01, '=') + Round(EmpPAYEArrears, 0.01, '=') + Round(EmpDeduction, 0.01, '='));// + Round(TotEmpBenefit, 0.01, '='));//+ Round(PensionBenefit, 1, '=')
        "EmpNetPay(LCY)" := "EmpGrossPay(LCY)" - (Round("EmpNSSF(LCY)", 0.01, '=') + Round("EmpNHIF(LCY)", 0.01, '=') + Round("EmpPaye(LCY)", 0.01, '=') + Round("EmpPAYEArrears(LCY)", 0.01, '=') + Round("EmpDeduction(LCY)", 0.01, '='));

        //Subtract net pay
        // EmployeeTransactions.Reset;
        // EmployeeTransactions.SetRange("No.", "Employee No");
        // EmployeeTransactions.SetRange("Transaction Code", 'EXCESS PEN');
        // EmployeeTransactions.SetRange("Payroll Period", "Payroll Period");
        // if EmployeeTransactions.FindFirst then begin
        //     //IF "Employee No"='0049' THEN MESSAGE('%1',EmployeeTransactions.Amount);
        //     EmpNetPay := Round(EmpNetPay - EmployeeTransactions.Amount, 1, '=');
        //     "EmpNetPay(LCY)" := "EmpNetPay(LCY)" - EmployeeTransactions.Amount;
        // end;


        currentAmount := (EmpNetPay + (EmpPayeBenefit));
        "currentAmount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Payroll Period", "Currency Code", currentAmount, "Currency Factor"), 0.01, '<');

        if PayrollPostingGroup.Get("Posting Group") then begin
            "Account Type" := "account type"::"G/L Account";
            "Account No." := PayrollPostingGroup."Net Salary Payable-Contract";
        end;
        //Insert Into Monthly Transactions
        InsertMonthlyTransactions("Employee No", "Transaction Code", "Transaction Type", Grouping, SubGrouping,
           TransDescription, currentAmount, "currentAmount(LCY)", 0, 0, "Payroll Period", CurMonth, CurYear, "Account Type",
           "Account No.", "posting type"::Credit, "Global Dimension 1 Code", "Global Dimension 2 Code", '',
           '', Department, "co-op", LoanNo);
    end;

    local procedure CalculateProratedAmount("Employee No": Code[20]; "Basic Pay": Decimal; "Payroll Month": Integer; "Payroll Year": Integer; DaysInMonth: Integer; DaysWorked: Integer) Amount: Decimal
    begin
        PrEmployee2.Get("Employee No");
        if PrEmployee2."Do not prorate Again" = true then
            Amount := "Basic Pay"
        else
            Amount := ROUND((DaysWorked / DaysInMonth) * "Basic Pay");
    end;


    procedure GetDaysInMonth(dtDate: Date) DaysInMonth: Integer
    var
        Day: Integer;
        SysDate: Record Date;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
    begin
        TodayDate := dtDate;

        Day := Date2dmy(TodayDate, 1);
        Expr1 := Format(-Day) + 'D+1D';
        FirstDay := CalcDate(Expr1, TodayDate);
        LastDate := CalcDate('1M-1D', FirstDay);

        SysDate.Reset;
        SysDate.SetRange(SysDate."Period Type", SysDate."period type"::Date);
        SysDate.SetRange(SysDate."Period Start", FirstDay, LastDate);
        if SysDate.FindSet then
            DaysInMonth := SysDate.Count;
    end;


    procedure GetDaysWorked(dtDate: Date; IsTermination: Boolean) DaysWorked: Integer
    var
        Day: Integer;
        SysDate: Record Date;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
    begin
        TodayDate := dtDate;

        Day := Date2dmy(TodayDate, 1);
        Expr1 := Format(-Day) + 'D+1D';
        FirstDay := CalcDate(Expr1, TodayDate);
        LastDate := CalcDate('1M-1D', FirstDay);

        SysDate.Reset;
        SysDate.SetRange(SysDate."Period Type", SysDate."period type"::Date);
        if not IsTermination then
            SysDate.SetRange(SysDate."Period Start", dtDate, LastDate)
        else
            SysDate.SetRange(SysDate."Period Start", FirstDay, dtDate);
        if SysDate.FindSet then
            DaysWorked := SysDate.Count;
    end;


    procedure GetDaysWorkedTimesheet(EmployeeNo: Code[20]; PayrollPeriod: Date) DaysWorked: Integer
    var
        Day: Integer;
        SysDate: Record Date;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
        BaseCalender: Record "Base Calendar";
        BaseCalenderLines: Record "Base Calendar Change";
        NonWorkingDays: Integer;
        DayDate: Date;
        DayName: Text;
        Nonworking: Boolean;
        CalendarMgmt: Codeunit "Calendar Management";
    begin
        /* DaysWorked:=0;NonWorkingDays:=0;
         EmployeeTimesheet.RESET;
         EmployeeTimesheet.SETRANGE(EmployeeTimesheet."Employee No",EmployeeNo);
         EmployeeTimesheet.SETRANGE(EmployeeTimesheet."Period Month",DATE2DMY(PayrollPeriod,2));
         EmployeeTimesheet.SETRANGE(EmployeeTimesheet."Period Year",DATE2DMY(PayrollPeriod,3));
         IF EmployeeTimesheet.FINDSET THEN BEGIN
          REPEAT
             DaysWorked:=DaysWorked+1;
          UNTIL EmployeeTimesheet.NEXT=0;
         END;
         //Get Nonworking Days
         //Get the HR Base Calender
         IF HRSetup.GET THEN BEGIN
          FirstDay:=PayrollPeriod;
          LastDate:=CALCDATE('<CM>',FirstDay);
          SysDate.RESET;
          SysDate.SETRANGE(SysDate."Period Type",SysDate."Period Type"::Date);
          SysDate.SETRANGE(SysDate."Period Start",FirstDay,LastDate);
          IF SysDate.FINDSET THEN BEGIN
            REPEAT
              Nonworking := CalendarMgmt.CheckDateStatus(HRSetup."HR Base Calender",SysDate."Period Start",Description);
              IF Nonworking THEN
                NonWorkingDays:=NonWorkingDays+1;
            UNTIL SysDate.NEXT=0;
          END;
         END;
         //return days worked + non working days
         DaysWorked:=DaysWorked+NonWorkingDays;
         */

    end;

    local procedure CalculatePartTimePAYE(TaxablePay: Decimal; IsSecondary: Boolean) PAYE: Decimal
    var
        PAYESetup: Record "Payroll PAYE Setup_AU";
        TempAmount: Decimal;
        "Count": Integer;
        PayGenSetup: Record "Payroll General Setup_AU";
    begin
        if PayGenSetup.Get then
            if PayGenSetup."Use Another Tax Bracket" = true then
                PAYE := TaxablePay * (PayGenSetup."Tax Bracket %" / 100);
    end;

    local procedure CalculatePAYES(TaxablePay: Decimal; IsSecondary: Boolean) PAYE: Decimal
    var
        PAYESetup: Record "Payroll PAYE Setup_AU";
        TempAmount: Decimal;
        "Count": Integer;
        PayGenSetup: Record "Payroll General Setup_AU";
    begin

        // IF PAYESetup.FINDLAST THEN BEGIN
        PAYE := EmpGrossPay * (32.5 / 100);
        // Message('Gross: %1, %rate: %2', EmpGrossPay, PAYESetup.Rate);
        // end;
    end;

    local procedure CalculatePAYE(TaxablePay: Decimal; IsSecondary: Boolean) PAYE: Decimal
    var
        PAYESetup: Record "Payroll PAYE Setup_AU";
        TempAmount: Decimal;
        "Count": Integer;
        PayrollEmployee: Record "Payroll Employee_AU";
    begin
        // PAYESetup.Reset;
        // PAYESetup.SetFilter(Rate, '>%1', 0);
        // if PAYESetup.FindLast then begin

        //     TaxablePay := TaxablePay * (PAYESetup.Rate / 100);
        //     PAYE := TaxablePay * (PAYESetup.Rate / 100);
        // end;
        /*
        {IF CURRTOUSE<18000 THEN
         TaxablePay:=TaxablePay-NSSFtoUSE2;}
        */
        // PayrollEmployee.Reset();
        // if PayrollEmployee.Secondary = true then begin
        //     IF PAYESetup.FINDLAST THEN BEGIN
        //         PAYE := EmpGrossPay * (PAYESetup.Rate / 100);
        //         Message('Gross: %1, %rate: %2', EmpGrossPay, PAYESetup.Rate);
        //     END;

        // end else
        Count := 0;
        PAYESetup.RESET;
        IF IsSecondary = FALSE THEN BEGIN
            IF PAYESetup.FINDFIRST THEN BEGIN
                IF TaxablePay < PAYESetup."PAYE Tier" THEN EXIT;
                REPEAT
                    Count += 1;
                    TempAmount := TaxablePay;
                    IF TaxablePay = 0 THEN EXIT;
                    IF Count = PAYESetup.COUNT THEN   //If Last Record
                        TaxablePay := TempAmount
                    ELSE                             //If Not Last Record
                        IF TempAmount >= PAYESetup."PAYE Tier" THEN
                            TempAmount := PAYESetup."PAYE Tier"
                        ELSE
                            TempAmount := TempAmount;

                    PAYE := PAYE + (TempAmount * (PAYESetup.Rate / 100));
                    TaxablePay := TaxablePay - TempAmount;
                UNTIL PAYESetup.NEXT = 0;
            END;
        END ELSE BEGIN
            //  IF PAYESetup.FINDLAST THEN BEGIN
            PAYE := TaxablePay * (32.5 / 100);
            //  END;
        END;


    end;

    local procedure CalculateNHIF(BaseAmount: Decimal) NHIF: Decimal
    var
        NHIFSetup: Record "Payroll NHIF Setup_AU";
        PayrollEmployee: Record "Payroll Employee_AU";
    begin
        if PayrollEmployee."Pays NHIF" = true then
            NHIFSetup.Reset;
        NHIFSetup.SetCurrentkey(NHIFSetup."Tier Code");
        if NHIFSetup.FindSet then begin
            repeat
                if ((BaseAmount >= NHIFSetup."Lower Limit") and (BaseAmount <= NHIFSetup."Upper Limit")) then
                    NHIF := NHIFSetup.Amount;
            until NHIFSetup.Next = 0;
        end;
    end;

    local procedure CalculateEmployerNSSF(BaseAmount: Decimal) NSSF: Decimal
    var
        NSSFSetup: Record "Payroll NSSF Setup_AU";
        PayrollEmployee: Record "Payroll Employee_AU";
    begin

        NSSFSetup.Reset;
        NSSFSetup.SetCurrentkey(NSSFSetup."Tier Code");
        if NSSFSetup.FindSet then begin
            repeat
                if ((BaseAmount >= NSSFSetup."Lower Limit") and (BaseAmount <= NSSFSetup."Upper Limit")) then
                    NSSF := NSSFSetup."Tier 1 Employer Contribution" + NSSFSetup."Tier 2 Employer Contribution";
            until NSSFSetup.Next = 0;
        end;
    end;

    local procedure CalculateEmployeeNSSFold(BaseAmount: Decimal) NSSF: Decimal
    var
        NSSFSetup: Record "Payroll NSSF Setup_AU";
        PayrollEmployee: Record "Payroll Employee_AU";
    begin
        NSSFSetup.Reset;
        NSSFSetup.SetCurrentkey(NSSFSetup."Tier Code");
        if NSSFSetup.FindSet then begin
            repeat
                if ((BaseAmount >= NSSFSetup."Lower Limit") and (BaseAmount <= NSSFSetup."Upper Limit")) then
                    NSSF := NSSFSetup."Tier 1 Employee Deduction" + NSSFSetup."Tier 2 Employee Deduction";

            until NSSFSetup.Next = 0;
        end;
        if PayrollEmployee."Pays NSSF" = true then begin
            NSSF := NSSF;
            NSSFTOUSE := 0;
            NSSFTOUSE := NSSF;
        end;
        //ELSE NSSF:=0;
    end;

    local procedure CalculateEmployeeNSSF(BaseAmount: Decimal) NSSF: Decimal
    var
        NSSFSetup: Record "Payroll NSSF Setup_AU";
        PayrollEmployee: Record "Payroll Employee_AU";
        NSSFT1: Decimal;
        NSSFT2: Decimal;
        NssfStt1: Decimal;
    begin
        NSSFSetup.Reset;
        NSSFSetup.SetCurrentkey(NSSFSetup."Tier Code");
        if NSSFSetup.FindSet then begin
            repeat
                NssfStt1 := 0;
                NssfStt1 := NSSFSetup."Lower Limit";

                if ((BaseAmount >= NSSFSetup."Tier 1 earnings") and (NSSFSetup."Tier Code" = '1')) then
                    NSSFT1 := NSSFSetup."Tier 1 Employee Deduction";

                if ((BaseAmount <= NSSFSetup."Tier 2 earnings") and (NSSFSetup."Tier Code" = '2')) then
                    NSSFT2 := (BaseAmount - NssfStt1) * 0.06
                else
                    if ((BaseAmount > NSSFSetup."Tier 2 earnings") and (NSSFSetup."Tier Code" = '2')) then
                        NSSFT2 := NSSFSetup."Tier 2 Employee Deduction";

                NSSF := NSSFT1 + NSSFT2;

            // if ((BaseAmount >= NSSFSetup."Lower Limit") and (BaseAmount <= NSSFSetup."Upper Limit")) then
            //     NSSF := NSSFSetup."Tier 1 Employee Deduction" + NSSFSetup."Tier 2 Employee Deduction";

            until NSSFSetup.Next = 0;
        end;
        if PayrollEmployee."Pays NSSF" = true then begin
            NSSF := NSSF;
            NSSFTOUSE := 0;
            NSSFTOUSE := NSSF;
        end;
        //ELSE NSSF:=0;
    end;

    local procedure CalculateTaxablePay()
    begin
    end;

    local procedure CalculateNetPay()
    begin
    end;


    procedure CalculateLoanInterest(EmpCode: Code[20]; TransCode: Code[20]; InterestRate: Decimal; RecoveryMethod: Option Reducing,"Straight line",Amortized; LoanAmount: Decimal; Balance: Decimal; CurrPeriod: Date; Welfare: Boolean) LnInterest: Decimal
    var
        curLoanInt: Decimal;
        intMonth: Integer;
        intYear: Integer;
    begin
        intMonth := Date2dmy(CurrPeriod, 2);
        intYear := Date2dmy(CurrPeriod, 3);

        curLoanInt := 0;

        if InterestRate > 0 then begin
            if RecoveryMethod = Recoverymethod::"Straight line" then //Straight Line Method [1]
                curLoanInt := (InterestRate / 1200) * LoanAmount;

            if RecoveryMethod = Recoverymethod::Reducing then //Reducing Balance [0]
                                                              //MESSAGE(FORMAT(balance));
                curLoanInt := (InterestRate / 1200) * Balance;

            if RecoveryMethod = Recoverymethod::Amortized then //Amortized [2]
                curLoanInt := (InterestRate / 1200) * Balance;
        end else
            curLoanInt := 0;

        //Return the Amount
        LnInterest := curLoanInt;
    end;

    local procedure CalculateSpecialTrans(EmpCode: Code[20]; Month: Integer; Year: Integer; TransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; CompDeduction: Boolean) TransAmount: Decimal
    var
        EmployeeTransactions: Record "Payroll Employee Trans_AU";
        TransactionCodes: Record "Payroll Transaction Code_AU";
        TransFormula: Text[250];
        ProvCompAmount: Decimal;
    begin
        TransAmount := 0;
        TransactionCodes.Reset;
        TransactionCodes.SetRange(TransactionCodes."Special Transaction", TransID);
        if TransactionCodes.FindSet then begin

            repeat
                EmployeeTransactions.Reset;
                EmployeeTransactions.SetRange(EmployeeTransactions."No.", EmpCode);
                EmployeeTransactions.SetRange(EmployeeTransactions."Transaction Code", TransactionCodes."Transaction Code");
                EmployeeTransactions.SetRange(EmployeeTransactions."Period Month", Month);
                EmployeeTransactions.SetRange(EmployeeTransactions."Period Year", Year);
                EmployeeTransactions.SetRange(EmployeeTransactions.Suspended, false);
                if EmployeeTransactions.FindFirst then begin

                    case TransID of
                        Transid::"Defined Contribution":
                            if TransactionCodes."Is Formulae" then begin
                                TransFormula := '';
                                TransFormula := ExpandFormula(EmployeeTransactions."No.", Month, Year, TransactionCodes.Formulae);
                                TransAmount := Round(TransAmount + FormulaResult(TransFormula), 0.01, '=');
                            end else
                                TransAmount := Round(TransAmount + EmployeeTransactions.Amount, 0.01, '=');

                        Transid::"Life Insurance":
                            TransAmount := TransAmount + ((InsuranceRelief / 100) * EmployeeTransactions.Amount);

                        Transid::"Owner Occupier Interest":
                            TransAmount := TransAmount + EmployeeTransactions.Amount;


                        Transid::"Home Ownership Savings Plan":
                            TransAmount := TransAmount + EmployeeTransactions.Amount;

                        Transid::Morgage:
                            begin
                                TransAmount := TransAmount + MorgageRelief;
                                if TransAmount > MorgageRelief then begin
                                    TransAmount := MorgageRelief
                                end;
                            end;

                    end;

                end;

            until TransactionCodes.Next = 0;
        end;
        TransAmount := TransAmount;

        ProvCompAmount := (1.5 * TransAmount);
    end;

    local procedure CalculatePrescribedBenefit(EmpCode: Code[20]; Month: Integer; Year: Integer; TransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; CompDeduction: Boolean) TransAmount: Decimal
    var
        EmployeeTransactions: Record "Payroll Employee Trans_AU";
        TransactionCodes: Record "Payroll Transaction Code_AU";
        TransFormula: Text[250];
        ProvCompAmount: Decimal;
    begin
        TotEmpBenefit := 0;
        TransactionCodes.Reset;
        TransactionCodes.SetRange(TransactionCodes."Special Transaction", TransactionCodes."special transaction"::"Prescribed Benefit");
        if TransactionCodes.FindSet then begin

            repeat
                EmployeeTransactions.Reset;
                EmployeeTransactions.SetRange(EmployeeTransactions."No.", EmpCode);
                EmployeeTransactions.SetRange(EmployeeTransactions."Transaction Code", TransactionCodes."Transaction Code");
                EmployeeTransactions.SetRange(EmployeeTransactions."Period Month", Month);
                EmployeeTransactions.SetRange(EmployeeTransactions."Period Year", Year);
                EmployeeTransactions.SetRange(EmployeeTransactions.Suspended, false);
                if EmployeeTransactions.FindFirst then begin
                    TotEmpBenefit := TotEmpBenefit + EmployeeTransactions.Amount;
                end;
            until TransactionCodes.Next = 0;
        end;
        TotEmpBenefit := TotEmpBenefit;
    end;

    local procedure CalculateInsuranceRelief(EmpCode: Code[20]; Month: Integer; Year: Integer; TransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; CompDeduction: Boolean) TransAmount: Decimal
    var
        EmployeeTransactions: Record "Payroll Employee Trans_AU";
        TransactionCodes: Record "Payroll Transaction Code_AU";
        TransFormula: Text[250];
        ProvCompAmount: Decimal;
        PayrollEmployee: Record "Payroll Employee_AU";
    begin

        /*TransactionCodes.RESET;
        TransactionCodes.SETRANGE(TransactionCodes."Special Transaction",TransactionCodes."Special Transaction"::"Life Insurance");
        IF TransactionCodes.FINDSET THEN BEGIN
        
           REPEAT
           EmployeeTransactions.RESET;
           EmployeeTransactions.SETRANGE(EmployeeTransactions."No.",EmpCode);
           EmployeeTransactions.SETRANGE(EmployeeTransactions."Transaction Code",TransactionCodes."Transaction Code");
           EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Month",Month);
           EmployeeTransactions.SETRANGE(EmployeeTransactions."Period Year",Year);
           EmployeeTransactions.SETRANGE(EmployeeTransactions.Suspended,FALSE);
           IF EmployeeTransactions.FINDFIRST THEN BEGIN
        
           InsuranceAmount:=InsuranceAmount+(InsuranceRelief/100*EmployeeTransactions.Amount);
        
           END;
           UNTIL TransactionCodes.NEXT=0;
        END;*/
        //InsuranceAmount := 0.15 * EmpNHIF;


        PayrollEmployee.Reset;
        PayrollEmployee.SetRange(PayrollEmployee."No.", EmpCode);
        if PayrollEmployee.Find('-') then begin
            InsuranceAmount := (EmpNHIF * NHIFRATE / 100) + PayrollEmployee."Insurance Relief";
        end;

        PremiumAmount := 0;
        MAximumPremium := 0;
        PayrollEmployee.Reset;
        PayrollEmployee.SetRange(PayrollEmployee."No.", EmpCode);
        PayrollEmployee.SetRange("Suspend Pay", false);
        if PayrollEmployee.Find('-') then begin
            PremiumAmount := PayrollEmployee.Premium * PayrollEmployee."Premium %" / 100;
            MAximumPremium := PayrollEmployee."Maximum Premium";
        end;



        TransactionCodes.Reset;
        TransactionCodes.SetRange(TransactionCodes."Is Insurance", true);
        if TransactionCodes.FindSet then begin
            repeat
                EmployeeTransactions.Reset;
                EmployeeTransactions.SetRange(EmployeeTransactions."No.", EmpCode);
                EmployeeTransactions.SetRange(EmployeeTransactions."Transaction Code", TransactionCodes."Transaction Code");
                EmployeeTransactions.SetRange(EmployeeTransactions."Period Month", Month);
                EmployeeTransactions.SetRange(EmployeeTransactions."Period Year", Year);
                EmployeeTransactions.SetRange(EmployeeTransactions.Suspended, false);
                if EmployeeTransactions.FindFirst then begin
                    InsuranceAmount := InsuranceAmount + (0.15 * EmployeeTransactions.Amount);
                end;
            until TransactionCodes.Next = 0;
        end;
        InsuranceAmount := InsuranceAmount + PremiumAmount;

        //InsuranceAmount:=InsuranceAmount;
        if InsuranceAmount > 5000 then
            InsuranceAmount := 5000;
        currentAmount := InsuranceAmount;

    end;

    local procedure InsertMonthlyTransactions(EmpNo: Code[20]; TransCode: Code[20]; TransType: Code[20]; Grouping: Integer; SubGrouping: Integer; Description: Text[50]; Amount: Decimal; "Amount(LCY)": Decimal; Balance: Decimal; "Balance(LCY)": Decimal; "Payroll Period": Date; Month: Integer; Year: Integer; "Account Type": Option " ","G/L Account",Customer,Vendor; "Account No": Code[20]; "Posting Type": Option " ",Debit,Credit; "Global Dimension 1 Code": Code[50]; "Global Dimension 2 Code": Code[50]; Membership: Text[30]; ReferenceNo: Text[30]; Department: Code[20]; "co-op": Option "None",Shares,Loan,"Loan Interest","Emergency Loan","Emergency Loan Interest","School Fees Loan","School Fees Loan Interest",Welfare,Pension,NSSF,Overtime,WSS; LoanNo: Code[10])
    var
        MonthlyTransactions: Record "Payroll Monthly Trans_AU";
        PayrollEmployee: Record "Payroll Employee_AU";
    begin

        if currentAmount = 0 then exit;

        //IF ExcessPension =0 THEN EXIT;
        //IF InsuranceAmount =0 THEN EXIT;
        MonthlyTransactions.Init;
        MonthlyTransactions."No." := EmpNo;
        MonthlyTransactions."Transaction Code" := TransCode;
        MonthlyTransactions."Group Text" := TransType;
        MonthlyTransactions."Transaction Name" := Description;
        MonthlyTransactions.Amount := (Amount);
        MonthlyTransactions."Amount(LCY)" := ROUND("Amount(LCY)");
        MonthlyTransactions.Balance := Balance;
        MonthlyTransactions."Balance(LCY)" := "Balance(LCY)";
        MonthlyTransactions.Grouping := Grouping;
        MonthlyTransactions.SubGrouping := SubGrouping;
        MonthlyTransactions.Membership := Membership;
        MonthlyTransactions."Reference No" := ReferenceNo;
        MonthlyTransactions."Period Month" := Month;
        MonthlyTransactions."Period Year" := Year;
        MonthlyTransactions."Payroll Period" := "Payroll Period";
        //MonthlyTransactions."Department Code":=Department;
        MonthlyTransactions."Posting Type" := "Posting Type";
        MonthlyTransactions."Account Type" := "Account Type";
        MonthlyTransactions."Account No" := "Account No";
        MonthlyTransactions."Loan Number" := LoanNo;
        //MonthlyTransactions."Payroll Code":=PayrollCode;
        MonthlyTransactions."Co-Op parameters" := "co-op";
        MonthlyTransactions."Global Dimension 1" := "Global Dimension 1 Code";
        MonthlyTransactions."Global Dimension 2" := "Global Dimension 2 Code";
        if PayrollEmployee.Get(EmpNo) then
            MonthlyTransactions."Payment Mode" := PayrollEmployee."Payment Mode";
        MonthlyTransactions.Insert(true);
        UpdateEmployeeTransactions(EmpNo, TransCode, Amount, "Amount(LCY)", "Payroll Period", Month, Year);
    end;

    local procedure UpdateEmployeeTransactions(EmpNo: Code[20]; TransCode: Code[20]; Amount: Decimal; "Amount(LCY)": Decimal; PayrollPeriod: Date; Month: Integer; Year: Integer)
    var
        PayrollEmpTrans: Record "Payroll Employee Trans_AU";
    begin
        PayrollEmpTrans.Reset;
        PayrollEmpTrans.SetRange(PayrollEmpTrans."No.", EmpNo);
        PayrollEmpTrans.SetRange(PayrollEmpTrans."Transaction Code", TransCode);
        PayrollEmpTrans.SetRange(PayrollEmpTrans."Payroll Period", PayrollPeriod);
        PayrollEmpTrans.SetRange(PayrollEmpTrans."Period Month", Month);
        PayrollEmpTrans.SetRange(PayrollEmpTrans."Period Year", Year);
        if PayrollEmpTrans.FindFirst then begin
            PayrollEmpTrans.Amount := Amount;
            PayrollEmpTrans."Amount(LCY)" := "Amount(LCY)";
            PayrollEmpTrans.Modify;

        end;
    end;

    local procedure InsertEmployeeDeductions()
    begin
    end;

    local procedure InsertEmployerDeductions(EmpCode: Code[20]; TransCode: Code[20]; TransType: Code[20]; Grouping: Integer; SubGrouping: Integer; Description: Text[50]; currentAmount: Decimal; "currentAmount(LCY)": Decimal; currentBalance: Decimal; "currentBalance(LCY)": Decimal; Month: Integer; Year: Integer; Membership: Text[30]; ReferenceNo: Text[30]; PayrollPeriod: Date; PayrollCode: Code[20])
    var
        EmployerDeductions: Record "Payroll Employer Deductions_AU";
    begin
        if currentAmount = 0 then exit;
        with EmployerDeductions do begin
            Init;
            "Employee Code" := EmpCode;
            "Transaction Code" := TransCode;
            Amount := currentAmount;
            "Period Month" := Month;
            "Period Year" := Year;
            "Payroll Period" := PayrollPeriod;
            "Payroll Code" := PayrollCode;
            "Amount(LCY)" := "currentAmount(LCY)";
            Group := Grouping;
            SubGroup := SubGrouping;
            "Transaction Type" := TransType;
            Description := Description;
            Balance := currentBalance;
            "Balance(LCY)" := "currentBalance(LCY)";
            "Membership No" := Membership;
            "Reference No" := ReferenceNo;
            Insert;
        end;
    end;

    local procedure RemoveEmployerDeduction(EmpCode: Code[20]; TransCode: Code[20]; Month: Integer; Year: Integer)
    var
        "Payroll Employer Ded": Record "Payroll Employer Deductions_AU";
    begin
        "Payroll Employer Ded".Reset;
        "Payroll Employer Ded".SetRange("Payroll Employer Ded"."Employee Code", EmpCode);
        "Payroll Employer Ded".SetRange("Payroll Employer Ded"."Transaction Code", TransCode);
        "Payroll Employer Ded".SetRange("Payroll Employer Ded"."Period Month", Month);
        "Payroll Employer Ded".SetRange("Payroll Employer Ded"."Period Year", Year);
        if "Payroll Employer Ded".FindSet then
            "Payroll Employer Ded".DeleteAll;
    end;

    local procedure InsertSalaryArrears()
    begin
    end;


    procedure UpdateP9Information(Month: Integer; Year: Integer; "Payroll Period": Date)
    var
        P9BasicPay: Decimal;
        P9Allowances: Decimal;
        P9Benefits: Decimal;
        P9ValueOfQuarters: Decimal;
        P9DefinedContribution: Decimal;
        P9OwnerOccupierInterest: Decimal;
        P9GrossPay: Decimal;
        P9TaxablePay: Decimal;
        P9TaxCharged: Decimal;
        P9InsuranceRelief: Decimal;
        P9TaxRelief: Decimal;
        P9Paye: Decimal;
        P9NSSF: Decimal;
        P9NHIF: Decimal;
        P9Deductions: Decimal;
        P9NetPay: Decimal;
        PayrollEmployee: Record "Payroll Employee_AU";
        MonthlyTransactions: Record "Payroll Monthly Trans_AU";
    begin
        P9BasicPay := 0;
        P9Allowances := 0;
        P9Benefits := 0;
        P9ValueOfQuarters := 0;
        P9DefinedContribution := 0;
        P9OwnerOccupierInterest := 0;
        P9GrossPay := 0;
        P9TaxablePay := 0;
        P9TaxCharged := 0;
        P9InsuranceRelief := 0;
        P9TaxRelief := 0;
        P9Paye := 0;
        P9NSSF := 0;
        P9NHIF := 0;
        P9Deductions := 0;
        P9NetPay := 0;

        PayrollEmployee.Reset;
        PayrollEmployee.SetRange(PayrollEmployee.Status, PayrollEmployee.Status::Active);
        if PayrollEmployee.FindSet then begin
            repeat
                P9BasicPay := 0;
                P9Allowances := 0;
                P9Benefits := 0;
                P9ValueOfQuarters := 0;
                P9DefinedContribution := 0;
                P9OwnerOccupierInterest := 0;
                P9GrossPay := 0;
                P9TaxablePay := 0;
                P9TaxCharged := 0;
                P9InsuranceRelief := 0;
                P9TaxRelief := 0;
                P9Paye := 0;
                P9NSSF := 0;
                P9NHIF := 0;
                P9Deductions := 0;
                P9NetPay := 0;

                MonthlyTransactions.Reset;
                MonthlyTransactions.SetRange(MonthlyTransactions."Period Month", Month);
                MonthlyTransactions.SetRange(MonthlyTransactions."Period Year", Year);
                MonthlyTransactions.SetRange(MonthlyTransactions."No.", PayrollEmployee."No.");
                if MonthlyTransactions.FindSet then begin
                    repeat
                        case MonthlyTransactions.Grouping of
                            1: //Basic pay & Arrears
                                begin
                                    if SubGrouping = 1 then P9BasicPay := MonthlyTransactions.Amount; //Basic Pay
                                    if SubGrouping = 2 then P9BasicPay := P9BasicPay + MonthlyTransactions.Amount; //Basic Pay Arrears
                                end;
                            3:  //Allowances
                                begin
                                    P9Allowances := P9Allowances + MonthlyTransactions.Amount
                                end;
                            4: //Gross Pay
                                begin
                                    P9GrossPay := MonthlyTransactions.Amount
                                end;
                            6: //Taxation
                                begin
                                    if SubGrouping = 1 then P9DefinedContribution := MonthlyTransactions.Amount; //Defined Contribution
                                    if SubGrouping = 9 then P9TaxRelief := MonthlyTransactions.Amount; //Tax Relief
                                    if SubGrouping = 8 then P9InsuranceRelief := MonthlyTransactions.Amount; //Insurance Relief
                                    if SubGrouping = 6 then P9TaxablePay := MonthlyTransactions.Amount; //Taxable Pay
                                    if SubGrouping = 7 then P9TaxCharged := MonthlyTransactions.Amount; //Tax Charged
                                end;
                            7: //Statutories
                                begin
                                    if SubGrouping = 1 then P9NSSF := MonthlyTransactions.Amount; //Nssf
                                    if SubGrouping = 2 then P9NHIF := MonthlyTransactions.Amount; //Nhif
                                    if SubGrouping = 3 then P9Paye := MonthlyTransactions.Amount; //paye
                                    if SubGrouping = 4 then P9Paye := P9Paye + MonthlyTransactions.Amount; //Paye Arrears
                                end;
                            8://Deductions
                                begin
                                    P9Deductions := P9Deductions + MonthlyTransactions.Amount;
                                end;
                            9: //NetPay
                                begin
                                    P9NetPay := MonthlyTransactions.Amount;
                                end;
                        end;
                    until MonthlyTransactions.Next = 0;
                end;
                //Insert the P9 Details
                if P9NetPay <> 0 then
                    InsertP9Information(PayrollEmployee."No.", "Payroll Period", P9BasicPay, P9Allowances, P9Benefits, P9ValueOfQuarters, P9DefinedContribution,
                       P9OwnerOccupierInterest, P9GrossPay, P9TaxablePay, P9TaxCharged, P9InsuranceRelief, P9TaxRelief, P9Paye, P9NSSF,
                       P9NHIF, P9Deductions, P9NetPay);
            until PayrollEmployee.Next = 0;
        end;
    end;

    local procedure InsertP9Information(EmpCode: Code[20]; "Payroll Period": Date; P9BasicPay: Decimal; P9Allowances: Decimal; P9Benefits: Decimal; P9ValueOfQuarters: Decimal; P9DefinedContribution: Decimal; P9OwnerOccupierInterest: Decimal; P9GrossPay: Decimal; P9TaxablePay: Decimal; P9TaxCharged: Decimal; P9InsuranceRelief: Decimal; P9TaxRelief: Decimal; P9Paye: Decimal; P9NSSF: Decimal; P9NHIF: Decimal; P9Deductions: Decimal; P9NetPay: Decimal)
    var
        Month: Integer;
        Year: Integer;
        PayrollP9: Record "Payroll Employee P9_AU";
    begin
        Month := Date2dmy("Payroll Period", 2);
        Year := Date2dmy("Payroll Period", 3);

        PayrollP9.Reset;
        PayrollP9.SetRange(PayrollP9."Period Month", Month);
        PayrollP9.SetRange(PayrollP9."Period Year", Year);
        PayrollP9.SetRange(PayrollP9."Employee Code", EmpCode);
        //PayrollP9.SETRANGE(PayrollP9."Payroll Period","Payroll Period");
        if PayrollP9.Find('-') then
            PayrollP9.Delete;
        with PayrollP9 do begin
            Init;
            "Employee Code" := EmpCode;
            "Basic Pay" := P9BasicPay;
            Allowances := P9Allowances;
            Benefits := P9Benefits;
            "Value Of Quarters" := P9ValueOfQuarters;
            "Defined Contribution" := P9DefinedContribution;
            "Owner Occupier Interest" := P9OwnerOccupierInterest;
            "Gross Pay" := P9GrossPay;
            "Taxable Pay" := P9TaxablePay;
            "Tax Charged" := P9TaxCharged;
            "Insurance Relief" := P9InsuranceRelief;
            "Tax Relief" := P9TaxRelief;
            PAYE := P9Paye;
            NSSF := P9NSSF;
            NHIF := P9NHIF;
            Deductions := P9Deductions;
            "Net Pay" := P9NetPay;
            "Period Month" := Month;
            //"Payroll Period":="Payroll Period";
            "Period Year" := Year;
            Insert;
        end;
    end;

    local procedure InsertNegativePay(Month: Integer; Year: Integer; "Payroll Period": Date)
    var
        NewPayrollPeriod: Date;
        NewMonth: Integer;
        NewYear: Integer;
        MonthlyTransactions: Record "Payroll Monthly Trans_AU";
        EmployeeTrans: Record "Payroll Employee Trans_AU";
        TCODE: label 'NEGP';
        TNAME: label 'Negative Pay';
    begin
        NewPayrollPeriod := CalcDate('1M', "Payroll Period");
        NewMonth := Date2dmy(NewPayrollPeriod, 2);
        NewYear := Date2dmy(NewPayrollPeriod, 3);

        MonthlyTransactions.Reset;
        MonthlyTransactions.SetRange(MonthlyTransactions."Period Month", Month);
        MonthlyTransactions.SetRange(MonthlyTransactions."Period Year", Year);
        MonthlyTransactions.SetRange(MonthlyTransactions.Grouping, 9);
        MonthlyTransactions.SetFilter(MonthlyTransactions.Amount, '<0');
        if MonthlyTransactions.FindFirst then begin
            repeat
                with EmployeeTrans do begin
                    Init;
                    "No." := MonthlyTransactions."No.";
                    "Transaction Code" := TCODE;
                    "Transaction Name" := TNAME;
                    "Transaction Type" := "transaction type"::Deduction;
                    Amount := MonthlyTransactions.Amount;
                    "Amount(LCY)" := MonthlyTransactions."Amount(LCY)";
                    Balance := 0;
                    "Original Amount" := 0;
                    "Period Month" := NewMonth;
                    "Period Year" := NewYear;
                    "Payroll Period" := NewPayrollPeriod;
                    Insert;
                end;
            until MonthlyTransactions.Next = 0;
        end;
    end;

    local procedure ExpandFormula(EmpNo: Code[20]; Month: Integer; Year: Integer; strFormula: Text[250]) Formula: Text[250]
    var
        Where: Text[30];
        Which: Text[30];
        i: Integer;
        TransCode: Code[20];
        Char: Text[1];
        FirstBracket: Integer;
        StartCopy: Boolean;
        FinalFormula: Text[250];
        TransCodeAmount: Decimal;
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin
        TransCode := '';
        for i := 1 to StrLen(strFormula) do begin
            Char := CopyStr(strFormula, i, 1);
            if Char = '[' then StartCopy := true;

            if StartCopy then TransCode := TransCode + Char;
            //Copy Characters as long as is not within []
            if not StartCopy then
                FinalFormula := FinalFormula + Char;
            if Char = ']' then begin
                StartCopy := false;
                //Get Transcode
                Where := '=';
                Which := '[]';
                TransCode := DelChr(TransCode, Where, Which);
                //Get TransCodeAmount
                TransCodeAmount := GetTransAmount(EmpNo, TransCode, Month, Year);
                //Reset Transcode
                TransCode := '';
                //Get Final Formula
                FinalFormula := FinalFormula + Format(TransCodeAmount);
                //End Get Transcode
            end;
        end;
        Formula := FinalFormula;
    end;

    local procedure GetTransAmount(EmpNo: Code[20]; TransCode: Code[20]; Month: Integer; Year: Integer) TransAmount: Decimal
    var
        EmployeeTransactions: Record "Payroll Employee Trans_AU";
        MonthlyTransactions: Record "Payroll Monthly Trans_AU";
        EmpPayrollCard: Record "Payroll Employee_AU";
    begin
        EmployeeTransactions.Reset;
        EmployeeTransactions.SetRange(EmployeeTransactions."No.", EmpNo);
        EmployeeTransactions.SetRange(EmployeeTransactions."Transaction Code", TransCode);
        EmployeeTransactions.SetRange(EmployeeTransactions."Period Month", Month);
        EmployeeTransactions.SetRange(EmployeeTransactions."Period Year", Year);
        EmployeeTransactions.SetRange(EmployeeTransactions.Suspended, false);
        if EmployeeTransactions.FindFirst then begin
            TransAmount := EmployeeTransactions.Amount;
            if EmployeeTransactions."No of Units" <> 0 then
                TransAmount := EmployeeTransactions."No of Units";
        end;

        if TransAmount = 0 then begin
            MonthlyTransactions.Reset;
            MonthlyTransactions.SetRange(MonthlyTransactions."No.", EmpNo);
            MonthlyTransactions.SetRange(MonthlyTransactions."Transaction Code", TransCode);
            MonthlyTransactions.SetRange(MonthlyTransactions."Period Month", Month);
            MonthlyTransactions.SetRange(MonthlyTransactions."Period Year", Year);
            if MonthlyTransactions.FindFirst then
                TransAmount := MonthlyTransactions.Amount;
        end;

        if (TransAmount = 0) and (TransCode = 'BPAY') then begin
            EmpPayrollCard.Reset;
            EmpPayrollCard.SetRange(EmpPayrollCard."No.", EmpNo);
            if EmpPayrollCard.FindFirst then begin
                TransAmount := EmpPayrollCard."Basic Pay";
            end;
        end;
    end;

    local procedure FormulaResult(Formula: Text[250]) Results: Decimal
    var
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement2;
    begin
        Results := AccSchedMgt.EvaluateExpression(TRUE, Formula, AccSchedLine, ColumnLayout, CalcAddCurr);
    end;

    procedure InsertP10(EmployeeCode: Code[20]; Month: Integer; Year: Integer; "Payroll Period": Date)
    var

        P10: Record P10;
    begin
        P10.RESET;
        P10.SETRANGE(P10."Employee No", EmployeeCode);
        P10.SETRANGE(P10."Payroll Preriod", "Payroll Period");
        IF P10.FIND('-') THEN BEGIN
            P10.Delete();
        end;
        with P10 do begin
            Init();
            "Employee No" := EmployeeCode;
            "Payroll Preriod" := "Payroll Period";
            "Payroll Month" := Month;
            "Payroll Year" := Year;
            if not Insert(true) then Modify(true)
        end;
    end;



    procedure ClosePayrollPeriod(CurrentPayrollPeriod: Date)
    var
        NewPayrollPeriod: Date;
        NewYear: Integer;
        NewMonth: Integer;
        EmployeeTransactions2: Record "Payroll Employee Trans_AU";
        PayrollCalender: Record "Payroll Calender_AU";
        NewPayrollCalender: Record "Payroll Calender_AU";
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Month: Integer;
        Year: Integer;
    begin
        currentAmount := 0;
        "currentAmount(LCY)" := 0;
        CurBalance := 0;
        "CurBalance(LCY)" := 0;

        CurrentMonth := Date2dmy(CurrentPayrollPeriod, 2);
        CurrentYear := Date2dmy(CurrentPayrollPeriod, 3);
        Month := Date2dmy(CurrentPayrollPeriod, 2);
        Year := Date2dmy(CurrentPayrollPeriod, 3);

        NewPayrollPeriod := CalcDate('1M', CurrentPayrollPeriod);
        NewYear := Date2dmy(NewPayrollPeriod, 3);
        NewMonth := Date2dmy(NewPayrollPeriod, 2);

        EmployeeTransactions.Reset;
        EmployeeTransactions.SetRange(EmployeeTransactions."Period Month", Month);
        EmployeeTransactions.SetRange(EmployeeTransactions."Period Year", Year);
        if EmployeeTransactions.FindSet then begin
            repeat
                PayrollTransactions.Reset;
                PayrollTransactions.SetRange(PayrollTransactions."Transaction Code", EmployeeTransactions."Transaction Code");
                if PayrollTransactions.FindFirst then begin
                    case PayrollTransactions."Balance Type" of
                        PayrollTransactions."balance type"::None:
                            begin
                                currentAmount := EmployeeTransactions.Amount;
                                "currentAmount(LCY)" := EmployeeTransactions."Amount(LCY)";
                                CurBalance := 0;
                                "CurBalance(LCY)" := 0;
                            end;

                        PayrollTransactions."balance type"::Increasing:
                            begin
                                currentAmount := EmployeeTransactions.Amount;
                                "currentAmount(LCY)" := EmployeeTransactions."Amount(LCY)";
                                CurBalance := EmployeeTransactions.Balance + EmployeeTransactions.Amount;
                                "CurBalance(LCY)" := EmployeeTransactions.Balance + EmployeeTransactions.Amount;
                            end;

                        PayrollTransactions."balance type"::Reducing:
                            begin
                                currentAmount := EmployeeTransactions.Amount;
                                "currentAmount(LCY)" := EmployeeTransactions."Amount(LCY)";
                                if EmployeeTransactions.Balance < EmployeeTransactions.Amount then begin
                                    currentAmount := EmployeeTransactions.Balance;
                                    CurBalance := 0;
                                    "CurBalance(LCY)" := 0;
                                end else begin
                                    CurBalance := EmployeeTransactions.Balance - EmployeeTransactions.Amount;
                                    "CurBalance(LCY)" := EmployeeTransactions.Balance - EmployeeTransactions.Amount;
                                end;
                                if CurBalance < 0 then begin
                                    currentAmount := 0;
                                    "currentAmount(LCY)" := 0;
                                    CurBalance := 0;
                                    "CurBalance(LCY)" := 0;
                                end;
                            end;
                    end;
                    //Transactions with Start and End Date Specified
                    if (EmployeeTransactions."Start Date" <> 0D) and (EmployeeTransactions."End Date" <> 0D) then begin
                        if EmployeeTransactions."End Date" < NewPayrollPeriod then begin
                            currentAmount := 0;
                            "currentAmount(LCY)" := 0;
                            CurBalance := 0;
                            "CurBalance(LCY)" := 0;
                        end;
                    end;
                    //End Transactions with Start and End Date

                    if (PayrollTransactions.Frequency = PayrollTransactions.Frequency::Fixed) and (EmployeeTransactions."Stop for Next Period" = false) then begin
                        if (currentAmount <> 0) then begin
                            if ((PayrollTransactions."Balance Type" = PayrollTransactions."balance type"::Reducing) and (CurBalance <> 0)) or (PayrollTransactions."Balance Type" <> PayrollTransactions."balance type"::Reducing) then
                                EmployeeTransactions.Balance := CurBalance;
                            EmployeeTransactions.Modify;
                            //Insert record for the next period
                            with EmployeeTransactions2 do begin
                                Init;
                                "No." := EmployeeTransactions."No.";
                                "Transaction Code" := EmployeeTransactions."Transaction Code";
                                "Transaction Name" := EmployeeTransactions."Transaction Name";
                                "Transaction Type" := EmployeeTransactions."Transaction Type";
                                Amount := currentAmount;
                                "Amount(LCY)" := "currentAmount(LCY)";
                                Balance := CurBalance;
                                "Balance(LCY)" := "CurBalance(LCY)";
                                "Amtzd Loan Repay Amt" := EmployeeTransactions."Amtzd Loan Repay Amt";
                                "Amtzd Loan Repay Amt(LCY)" := EmployeeTransactions."Amtzd Loan Repay Amt(LCY)";
                                "Original Amount" := EmployeeTransactions."Original Amount";
                                Membership := EmployeeTransactions.Membership;
                                "Reference No" := EmployeeTransactions."Reference No";
                                "Loan Number" := EmployeeTransactions."Loan Number";
                                "Period Month" := NewMonth;
                                "Period Year" := NewYear;
                                "Payroll Period" := NewPayrollPeriod;
                                Insert;
                            end;
                        end;
                    end;
                end;
            until EmployeeTransactions.Next = 0;
        end;

        //Close Payroll Period
        PayrollCalender.Reset;
        PayrollCalender.SetRange(PayrollCalender."Period Year", CurrentYear);
        PayrollCalender.SetRange(PayrollCalender."Period Month", CurrentMonth);
        PayrollCalender.SetRange(PayrollCalender.Closed, false);
        if PayrollCalender.FindFirst then begin
            PayrollCalender.Closed := true;
            PayrollCalender."Date Closed" := Today;
            PayrollCalender."Branch Code" := 'Kenya';
            PayrollCalender.Modify;
        end;

        //Enter a New Period
        with NewPayrollCalender do begin
            Init;
            "Period Month" := NewMonth;
            "Period Year" := NewYear;
            "Period Name" := Format(NewPayrollPeriod, 0, '<Month Text>') + ' - ' + Format(NewYear);
            "Date Opened" := NewPayrollPeriod;
            "Branch Code" := 'Kenya';
            Closed := false;
            Insert;
        end;

        //Update P9 Information
        UpdateP9Information(CurrentMonth, CurrentYear, CurrentPayrollPeriod);

        //If there are any Negative Payments Take Them to Next Period as Deductions
        InsertNegativePay(CurrentMonth, CurrentYear, CurrentPayrollPeriod);
    end;

    local procedure CalculateProratedAmount2("Employee No": Code[20]; "Basic Pay": Decimal; "Payroll Month": Integer; "Payroll Year": Integer; DaysInMonth: Integer; DaysWorked: Integer) Amount: Decimal
    begin

        Amount := ROUND((DaysWorked / DaysInMonth) * "Basic Pay");
    end;

}

