Page 170028 "Tenants Card"
{
    PageType = Card;
    SourceTable = Tenants;

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
                field("Full Names";Rec."Full Names")
                {
                    ApplicationArea = Basic;
                }
                field("Identification Document";Rec."Identification Document")
                {
                    ApplicationArea = Basic;
                }
                field("Identification Number";Rec."Identification Number")
                {
                    ApplicationArea = Basic;
                }
                field("Tenants Phone Number";Rec."Tenants Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Terms Of Tenancy";Rec."Terms Of Tenancy")
                {
                    ApplicationArea = Basic;
                }
                field("Property ID";Rec."Property ID")
                {
                    ApplicationArea = Basic;
                }
                field("Property Name";Rec."Property Name")
                {
                    ApplicationArea = Basic;
                }
                field("Unit ID";Rec."Unit ID4")
                {
                    ApplicationArea = Basic;
                }
                field(Unit;Rec.Unit)
                {
                    ApplicationArea = Basic;
                }
                field("Next Of Kin Full  Names";Rec."Next Of Kin Full  Names")
                {
                    ApplicationArea = Basic;
                }
                field("Next Of KIn Phone Number";Rec."Next Of KIn Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Lease Number";Rec."Lease Number")
                {
                    ApplicationArea = Basic;
                }
                field("Account Number";Rec."Account Number")
                {
                    ApplicationArea = Basic;
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

