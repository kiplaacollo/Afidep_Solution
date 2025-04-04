Page 170031 "Lease List"
{
    CardPageID = "Lease Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = Lease;
    SourceTableView = where(Posted=filter(false));

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

