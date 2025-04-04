Table 50101 "Resources Required "
{

    fields
    {
        field(1; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROJECTS'));

            trigger OnValidate()
            begin
                DimensionValue.Reset;
                DimensionValue.SetRange(Code, "Project Code");
                if DimensionValue.FindFirst then
                    "Project Name" := DimensionValue.Name;

            end;
        }
        field(2; "Project Name"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Header No"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Resources Required"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Intervention; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Targets and timelines"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Person Responsible"; Text[1000])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees";
        }
         field(8; "Line No"; integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1;"Line No", "Header No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DimensionValue: Record "Dimension Value";
}

