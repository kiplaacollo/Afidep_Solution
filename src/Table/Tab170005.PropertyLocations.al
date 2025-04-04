Table 170005 "Property Locations"
{

    fields
    {
        field(1;Location;Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Location Description";Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;Location)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

