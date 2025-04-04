table 50125 "Field Mapping"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Field Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Field No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Table ID", "Field Name")
        {
            Clustered = true;
        }
    }
}
