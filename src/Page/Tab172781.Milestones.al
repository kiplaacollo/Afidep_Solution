table 172781 "Milestones "
{
    Caption = 'Milestones ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Contract; Code[40])
        {
            Caption = 'Contract';
        }
        field(2; "Milestone description"; Text[2048])
        {
            Caption = 'Milestone description';
        }

        field(8; Deadline; Date)
        {
            Caption = 'Deadline';
        }
        field(3; "Notification 1"; Integer)
        {
            Caption = 'Notification 1';
        }
        field(4; "Notification 2"; Integer)
        {
            Caption = 'Notification 2';
        }
        field(5; "Notification 3"; Integer)
        {
            Caption = 'Notification 3';
        }
        field(6; Status; Option)
        {
            OptionMembers = Pending,"Work in progress",Complete;
            Caption = 'Status';
        }
        field(7; "Action by"; Code[50])
        {
            Caption = 'Action by';
            TableRelation = "HR Employees"."No.";
        }

    }
    keys
    {
        key(PK; Contract, Deadline)
        {
            Clustered = true;
        }


    }
}
