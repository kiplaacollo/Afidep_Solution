Table 50035 "Portal Document upload"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Document No"; Code[2000])
        {
        }
        field(3; "Description"; Text[2000])
        {
        }
        field(4; "Url"; Text[2000])
        {
            ExtendedDatatype = URL;
            
            
        }
        field(6;"File Name"; Text[2048])
        {
            
        }
        field(5; Uploaded; Boolean)
        {
        }

    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

