Page 170056 "Active Lease List"
{
    CardPageID = "Active Lease Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Lease;
    SourceTableView = where(Posted=filter(true),
                            "Lease Status"=const(Active));

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
                field("Property Name";Rec."Property Name")
                {
                    ApplicationArea = Basic;
                }
                field("Managed By";Rec."Managed By")
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
                field("Unit Name";Rec."Unit Name")
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

