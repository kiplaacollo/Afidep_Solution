page 17414 "Vender rfq"
{
    ApplicationArea = All;
    Caption = 'Vender rfq';
    PageType = ListPart;
    SourceTable = "Vendor Rfqs";

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Document Type"; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Expense code"; Rec."Expense code")
                {
                    ToolTip = 'Specifies the value of the No field.';
                }


                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Buy-from Vendor No. field.';
                }
                field("Description"; Rec."Extended Order Description")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }

                field("Unit of measure"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Quantity"; Rec."Quantity (Base)")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Direct unit cost"; Rec."Direct unit cost")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Amount"; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Selected"; Rec.Selected)
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }

            }
        }
    }
}
