Table 172007 "Payroll Posting Groups_AU"
{

    fields
    {
        field(10; "Posting Code"; Code[10])
        {
        }
        field(11; Description; Text[50])
        {
        }
        field(12; "Salary Account"; Code[100])
        {
            TableRelation = "G/L Account";
        }
        field(13; "Income Tax Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(14; "SSF Employer Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(15; "SSF Employee Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(16; "Net Salary Payable"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(17; "Operating Overtime"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(18; "Tax Relief"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(19; "Employee Provident Fund Acc."; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(20; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(21; "Pension Employer Acc"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(22; "Pension Employee Acc"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(23; "Earnings and deductions"; Code[50])
        {
        }
        field(24; "Staff Benevolent"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(25; SalaryExpenseAC; Code[100])
        {
            TableRelation = "G/L Account";
        }
        field(26; "Directors Fee GL"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(27; "Staff Gratuity"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(28; "NHIF Employee Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(29; "Payroll Code"; Code[20])
        {
        }
        field(30; "Upload to Payroll"; Boolean)
        {
        }
        field(31; "PAYE Benefit A/C"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(32; "Provident Employer Acc"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(33; "Provident Employee Acc"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(34; "Net Salary Payable-Contract"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(35; "Premium Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(36; "Housing Employee"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(37; "Housing Employer"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(40; TotalDed; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(41; "SHIF Employee"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(42; "SHIF Employer"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(43; "Life Insurance Employer Acc"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(44; "Life Insurance Employee Acc"; Code[50])
        {
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Posting Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

