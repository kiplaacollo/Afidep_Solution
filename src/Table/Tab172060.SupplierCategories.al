Table 172060 "Supplier Categories"
{
    DrillDownPageID = "Supplier Categories";
    LookupPageID = "Supplier Categories";

    fields
    {
        field(1;"Code";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Description;Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Category;Code[100])
        {
            DataClassification = ToBeClassified;
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

