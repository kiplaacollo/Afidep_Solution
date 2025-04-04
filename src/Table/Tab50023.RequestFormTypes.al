table 50023 "Request Form Types"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Type; Integer)
        {
            DataClassification = ToBeClassified;



        }
        field(5; "Type 2"; Enum "Purchase Line Type")
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Type of Request"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Account No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            trigger OnValidate()
            var
                GLAccount: Record "G/L Account";

            begin
                GLAccount.Reset();
                GLAccount.SetRange("No.", "Account No");
                if GLAccount.FindFirst() then begin
                    "Account Name" := GLAccount.Name;
                end;
            end;
        }
        field(4; "Account Name"; text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Type of Request")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

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