table 50025 "Bid Analysis Comment"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(3; Comment; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; No, Comment)
        {
            Clustered = true;
        }
        key(Key2; Comment)
        {

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