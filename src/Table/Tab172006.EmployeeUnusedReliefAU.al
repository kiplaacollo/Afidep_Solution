Table 172006 "Employee Unused Relief_AU"
{

    fields
    {
        field(10;"Employee No.";Code[20])
        {
        }
        field(11;"Unused Relief";Decimal)
        {
        }
        field(12;"Unused Relief(LCY)";Decimal)
        {
        }
        field(13;"Period Month";Integer)
        {
        }
        field(14;"Period Year";Integer)
        {
        }
        field(15;"Payroll Period";Date)
        {
        }
    }

    keys
    {
        key(Key1;"Employee No.","Payroll Period","Period Month","Period Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

