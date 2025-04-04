pageextension 50013 "Sales Invoice Rep" extends "Sales Invoice"
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
        addbefore(DraftInvoice)
        {


            action("Sales Invoice Report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoice Report';
                Promoted = true;
                PromotedCategory = Process;
                Ellipsis = true;
                Image = Transactions;
                ToolTip = 'Preview the resulting bank account reconciliations to see the Posted Bank Rec Report.';

                trigger OnAction()
                var
                    BankRecon: Record "Sales Header";
                begin

                    BankRecon.Reset();
                    BankRecon.SetRange(BankRecon."No.", Rec."No.");
                    //BankRecon.SetRange("Bank Account No.", Rec."Bank Account No.");
                    report.Run(80105, true, false, BankRecon);
                end;
            }
        }
    }

    var
        myInt: Integer;
}