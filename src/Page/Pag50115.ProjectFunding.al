Page 50115 "Project Funding"
{
    PageType = ListPart;
    SourceTable = "Project Budget";
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Funding; Rec.Funding)
                {
                    ApplicationArea = Basic;
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Project Amount (US$)';
                }
                field("Amount Awarded"; Rec."Amount Awarded")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Spend to Date (US$)';
                }
                field("Remaining Balance"; Rec."Remaining Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Variance (US$)';
                }
                field("Burn rate %"; Rec."Burn rate %")
                {
                    ApplicationArea = Basic;
                }
                field(Commentary; Rec.Commentary)
                {
                    ApplicationArea = Basic;
                }
                field("Received Amount"; Rec."Received Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

