Table 172009 "Payroll Employee Deductions_AU"
{

    fields
    {
        field(10;"Employee Code";Code[1000])
        {
        }
        field(11;"Transaction Code";Code[1000])
        {
        }
    }

    keys
    {
        key(Key1;"Employee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

