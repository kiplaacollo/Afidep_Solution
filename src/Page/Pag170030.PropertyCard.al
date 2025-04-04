Page 170030 "Property Card"
{
    PageType = Card;
    SourceTable = "Property Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No;Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("Property Name";Rec."Property Name")
                {
                    ApplicationArea = Basic;
                }
                field("Property Location";Rec."Property Location")
                {
                    ApplicationArea = Basic;
                }
                field("Property Type";Rec."Property Type")
                {
                    ApplicationArea = Basic;
                }
                field("Property Owner";Rec."Property Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Property Owner Name";Rec."Property Owner Name")
                {
                    ApplicationArea = Basic;
                }
                field("Landlord Contact";Rec."Landlord Contact")
                {
                    ApplicationArea = Basic;
                }
                field("Property Description";Rec."Property Description")
                {
                    ApplicationArea = Basic;
                }
                field("Number Of Units";Rec."Number Of Units")
                {
                    ApplicationArea = Basic;
                }
                field(Ammenities;Rec.Ammenities)
                {
                    ApplicationArea = Basic;
                }
                field("Property LR Number";Rec."Property LR Number")
                {
                    ApplicationArea = Basic;
                }
                field("Property Administrator";Rec."Property Administrator")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Deadline Date";Rec."Payment Deadline Date")
                {
                    ApplicationArea = Basic;
                }
                field("Service Type";Rec."Service Type")
                {
                    ApplicationArea = Basic;
                }
                field("Commission Type";Rec."Commission Type")
                {
                    ApplicationArea = Basic;
                }
                field(Commission;Rec.Commission)
                {
                    ApplicationArea = Basic;
                }
            }
            part("Property Billing Lines";"Property Bills Subpage")
            {
                SubPageLink = "Property Code"=field(No);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(ActionGroup15)
            {
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

