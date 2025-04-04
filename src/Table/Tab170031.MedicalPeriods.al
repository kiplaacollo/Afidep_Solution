Table 170031 "Medical Periods"
{

    fields
    {
        field(1;"Period Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Period Start Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Period End Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4;Closed;Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Period Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

