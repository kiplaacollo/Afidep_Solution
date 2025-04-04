Table 172067 "Report Q3"
{

    fields
    {
        field(1; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;
        }
        field(2; "Key Activities"; Text[1000])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Locations;
        }
        field(3; "Activity status"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Any Variation"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Key Deliverables"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Key"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(7; "Key Outcomes"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Planned Activities"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Key Challenges Faced"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Opportunities Identified"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Lessons Learnt"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Commmunications Outputs"; Text[1000])
        {
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

