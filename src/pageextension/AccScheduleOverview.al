pageextension 50123 MyExtensionAcc extends "Acc. Schedule Overview"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Fund Filter"; Rec."Fund Filter") { ApplicationArea = all; }
            field("Donor Filter"; Rec."Donor Filter") { ApplicationArea = all; }
            field("budget Filter"; Rec."budget Filter") { ApplicationArea = all; }
            field("Program Filter"; Rec."Program Filter") { ApplicationArea = all; }
        }
    }

     var
        myInt: Integer;
}