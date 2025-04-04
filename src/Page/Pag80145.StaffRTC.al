Page 80145 "Staff Role Center"
{
    // CurrPage."Help And Setup List".ShowFeatured;

    Caption = 'Staff RTC', Comment = '{Dependency=Match,"ProfileDescription_SMALLBUSINESS"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control139; "Headline RC Business Manager")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(ApprovalActivities; "Approvals Activities")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part(OtherDocActivities; "staff Dashboard Cue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(EmailActivities; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }

            part(Control16; "O365 Activities")
            {
                AccessByPermission = TableData "Activities Cue" = I;
                //AccessByPermission = TableData financecue = 1;
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control55; "Help And Chart Wrapper")
            {
                //AccessByPermission = TableData UnknownTableData1803=I;
                ApplicationArea = Basic, Suite;
                Caption = '';
                ToolTip = 'Specifies the view of your business assistance';
                Visible = false;
            }


            part(Control98; "Power BI Report Spinner Part")
            {
                AccessByPermission = TableData "Power BI User Configuration" = I;
                ApplicationArea = Basic, Suite;
            }
            part(Control46; "Team Member Activities No Msgs")
            {
                ApplicationArea = Suite;
                Visible = false;
            }

        }
    }

    actions
    {
        area(creation)
        {

            action("Imprest Requisition.")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Imprest Requisition';
                Image = NewSalesInvoice;
                RunObject = Page "Imprest Requisition";
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for the sales of items or services. Invoice quantities cannot be posted partially.';
            }
            action("Imprest Accounting.")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Imprest Surrender';
                Image = NewSalesInvoice;
                RunObject = Page "Travel Accounting";
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for the sales of items or services. Invoice quantities cannot be posted partially.';
            }
            action("Purchase Requisition")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Requisition';
                Image = NewSalesInvoice;
                RunObject = Page "Task Order Card";
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for the sales of items or services. Invoice quantities cannot be posted partially.';
            }
            action("<Page Purchase Order>")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Suite;
                Caption = 'Purchase Order';
                Image = NewOrder;
                RunObject = Page "Purchase Order";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase order.';
            }
        }
        area(processing)
        {
            group(New)
            {
                Caption = 'New';
                Image = New;
                action(Vendor)
                {
                    AccessByPermission = TableData Vendor = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageMode = Create;
                    ToolTip = 'Register a new vendor.';
                }
            }

        }
        area(embedding)
        {
            action(Vendors)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendors';
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items';
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }

        }
        area(sections)
        {
            group(ImprestAccount)
            {
                Caption = 'Imprest Account';
                Image = Marketing;
                //ToolTip = 'Collect and make payments, prepare statements, and reconcile bank accounts.';


                action("Imprest Account")
                {
                    ApplicationArea = Suite;
                    Caption = 'Imprest Account';

                    Visible = true;

                    RunObject = Page "Imprest Account List";
                    //ToolTip = 'View summary information about the amount budgeted for each general ledger account in different time periods.';
                }

            }

            group("Expense Requisitions")
            {
                Caption = 'Expense Requisitions';
                Image = Purchasing;
                Visible = false;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(ExpenseRequisitions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Expense Requisition';


                    RunObject = Page "Expense Requisition New List";
                }
                action("Pending Expense Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Expense Requisition';


                    RunObject = Page "Expense Req Pending List";
                }
                action("Approved Expense Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Expense Requisition';


                    RunObject = Page "Expense Requ Approved List";
                }
                action("Completed Expense Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Completed Expense Requisition';


                    RunObject = Page "Expense Requ comp List";
                }
            }
            group("Purchase Requisitions")
            {
                Caption = 'Purchase Requisitions';
                Image = Purchasing;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(Requisitions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Purchase Requisition';


                    RunObject = Page "Task Order";
                }
                action("Pending Purchase Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Purchase Requisition';


                    RunObject = Page "Pending Purchase Requisition";
                }
                group("Approved PRQ")
                {
                    action("Approved Purchase Requisition K")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved PRQ Kenya';


                        RunObject = Page "Posted Purchase Requisitions";
                        RunPageView = order(ascending) where("Shortcut Dimension 1 Code" = filter('KENYA'));
                    }
                    action("Approved Purchase Requisition M")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved PRQ Malawi';


                        RunObject = Page "Posted Purchase Requisitions";
                        RunPageView = order(ascending) where("Shortcut Dimension 1 Code" = filter('MALAWI'));
                    }
                }
                group("Completed PRQ")
                {
                    action("Completed Purchase Requisition K")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Completed PRQ Kenya';


                        RunObject = Page "Completed  Purchase Req.";
                        RunPageView = order(ascending) where("Shortcut Dimension 1 Code" = filter('KENYA'));
                    }
                    action("Completed Purchase Requisition M")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Completed PRQ Malawi';


                        RunObject = Page "Completed  Purchase Req.";
                        RunPageView = order(ascending) where("Shortcut Dimension 1 Code" = filter('MALAWI'));
                    }
                }

            }
            group("Imprest Requisition")
            {
                Caption = 'Imprest Requisition';
                Image = CostAccounting;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("Imprest Requisition (New)")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Requisition (New)';


                    RunObject = Page "New Travel Authorization";
                }
                action("Pending Imprest Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Requisition Pending Approval';


                    RunObject = Page "Pending Travel Authorization";
                }
                action("Approved Imprest Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Requisition Approved';


                    RunObject = Page "Approved Travel Authorization";
                }
                action("Posted Imprest Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Imprest Requisition';


                    RunObject = Page "Posted Travel Authorization";
                }
            }
            group("Imprest Accounting")
            {
                Caption = 'Imprest Surrender';
                Image = CostAccounting;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("New Imprest Accounting")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Imprest Surrender';


                    RunObject = Page "New Travel Accounting";
                }
                action("Pending Imprest Accounting")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Imprest Surrender';


                    RunObject = Page "Pending Travel Accounting";
                }
                action("Approved Imprest Accounting")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Imprest Surrender';


                    RunObject = Page "Approved Travel Accounting";
                }
                action("Posted Imprest Accounting")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Imprest Surrender';


                    RunObject = Page "Posted Travel Accounting";
                }
            }

            group("Human Resource Management")
            {
                Caption = 'Human Resource Management';
                action("HR Employee List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Employee List';


                    RunObject = Page "HR Employee List";
                }

                action("HR Leave Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Leave Journal Lines';


                    RunObject = Page "HR Leave Journal Lines";
                }
                action("Base Calender")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Base Calender';


                    RunObject = Page "Base Calender";
                }
                action("HR Leave Applications List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Leave Applications List';


                    RunObject = Page "HR Leave Applications List";
                }
                action("HR Leave Posted Appli List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Leave Applications Posted';


                    RunObject = Page "Posted Leave Applications";
                }



            }
            group(Procurement)
            {
                action("List of Vendors")
                {
                    Caption = 'List Of Vendors';


                    RunObject = page "Vendor List";
                    Image = Vendor;
                }
                action("List of Approved Purchase Requisition")
                {
                    Caption = 'List Of Approved Purchase Requisition';


                    RunObject = page "Posted Purchase Requisitions";
                    Image = Vendor;
                }
                action("Request For Quotes")
                {
                    Caption = 'Requeste For Quotation';


                    RunObject = page "RFQ List";
                }
                action("Purchase Quotes")
                {
                    Caption = 'Purchase Quotes';


                    RunObject = page "Purchase Quotes List";
                }

                action("LPO List")
                {
                    Caption = 'LPO Lists';



                    RunObject = page "LPO Lists";
                }

            }

            group(Timesheets)
            {
                Caption = 'Timesheets';
                Image = CostAccounting;
                Visible = false;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("New Timesheet Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Timesheet Entries';


                    RunObject = Page "New Timesheet Entries";
                }
                action("Pending Timesheet Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Timesheet Entries';


                    RunObject = Page "Pending Timesheet Entries";
                }
                action("Approved Timesheet Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Timesheet Entries';


                    RunObject = Page "Approved Timesheet Entries";
                }
            }

        }
    }
}
profile "Staff Role Center"
{
    Caption = 'Staff Role Center';
    RoleCenter = "Staff Role Center";
    ProfileDescription = 'Staff Role Center Custom';
}
