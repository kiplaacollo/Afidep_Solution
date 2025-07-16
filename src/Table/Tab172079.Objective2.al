Table 172079 "Objective 2"
{

    fields
    {
        field(1; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;
        }
        field(2; "Project Objecive / Outcome"; Text[1000])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Locations;
        }
        field(3; "No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Anticipated Outcomes"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Key Deliverables"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Key"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(8; Responsible; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Q1; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Q2; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Q3; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Q4; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Year; Code[20])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "Project Code", "No.", Year, "Key")
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

