pageextension 50080 "Payment Journal Ext" extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter(Amount)
        {
            field(AmountLCY; Rec."Amount (LCY)")
            {
                ApplicationArea = all;
            }
            field(CurrencyCode; Rec."Currency Code") { ApplicationArea = all; }
            field("Currency Factor"; Rec."Currency Factor") { ApplicationArea = all; }
            field("Gen. Posting Type."; Rec."Gen. Posting Type") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}