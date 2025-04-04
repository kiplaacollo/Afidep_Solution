page 17409 "Quotation Evaluation"
{
    CardPageID = "Quotation Card";
    Editable = false;
    PageType = Card;
    SourceTable = "Quotation Request Vendors";

    layout
    {
        area(content)
        {
            repeater(Group)
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
}

