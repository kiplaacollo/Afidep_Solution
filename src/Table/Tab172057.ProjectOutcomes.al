Table 172057 "Project Outcomes"
{

    fields
    {
        field(1; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;
        }
        field(2; "Outcomes Summary"; Text[1000])
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
        field(7; "Activities by Objective"; Option)
        {
            OptionMembers = "","Funder's Report:";
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
        field(14; "Reports Deadline"; Date)
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

