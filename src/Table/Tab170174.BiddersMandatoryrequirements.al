Table 170174 "Bidders Mandatory requirements"
{

    fields
    {
        field(1; "Tendor No"; Code[20])
        {
        }
        field(2; "Code"; Code[20])
        {
            TableRelation = "Tender Mandatory Requirements";
        }
        field(3; Requirement; Text[250])
        {
        }
        field(4; Status; Option)
        {
            OptionMembers = " ",Available,"Not Available";
        }
        field(5; "Vendor No"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Tendor No", "Code", "Vendor No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

