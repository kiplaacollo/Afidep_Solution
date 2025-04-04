Table 170019 "Meter Reading History"
{

    fields
    {
        field(1;No;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;Date;Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3;Unit;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Property;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5;Tenant;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Meter Reading";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Billing Period";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Billing Document";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Billing Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Single,Mass';
            OptionMembers = ,Single,Mass;
        }
        field(10;"Amount Billed";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

