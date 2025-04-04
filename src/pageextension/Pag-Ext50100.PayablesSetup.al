// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50100 "PayablesSetup" extends "Purchases & Payables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Price List Nos.")
        {
            field("Requisition Nos."; Rec."Requisition Nos.")
            {
                ApplicationArea = all;
            }
            field("Mission Proposal Nos."; Rec."Mission Proposal Nos.")
            {
                ApplicationArea = all;
            }
            field("Imprest Nos."; Rec."Imprest Nos.")
            {
                ApplicationArea = all;
            }
            field("Surrender Nos."; Rec."Surrender Nos.")
            {
                ApplicationArea = all;
            }
            field("Landlord Nos"; Rec."Landlord Nos")
            {
                ApplicationArea = all;
            }
            field("Line Nos."; Rec."Line Nos.") { ApplicationArea = all; }
            field("Property Numbers"; Rec."Property Numbers") { ApplicationArea = all; }
            field("Lease Numbers"; Rec."Lease Numbers") { ApplicationArea = all; }
            field("Tenant Numbers"; Rec."Tenant Numbers") { ApplicationArea = all; }
            field("Unit Receipt Numbers"; Rec."Unit Receipt Numbers") { ApplicationArea = all; }
            field("Unit Receipt Line Numbers"; Rec."Unit Receipt Line Numbers") { ApplicationArea = all; }
            field("Unit Receipt Template"; Rec."Unit Receipt Template") { ApplicationArea = all; }
            field("Unit Receipting Batch"; Rec."Unit Receipting Batch") { ApplicationArea = all; }
            field("Payments Control Account"; Rec."Payments Control Account") { ApplicationArea = all; }
            field("Mass Billing Numbers"; Rec."Mass Billing Numbers") { ApplicationArea = all; }
            field("Purchase Requisition Template"; Rec."Purchase Requisition Template") { ApplicationArea = all; }
            field("Purchase Requisition Batch"; Rec."Purchase Requisition Batch") { ApplicationArea = all; }
            field("Unit Update Numbers"; Rec."Unit Update Numbers") { ApplicationArea = all; }
            field("Payment Vouchers Form"; Rec."Payment Vouchers Form") { ApplicationArea = all; }
            field("Petty Cash Payment Form"; Rec."Petty Cash Payment Form") { ApplicationArea = all; }
            field("Funds Transfer Vouchers Form"; Rec."Funds Transfer Vouchers Form") { ApplicationArea = all; }
            field("Claims Voucher Form"; Rec."Claims Voucher Form") { ApplicationArea = all; }
            field("Salary Advance Vouchers Form"; Rec."Salary Advance Vouchers Form") { ApplicationArea = all; }
            field("Receipt Vouchers Form"; Rec."Receipt Vouchers Form") { ApplicationArea = all; }
            field("RFQ Nos"; Rec."RFQ Nos") { ApplicationArea = all; }
            field("Funds Transfer Nos"; Rec."Funds Transfer Nos") { }
            field("Tender Nos"; Rec."Tender Nos") { ApplicationArea = all; }
            field("Default Vendor"; Rec."Default Vendor") { ApplicationArea = all; }
            field("Vendor Posting Group"; Rec."Vendor Posting Group") { ApplicationArea = all; }
            field("Vehicle Order No"; Rec."Vehicle Order No") { }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}