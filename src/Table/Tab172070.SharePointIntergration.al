table 172070 "SharePoint Intergration"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Document No"; Code[250])
        {

        }
        field(3; "LocalUrl"; Text[2048])
        {

        }
        field(4; "Description"; Text[2048])
        {

        }
        field(5; "Uploaded"; Boolean)
        {

        }
        field(6; "Fetch_To_Sharepoint"; Boolean)
        {

        }
        field(7; Polled; Boolean)
        {

        }
        field(8; Base_URL; Text[2048])
        {

        }
        field(9; SP_URL_Returned; Text[2048])
        {


        }
        field(10; Failure_reason; Text[2048])
        {
            ExtendedDatatype = URL;
        }
    }

    keys
    {
        key(Key1; "Entry No")
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