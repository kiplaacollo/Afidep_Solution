Page 170049 "Posted Receipt"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "Receipts Header";
    SourceTableView = where(Posted=const(true));

    layout
    {
        area(content)
        {
            group(Receipt)
            {
                Caption = 'Receipt';
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date;Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("Pay Mode";Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code";Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Code";Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Account';
                }
                field(Cashier;Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted;Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Posted Date";Rec."Posted Date")
                {
                    ApplicationArea = Basic;
                }
                field("Posted Time";Rec."Posted Time")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By";Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount";Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)";Rec."Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000034;"Receipts Line")
            {
                Editable = false;
                SubPageLink = "Receipt No."=field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                action("Print Receipt")
                {
                    ApplicationArea = Basic;
                    Caption = 'Print Receipt';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        receiptrec.Reset;
                        receiptrec.SetFilter("No.",Rec."No.");
                        if receiptrec.FindSet then begin
                          Report.Run(51525004,true,true,receiptrec);
                          //BankLedgerEntry.RESET;
                        end;
                    end;
                }
            }
        }
    }

    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        receiptrec: Record "Receipts Header";
        PostRcpt: Codeunit "Receipts-Post";
        PEdit: Boolean;
}

