Page 80014 "Payroll PAYE Setup_AU"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Payroll PAYE Setup_AU";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tier Code";Rec."Tier Code")
                {
                    ApplicationArea = Basic;
                }
                field("PAYE Tier";Rec."PAYE Tier")
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

