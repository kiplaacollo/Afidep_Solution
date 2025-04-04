pageextension 50003 "BankExtension" extends "Bank Account Card"
{
    layout
    {
        addafter("Bank Account No.")
        {
            field("Transaction No Series";Rec."Transaction No Series")
            {
                Visible=true;
                Caption='Payment Vouchers Nos';

            }
        }
    }
    
    

    actions
    {
        addbefore("Detail Trial Balance")
        {


            action("Detail Trial Balance New")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Detail Trial Balance';
                Ellipsis = true;
                Image = Report;
                ToolTip = 'Detail Trial Balance.';

                trigger OnAction()
                var
                    BankRecon: Record "Bank Account";
                begin

                    BankRecon.Reset();
                    BankRecon.SetRange(BankRecon."No.", Rec."No.");
                    report.Run(1404, true, false, BankRecon);
                end;
            }
        }
    }
    

    var
        myInt: Integer;
}