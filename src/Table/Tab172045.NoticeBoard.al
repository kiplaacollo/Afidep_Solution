Table 172045 "Notice Board"
{

    fields
    {
        field(1; "Date of Announcement"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Department Announcing"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Announcement; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Date of Announcement", Announcement)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

