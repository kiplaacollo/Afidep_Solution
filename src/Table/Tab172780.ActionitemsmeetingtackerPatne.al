table 172800 "Action items meeting tacker P"
{
    Caption = 'Action items meeting tacker Patner';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';
        }
        field(2; "Action item"; Text[2048])
        {
            Caption = 'Action item';
        }

        field(8; "Action by Whom Patner"; Text[100])
        {
            Caption = 'Action by Whom';
            //TableRelation = PrtnerMeetingtracker.Code;

        }
        field(4; "By when"; Date)
        {
            Caption = 'By when';
        }
        field(5; "Notes"; Text[2048])
        {
            Caption = 'Notes';
        }

        field(7; ActionByPatner; option)
        {
            OptionMembers = "Patner";

        }
    }
    keys
    {
        key(PK; "Code", "Action item")
        {
            Clustered = true;
        }
    }
    var
        HrEmp: Record "HR Employees";
}
