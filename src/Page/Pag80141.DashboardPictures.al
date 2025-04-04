page 80141 "Dashboard Picture"
{
    Caption = 'Dashboard Visualization';
    PageType = Card;
    SourceTable = "Dashboard Visualization";
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Organization Logo"; Rec."Organization Logo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Organization Logo field.';
                }
                field("Fixed Asset"; Rec."Fixed Asset")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fixed Asset field.';
                }
                field(Customers; Rec.Customers)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customers field.';
                }
                field(LPOs; Rec.LPOs)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LPOs field.';
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field(COA; Rec.COA)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the COA field.';
                }
                field("General Ledger Entries"; Rec."General Ledger Entries")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the General Ledger Entries field.';
                }
                field(Banks; Rec.Banks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Banks field.';
                }
                field(Vendors; Rec.Vendors)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendors field.';
                }
            }
        }
    }
}
