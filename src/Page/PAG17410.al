page 17410 "Quotation Card"
{
    PageType = Card;
    SourceTable = "Quotation Request Vendors";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Requisition Document No."; Rec."Requisition Document No.")
                {
                    Visible = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                   
                }
                field("Currency Code"; Rec."Currency Code")
                {
                  
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                   
                }
                field(Amount; Rec.Amount)
                {
                    
                }
                field("Total Quoted Cost"; Rec."Total Quoted Cost")
                {
                    
                }
                field(Selected; Rec.Selected)
                {
                    Visible = true;

                    trigger OnValidate()
                    begin
                        IF CONFIRM('Are you sure you want to mark the bidder as selected') THEN BEGIN
                            BiddersMandatoryrequirements.RESET;
                            BiddersMandatoryrequirements.SETRANGE("Tendor No", Rec."Requisition Document No.");
                            BiddersMandatoryrequirements.SETRANGE("Vendor No", Rec."Vendor No.");
                            BiddersMandatoryrequirements.SETRANGE(BiddersMandatoryrequirements.Status, BiddersMandatoryrequirements.Status::"Not Available");
                            IF BiddersMandatoryrequirements.FINDFIRST THEN
                                ERROR('All mandatory requirements must be met');

                            BiddersMandatoryrequirements.RESET;
                            BiddersMandatoryrequirements.SETRANGE("Tendor No", Rec."Requisition Document No.");
                            BiddersMandatoryrequirements.SETRANGE("Vendor No", Rec."Vendor No.");
                            BiddersMandatoryrequirements.SETRANGE(BiddersMandatoryrequirements.Status, BiddersMandatoryrequirements.Status::" ");
                            IF BiddersMandatoryrequirements.FINDFIRST THEN
                                ERROR('All mandatory requirements must be met');

                            /*QuotationRequestVendors.RESET;
                            QuotationRequestVendors.SETRANGE("Requisition Document No.","Requisition Document No.");
                            QuotationRequestVendors.SETFILTER("Vendor No.",'<>%1',"Vendor No.");
                            IF QuotationRequestVendors.FINDSET THEN BEGIN
                              REPEAT
                                QuotationRequestVendors.Selected:=FALSE;
                                QuotationRequestVendors.MODIFY;
                                UNTIL QuotationRequestVendors.NEXT=0;
                              END*/
                        END;

                    end;
                }
            }
            part("Vendor response"; 17414)
            {
                SubPageLink = "Document No." = FIELD("Requisition Document No."),
                              "Buy-from Vendor No." = FIELD("Vendor No.");
            }
            part(Bidders; "Bidders requirements List")
            {
                SubPageLink = "Tendor No" = FIELD("Requisition Document No."),
                              "Vendor No" = FIELD("Vendor No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(group)
            {
            }
        }
    }

    var
        QuotationRequestVendors2: Record "170165";

        Email: Text;
        Vendor: Record "23";
        PurchaseQuoteHeader: Record "170160";
        Filename: Text;
        Attachment: Text[250];
        QuotationRequestVendors5: Record "170165";
        Vend: Record "170165";
        PQH: Record "170160";
        QuotationRequestVendors: Record "170165";
        BiddersMandatoryrequirements: Record 170174;
}

