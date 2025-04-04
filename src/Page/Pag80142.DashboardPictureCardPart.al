page 80142 "Dashbord Visualization CardPar"
{
    Caption = 'Navigate';
    PageType = CardPart;
    SourceTable = "Dashboard Visualization";
    

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Organization Logo"; Rec."Organization Logo")
                {
                    ApplicationArea = All;
                    Caption = '';
                    Visible=true;
                    ToolTip = 'Specifies the value of the Organization Logo field.';
                }
                field("Fixed Asset"; Rec."Fixed Asset")
                {
                    ApplicationArea = All;
                    Caption = '';

                    ToolTip = 'Specifies the value of the Fixed Asset field.';
                }
                field(TextNavigate; 'Fixed Asset')
                {
                    ApplicationArea = all;
                    ShowCaption = false;
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::"Fixed Asset List");
                    end;
                }
                field(Customers; Rec.Customers)
                {
                    ApplicationArea = All;
                    Visible = false;
                    Caption = '';
                    ToolTip = 'Specifies the value of the Customers field.';
                }
                field(CustomersNavigate; 'Customers')
                {
                    ApplicationArea = all;
                    ShowCaption = false;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::"Customers List");
                    end;
                }
                field(LPOs; Rec.LPOs)
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the LPOs field.';
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                    Visible = false;
                    Caption = '';
                    ToolTip = 'Specifies the value of the Currency field.';
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::Currencies);
                    end;
                }
                field(COA; Rec.COA)
                {
                    ApplicationArea = All;
                    Caption = '';
                    ToolTip = 'Specifies the value of the COA field.';
                }
                field(TextNavigateCOA; 'COA')
                {
                    ApplicationArea = all;
                    ShowCaption = false;
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::"Chart of Accounts");
                    end;
                }
                field("General Ledger Entries"; Rec."General Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = '';
                    ToolTip = 'Specifies the value of the General Ledger Entries field.';
                }
                field(TextNavigateGls; 'General Ledger Entries')
                {
                    ApplicationArea = all;
                    ShowCaption = false;
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::"General Ledger Entries");
                    end;
                }
                field(Banks; Rec.Banks)
                {
                    ApplicationArea = All;
                    Visible = false;
                    Caption = '';
                    ToolTip = 'Specifies the value of the Banks field.';
                }
                field(TextNavigateBanks; 'List of Banks')
                {
                    ApplicationArea = all;
                    Visible = false;
                    ShowCaption = false;
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::"Bank Account List");
                    end;
                }
                field(Vendors; Rec.Vendors)
                {
                    ApplicationArea = All;
                    Visible = false;
                    Caption = '';
                    ToolTip = 'Specifies the value of the Vendors field.';
                }
                field(TextNavigateVendors; 'List of Vendors')
                {
                    ApplicationArea = all;
                    ShowCaption = false;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        Page.Run(page::"Vendor List");
                    end;
                }

            }
        }
    }
}
