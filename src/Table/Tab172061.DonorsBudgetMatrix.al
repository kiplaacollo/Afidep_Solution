Table 172061 "Donors Budget Matrix"
{
    //DrillDownPageID = "Supplier Categories";
    //LookupPageID = "Supplier Categories";

    fields
    {
        field(1;"Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Budget Template Description";Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Fund No Code";Code[20])
        {
            DataClassification = ToBeClassified;
             TableRelation = "Dimension Value".Code where("Dimension Code" = const('FUND NO.'),"Dimension Value Type"=filter(Standard));
        }
        field(4;"Fund No Description";Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Budget Line No Code";Code[20])
        
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BUDGET LINE'),"Dimension Value Type"=filter(Standard));
            DataClassification = ToBeClassified;
        }
        field(6;"Budget Line Description";Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Donor Code";Code[20])
        {
             TableRelation = "Dimension Value".Code where("Dimension Code" = const('DONOR'),"Dimension Value Type"=filter(Standard));
            DataClassification = ToBeClassified;
        }
        field(8;"Donor Description";Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Programme Code";Code[20])
        {
             TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROGRAMME'),"Dimension Value Type"=filter(Standard));
            DataClassification = ToBeClassified;
        }
        field(10;"Programme Description";Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Output Code";Code[20])
        {
             TableRelation = "Dimension Value".Code where("Dimension Code" = const('OUTPUT'),"Dimension Value Type"=filter(Standard));
            DataClassification = ToBeClassified;
        }
        field(12;"Output Description";Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Cost Category Code";Code[20])
        {
             TableRelation = "Dimension Value".Code where("Dimension Code" = const('COST CATEGORY'),"Dimension Value Type"=filter(Standard));
            DataClassification = ToBeClassified;
        }
        field(14;"Cost Category Description";Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15;"GL Account No";Code[20])
        {
             TableRelation = "G/L Account" where("Direct Posting" = const(true));
            DataClassification = ToBeClassified;
        }
        field(16;"GL Account Name";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17;"Staff Code";Code[20])
        {
             TableRelation = "Dimension Value".Code where("Dimension Code" = const('STAFF NO.'),"Dimension Value Type"=filter(Standard));
            DataClassification = ToBeClassified;
        }
        field(18;"Staff Description";Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(19;"Grant Code";Code[20])
        {
             TableRelation = "Dimension Value".Code where("Dimension Code" = const('GRANT'),"Dimension Value Type"=filter(Standard));
            DataClassification = ToBeClassified;
        }
        field(20;"Grant Description";Code[250])
        {
            DataClassification = ToBeClassified;
        }
         field(21;Active;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22;"Budget Line code Category";Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BUDGET LINE'),"Dimension Value Type"=filter("Begin-Total"));
        }
        field(23;"Budget Template Description Category";code[150])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Budget T Description Category"."Budget Template Description Category";
        }
        field(24;"Total Budget Amount";Decimal)
        {
            DataClassification = ToBeClassified;
           
        }
        field(25;"Total Actual Amount";Decimal)
        {
            DataClassification = ToBeClassified;
           
        }
        field(26;"Currency";Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation=Currency.Code;
           
        }
        field(27;"Account Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers="G/L Account";
           
        }
        field(28;"Budget Line Description.";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(29;"Line N0";Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Code","Fund No Code","Budget Line No Code")
        {
            Clustered = true;
        }
        key(pk2;"Line N0")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Budget Line No Code","Fund No Code","Budget Template Description","Budget Line Description.")
        {

        }
    }
}

