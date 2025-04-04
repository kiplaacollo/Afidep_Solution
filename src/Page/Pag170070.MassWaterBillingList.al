Page 170070 "Mass Water Billing List"
{
    CardPageID = "Mass Water Billing Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Water Billing";
    SourceTableView = where(Posted=filter(false));

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
                field("Billing Date";Rec."Billing Date")
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

