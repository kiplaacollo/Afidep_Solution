Table 170022 "Mass Unit Update Lines"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Document Number";Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Ammenity;Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;Description;Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if EntryNo.FindLast then
        "Entry No":=EntryNo."Entry No"+1
        else
        "Entry No":=1;
    end;

    var
        EntryNo: Record "Mass Unit Update Lines";
}

