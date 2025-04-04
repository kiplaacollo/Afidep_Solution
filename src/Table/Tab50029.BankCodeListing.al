Table 50029 "Bank Code Listing"
{

    fields
    {
        field(1;"Bank Narration";Code[200])
        {
        }
        field(2;"Branch Code";Code[100])
        {
        }
        field(3;"Branch Name";Text[200])
        {
        }
        field(4;"Branch Address";Text[200])
        {
        }
        field(5;Telephone;Text[2048])
        {
        }
        field(6;"Fax Number";Text[2048])
        {
        }
        field(7;"Bank Code";Code[100])
        {
        }
        field(8;"Bank Name";Text[200])
        {
        }
    }

    keys
    {
        key(Key1;"Bank Narration","Branch Code","Branch Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

