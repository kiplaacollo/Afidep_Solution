table 50036 "EmailLogs"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "User Id"; Code[200]) { DataClassification = ToBeClassified; }
        field(3; Message; Text[2048]) { DataClassification = ToBeClassified; }
        field(4; "Time Sent"; Time) { DataClassification = ToBeClassified; }
        field(5; "Date Sent"; Date) { DataClassification = ToBeClassified; }
        field(6; "Employee Name"; Code[100]) { DataClassification = ToBeClassified; }
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