Table 170172 "Mandatory Requirements"
{

    fields
    {
        field(1;"Code";Code[10])
        {
        }
        field(2;"Doc No";Code[10])
        {
        }
        field(3;Description;Text[100])
        {
        }
    }

    keys
    {
        key(Key1;"Code","Doc No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

