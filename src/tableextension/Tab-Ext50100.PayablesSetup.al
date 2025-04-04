tableextension 50100 "PayablesSetup" extends "Purchases & Payables Setup"
{


    fields
    {
        field(6603; "Requisition Nos."; Code[20])
        {
            Caption = 'Requisition Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6604; "Mission Proposal Nos."; Code[20])
        {
            Caption = 'Mission Proposal Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6605; "Imprest Nos."; Code[20])
        {
            Caption = 'Imprest Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6606; "Surrender Nos."; Code[20])
        {
            Caption = 'Surrender Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6607; "Line Nos."; Code[20])
        {
            Caption = 'Line Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6609; "Landlord Nos"; Code[20])
        {
            Caption = 'Landlord Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6610; "Property Numbers"; Code[20])
        {
            Caption = 'Property Numbers';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6611; "Lease Numbers"; Code[20])
        {
            Caption = 'Lease Numbers';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6612; "Tenant Numbers"; Code[20])
        {
            Caption = 'Tenant Numbers';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6613; "Unit Receipt Numbers"; Code[20])
        {
            Caption = 'Unit Receipt Numbers';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6614; "Unit Receipt Line Numbers"; Code[20])
        {
            Caption = 'Unit Receipt Line Numbers';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6615; "Unit Receipt Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(6616; "Unit Receipting Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = filter('GENERAL'));
        }
        field(6617; "Payments Control Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(6618; "Mass Billing Numbers"; Code[20])
        {
            Caption = 'Unit Receipt Numbers';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6619; "Purchase Requisition Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(6620; "Purchase Requisition Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = filter('GENERAL'));
        }
        field(6621; "Unit Update Numbers"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6622; "Payment Vouchers Form"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6623; "Funds Transfer Vouchers Form"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6624; "Petty Cash Payment Form"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6625; "Claims Voucher Form"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6626; "Salary Advance Vouchers Form"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6627; "Receipt Vouchers Form"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50016; "RFQ Nos"; Code[20])
        {
            Caption = 'RFQ Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50017; "Tender Nos"; Code[20])
        {
            Caption = 'Tender Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(172000; "Default Vendor"; Code[600])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(172001; "Vendor Posting Group"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group".Code;
        }
        field(172002; "Funds Transfer Nos"; Code[20])
        {

            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(172003; "Vehicle Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

        }
    }

}




