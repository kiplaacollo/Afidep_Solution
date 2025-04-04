Page 170059 "Inactive Lease Card"
{
    DeleteAllowed = false;
    Editable = false;
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
                field("Lease Date";Rec."Lease Date")
                {
                    ApplicationArea = Basic;
                }
                field("Tenant Name";Rec."Tenant Name")
                {
                    ApplicationArea = Basic;
                }
                field(Tenant;Rec.Tenant)
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
                field("Unit Name";Rec."Unit Name")
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
            }
            part(Control25;"Lease  Bills Subpage")
            {
                SubPageLink = "Unit Code"=field(Unit);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Lease)
            {
                Caption = 'Lease';
                action("Post Lease")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Lease';
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to allocate lease?',true,false)=true then
                        begin
                        Units.Reset;
                        Units.SetRange(Units."No.",Rec.Unit);
                        if Units.FindFirst then
                        begin
                        Units.Tenant22:=Rec.Tenant;
                        Units."Tenant Full Name 33":=Rec."Tenant Name";
                        Units.Modify;
                        end;
                        Rec.Posted:=true;
                        Rec."Posted Date":=Today;
                        Rec."Posted By":=UserId;
                        Rec.Modify;
                        end;
                    end;
                }
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

    var
        Units: Record Customer;
}

