Table 170008 "Unit Transaction Types"
{

    fields
    {
        field(1;"Transaction Code";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Transaction Description";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Transaction Type";Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Payment,Receipt,Imprest,Claim';
            OptionMembers = Payment,Receipt,Imprest,Claim;
        }
        field(4;"Account Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,Investor';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        }
        field(5;"Account No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(6;"Account Name";Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7;"Default Grouping";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"VAT Chargeable";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"VAT Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Withholding Tax Chargeable";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Withholding Tax Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Transaction Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

