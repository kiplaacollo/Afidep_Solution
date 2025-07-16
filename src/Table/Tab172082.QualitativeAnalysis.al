Table 172082 "Qualitative Indicators"
{

    fields
    {
        field(1; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;
        }
        field(2; Indicator; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"PO1.3 Qualitative feedback","MO1.3 Qualitative evidence","MO3.3 Qualitative evidence","MO4.2 Qualitative feedback";
        }
        field(3; "Indicator Level"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"Primary Outcome","Medium-term Outcome 1","Medium-term Outcome 3","Medium-term Outcome 4";
        }
        field(4; Baseline; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Q1; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Q2; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Q3; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Q4; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Data Source/Reporting projects"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Comments; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Project Code", Indicator)
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

