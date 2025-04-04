Table 170029 "Scheme Subcategory"
{
    LookupPageID = "Scheme Subcategories";

    fields
    {
        field(1;"Scheme Category";Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Scheme Name";Code[120])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Scheme Category")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

