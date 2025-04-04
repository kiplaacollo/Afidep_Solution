Table 172012 "Payroll PAYE Setup_AU"
{

    fields
    {
        field(10;"Tier Code";Code[10])
        {
        }
        field(12;"PAYE Tier";Decimal)
        {
        }
        field(13;Rate;Decimal)
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

