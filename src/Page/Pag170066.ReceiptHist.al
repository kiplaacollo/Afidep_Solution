Page 170066 "Receipt Hist"
{
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Receipts Header";

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
                    Editable = false;
                }
                field(Date;Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("Pay Mode";Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No";Rec."Cheque No")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Date";Rec."Cheque Date")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Category";Rec."Customer Category")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Received From No";Rec."Received From No")
                {
                    ApplicationArea = Basic;
                }
                field("Received From";Rec."Received From")
                {
                    ApplicationArea = Basic;
                }
                field("On Behalf Of";Rec."On Behalf Of")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment For';
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
                field("Total Amount";Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code";Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)";Rec."Amount(LCY)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Record From SMS";Rec."Record From SMS")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000034;"Receipts Line Hist")
            {
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
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.Validate(Rec."Global Dimension 1 Code");
                        Rec.Validate(Rec."Global Dimension 2 Code");
                        Rec.TestField(Rec."On Behalf Of");
                        PostRcpt.PostReceipt(Rec);
                    end;
                }
                separator(Action1000000038)
                {
                }
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
                        end;
                    end;
                }
                action("Print Receipt 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Print Receipt 2';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        receiptrec.Reset;
                        receiptrec.SetFilter("No.",Rec."No.");
                        if receiptrec.FindSet then begin
                          Report.Run(51525017,true,true,receiptrec);
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

