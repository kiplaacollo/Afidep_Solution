tableextension 50030 "Time Sheet LineExt" extends "Time Sheet Line"
{
    fields
    {
        field(60; Project; Code[250])
        {
            Caption = 'Project';

            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROJECTS'));
            trigger OnValidate()
            var
                Dim: Record "Dimension Value";
            begin
                Dim.Reset();
                Dim.SetRange(Code, Project);
                if Dim.Find('-') then begin
                    "Projecct decription" := Dim.Name;
                end;
            end;
            // DataClassification = ToBeClassified;
        }
        field(61; "Projecct decription"; Text[2048])
        {
            Caption = 'Projecct decription';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(62; "Work Description"; Text[2048])
        {

        }
    }
}
