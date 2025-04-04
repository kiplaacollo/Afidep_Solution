Table 50102 Confirmation
{

    fields
    {
        field(1; "Employee’s Signature"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees".Signature;

        }
        field(4; "Appraiser’s Signature"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees".Signature;

        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Header No"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Header No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


}

