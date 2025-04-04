table 172771 "Engagement plan Q updates"
{
    Caption = 'Engagement plan Q updates';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[40])
        {
            Caption = 'Code';
        }
        field(2; "Date of update"; Date)
        {
            Caption = 'Date of update';
        }
        field(3; Update; Text[2048])
        {
            Caption = 'Update';
        }
        field(4; Links; Text[300])
        {
            Caption = 'Links';
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
