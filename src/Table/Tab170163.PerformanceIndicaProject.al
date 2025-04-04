table 170163 "Performance Indica Project"
{
    Caption = ' Performance Indica Project';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Key Output"; Text[2048])
        {
            Caption = 'Key Output';
        }
        field(2; "Key Performance Indicators"; Text[2048])
        {
            Caption = 'Key Performance Indicators';

        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = "Open","In Progress","Completed";
        }
        field(4; Duration; Text[2048])
        {

        }
        field(5; "Award No"; Code[100])
        {
            TableRelation = Award;
        }
    }
    keys
    {
        key(PK; "Key Output", Status, "Key Performance Indicators", Duration)
        {
            Clustered = true;
        }
    }
}
