table 172778 "P_Updates"
{

    fields
    {
        field(1; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Update; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; User; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";

            trigger OnValidate()
            begin
                UserSetup.SETRANGE("User ID", User);
                //  IF UserSetup.FIND('-') THEN
                // Name:=UserSetup.Name;
            end;
        }
        field(4; "Update Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Legal,Project';
            OptionMembers = ,Legal,Project;
        }
        field(5; No; Code[50])
        {
        }
        field(6; "Planned Start Date"; Date)
        {
        }
        field(7; "Planned End Date"; Date)
        {
        }
        field(8; Status; Option)
        {
            OptionMembers = " ",Open,WIP,Closed;
        }
        field(9; Name; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; Date, No, Update)
        {
        }
    }

    fieldgroups
    {
    }

    var
        UserSetup: Record "91";
}

