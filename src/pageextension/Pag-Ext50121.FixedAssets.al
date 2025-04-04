pageextension 50121 "Fixed Asset Ext" extends "Fixed Asset List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {


            field("Asset Tag No."; Rec."Asset Tag No.")
            {
                ApplicationArea = all;

            }
            field("Employee No."; Rec."Employee No.")
            {
                ApplicationArea = all;
                Caption = 'Responsible Employee';
            }

        }
        modify("Responsible Employee")
        {
            Visible = false;
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}



pageextension 50122 "Fixed Asset Card Ext" extends "Fixed Asset Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Search Description")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;

            }

            field("Asset Tag No."; Rec."Asset Tag No.")
            {
                ApplicationArea = all;

            }
            field("Employee No."; Rec."Employee No.")
            {
                ApplicationArea = all;
                Caption = 'Responsible Employee';
            }

        }
        modify("Responsible Employee")
        {
            Visible = false;
        }


    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}

