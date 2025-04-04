table 170105 "Proposal Partner"
{

    fields
    {
        field(1; "Proposal Code"; Code[20])
        {
        }
        field(2; "Partner Name"; Text[200])
        {
            TableRelation = Customer where("Customer Posting Group" = const('COLLAB'));
        }
        field(3; Address; Text[100])
        {
        }
        field(4; "Address 2"; Text[100])
        {
        }
        field(5; "Telephone No."; Code[20])
        {
        }
        field(6; Country; Code[100])
        {
            TableRelation = "Country/Region";
        }
        field(7; Region; Option)
        {
            OptionMembers = ,Southern,Northern;
        }
        field(8; Scope; Option)
        {
            OptionMembers = ,"Local",International;
        }
        field(9; Amount; Decimal)
        {
            DecimalPlaces = 2;
        }
    }

    keys
    {
        key(Key1; "Proposal Code", "Partner Name")
        {
        }
    }

    fieldgroups
    {
    }
}

