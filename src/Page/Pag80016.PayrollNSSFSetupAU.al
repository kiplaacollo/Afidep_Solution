Page 80016 "Payroll NSSF Setup_AU"
{
    //  DeleteAllowed = false;
    PageType = List;
    SourceTable = "Payroll NSSF Setup_AU";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tier Code"; Rec."Tier Code")
                {
                    ApplicationArea = Basic;
                }
                field(Earnings; Rec.Earnings)
                {
                    ApplicationArea = Basic;
                }
                field("Pensionable Earnings"; Rec."Pensionable Earnings")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 1 earnings"; Rec."Tier 1 earnings")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 1 Employee Deduction"; Rec."Tier 1 Employee Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 1 Employer Contribution"; Rec."Tier 1 Employer Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 2 earnings"; Rec."Tier 2 earnings")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 2 Employee Deduction"; Rec."Tier 2 Employee Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 2 Employer Contribution"; Rec."Tier 2 Employer Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Upper Limit"; Rec."Upper Limit")
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

