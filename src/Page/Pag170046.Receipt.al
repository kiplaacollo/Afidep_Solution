Page 170046 "Receipt"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Receipts Header";
   UsageCategory=Lists;
    ApplicationArea=ALL;
    layout
    {
        area(content)
        {
            group(Receipt)
            {
                Caption = 'Receipt';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                
                field("Payment Period"; Rec."Payment Period")
                {
                    ApplicationArea = Basic;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Category"; Rec."Customer Category")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment For';
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Account';
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000034; "Receipts Line")
            {
                SubPageLink = "Receipt No." = field("No.");
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
                        Rec.Validate("Global Dimension 2 Code");
                        Rec.TestField("On Behalf Of");
                        PostRcpt.PostReceipt(Rec);
                    end;
                }
                separator(Action1000000038)
                {
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

