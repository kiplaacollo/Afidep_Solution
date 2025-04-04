Table 172051 "Locations"
{
    DrillDownPageID = Locations;
    LookupPageID = Locations;

    fields
    {
        field(1;"Code";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Description;Text[100])
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

