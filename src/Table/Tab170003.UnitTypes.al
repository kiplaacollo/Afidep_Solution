Table 170003 "Unit Types"
{
    LookupPageID = "Unit Types";

    fields
    {
        field(1;"Unit Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Unit Type";Text[40])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Unit Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

