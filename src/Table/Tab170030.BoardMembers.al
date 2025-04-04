Table 170030 "Board Members"
{

    fields
    {
        field(1;No;Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Member Name";Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Member ID No";Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Member Telephone";Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Requisition No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(28;text;Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;No,"Member Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

