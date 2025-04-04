Page 170072 "Mass Unit Update List"
{
    CardPageID = "Mass Update Card";
    PageType = List;
    SourceTable = "Units Mass Update";
    SourceTableView = where(Updated=const(false));

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
                field(Date;Rec.Date)
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

