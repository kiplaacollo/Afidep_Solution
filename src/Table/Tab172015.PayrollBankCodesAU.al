Table 172015 "Payroll Bank Codes_AU"
{
    DrillDownPageID = "Bank codes";
    LookupPageID = "Bank codes";

    fields
    {
        field(10; "Bank Code"; Code[10])
        {
        }
        field(11; "Bank Name"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Bank Code", "Bank Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

