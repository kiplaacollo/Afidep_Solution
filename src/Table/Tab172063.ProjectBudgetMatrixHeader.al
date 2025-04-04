table 172063 "Project Budget Matrix Header"
{
    Caption = 'Project Budget Matrix Header';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Project Title"; Text[1000])
        {
            Caption = 'Project Title';
            DataClassification = ToBeClassified;
        }
        field(3; "Project Start Date"; Date)
        {
            Caption = 'Project Start Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Project End Date"; Date)
        {
            Caption = 'Project End Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Principle Manager"; Text[1000])
        {
            Caption = 'Principle Manager';
            DataClassification = ToBeClassified;
        }
        field(6; Comments; Text[2040])
        {
            Caption = 'Comments';
            DataClassification = ToBeClassified;
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
