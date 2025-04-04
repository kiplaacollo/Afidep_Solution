page 17200 "Dashboard Visualization"
{
    ApplicationArea = All;
    Caption = 'Dashboard Visualization';
    PageType = Card;

    SourceTable = "Dashboard Visualization";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Banks; Rec.Banks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Banks field.';
                }
                field("Organization Logo"; Rec."Organization Logo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Organization Logo field.';
                }
                field("General Ledger Entries"; Rec."General Ledger Entries")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the General Ledger Entries field.';
                }
                field(COA; Rec.COA)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the COA field.';
                }
                field("Fixed Asset"; Rec."Fixed Asset")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fixed Asset field.';
                }
            }
        }
    }
}
