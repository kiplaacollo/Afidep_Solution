pageextension 80136 GeneralLedgerEntries extends "General Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter(Amount)
        {
            field("Source Code "; Rec."Source Code") { ApplicationArea = all; }
            field("Additional-Currency Amount "; Rec."Additional-Currency Amount") { ApplicationArea = all; Caption = 'Local Currency'; }
            field("Currency Code"; Rec."Currency Code 3") { ApplicationArea = all; }
            field("Currency Factor"; Rec."Currency Factor3") { ApplicationArea = all; }
            field("Posting User"; Rec."User ID") { ApplicationArea = all; }

        }

    }



    actions
    {
        // Add changes to page actions here
        addafter("F&unctions")
        {
            action("General Ledger Report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'General Ledger Report';
                Ellipsis = true;
                Image = Report;
                ToolTip = 'General Ledger Report.';

                trigger OnAction()
                var
                    BankRecon: Record "G/L Entry";
                begin

                    BankRecon.Reset();
                    // BankRecon.SetRange(BankRecon."G/L Account No.", Rec."G/L Account No.");
                    BankRecon.SetRange(BankRecon."Entry No.", Rec."Entry No.");
                    report.Run(50038, true, false, BankRecon);
                end;
            }
        }
    }

    var
        myInt: Integer;





}