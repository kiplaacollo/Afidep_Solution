Page 50031 "Procurement Office Role Center"
{
    // CurrPage."Help And Setup List".ShowFeatured;

    Caption = 'Procurement Office Role Center', Comment = '{Dependency=Match,"ProfileDescription_SMALLBUSINESS"}';
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
            part(Control16; "Role Activities")
            {
                AccessByPermission = TableData "Activities Cue" = I;
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(sections)
        {
            group(Purchasing)
            {
                Caption = 'Purchasing';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action(Purchase_VendorList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';

                    RunObject = Page "Vendor List";
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action("Supplier Categories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Supplier Categories';

                    RunObject = Page "Supplier Categories";
                }
                action(Items)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';

                    RunObject = Page "Item List";
                }
                action("Procurement Plan")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Procurement Plan';

                    RunObject = Page "Procurement Plan";
                }
                action("<Page Purchase Orders>")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Orders';

                    RunObject = Page "Purchase Order List";
                    ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action(Dimensions)
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';

                    RunObject = Page Dimensions;
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
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
                action("Approved Purchase Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Purchase Requisition';

                    RunObject = Page "Posted Purchase Requisitions";
                }
                action("Completed Purchase Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Completed Purchase Requisition';

                    RunObject = Page "Completed  Purchase Req.";
                }
            }
            group("Request For Quotations")
            {
                Caption = 'Request For Quotations';
                Image = Purchasing;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(Action132)
                {
                    ApplicationArea = Suite;
                    Caption = 'Request For Quotations';

                    //RunObject = Page UnknownPage17393;
                }
                action("Completed RFQs")
                {
                    ApplicationArea = Suite;
                    Caption = 'Completed RFQs';

                    // RunObject = Page UnknownPage17412;
                }
            }


            group(Timesheets)
            {
                Caption = 'Timesheets';
                Image = CostAccounting;

                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("New Timesheet Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Timesheet Entries';

                    RunObject = Page "New Timesheet Entries";
                    RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }

                action("New Timesheet Entries2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Timesheet ';

                    RunObject = Page "Time Sheet";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("Pending Timesheet Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Timesheet Entries';
                    RunObject = Page "New Timesheet Entries";
                    // RunPageLink = Status = filter("Pending Approval");

                    //RunObject = Page "Pending Timesheet Entries";
                }
                action("Approved Timesheet Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Timesheet Entries';
                    RunObject = Page "New Timesheet Entries";
                    RunPageLink = Status = filter(Approved);

                    //RunObject = Page "Approved Timesheet Entries";
                }
            }


            group(Tenders)
            {
                Caption = 'Tenders';
                Image = Purchasing;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("New Tenders")
                {
                    ApplicationArea = Suite;
                    Caption = 'New Tenders';

                    //RunObject = Page UnknownPage17385;
                }
                action("Closed Tenders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Closed Tenders';

                    //RunObject = Page UnknownPage17387;
                }
                action("Tender Contracts")
                {
                    ApplicationArea = Suite;
                    Caption = 'Tender Contracts';

                    //RunObject = Page UnknownPage17205;
                }
            }
        }
    }
}

