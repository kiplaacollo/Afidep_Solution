table 50026 "Bid Analysis Committee"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Purchase Header"."No." where("AU Form Type" = filter(RFQ));

        }
        field(2; "Name of the Member"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Phone No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "ID No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Position; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Captured By"; Code[50])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(7; "Date Time"; DateTime)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No, "ID No.", "Name of the Member")
        {
            Clustered = true;
        }
        key(PK; "ID No.", "Name of the Member")
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