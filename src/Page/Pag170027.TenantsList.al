Page 170027 "Tenants List"
{
    CardPageID = "Tenants Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = Tenants;

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
                field("Full Names";Rec."Full Names")
                {
                    ApplicationArea = Basic;
                }
                field("Unit ID";Rec."Unit ID4")
                {
                    ApplicationArea = Basic;
                }
                field("Property Name";Rec."Property Name")
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

