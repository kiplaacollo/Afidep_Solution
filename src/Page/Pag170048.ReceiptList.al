Page 170048 "Receipt List"
{
    CardPageID = Receipt;
    PageType = List;
    SourceTable = "Receipts Header";
    SourceTableView = where(Posted = const(false));
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }
                
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
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

