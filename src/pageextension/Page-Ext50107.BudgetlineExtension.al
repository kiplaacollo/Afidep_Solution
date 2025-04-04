pageextension 50109 "Budget Matrix Ext" extends "G/L Budget Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Budget Dimension 2 Code")
        {

            field("Budget Line Description";Rec."Budget Line Description")
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