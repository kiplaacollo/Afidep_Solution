Table 170028 "Scheme Categories"
{

    fields
    {
        field(1;"Scheme Number";Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Scheme Category";Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Scheme Subcategory"."Scheme Category";
        }
        field(3;Inpatient;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4;Maternity;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;Outpatient;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;Optical;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;Dental;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Last Expense";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Scheme Number","Scheme Category")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

