Table 170037 "HR Committees"
{
    // DrillDownPageID = UnknownPage51525078;
    // LookupPageID = UnknownPage51525078;

    fields
    {
        field(1;"Code";Code[20])
        {
            NotBlank = true;
        }
        field(2;Description;Text[200])
        {
            NotBlank = true;
        }
        field(3;Roles;Text[200])
        {
        }
        field(4;"Transaction Amount";Decimal)
        {
        }
        field(5;"Transaction Code";Code[45])
        {
        }
        field(6;"Monetary Benefit?";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

