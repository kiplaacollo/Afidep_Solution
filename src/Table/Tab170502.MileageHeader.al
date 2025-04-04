Table 170502 "MileageHeader"
{

    fields
    {
        field(1;"code";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Plateno;Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Purpose;Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4;county;Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(5;nature;Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(6;repaircost;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;comments;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8;StartDate;Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9;employee;Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Point of departure";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11;Destination;Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Total fuel";Decimal)
        {
            CalcFormula = sum(MileageLines.fuelLitres where (Mileagecode=field(code)));
            FieldClass = FlowField;
        }
        field(13;"Total cost";Decimal)
        {
            CalcFormula = sum(MileageLines.fuelKsh where (Mileagecode=field(code)));
            FieldClass = FlowField;
        }
        field(14;"Total miles";Decimal)
        {
            CalcFormula = sum(MileageLines.TotalMieleage where (Mileagecode=field(code)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

