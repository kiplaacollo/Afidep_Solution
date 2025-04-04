Page 170053 "Property Bills Subpage"
{
    PageType = ListPart;
    SourceTable = "Property Billing Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Property Code";Rec."Property Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Ammenity;Rec.Ammenity)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Rate;Rec.Rate)
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

