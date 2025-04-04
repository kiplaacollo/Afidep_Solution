table 170082 "Budget Import"
{
    Caption = 'Budget Import';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Thematic Code"; Code[20])
        {
            Caption = 'Thematic Code';
        }
        field(2; "Thematic Name"; Text[1000])
        {
            Caption = 'Thematic Name';
        }
        field(3; "Project Code"; Code[20])
        {
            Caption = 'Project Code';
            trigger OnValidate()
            var
                Dimesion: Record "Dimension Value";
            begin
                Dimesion.Reset();
                Dimesion.SetRange(code, "Project Code");
                if Dimesion.find('-') then begin
                    "Project Name" := Dimesion.Name;
                end;
            end;
        }
        field(4; "Project Name"; Text[100])
        {
            Caption = 'Project Name';
        }
        field(5; "Expense Category"; Code[100])
        {
            Caption = 'Expense Category';
            trigger OnValidate()
            var
                Dimesion: Record "Dimension Value";
            begin
                Dimesion.Reset();
                Dimesion.SetRange(code, "Expense Category");
                if Dimesion.find('-') then begin
                    "Expense Category Name" := Dimesion.Name;
                end;
            end;
        }
        field(6; "Expense Category Name"; Text[100])
        {
            Caption = 'Expense Category Name';
        }
        field(7; "Budget Line"; Code[100])
        {
            Caption = 'Budget Line';
        }
        field(8; "BudgetLine Name"; Text[100])
        {
            Caption = 'BudgetLine Name';
        }
        field(9; "Dimesion type"; Text[100])
        {
            Caption = 'Dimesion type';
        }
        field(10; "Budget Amount"; Decimal)
        {
            Caption = 'Budget Amount';
        }
        field(11; "Standard"; Option)
        {
            OptionCaption = 'Standard,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Standard,Heading,Total,"Begin-Total","End-Total";
        }
        field(12; "GL Account"; Code[200])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(13; "Dimension Code"; Code[200])
        {

        }
    }
    keys
    {
        key(PK; "Thematic Code", "Budget Line", "Project Code", "Expense Category")
        {
            Clustered = true;
        }
    }
}
