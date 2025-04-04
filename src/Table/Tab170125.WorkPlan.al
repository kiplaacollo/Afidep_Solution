table 170125 WorkPlan
{
    Caption = 'WorkPlan';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Project Code"; Code[50])
        {
            Caption = 'Project Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROJECTS'));
        }
        field(2; "Project Description"; Text[1024])
        {
            Caption = 'Project Description';
        }
        field(3; "Workplan Code"; Code[50])
        {
            Caption = 'Workplan Code';
        }
        field(4; "Workplan Descption"; Text[1000])
        {
            Caption = 'Workplan Descption';
        }
    }
    keys
    {
        key(PK; "Project Code", "Workplan Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Project Code", "Project Description", "Workplan Code", "Workplan Descption")
        {

        }
        fieldgroup(Brick; "Project Code", "Project Description", "Workplan Code", "Workplan Descption")
        {

        }

    }
}
