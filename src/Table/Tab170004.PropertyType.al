Table 170004 "Property Type"
{

    fields
    {
        field(1;"Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Property Type";Text[100])
        {
            DataClassification = ToBeClassified;
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

