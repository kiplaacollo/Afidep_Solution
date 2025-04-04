Table 172050 "Donors"
{
    DrillDownPageID = Donors;
    LookupPageID = Donors;

    fields
    {
        field(1; "Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value" where("Dimension Code" = const('DONOR'));
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

