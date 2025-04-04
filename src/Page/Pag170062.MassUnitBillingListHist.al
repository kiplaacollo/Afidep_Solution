Page 170062 "Mass Unit Billing List Hist"
{
    CardPageID = "Mass Billing Card Hist";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Mass Unit Billing";
    SourceTableView = where(Posted=filter(true));

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
                field("Transaction Date";Rec."Transaction Date")
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
            }
        }
    }

    actions
    {
    }
}

