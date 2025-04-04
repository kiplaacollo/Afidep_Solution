Page 170058 "Inactive Lease List"
{
    CardPageID = "Inactive Lease Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Lease;
    SourceTableView = where(Posted=filter(true),
                            "Lease Status"=const(Inactive));

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
            }
        }
    }

    actions
    {
    }
}

