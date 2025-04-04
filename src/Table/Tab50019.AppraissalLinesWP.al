Table 50019 "Appraissal Lines WP"
{

    fields
    {
        field(1; "Appraisal No."; Integer)
        {
            Editable = false;
            TableRelation = "HR Appraisal Header"."No.";
        }
        field(2; "Key Value Driver"; Code[40])
        {
            Editable = false;
        }
        field(3; "Key Performance Indicator"; Text[2040])
        {
            // Editable = false;
        }
        field(4; "Agreed Performance Targets"; Text[2040])
        {
            // Editable = false;
            //ValuesAllowed = '"<>"';
        }
        field(5; "Appraisee Comments"; Text[2040])
        {
        }
        field(6; "Actual Achievement"; Text[2040])
        {
        }
        field(8; "Self Assesment Score"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
        }
        field(9; "Self Comments"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Use Rating Scale';
            Editable = false;
        }
        field(10; "Supervisor-Assesment"; Decimal)
        {
            BlankZero = true;
            Caption = 'Supervisor-Assesment(Score)';
            DataClassification = ToBeClassified;
        }
        field(11; "Supervisors Comments"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Use Rating Scale';
            Editable = false;
        }
        field(12; "Agreed-Assesment Score"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Weighted Average" := ROUND(("Agreed-Assesment Score" / Weight), 0.05, '>');
            end;
        }
        field(13; "Header No"; Code[40])
        {
        }
        field(14; "Weighted Average"; Decimal)
        {
        }
        field(15; Weight; Decimal)
        {
            TableRelation = "Projects Work Load".Weight;
            Editable = false;
        }
        field(16; "Project Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Projects Work Load"."Project Code";
            trigger OnValidate()
            begin
                Proj.Reset();
                Proj.SetRange("Project Code", "Project Code");
                Proj.SetFilter(Proj."Header No", "Header No");
                if Proj.Find('-') then
                    Proj."Header No" := "Header No";
            end;
        }
        field(17; Objectives; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Appraisee Rating"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(19; "Appraiser Rating"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","1","2","3","4";
        }
        field(20; "Line No"; integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Line No", "Appraisal No.", "Header No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Wplines.FindLast then
            "Appraisal No." := Wplines."Appraisal No." + 1
        else
            "Appraisal No." := 1;
    end;

    var
        Wplines: Record "Appraissal Lines WP";
        Proj: Record "Projects Work Load";
}

