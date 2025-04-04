Table 170009 "Duration Types"
{

    fields
    {
        field(1;"Duration Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Duration Details";Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Duration;DateFormula)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Duration Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

