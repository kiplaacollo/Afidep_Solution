pageextension 50011 "Posted Bank Rec" extends "Bank Account Statement"
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // modify(Print)
        // {
        //    // Visible = false;
        // }
        // Add changes to page actions here
        addafter(Print)
        {


            action("Posted Bank Rec Report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Custom Print';
                Ellipsis = true;
                Image = Print;
                Scope = Repeater;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                // ApplicationArea = Basic, Suite;
                // Caption = 'Posted Bank Rec Report';
                // Ellipsis = true;
                // Image = Transactions;
                // ToolTip = 'Preview the resulting bank account reconciliations to see the Posted Bank Rec Report.';

                trigger OnAction()
                var
                    BankRecon: Record "Bank Account Statement";
                begin

                    BankRecon.Reset();
                    BankRecon.SetRange("Statement No.", Rec."Statement No.");
                    BankRecon.SetRange("Bank Account No.", Rec."Bank Account No.");
                    report.Run(80030, true, false, BankRecon);
                end;
            }
        }
    }

    var
        myInt: Integer;
}




pageextension 50200 "Posted Bank List" extends "Bank Account Statement List"
{
    layout
    {

    }
    actions
    {
        // modify(Print)
        // {
        //     Visible = false;
        // }
        // Add changes to page actions here
        addafter(Print)
        {


            action("Posted Bank Rec Report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Custom Print';
                Ellipsis = true;
                Image = Print;
                Scope = Repeater;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                // ApplicationArea = Basic, Suite;
                // Caption = 'Posted Bank Rec Report';
                // Ellipsis = true;
                // Image = Transactions;
                // ToolTip = 'Preview the resulting bank account reconciliations to see the Posted Bank Rec Report.';

                trigger OnAction()
                var
                    BankRecon: Record "Bank Account Statement";
                begin

                    BankRecon.Reset();
                    BankRecon.SetRange("Statement No.", Rec."Statement No.");
                    BankRecon.SetRange("Bank Account No.", Rec."Bank Account No.");
                    report.Run(80030, true, false, BankRecon);
                end;
            }
        }
    }

}