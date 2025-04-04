Table 170503 "MileageLines"
{

    fields
    {
        field(1;Mileagecode;Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2;startodo;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3;endodo;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4;fuelLitres;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;fuelKsh;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;EntryNo;Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(7;stoplocation;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8;TotalMieleage;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TotalMieleage:= endodo-startodo;
    end;
}

