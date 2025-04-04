table 172780 "Contract party"
{
    Caption = 'Contract party';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No"; Code[30])
        {
            Caption = ' No';
        }
        field(2; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(3; Town; Text[100])
        {
            Caption = 'Town';
        }
        field(4; "Mobile No."; Code[16])
        {
            Caption = 'Mobile No.';
        }
        field(5; Email; Code[15])
        {
            Caption = 'Email';
        }
        field(6; "Tel No."; Code[16])
        {
            Caption = 'Tel No.';
        }
        field(7; Name; Code[60])
        {
            Caption = 'Name';
        }
    }
    keys
    {
        key(PK; "No")
        {
            Clustered = true;
        }
    }
}
