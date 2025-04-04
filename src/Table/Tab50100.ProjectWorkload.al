Table 50100 "Projects Work Load"
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

        field(3; Weight; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Header No"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Line No"; integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Line No", "Project Code", "Header No")
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

