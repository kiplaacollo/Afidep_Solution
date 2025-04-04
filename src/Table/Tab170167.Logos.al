Table 170167 "Logos"
{

    fields
    {
        field(1;"Code";Code[50])
        {
            TableRelation = "Dimension Value".Code where ("Dimension Code"=filter('FUND'));
        }
        field(29;Picture;Blob)
        {
            SubType = Bitmap;
        }
        field(30;Default;Boolean)
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
    }
}

