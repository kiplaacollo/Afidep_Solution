table 172069 "Donors Budget Matrix line"
{
    DataClassification = ToBeClassified;
    LookupPageId = "budget Line Matrix";
    fields
    {
        field(1; "Code"; Code[2000])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Project Budget Matrix Header";
        }

        field(3; "Fund No Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('FUND NO.'), "Dimension Value Type" = filter(Standard));
        }
        field(4; "Fund No Description"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Budget Line No Code"; Code[2000])

        {
            //TableRelation = "Dimension Value".Code where("Dimension Code" = const('BUDGET LINE'));
            DataClassification = ToBeClassified;
        }
        field(6; "Budget Line Description"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Donor Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DONOR'), "Dimension Value Type" = filter(Standard));
            DataClassification = ToBeClassified;
        }
        field(8; "Donor Description"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Programme Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROGRAMME'), "Dimension Value Type" = filter(Standard));
            DataClassification = ToBeClassified;
        }
        field(10; "Programme Description"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Output Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('OUTPUT'), "Dimension Value Type" = filter(Standard));
            DataClassification = ToBeClassified;
        }
        field(12; "Output Description"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Cost Category Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('COST CATEGORY'), "Dimension Value Type" = filter(Standard));
            DataClassification = ToBeClassified;
        }
        field(14; "Cost Category Description"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "GL Account No"; Code[20])
        {
            TableRelation = "G/L Account" where("Direct Posting" = const(true));
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                GLName.Reset();
                GLName.SetRange(GLName."No.", "GL Account No");
                if GLName.FindFirst() then begin
                    "GL Account Name" := GLName.Name;
                end;
            end;

        }
        field(16; "GL Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Staff Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('STAFF NO.'), "Dimension Value Type" = filter(Standard));
            DataClassification = ToBeClassified;
        }
        field(18; "Staff Description"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Grant Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('GRANT'), "Dimension Value Type" = filter(Standard));
            DataClassification = ToBeClassified;
        }
        field(20; "Grant Description"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Budget Line code Category"; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BUDGET LINE'), "Dimension Value Type" = filter("Begin-Total"));
        }
        field(23; "Budget Template Description Category"; code[150])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Budget T Description Category"."Budget Template Description Category";
        }
        field(24; "Total Budget Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(25; "Total Actual Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(26; "Currency"; Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency."ISO Code";

        }
        field(27; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Account";

        }
        field(28; "Budget Line Description."; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Actual Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("G/L Entry".Amount where("Global Dimension 1 Code" = field("Fund No Code"), "Global Dimension 2 Code" = field("Budget Line No Code"), "G/L Account No." = field("GL Account No")));
        }
        field(31; "Transaction from"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Transaction To"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Budget Code2"; Code[20])

        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BUDGET LINE'));
            DataClassification = ToBeClassified;
        }
        field(34; "Committed Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line".Amount where("Budget Speed key" = field("Budget Line No Code")));
        }
    }

    keys
    {
        key(Key1; "Line No", Code, "Budget Line No Code", "Fund No Code", "Budget Line Description.", "Donor Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        ObjProjectBDMH: Record "Donors Budget Matrix line";
        GLName: Record "G/L Account";

    trigger OnInsert()
    begin
        ObjProjectBDMH.Reset();
        if ObjProjectBDMH.FindLast() then begin
            "Line No" := ObjProjectBDMH."Line No" + 1;
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}