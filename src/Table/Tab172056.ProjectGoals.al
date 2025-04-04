Table 172056 "Project Goals"
{

    fields
    {
        field(1; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;
        }
        field(2; "Goal Summary"; Text[2048])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Locations;
        }
        field(3; Indicator; Text[2048])
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
        field(7; "Objective & Outcomes"; Option)
        {
            OptionMembers = "","Monthly Reports:","Quarterly Report:","Funder's Report:";
        }
        field(8; Responsible; Code[50])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(9; "Anticipated Outcomes"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Key Deliverables"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Year 1"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Year 2"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Year 3"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Q1; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Q2; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Q3; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Q4; Text[200])
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

