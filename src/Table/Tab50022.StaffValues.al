Table 50022 "Staff Values"
{

    fields
    {
        field(1; Value; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",Accountabily,Focus,Integrity,Diversity,Excellence,Passion;
            OptionCaption = ',Accountabily,Focus,Integrity,Diversity,Excellence,Passion';
        }
        field(2; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Accountabily; text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Focus; text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Integrity; text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Diversity; text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Excellence; text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Passion; text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Improvement Require"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Average; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Good; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Excellent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Comments; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Appraisal No"; Code[30])
        {
            TableRelation = "HR Appraisal Header"."No.";
        }
    }

    keys
    {
        key(Key1; Value,"Appraisal No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

