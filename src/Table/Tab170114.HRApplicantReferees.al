Table 170114 "HR Applicant Referees"
{

    fields
    {
        field(1; "Job Application No"; Code[20])
        {
            TableRelation = "HR Job Applications"."Application No";
        }
        field(2; Names; Text[200])
        {
        }
        field(3; Designation; Text[100])
        {
        }
        field(4; Institution; Text[100])
        {
        }
        field(5; Address; Text[200])
        {
        }
        field(6; "Telephone No"; Text[100])
        {
        }
        field(7; "E-Mail"; Text[100])
        {
        }
        field(8; "Employee No"; Code[30])
        {
        }
        field(9; "Application No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Applicant Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Referee No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Premise Application No."; Code[30])
        {
            // TableRelation = Table170113.Field1;
        }
        field(13; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

