Table 172031 "HR Job Qualifications"
{
    Caption = 'HR Qualifications';
    DataCaptionFields = "Code",Description;
    DrillDownPageID = "HR Job Qualifications";
    LookupPageID = "HR Job Qualifications";

    fields
    {
        field(1;"Qualification Type";Code[50])
        {
            TableRelation = "HR Lookup Values".Code where (Type=const("Qualification Type"));
        }
        field(2;"Code";Code[100])
        {
            Caption = 'Code';
        }
        field(6;Description;Text[100])
        {
            Caption = 'Description';
            NotBlank = true;
        }
        field(10;code3;Code[100])
        {
        }
        field(11;Equivalence;Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Qualification Type","Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

