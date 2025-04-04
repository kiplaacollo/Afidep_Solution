Table 172054 "Project Locations"
{

    fields
    {
        field(1; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Projects;
        }
        field(2; "Location Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                if Locations.Get("Project Code") then
                    "Location Name" := Locations.Name;
            end;
        }
        field(3; "Location Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Project Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Locations: Record "Dimension Value";
}

