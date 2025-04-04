Table 172058 "Project Outputs"
{

    fields
    {
        field(1; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;
        }
        field(2; "Output Summary"; Text[1000])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Locations;
        }
        field(3; Indicator; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Means of Verification"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Risks/Assumptions"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Key"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
       
    }

    keys
    {
        key(Key1; "Project Code", "Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Locations: Record Locations;
}

