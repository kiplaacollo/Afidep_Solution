pageextension 50001 userSetup extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter(PhoneNo)
        {
            field(ImprestAccount; Rec.ImprestAccount) { ApplicationArea = all; }
            field("Responsibility Center"; Rec."Responsibility Center") { ApplicationArea = all; }
            field("View Payroll"; Rec."View Payroll") { ApplicationArea = all; Caption = 'View Kenyan Payroll'; }
            field("View Malawi Payroll"; Rec."View Malawi Payroll") { Caption = 'View Malawi Payroll'; }
            field("Post Rights"; Rec."Post Rights") { ApplicationArea = all; }
            field("Supper Approver Rights"; Rec."Supper Approver Rights") { ApplicationArea = all; Visible = false; }

            field(Signature; Rec.Signature)
            {
                ApplicationArea = all;
                Editable = true;
                Enabled = true;
            }
            field("Keep Change"; Rec."Keep Change")
            {
                Caption = 'Change My Settings';
            }
            field(Changes; Rec.Changes)
            {
                Caption = 'Change Role';
            }
            field("Company Change"; Rec."Company Change")
            {
                Caption = 'Change Company';
            }
            field("Change Work Date"; Rec."Change Work Date")
            {

            }
            field("Delegation Rights"; Rec."Delegation Rights")
            {
                Caption = 'Delegate Role';
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

pageextension 50230 "extends " extends "Vendor List"
{
    layout
    {
        addafter("No.")
        {
            field("Our Account No."; Rec."Our Account No.")
            {
                Caption = 'Account No in Legacy';
            }
        }
    }
}