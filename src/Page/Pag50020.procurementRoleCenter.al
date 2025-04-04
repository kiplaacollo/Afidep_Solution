Page 50020 "procurement Role Center"
{
    // CurrPage."Help And Setup List".ShowFeatured;

    Caption = 'Business Manager', Comment = '{Dependency=Match,"ProfileDescription_SMALLBUSINESS"}';
    PageType = RoleCenter;
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(rolecenter)
        {
            part(Control139; "Headline RC Business Manager")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control16; "Procurement Activities")
            {
                AccessByPermission = TableData "Activities Cue" = I;
                ApplicationArea = Basic, Suite;
            }
            part(Control7; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Favorite Accounts';
                Visible = false;
            }
            part(Control113; "O365 Link to Financials")
            {
                ApplicationArea = Invoicing;
                Caption = ' ';
                Visible = false;
            }
            part(Control46; "Team Member Activities No Msgs")
            {
                ApplicationArea = Suite;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group("Excel Reports")
            {
                Caption = 'Excel Reports';
                Image = Excel;
                action(ExcelTemplatesBalanceSheet)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance Sheet';
                    Image = "Report";
                    
                    RunObject = Codeunit "Run Template Balance Sheet";
                    ToolTip = 'Open a spreadsheet that shows your company''s assets, liabilities, and equity.';
                }
                action(ExcelTemplateIncomeStmt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Income Statement';
                    Image = "Report";
                    
                    RunObject = Codeunit "Run Template Income Stmt.";
                    ToolTip = 'Open a spreadsheet that shows your company''s income and expenses.';
                }
                action(ExcelTemplateCashFlowStmt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Statement';
                    Image = "Report";
                    
                    RunObject = Codeunit "Run Template CashFlow Stmt.";
                    ToolTip = 'Open a spreadsheet that shows how changes in balance sheet accounts and income affect the company''s cash holdings.';
                }
                action(ExcelTemplateRetainedEarn)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Retained Earnings Statement';
                    Image = "Report";
                    
                    RunObject = Codeunit "Run Template Retained Earn.";
                    ToolTip = 'Open a spreadsheet that shows your company''s changes in retained earnings based on net income from the other financial statements.';
                }
                action(ExcelTemplateTrialBalance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance';
                    Image = "Report";
                    
                    RunObject = Codeunit "Run Template Trial Balance";
                    ToolTip = 'Open a spreadsheet that shows a summary trial balance by account.';
                }
                action(ExcelTemplateAgedAccPay)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Payable';
                    Image = "Report";
                    
                    RunObject = Codeunit "Run Template Aged Acc. Pay.";
                    ToolTip = 'Open a spreadsheet that shows a list of aged remaining balances for each vendor by period.';
                }
                action(ExcelTemplateAgedAccRec)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Receivable';
                    Image = "Report";
                    
                    RunObject = Codeunit "Run Template Aged Acc. Rec.";
                    ToolTip = 'Open a spreadsheet that shows when customer payments are due or overdue by period.';
                }
            }
        }
        area(embedding)
        {
            ToolTip = 'Manage your business. See KPIs, trial balance, and favorite customers.';
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers';
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
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
            action("Bank Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action("Chart of Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
            }
        }
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
                action("Procurement Plan")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Procurement Plan';
                   
                   
                    RunObject = Page "Procurement Plan";
                }
                action("Incoming Documents")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Incoming Documents';
                    Gesture = None;
                   
                   
                    RunObject = Page "Incoming Documents";
                    ToolTip = 'Handle incoming documents, such as vendor invoices in PDF or as image files, that you can manually or automatically convert to document records, such as purchase invoices. The external files that represent incoming documents can be attached at any process stage, including to posted documents and to the resulting vendor, customer, and general ledger entries.';
                }
                action("Item Charges")
                {
                    ApplicationArea = Suite;
                    Caption = 'Item Charges';
                   
                   
                    RunObject = Page "Item Charges";
                    ToolTip = 'View or edit the codes for item charges that you can assign to purchase and sales transactions to include any added costs, such as freight, physical handling, and insurance that you incur when purchasing or selling items. This is important to ensure correct inventory valuation. For purchases, the landed cost of a purchased item consists of the vendor''s purchase price and all additional direct item charges that can be assigned to individual receipts or return shipments. For sales, knowing the cost of shipping sold items can be as vital to your company as knowing the landed cost of purchased items.';
                }
                action("Purchase Quotes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Quotes';
                   
                   
                    RunObject = Page "Purchase Quotes";
                    ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
                }
                action("Request For Quotations")
                {
                    ApplicationArea = Suite;
                    Caption = 'Request For Quotations';
                   
                   
                    //RunObject = Page UnknownPage17393;
                }
                action("Completed RFQs")
                {
                    ApplicationArea = Suite;
                    Caption = 'Completed RFQs';
                   
                   
                    //RunObject = Page UnknownPage17412;
                }
                action("<Page Purchase Orders>")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Orders';
                   
                   
                    RunObject = Page "Purchase Order List";
                    ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action("Blanket Purchase Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Purchase Orders';
                   
                   
                    RunObject = Page "Blanket Purchase Orders";
                    ToolTip = 'Use blanket purchase orders as a framework for a long-term agreement between you and your vendors to buy large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a purchase order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes.';
                }
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
                action("<Page Purchase Invoices>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoices';
                   
                   
                    RunObject = Page "Purchase Invoices";
                    ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action("<Page Purchase Credit Memos>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Credit Memos';
                   
                   
                    RunObject = Page "Purchase Credit Memos";
                    ToolTip = 'Create purchase credit memos to mirror sales credit memos that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. If you need more control of the purchase return process, such as warehouse documents for the physical handling, use purchase return orders, in which purchase credit memos are integrated. Purchase credit memos can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
                }
                action("Purchase Return Orders")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Purchase Return Orders';
                   
                   
                    RunObject = Page "Purchase Return Order List";
                    ToolTip = 'Create purchase return orders to mirror sales return documents that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. Purchase return orders enable you to ship back items from multiple purchase documents with one purchase return and support warehouse documents for the item handling. Purchase return orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
                }
                action("<Page Posted Purchase Invoices>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("<Page Posted Purchase Credit Memos>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("<Page Posted Purchase Receipts>")
                {
                    ApplicationArea = Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
                action("Posted Purchase Return Shipments")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Posted Purchase Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                    ToolTip = 'Open the list of posted purchase return shipments.';
                }
            }
            group("Float Management")
            {
                Caption = 'Float Management';
                Image = CostAccounting;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("Imprest Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Float Request';
                   
                   
                    RunObject = Page "Imprest Request";
                }
                action("Posted Imprests")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Floats';
                   
                   
                    RunObject = Page "Posted Imprests";
                }
                action("Imprest Surrender")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Float Accounting';
                   
                   
                    RunObject = Page "Imprest Surrender";
                }
                action("Posted Surrender")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Accounting';
                   
                   
                    RunObject = Page "Posted Surrender";
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
        }
    }



}

