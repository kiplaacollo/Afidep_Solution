Page 170055 "Lease  Bills Subpage"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Unit Billing Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Unit Code";Rec."Unit Code")
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

