pageextension 50110 "ContactCardExt" extends "Company Details"
{
    layout
    {
        addafter("Phone No.")
        {
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = Basic;
            }
        }
    }
}
