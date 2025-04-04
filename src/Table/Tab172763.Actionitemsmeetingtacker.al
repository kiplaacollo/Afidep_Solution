table 172763 "Action items meeting tacker"
{
    Caption = 'Action items meeting tacker';
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
        field(3; "Action by Whom Staff"; Text[100])
        {
            Caption = 'Action by Whom';
           // TableRelation = "HR Employees";

        }
        field(10; "Staff Name"; Code[100])
        {

        }
        field(8; "Action by Whom Patner"; Text[100])
        {
            Caption = 'Action by Whom';
            TableRelation = Partners;

        }
        field(4; "By when"; Date)
        {
            Caption = 'By when';
        }
        field(5; "Notes"; Text[2048])
        {
            Caption = 'Notes';
        }
        field(6; ActionByStaff; option)
        {
            OptionMembers = "Staff";
            // TableRelation = "HR Employees";

        }
        field(7; ActionByPatner; option)
        {
            OptionMembers = "Patner";
            //TableRelation = Partners;

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
