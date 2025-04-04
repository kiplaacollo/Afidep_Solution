pageextension 50040 AccScheduleLine extends "Account Schedule"
{
    layout
    {
        // Add changes to page layout here
        addafter("New Page")
        {
            field("Fund Filter"; Rec."Fund Filter")
            {
                ApplicationArea = all;
                trigger OnValidate()

                begin
                    Rec."Dimension 1 Totaling" := Rec."Fund Filter";
                end;
            }
            field("Dimension 1 Totaling2"; Rec."Dimension 1 Totaling") { ApplicationArea = all; Enabled = false; }
            field("budget Filter"; Rec."budget Filter")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    Rec."Dimension 2 Totaling" := Rec."budget Filter";
                end;
            }

            field("Dimension 2 Totaling2"; Rec."Dimension 2 Totaling")
            {
                ApplicationArea = all;
                Enabled = false;

            }

            field("Donor Filter"; Rec."Donor Filter") { ApplicationArea = all; Visible = false; }

            field("Program Filter"; Rec."Program Filter") { ApplicationArea = all; Visible = false; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}