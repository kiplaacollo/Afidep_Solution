pageextension 50106 "COA List" extends "Chart of Accounts"
{
    layout
    {
        // Add changes to page layout here
        addafter("Direct Posting")
        {
            field("Budget Code Mandatory"; Rec."Budget Code Mandatory 2")
            {
                ApplicationArea = all;

            }
            field("Staff Code Mandatory"; Rec."Staff Code Mandatory 2")
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