Table 172016 "Payroll Bank Branches_AU"
{

    fields
    {
        field(10;"Bank Code";Code[100])
        {
            TableRelation = "Payroll Bank Codes_AU"."Bank Code";
        }
        field(11;"Branch Code";Code[100])
        {
        }
        field(12;"Branch Name";Text[100])
        {
        }
        field(13;"Branch Physical Location";Text[100])
        {
        }
        field(14;"Branch Postal Code";Code[20])
        {
        }
        field(15;"Branch Address";Text[50])
        {
        }
        field(16;"Branch Phone No.";Code[50])
        {
        }
        field(17;"Branch Mobile No.";Code[50])
        {
        }
        field(18;"Branch Email Address";Text[100])
        {
        }
    }

    keys
    {
        key(Key1;"Bank Code","Branch Code","Branch Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

