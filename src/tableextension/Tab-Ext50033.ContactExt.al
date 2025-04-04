tableextension 50033 ContactExt extends Contact
{
    fields
    {
        field(1100; "About funder"; Text[2048])
        {
            Caption = 'About Organisation';
        }
        field(1101; "Funding history"; Text[2048])
        {
            Caption = 'Funding history with Similar Organisation';
        }
        field(1102; "Funding history with afidep"; Text[2048])
        {
            Caption = 'Funding history with Afidep';
        }
    }
}
