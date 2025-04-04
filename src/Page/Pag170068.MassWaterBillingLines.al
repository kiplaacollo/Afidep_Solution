Page 170068 "Mass Water Billing Lines"
{
    PageType = ListPart;
    SourceTable = "Mass Water Billing Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Unit;Rec.Unit)
                {
                    ApplicationArea = Basic;
                }
                field("Unit Name";Rec."Unit Name")
                {
                    ApplicationArea = Basic;
                }
                field(Tenant;Rec.Tenant33)
                {
                    ApplicationArea = Basic;
                }
                field("Tenant Name";Rec."Tenant Name")
                {
                    ApplicationArea = Basic;
                }
                field("Previous Meter Reading";Rec."Previous Meter Reading")
                {
                    ApplicationArea = Basic;
                }
                field("Current Meter Reading";Rec."Current Meter Reading")
                {
                    ApplicationArea = Basic;
                }
                field("Units Consumed";Rec."Units Consumed")
                {
                    ApplicationArea = Basic;
                }
                field(Rate;Rec.Rate)
                {
                    ApplicationArea = Basic;
                }
                field("Amount Charged";Rec."Amount Charged")
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

