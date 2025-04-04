Page 170051 "Water Billing List"
{
    CardPageID = "Water Billing Card";
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
                field(Unit;Rec.Unit)
                {
                    ApplicationArea = Basic;
                }
                field("Unit Name";Rec."Unit Name")
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
                field(Tenant;Rec.Tenant)
                {
                    ApplicationArea = Basic;
                }
                field("Tenant Name";Rec."Tenant Name")
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

