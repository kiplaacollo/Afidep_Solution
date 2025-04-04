table 50002 "Approval Notification Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Approver ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Sender ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Employee Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(5; "Email Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Time Sent"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Date Sent"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Notification Type"; Option)
        {
            OptionMembers = " ","Send Approval","Approve Document","Reject Document";
        }
        field(10; Status; Enum "Approval Status")
        {
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