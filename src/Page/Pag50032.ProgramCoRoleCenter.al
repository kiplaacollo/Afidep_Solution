Page 50032 "Program Co  Role Center"
{
    // CurrPage."Help And Setup List".ShowFeatured;

    Caption = 'Program Co-ordinator Role Center', Comment='{Dependency=Match,"ProfileDescription_SMALLBUSINESS"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control139;"Headline RC Business Manager")
            {
                ApplicationArea = Basic,Suite;
                Visible = false;
            }
            part(Control16;"Role Activities")
            {
                AccessByPermission = TableData "Activities Cue"=I;
                ApplicationArea = Basic,Suite;
            }
        }
    }

    actions
    {
        area(sections)
        {
            group(Programs)
            {
                Caption = 'Programs';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action(Donors)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Donors';
                  
                    RunObject = Page Donors;
                }
                action(Partners)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Partners';
                  
                    RunObject = Page Partners;
                }
                action(Locations)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Locations';
                  
                    RunObject = Page Locations;
                }
                action(Projects)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Projects';
                  
                    RunObject = Page "Project List";
                }
            }
            group("Purchase Requisitions")
            {
                Caption = 'Purchase Requisitions';
                Image = Purchasing;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(Requisitions)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'New Purchase Requisition';
                  
                    RunObject = Page "Task Order";
                }
                action("Pending Purchase Requisition")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Pending Purchase Requisition';
                  
                    RunObject = Page "Pending Purchase Requisition";
                }
                action("Approved Purchase Requisition")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Approved Purchase Requisition';
                  
                    RunObject = Page "Posted Purchase Requisitions";
                }
                action("Completed Purchase Requisition")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Completed Purchase Requisition';
                  
                    RunObject = Page "Completed  Purchase Req.";
                }
            }
            group("Travel Authorization")
            {
                Caption = 'Travel Authorization';
                Image = CostAccounting;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("Imprest Request")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Travel Authorization Request';
                  
                    RunObject = Page "Imprest Request";
                }
                action("Posted Imprests")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Posted Authorizations';
                  
                    RunObject = Page "Posted Imprests";
                }
                action("Imprest Surrender")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Travel Accounting';
                  
                    RunObject = Page "Imprest Surrender";
                }
                action("Posted Surrender")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Posted Travel Accounting';
                  
                    RunObject = Page "Posted Surrender";
                }
            }
        }
    }
}

