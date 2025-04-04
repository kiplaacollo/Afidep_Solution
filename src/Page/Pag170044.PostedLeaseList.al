Page 170044 "Posted Lease List"
{
    CardPageID = "Posted Lease Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Lease;
    SourceTableView = where(Posted=filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field("Unit Name";Rec."Unit Name")
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
                field("Starts From";Rec."Starts From")
                {
                    ApplicationArea = Basic;
                }
                field("Lease End Date";Rec."Lease End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Lease Status";Rec."Lease Status")
                {
                    ApplicationArea = Basic;
                }
                field("Managed By";Rec."Managed By")
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

