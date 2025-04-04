pageextension 50111 "NameDetailsExt" extends "Name Details"
{
    layout
    {
        addafter("Language Code")
        {
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = Basic;
            }
        }
    }
}
