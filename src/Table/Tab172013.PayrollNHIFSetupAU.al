Table 172013 "Payroll NHIF Setup_AU"
{

    fields
    {
        field(10;"Tier Code";Code[10])
        {
        }
        field(11;"NHIF Tier";Decimal)
        {
        }
        field(12;Amount;Decimal)
        {
        }
        field(13;"Lower Limit";Decimal)
        {
        }
        field(14;"Upper Limit";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Tier Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

