Table 172044 "Allocation Line2"
{

    fields
    {
        field(1;"Allocation No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Line No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3;"G/L Account";Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(4;"Shortcut Dimension 1 Code";Code[50])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1),
                                                          Blocked=const(false));
        }
        field(5;"Shortcut Dimension 2 Code";Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2),
                                                          Blocked=const(false));
        }
        field(6;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Allocation No","Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

