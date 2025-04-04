pageextension 50105 "COA Card" extends "G/L Account Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Direct Posting")
        {
            field("Budget Code Mandatory";Rec."Budget Code Mandatory 2")
            {
                ApplicationArea = all;
                
            }
            field("Staff Code Mandatory";Rec."Staff Code Mandatory 2")
            {
                ApplicationArea = all;
                
            }

        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}