Table 172052 "Projects"
{

    fields
    {
        field(1; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Award."No.";
            trigger OnValidate()
            begin
                project.Reset;
                project.SetRange(project."No.", "Project Code");
                if project.Find('-') then begin
                    // Message('kimi yu');
                    "Project Name" := project.Description;
                    "Project Short Name" := project.Name;
                    "Thematic Programme" := project."Global Dimension 5 Code";
                    //  Message('kimi yu: %1', project."Global Dimension 5 Code");
                    "Start Date" := project."Start Date";
                    "End Date" := project."End Date";
                    Partner := project."Sponsoring Funder No.";
                    // Message('kimi yu: %1', project."End Date");
                end;
            end;
            // TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROJECTS'));

            // trigger OnValidate()
            // begin
            //     DimensionValue.Reset;
            //     DimensionValue.SetRange(Code, "Project Code");
            //     if DimensionValue.FindFirst then
            //         "Project Name" := DimensionValue.Name;
            //     "Thematic Programme" := DimensionValue."Thematic Code";
            //     "Project Manager & SMT Lead " := DimensionValue."Approver ID";

            // end;
        }
        field(2; "Project Name"; Text[500])
        {
            DataClassification = ToBeClassified;
            // Editable = false;
        }
        field(3; Partner; Code[100])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Partners;
        }
        field(4; Donor; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Donors;
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No of Beneficiaries"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Weight; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Header No"; Code[40])
        {
        }
        field(10; "Thematic Programme"; code[100])
        {
            //  TableRelation = "Dimension Value".Name where("Dimension Code" = const('THEMATIC'));
        }
        field(11; "Project Manager & SMT Lead "; Code[100])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(12; "Completed by"; Code[70])
        {
        }
        field(13; "Project Short Name"; Text[200])
        {
        }
        field(14; "Project rationale"; Text[2048])
        {
        }
        field(15; Indicator; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Goal Summary"; Text[2048])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Locations;
        }
        field(17; "INSTITUTIONAL STRATEGIC 1"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "INSTITUTIONAL STRATEGIC 2"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "INSTITUTIONAL STRATEGIC 3"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Project Objective 1: "; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Project Objective 2: "; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Project Objective 3: "; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Project Objective 4: "; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Project Objective 5: "; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Project Objective 6: "; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Anticipated Risks "; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Risk Mitigation "; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Opportunities "; Text[1000])
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
        DimensionValue: Record "Dimension Value";
        project: Record Award;
}

