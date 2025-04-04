table 172764 StatusUpdateMeetingTracker
{
    Caption = 'StatusUpdateMeetingTracker';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';
        }
        field(2; Status; Text[2048])
        {
            Caption = 'Status';
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
        }
    }
    keys
    {
        key(PK; "Code", Status)
        {
            Clustered = true;
        }
    }
}
