Table 172001 "Payroll Transaction Code_AU"
{
    DrillDownPageID = "Payroll Transaction List_AU";
    LookupPageID = "Payroll Transaction List_AU";

    fields
    {
        field(10; "Transaction Code"; Code[1000])
        {
            Editable = true;
        }
        field(11; "Transaction Name"; Text[1000])
        {
        }
        field(12; "Transaction Type"; Option)
        {
            Editable = true;
            OptionCaption = 'Income,Deduction';
            OptionMembers = Income,Deduction;
        }
        field(13; "Balance Type"; Option)
        {
            OptionCaption = 'None,Increasing,Reducing';
            OptionMembers = "None",Increasing,Reducing;
        }
        field(14; Frequency; Option)
        {
            OptionCaption = 'Fixed,Varied';
            OptionMembers = "Fixed",Varied;
        }
        field(15; Taxable; Boolean)
        {
        }
        field(16; "Is Cash"; Boolean)
        {
        }
        field(17; "Is Formulae"; Boolean)
        {
        }
        field(18; Formulae; Code[50])
        {
        }
        field(19; "Special Transaction"; Option)
        {
            OptionCaption = 'Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters,Morgage';
            OptionMembers = Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
        }
        field(20; "Amount Preference"; Option)
        {
            OptionCaption = 'Posted Amount,Take Higher,Take Lower ';
            OptionMembers = "Posted Amount","Take Higher","Take Lower ";
        }
        field(21; "Deduct Premium"; Boolean)
        {
        }
        field(22; "Interest Rate"; Decimal)
        {
        }
        field(23; "Repayment Method"; Option)
        {
            OptionCaption = 'Reducing,Straight line,Amortized';
            OptionMembers = Reducing,"Straight line",Amortized;
        }
        field(24; "Fringe Benefit"; Boolean)
        {
        }
        field(25; "Employer Deduction"; Boolean)
        {
        }
        field(26; IsHouseAllowance; Boolean)
        {
        }
        field(27; "Include Employer Deduction"; Boolean)
        {
        }
        field(28; "Formulae for Employer"; Code[50])
        {
        }
        field(29; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin
                GLAcc.Reset;
                GLAcc.SetRange(GLAcc."No.", "G/L Account");
                if GLAcc.FindFirst then begin
                    "G/L Account Name" := GLAcc.Name;
                end;
            end;
        }
        field(30; "G/L Account Name"; Text[50])
        {
            Editable = false;
        }
        field(31; "Co-Op Parameters"; Option)
        {
            OptionCaption = 'None,Shares,Loan,Loan Interest,Emergency Loan,Emergency Loan Interest,School Fees Loan,School Fees Loan Interest,Welfare,Pension,NSSF,Overtime,WSS';
            OptionMembers = "None",Shares,Loan,"Loan Interest","Emergency Loan","Emergency Loan Interest","School Fees Loan","School Fees Loan Interest",Welfare,Pension,NSSF,Overtime,WSS;
        }
        field(32; "IsCo-Op/LnRep"; Boolean)
        {
        }
        field(33; "Deduct Mortgage"; Boolean)
        {
        }
        field(34; SubLedger; Option)
        {
            OptionCaption = ' ,Customer,Vendor';
            OptionMembers = " ",Customer,Vendor;
        }
        field(35; Welfare; Boolean)
        {
        }
        field(36; "Customer Posting Group"; Code[20])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(37; "Previous Month Filter"; Date)
        {
        }
        field(38; "Current Month Filter"; Date)
        {
        }
        field(39; "Previous Amount"; Decimal)
        {
        }
        field(40; "Current Amount"; Decimal)
        {
        }
        field(41; "Previous Amount(LCY)"; Decimal)
        {
        }
        field(42; "Current Amount(LCY)"; Decimal)
        {
        }
        field(43; "Transaction Category"; Option)
        {
            OptionCaption = ' ,Housing,Transport,Other Allowances,NHF,Pension,Company Loan,Housing Deduction,Personal Loan,Inconvinience,Bonus Special,Other Deductions,Overtime,Entertainment,Leave,Utility,Other Co-deductions,Car Loan,Call Duty,Co-op,Lunch,Compassionate Loan';
            OptionMembers = " ",Housing,Transport,"Other Allowances",NHF,Pension,"Company Loan","Housing Deduction","Personal Loan",Inconvinience,"Bonus Special","Other Deductions",Overtime,Entertainment,Leave,Utility,"Other Co-deductions","Car Loan","Call Duty","Co-op",Lunch,"Compassionate Loan";
        }
        field(44; "Employee Code Filter"; Code[20])
        {
        }
        field(45; "No. Series"; Code[10])
        {
        }
        field(46; Blocked; Boolean)
        {
        }
        field(47; "Exclude in NSSF"; Boolean)
        {
        }
        field(48; "Exclude in NHIF"; Boolean)
        {
        }
        field(49; "Payable Bank Ac"; Code[50])
        {
            TableRelation = "Payroll Bank Codes_AU"."Bank Code";

            trigger OnValidate()
            begin
                Bank.Reset;
                Bank.SetRange(Bank."Bank Code", "Payable Bank Ac");
                if Bank.Find('-') then begin
                    "Bank Name" := Bank."Bank Name";
                end;
            end;
        }
        field(50; "Bank Name"; Text[100])
        {
            Editable = false;
        }
        field(51; "Branch Code"; Code[50])
        {
            TableRelation = "Payroll Bank Branches_AU"."Branch Code" where("Bank Code" = field("Payable Bank Ac"));

            trigger OnValidate()
            begin
                TestField("Payable Bank Ac");
                BBranch.Reset;
                BBranch.SetRange(BBranch."Bank Code", "Payable Bank Ac");
                BBranch.SetRange(BBranch."Branch Code", "Branch Code");
                if BBranch.Find('-') then begin
                    "Branch Name" := BBranch."Branch Name";
                end;
            end;
        }
        field(52; "Branch Name"; Text[100])
        {
            Editable = false;
        }
        field(53; "Account Number"; Text[30])
        {
        }
        field(54; "Percent of Basic"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Is Pension"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Is Insurance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Inclusive housing Leavy"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Transaction Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Transaction Code", "Transaction Name")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Transaction Code" = '' then begin
            if "Transaction Type" = "transaction type"::Income then begin
                Setup.Get;
                Setup.TestField(Setup."Earnings No");
                NoSeriesMgt.InitSeries(Setup."Earnings No", xRec."No. Series", 0D, "Transaction Code", "No. Series");
            end;
            if "Transaction Type" = "transaction type"::Deduction then begin
                Setup.Get;
                Setup.TestField(Setup."Deductions No");
                NoSeriesMgt.InitSeries(Setup."Deductions No", xRec."No. Series", 0D, "Transaction Code", "No. Series");
            end;
        end;
    end;

    var
        Setup: Record "Payroll General Setup_AU";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GLAcc: Record "G/L Account";
        Bank: Record "Payroll Bank Codes_AU";
        BBranch: Record "Payroll Bank Branches_AU";
}

