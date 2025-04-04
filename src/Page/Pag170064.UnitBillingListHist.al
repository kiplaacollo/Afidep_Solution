Page 170064 "Unit Billing List Hist"
{
    CardPageID = Receipt;
    PageType = List;
    SourceTable = "Receipts Header";
    SourceTableView = where(Posted=const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date;Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("Bank Code";Rec."Bank Code")
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
                }
                field(Cashier;Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Banked;Rec.Banked)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

