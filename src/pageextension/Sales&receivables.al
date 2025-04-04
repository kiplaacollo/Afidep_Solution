pageextension 50000 SalesReceivables extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Price List Nos.")
        {
            field("Receipt Nos"; Rec."Receipt Nos") { ApplicationArea = all; }
        }
    }

    actions
    {
   
    }

    var
        myInt: Integer;
}