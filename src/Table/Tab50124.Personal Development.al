Table 50124 "Personal Development "
{

    fields
    {
        field(1; "Appraisal No."; Code[30])
        {
            Editable = false;
            TableRelation = "HR Appraisal Header"."No.";
        }
        field(2; "Key Value Driver"; Code[40])
        {
            Editable = false;
        }
        field(3; "Areas to develop"; Text[200])
        {
            // Editable = false;
        }
        field(4; "Development activities"; Text[250])
        {
            // Editable = false;
            //ValuesAllowed = '"<>"';
        }
        field(5; "Resources required"; Text[100])
        {
        }
        field(6; "Targets and Timelines"; Text[200])
        {
        }

    }

    keys
    {
        key(Key1; "Appraisal No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

    end;

    var
        Wplines: Record "Appraissal Lines WP";
        Proj: Record "Projects Work Load";
}

