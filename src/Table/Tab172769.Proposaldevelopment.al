table 172769 Proposaldevelopment
{
    Caption = 'Proposaldevelopment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[40])
        {
            Caption = 'Code';
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(4; "Opportunity Value"; Decimal)
        { }
    }
    keys
    {
        key(PK; "Code", Amount)
        {
            Clustered = true;
        }
    }
}
