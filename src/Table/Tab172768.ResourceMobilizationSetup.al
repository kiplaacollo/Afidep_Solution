table 172768 ResourceMobilizationSetup
{
    Caption = 'ResourceMobilizationSetup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key "; Integer)
        {
            Caption = 'Primary Key ';
        }
        field(2; Mettingtracker; Code[20])
        {
            Caption = 'Mettingtracker';
            TableRelation = "No. Series".Code;
        }
        field(3; Engagement; Code[20])
        {
            Caption = 'Engagement';
            TableRelation = "No. Series".Code;
        }
        field(4; Gonogodecision; Code[20])
        {
            Caption = 'Gonogodecision';
            TableRelation = "No. Series".Code;
        }
        field(5; Professionaldevelopment; Code[20])
        {
            Caption = 'Professionaldevelopment';
            TableRelation = "No. Series".Code;
        }

        field(6; Conference; Code[20])
        {
            Caption = 'Conference';
            TableRelation = "No. Series".Code;
        }
    }
    keys
    {
        key(PK; "Primary Key ")
        {
            Clustered = true;
        }
    }


}
