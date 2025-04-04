Page 170041 "Unit Receipt Card History"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Unit Billing";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date";Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Code";Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name";Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field(Property;Rec.Property)
                {
                    ApplicationArea = Basic;
                }
                field("Property Name";Rec."Property Name")
                {
                    ApplicationArea = Basic;
                }
                field("Unit No.";Rec."Unit No.")
                {
                    ApplicationArea = Basic;
                }
                field("Unit Name";Rec."Unit Name")
                {
                    ApplicationArea = Basic;
                }
                field(Tenant;Rec.Tenant)
                {
                    ApplicationArea = Basic;
                }
                field("Tenant Name";Rec."Tenant Name")
                {
                    ApplicationArea = Basic;
                }
                field(Balance;Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount";Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount(LCY)";Rec."Total Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("On Behalf of";Rec."On Behalf of")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created";Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Time Created";Rec."Time Created")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By";Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted";Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted";Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Control10)
            {
                part("Unit Transactions";"Unit Receipting Lines History")
                {
                    SubPageLink = "Document No"=field("No."),
                                  Property=field(Property),
                                  "Unit No."=field("Unit No.");
                         
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Post)
            {
                Caption = 'Post';
                action(Attachments)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
            }
        }
    }
}

