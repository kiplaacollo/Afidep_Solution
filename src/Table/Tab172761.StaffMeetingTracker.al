table 172761 StaffMeetingTracker
{
    Caption = 'StaffMeetingTracker';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Staff code"; Code[50])
        {
            Caption = 'Staff code';
        }
        field(3; "Staff name"; Text[2048])
        {
            Caption = 'Staff name';
        }
    }
    keys
    {
        key(PK; "Code", "Staff code")
        {
            Clustered = true;
        }
    }
}
