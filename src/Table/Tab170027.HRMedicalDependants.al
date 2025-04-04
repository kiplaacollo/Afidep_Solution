Table 170027 "HR Medical Dependants"
{

    fields
    {
        field(1;"Scheme No";Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2;"Dependant Names";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Dependant Id No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Dependant Phone No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Dependant Year Of Birth";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Relationship Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Spouse,Child';
            OptionMembers = Spouse,Child;
        }
        field(7;Gender;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Female,Male';
            OptionMembers = Female,Male;
        }
        field(8;"Job Application Nos";Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Scheme No","Dependant Names")
        {
            Clustered = true;
        }
        key(Key2;"Dependant Names","Dependant Id No")
        {
        }
    }

    fieldgroups
    {
    }
}

