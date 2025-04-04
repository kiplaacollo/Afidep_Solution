Table 172046 "HR Documents"
{

    fields
    {
        field(1;"Code";Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Description;Text[1000])
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

