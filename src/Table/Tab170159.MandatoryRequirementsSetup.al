Table 170159 "Mandatory Requirements Setup"
{

    fields
    {
        field(1;"Code";Code[20])
        {
        }
        field(2;Requirement;Text[250])
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Code",Requirement)
        {
        }
    }
}

