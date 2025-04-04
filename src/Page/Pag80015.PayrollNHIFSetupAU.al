Page 80015 "Payroll NHIF Setup_AU"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Payroll NHIF Setup_AU";

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
                field("NHIF Tier";Rec."NHIF Tier")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Lower Limit";Rec."Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Upper Limit";Rec."Upper Limit")
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

