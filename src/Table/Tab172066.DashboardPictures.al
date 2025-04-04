table 172066 "Dashboard Pictures"
{
    Caption = 'Dashboard Visualization';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Organization Logo"; Blob)
        {
            Caption = 'Organization Logo';
            Subtype=Bitmap;
            DataClassification = ToBeClassified;
        }
        field(3; "Fixed Asset"; Blob)
        {
            Caption = 'Fixed Asset';
            DataClassification = ToBeClassified;
            Subtype=Bitmap;
        }
        field(4; Customers; Blob)
        {
            Caption = 'Customers';
            DataClassification = ToBeClassified;
            Subtype=Bitmap;
        }
        field(5; LPOs; Blob)
        {
            Caption = 'LPOs';
            DataClassification = ToBeClassified;
            Subtype=Bitmap;
        }
        field(6; Currency; Blob)
        {
            Caption = 'Currency';
            DataClassification = ToBeClassified;
        }
        field(7; COA; Blob)
        {
            Caption = 'COA';
            DataClassification = ToBeClassified;
            Subtype=Bitmap;
        }
        field(8; "General Ledger Entries"; Blob)
        {
            Caption = 'General Ledger Entries';
            DataClassification = ToBeClassified;
            Subtype=Bitmap;
        }
        field(9; Banks; Blob)
        {
            Caption = 'Banks';
            DataClassification = ToBeClassified;
            Subtype=Bitmap;
        }
        field(10; Vendors; Blob)
        {
            Caption = 'Vendors';
            DataClassification = ToBeClassified;
            Subtype=Bitmap;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
