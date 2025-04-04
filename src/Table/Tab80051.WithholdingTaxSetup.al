Table 80051 "Withholding Tax Setup"
{
    Caption = 'Withholding Tax Setup';
    DataCaptionFields = "Code", Description, "Rate %", "Withholding Tax Account";
    LookupPageID = "Withholding Tax Setups";

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Withholding Tax Account"; Code[20])
        {
            Caption = 'Withholding Tax Account';
            TableRelation = "G/L Account";
        }
        field(4; "Country code"; Code[20])
        {
            Caption = 'Country code';
            TableRelation = "Country/Region";
        }
        field(5; "Country Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Rate %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Date Created"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Created by"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Consultancy Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Consultancy Fee AC"; Code[50])
        {
            TableRelation = "G/L Account"."No.";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Country Name")
        {
        }
    }

    fieldgroups
    {
    }
}

