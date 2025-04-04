table 170081 "Award Notification"
{

    fields
    {
        field(1; "Award No"; Code[10])
        {
            //TableRelation = Award.No.;
        }
        field(2; "Notification Code"; Code[100])
        {
        }
        field(3; "Notification Header"; Text[100])
        {
        }
        field(4; "Notification Body"; Text[2048])
        {
        }
        field(5; Deadline; Date)
        {
        }
        field(6; "Notify (Days before Deadline)"; Integer)
        {
        }
        field(7; "Notify2 (Days before Deadline)"; Integer)
        {
        }
        field(8; "Notify3 (Days before Deadline)"; Integer)
        {
        }
        field(9; Type; Option)
        {
            OptionMembers = "","Key Milestones","Report";
            OptionCaption = ' ,Key Milestones,Report';
        }
        field(10; Status; Option)
        {
            OptionMembers = "","completed","Not Completed","Submitted","Not Submitted";
            OptionCaption = ',Completed,Not Completed,Submitted,Not Submitted';
        }
        field(11; "Date Submitted"; Date)
        {
        }
        field(12; Comments; Text[1000])
        {
        }
    }

    keys
    {
        key(Key1; "Award No")
        {
        }
    }

    fieldgroups
    {
    }
}

