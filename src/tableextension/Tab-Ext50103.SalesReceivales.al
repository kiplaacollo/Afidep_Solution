tableextension 50103 "SalesReceivales" extends "Sales & Receivables Setup"
{
    fields
    {

        field(7109; "Unit Nos"; Code[20])
        {
            Caption = 'Units';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(7105; "Receipt Nos"; Code[20])
        {
            Caption = 'Receipt Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(7106; "Receipt Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(7107; "Receipt Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Template Type" = const("Cash Receipts"));
        }
        field(7108; "Water Billing Nos"; Code[20])
        {
            Caption = 'Water Billing Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }


    fieldgroups
    {
    }

    var
        Text001: label 'Job Queue Priority must be zero or positive.';
        RecordHasBeenRead: Boolean;



}

