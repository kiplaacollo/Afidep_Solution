pageextension 50102 "Customer Card" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("User name"; Rec."User name2")
            {
                ApplicationArea = all;

            }

        }

    }

    actions
    {

    }

    var
        myInt: Integer;
}

pageextension 50132 "Vendor Card" extends "Vendor Card"
{

    layout
    {
        modify("Our Account No.")
        {
            Caption = 'Account No in Legacy System';
            ToolTip = 'Specifies Account number with the vendor, In the previous system.';
        }

        // Add changes to page layout here
        // addafter(Name)
        // {
        //     field("User name";Rec."User name2")
        //     {
        //         ApplicationArea = all;

        //     }

        // }

    }

    actions
    {

    }

    var
        myInt: Integer;
}