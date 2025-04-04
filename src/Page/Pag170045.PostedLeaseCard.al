Page 170045 "Posted Lease Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Lease;

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
                field(Property;Rec.Property)
                {
                    ApplicationArea = Basic;
                }
                field("Property Name";Rec."Property Name")
                {
                    ApplicationArea = Basic;
                }
                field(Unit;Rec.Unit)
                {
                    ApplicationArea = Basic;
                }
                field("Account Number";Rec."Account Number")
                {
                    ApplicationArea = Basic;
                }
                field("Starts From";Rec."Starts From")
                {
                    ApplicationArea = Basic;
                }
                field("Renew Lease Every";Rec."Renew Lease Every")
                {
                    ApplicationArea = Basic;
                }
                field("Lease End Date";Rec."Lease End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Next Automated Invoice";Rec."Next Automated Invoice")
                {
                    ApplicationArea = Basic;
                }
                field("Managed By";Rec."Managed By")
                {
                    ApplicationArea = Basic;
                }
                field("Lease Type";Rec."Lease Type")
                {
                    ApplicationArea = Basic;
                }
                field("Water Consumption(Units)";Rec."Water Consumption(Units)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Water Consumption Rate';
                }
                field("Tenant Monthly Rent";Rec."Tenant Monthly Rent")
                {
                    ApplicationArea = Basic;
                }
                field("Tenant Rent Deposit";Rec."Tenant Rent Deposit")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Posted Date";Rec."Posted Date")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By";Rec."Posted By")
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

