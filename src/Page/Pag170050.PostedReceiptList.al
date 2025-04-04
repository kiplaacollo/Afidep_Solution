Page 170050 "Posted Receipt List"
{
    CardPageID = "Posted Receipt";
    Editable = false;
    PageType = List;
    SourceTable = "Receipts Header";
    SourceTableView = where(Posted=const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Date;Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Pay Mode";Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Amount";Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Cashier;Rec.Cashier)
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
                field("Posted Time";Rec."Posted Time")
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
    }
}

