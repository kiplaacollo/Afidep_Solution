pageextension 50103 "Purchase Lines" extends "Purchase Lines"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Document Type")
        {
            field("Document No";Rec."Document No.")
            {
                ApplicationArea = all;
                
            }
            field("ShortcutDimension 1 Code";Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = all;
                
            }
            field("ShortcutDimension 2 Code";Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = all;
                
            }
            field("Budget Line description";Rec."Budget Line description")
            {
                ApplicationArea = all;
                
            }
            field("ShortcutDimCode3";Rec."ShortcutDimCode[3]")
            {
                ApplicationArea = all;
                
            }
            field("ShortcutDimCode4";Rec."ShortcutDimCode[4]")
            {
                ApplicationArea = all;
                
            }
            field("Unit Cost";Rec."Unit Cost")
            {
                ApplicationArea = all;
                
            }
            field(Amount;Rec.Amount)
            {
                ApplicationArea = all;
                
            }
            field("Budget Amount";Rec."Budget Amount")
            {
                ApplicationArea = all;
                
            }
            field("Committed Amount";Rec."Committed Amount")
            {
                ApplicationArea = all;
                
            }
            field("Budget Balance";Rec."Budget Balance")
            {
                ApplicationArea = all;
                
            }
            field("No";Rec."No.")
            {
                ApplicationArea = all;
                
            }
            field(Descriptions;Rec.Description)
            {
                ApplicationArea = all;
                
            }
            field("Description2";Rec."Description 2")
            {
                ApplicationArea = all;
                
            }
            field("ShortcutDimCode5";Rec."ShortcutDimCode[5]")
            {
                ApplicationArea = all;
                
            }
            field("ShortcutDimCode6";Rec."ShortcutDimCode[6]")
            {
                ApplicationArea = all;
                
            }
            field("ShortcutDimCode7";Rec."ShortcutDimCode[7]")
            {
                ApplicationArea = all;
                
            }
            field("ShortcutDimCode8";Rec."ShortcutDimCode[8]")
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