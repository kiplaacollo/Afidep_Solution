Page 50029 "Finance Manager Role Center2"
{
    // CurrPage."Help And Setup List".ShowFeatured;

    Caption = 'Business Manager', Comment='{Dependency=Match,"ProfileDescription_SMALLBUSINESS"}';
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
            part(Control16;"O365 Activities")
            {
                AccessByPermission = TableData "Activities Cue"=I;
                ApplicationArea = Basic,Suite;
            }
           
            part(Control7;"My Accounts")
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Favorite Accounts';
            }
            part(Control9;"Trial Balance")
            {
                AccessByPermission = TableData "G/L Entry"=R;
                ApplicationArea = Basic,Suite;
            }
           
            part(Control46;"Team Member Activities No Msgs")
            {
                ApplicationArea = Suite;
            }
            part(Control113;"O365 Link to Financials")
            {
                ApplicationArea = Invoicing;
                Caption = ' ';
            }
            part(Control96;"Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox"=IMD;
                ApplicationArea = Basic,Suite;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Donor Invoice")
            {
                AccessByPermission = TableData "Sales Header"=IMD;
                ApplicationArea = Basic,Suite;
                Caption = 'Donor Invoice';
                Image = NewSalesInvoice;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for the sales of items or services. Invoice quantities cannot be posted partially.';
            }
            action("Purchase Quote")
            {
                AccessByPermission = TableData "Purchase Header"=IMD;
                ApplicationArea = Suite;
                Caption = 'Purchase Quote';
                Image = NewSalesQuote;
                RunObject = Page "Purchase Quote";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase quote.';
            }
            action("<Page Purchase Order>")
            {
                AccessByPermission = TableData "Purchase Header"=IMD;
                ApplicationArea = Suite;
                Caption = 'Purchase Order';
                Image = NewOrder;
                RunObject = Page "Purchase Order";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase order.';
            }
            action("Purchase Invoice")
            {
                AccessByPermission = TableData "Purchase Header"=IMD;
                ApplicationArea = Basic,Suite;
                Caption = 'Purchase Invoice';
                Image = NewPurchaseInvoice;
                RunObject = Page "Purchase Invoice";
                RunPageMode = Create;
                ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
        }
        area(processing)
        {
            group(New)
            {
                Caption = 'New';
                Image = New;
                action(Customer)
                {
                    AccessByPermission = TableData Customer=IMD;
                    ApplicationArea = Basic,Suite;
                    Caption = 'Customer';
                    Image = Customer;
                    RunObject = Page "Customer Card";
                    RunPageMode = Create;
                    ToolTip = 'Register a new customer.';
                }
                action(Vendor)
                {
                    AccessByPermission = TableData Vendor=IMD;
                    ApplicationArea = Basic,Suite;
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageMode = Create;
                    ToolTip = 'Register a new vendor.';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                action("Payment Reconciliation Journals")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Reconcile Imported Payments';
                    Image = ApplyEntries;
                    RunObject = Codeunit "Pmt. Rec. Journals Launcher";
                    ToolTip = 'Reconcile your bank account by importing transactions and applying them, automatically or manually, to open customer ledger entries, open vendor ledger entries, or open bank account ledger entries.';
                }
                action("Import Bank Transactions")
                {
                    AccessByPermission = TableData "Bank Export/Import Setup"=IMD;
                    ApplicationArea = Basic,Suite;
                    Caption = 'Import Bank Transactions...';
                    Image = Import;
                    RunObject = Codeunit "Pmt. Rec. Jnl. Import Trans.";
                    ToolTip = 'To start the process of reconciling new payments, import a bank feed or electronic file containing the related bank transactions.';
                }
                action("Register Customer Payments")
                {
                    AccessByPermission = TableData "Payment Registration Setup"=IMD;
                    ApplicationArea = Basic,Suite;
                    Caption = 'Register Customer Payments';
                    Image = Payment;
                    RunObject = Page "Payment Registration";
                    ToolTip = 'Process your customer payments by matching amounts received on your bank account with the related unpaid sales invoices, and then post the payments.';
                }
                action("Create Vendor Payments")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Create Vendor Payments';
                    Image = SuggestVendorPayments;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageView = where("Document Type"=filter(Invoice),
                                        "Remaining Amount"=filter(<0),
                                        "Applies-to ID"=filter(''));
                    ToolTip = 'Opens vendor ledger entries for all vendors with invoices that have not been paid yet.';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                group("Financial Statements")
                {
                    Caption = 'Financial Statements';
                    Image = ReferenceData;
                    action("Balance Sheet")
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";
                      
                        RunObject = Report "Balance Sheet";
                        ToolTip = 'View your company''s assets, liabilities, and equity.';
                    }
                    action("Income Statement")
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Income Statement';
                        Image = "Report";
                      
                        RunObject = Report "Income Statement";
                        ToolTip = 'View your company''s income and expenses.';
                    }
                    action("Statement of Cash Flows")
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Statement of Cash Flows';
                        Image = "Report";
                      
                        RunObject = Report "Statement of Cashflows";
                        ToolTip = 'View a financial statement that shows how changes in balance sheet accounts and income affect the company''s cash holdings, displayed for operating, investing, and financing activities respectively.';
                    }
                    action("Statement of Retained Earnings")
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Statement of Retained Earnings';
                        Image = "Report";
                      
                        RunObject = Report "Retained Earnings Statement";
                        ToolTip = 'View a report that shows your company''s changes in retained earnings for a specified period by reconciling the beginning and ending retained earnings for the period, using information such as net income from the other financial statements.';
                    }
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;
                action("Company Settings")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Company Settings';
                    Image = CompanyInformation;
                    RunObject = Page "Company Information";
                    ToolTip = 'Enter the company name, address, and bank information that will be inserted on your business documents.';
                }
                action("Assisted Setup")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    //RunObject = Page UnknownPage1801;
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                }
                group("Services & Extensions")
                {
                    Caption = 'Services & Extensions';
                    Image = ServiceSetup;
                    action(Extensions)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Extensions';
                        Image = NonStockItemSetup;
                       /// RunObject = Page UnknownPage2500;
                        ToolTip = 'Install Extensions for greater functionality of the system.';
                    }
                    action("Service Connections")
                    {
                        ApplicationArea = Service;
                        Caption = 'Service Connections';
                        Image = ServiceTasks;
                        RunObject = Page "Service Connections";
                        ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                    }
                }
            }
        }
        area(reporting)
        {
            group("Excel Reports")
            {
                Caption = 'Excel Reports';
                Image = Excel;
                action(ExcelTemplatesBalanceSheet)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Balance Sheet';
                    Image = "Report";
                   
                   
                    RunObject = Codeunit "Run Template Balance Sheet";
                    ToolTip = 'Open a spreadsheet that shows your company''s assets, liabilities, and equity.';
                }
                action(ExcelTemplateIncomeStmt)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Income Statement';
                    Image = "Report";
                   
                   
                    RunObject = Codeunit "Run Template Income Stmt.";
                    ToolTip = 'Open a spreadsheet that shows your company''s income and expenses.';
                }
                action(ExcelTemplateCashFlowStmt)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Cash Flow Statement';
                    Image = "Report";
                   
                   
                    RunObject = Codeunit "Run Template CashFlow Stmt.";
                    ToolTip = 'Open a spreadsheet that shows how changes in balance sheet accounts and income affect the company''s cash holdings.';
                }
                action(ExcelTemplateRetainedEarn)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Retained Earnings Statement';
                    Image = "Report";
                   
                   
                    RunObject = Codeunit "Run Template Retained Earn.";
                    ToolTip = 'Open a spreadsheet that shows your company''s changes in retained earnings based on net income from the other financial statements.';
                }
                action(ExcelTemplateTrialBalance)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Trial Balance';
                    Image = "Report";
                   
                   
                    RunObject = Codeunit "Run Template Trial Balance";
                    ToolTip = 'Open a spreadsheet that shows a summary trial balance by account.';
                }
                action(ExcelTemplateAgedAccPay)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Aged Accounts Payable';
                    Image = "Report";
                   
                   
                    RunObject = Codeunit "Run Template Aged Acc. Pay.";
                    ToolTip = 'Open a spreadsheet that shows a list of aged remaining balances for each vendor by period.';
                }
                action(ExcelTemplateAgedAccRec)
                {
                    ApplicationArea = Basic,Suite;
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
                ApplicationArea = Basic,Suite;
                Caption = 'Customers';
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action(Vendors)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Vendors';
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }
            action(Items)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Items';
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action("Bank Accounts")
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action("Chart of Accounts")
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
            }
        }
        area(sections)
        {
            group(Finance)
            {
                Caption = 'Finance';
                Image = Journals;
                ToolTip = 'Collect and make payments, prepare statements, and reconcile bank accounts.';
                action(GeneralJournals)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type"=const(General),
                                        Recurring=const(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action(Action3)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Chart of Accounts';
                
                    RunObject = Page "Chart of Accounts";
                    ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
                }
                action("Line Allocation")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Line Allocation';
                
                    RunObject = Page "Line Allocations";
                }
                action("Project Budgets")
                {
                    ApplicationArea = Suite;
                    Caption = 'Project Budgets';
                
                    RunObject = Page "Project Budget";
                    ToolTip = 'View summary information about the amount budgeted for each general ledger account in different time periods.';
                }
                action("Fixed Assets")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action("Account Schedules")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Account Schedules';
                
                    RunObject = Page "Account Schedule Names";
                    ToolTip = 'Get insight into the financial data stored in your chart of accounts. Account schedules analyze figures in G/L accounts, and compare general ledger entries with general ledger budget entries. For example, you can view the general ledger entries as percentages of the budget entries. Account schedules provide the data for core financial statements and views, such as the Cash Flow chart.';
                }
                action(Currencies)
                {
                    ApplicationArea = Suite;
                    Caption = 'Currencies';
                    Image = Currency;
                
                    RunObject = Page Currencies;
                    ToolTip = 'View the different currencies that you trade in or update the exchange rates by getting the latest rates from an external service provider.';
                }
                action(Dimensions)
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                
                    RunObject = Page Dimensions;
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action(RequestToApproveEntries)
                {
                    ApplicationArea = Suite;
                    Caption = 'Request To Approve';
                
                    RunObject = Page "Approval Entries Delegation";
                    //ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action(ListofApprovers)
                {
                    ApplicationArea = Suite;
                    Caption = 'Listof Approvers';
                
                    RunObject = Page "Approval User Setup";
                    //ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
            }
            group("Cash Management")
            {
                Caption = 'Cash Management';
                ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.';
                action(CashReceiptJournals)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type"=const("Cash Receipts"),
                                        Recurring=const(false));
                    ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
                }
                action(PaymentJournals)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Payment Journals';
                    Image = Journals;
                
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type"=const(Payments),
                                        Recurring=const(false));
                    ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                }
                action(Action23)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                
                    RunObject = Page "Bank Account List";
                    ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                }
                action("Bank Acc. Reconciliation")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Bank Acc. Reconciliation';
                    Image = BankAccount;
                
                    RunObject = Page "Bank Acc. Reconciliation List";
                }
                action("Bank Acc. Statements")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Bank Acc. Statements';
                    Image = BankAccountStatement;
                
                    RunObject = Page "Bank Account Statement List";
                    ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
                }
                action("Payment Terms")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Payment Terms';
                    Image = Payment;
                
                    RunObject = Page "Payment Terms";
                    ToolTip = 'Set up the payment terms that you select from on customer cards to define when the customer must pay, such as within 14 days.';
                }
            }
            group(Receivables)
            {
                Caption = 'Receivables';
                Image = Sales;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(Sales_CustomerList)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Customers';
                
                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
                action(Action129)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Items';
                
                    RunObject = Page "Item List";
                    ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit.';
                }
                action("Item Charges")
                {
                    ApplicationArea = Suite;
                    Caption = 'Item Charges';
                    RunObject = Page "Item Charges";
                    ToolTip = 'View or edit the codes for item charges that you can assign to purchase and sales transactions to include any added costs, such as freight, physical handling, and insurance that you incur when purchasing or selling items. This is important to ensure correct inventory valuation. For purchases, the landed cost of a purchased item consists of the vendor''s purchase price and all additional direct item charges that can be assigned to individual receipts or return shipments. For sales, knowing the cost of shipping sold items can be as vital to your company as knowing the landed cost of purchased items.';
                }
                action("Sales Quotes")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Sales Quotes';
                
                    RunObject = Page "Sales Quotes";
                    ToolTip = 'Make offers to customers to sell certain products on certain delivery and payment terms. While you negotiate with a customer, you can change and resend the sales quote as much as needed. When the customer accepts the offer, you convert the sales quote to a sales invoice or a sales order in which you process the sale.';
                }
                action("Sales Orders")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Sales Orders';
                
                    RunObject = Page "Sales Order List";
                    ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
                }
                action("Blanket Sales Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Sales Orders';
                    Image = Reminder;
                
                    RunObject = Page "Blanket Sales Orders";
                    ToolTip = 'Use blanket sales orders as a framework for a long-term agreement between you and your customers to sell large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a sales order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes..';
                }
                action("Funds Request")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Funds Request';
                
                    RunObject = Page "Sales Invoice List";
                    ToolTip = 'Register your sales to customers and invite them to pay according to the delivery and payment terms by sending them a sales invoice document. Posting a sales invoice registers shipment and records an open receivable entry on the customer''s account, which will be closed when payment is received. To manage the shipment process, use sales orders, in which sales invoicing is integrated.';
                }
                action("Fund Credit Memos")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Fund Credit Memos';
                
                    RunObject = Page "Sales Credit Memos";
                    ToolTip = 'Revert the financial transactions involved when your customers want to cancel a purchase or return incorrect or damaged items that you sent to them and received payment for. To include the correct information, you can create the sales credit memo from the related posted sales invoice or you can create a new sales credit memo with copied invoice information. If you need more control of the sales return process, such as warehouse documents for the physical handling, use sales return orders, in which sales credit memos are integrated. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
                }
                action("Sales Return Orders")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Sales Return Orders';
                
                    RunObject = Page "Sales Return Order List";
                    ToolTip = 'Compensate your customers for incorrect or damaged items that you sent to them and received payment for. Sales return orders support warehouse documents for the item handling, the ability to return items from multiple sales documents with one return, and automatic creation of related sales credit memos or other return-related documents, such as a replacement sales order.';
                }
                action(Reminders)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reminders';
                    Image = Reminder;
                
                    RunObject = Page "Reminder List";
                    ToolTip = 'Remind customers about overdue amounts based on reminder terms and the related reminder levels. Each reminder level includes rules about when the reminder will be issued in relation to the invoice due date or the date of the previous reminder and whether interests are added. Reminders are integrated with finance charge memos, which are documents informing customers of interests or other money penalties for payment delays.';
                }
                action("Finance Charge Memos")
                {
                    ApplicationArea = Suite;
                    Caption = 'Finance Charge Memos';
                    Image = FinChargeMemo;
                
                    RunObject = Page "Finance Charge Memo List";
                    ToolTip = 'Send finance charge memos to customers with delayed payments, typically following a reminder process. Finance charges are calculated automatically and added to the overdue amounts on the customer''s account according to the specified finance charge terms and penalty/interest amounts.';
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action("Posted Sales Return Receipts")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Posted Sales Return Receipts';
                    RunObject = Page "Posted Return Receipts";
                    ToolTip = 'Open the list of posted sales return receipts.';
                }
                action("Issued Reminders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Issued Reminders';
                    Image = OrderReminder;
                    RunObject = Page "Issued Reminder List";
                    ToolTip = 'View the list of issued reminders.';
                }
                action("Issued Finance Charge Memos")
                {
                    ApplicationArea = Suite;
                    Caption = 'Issued Finance Charge Memos';
                    Image = PostedMemo;
                    RunObject = Page "Issued Fin. Charge Memo List";
                    ToolTip = 'View the list of issued finance charge memos.';
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
            group(Payables)
            {
                Caption = 'Payables';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action(Purchase_VendorList)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Vendors';
                
                    RunObject = Page "Vendor List";
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action("Incoming Documents")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Incoming Documents';
                    Gesture = None;
                
                    RunObject = Page "Incoming Documents";
                    ToolTip = 'Handle incoming documents, such as vendor invoices in PDF or as image files, that you can manually or automatically convert to document records, such as purchase invoices. The external files that represent incoming documents can be attached at any process stage, including to posted documents and to the resulting vendor, customer, and general ledger entries.';
                }
                action("<Page Purchase Orders>")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Orders';
                
                    RunObject = Page "Purchase Order List";
                    ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action("<Page Purchase Invoices>")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Purchase Invoices';
                
                    RunObject = Page "Purchase Invoices";
                    ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action("<Page Purchase Credit Memos>")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Purchase Credit Memos';
                
                    RunObject = Page "Purchase Credit Memos";
                    ToolTip = 'Create purchase credit memos to mirror sales credit memos that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. If you need more control of the purchase return process, such as warehouse documents for the physical handling, use purchase return orders, in which purchase credit memos are integrated. Purchase credit memos can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
                }
                action("<Page Posted Purchase Invoices>")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("<Page Posted Purchase Credit Memos>")
                {
                    ApplicationArea = Basic,Suite;
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
            group("Travel Authorization")
            {
                Caption = 'Travel Authorization';
                Image = CostAccounting;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("New Travel Authorization")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'New Travel Authorization';
                
                    RunObject = Page "New Travel Authorization";
                }
                action("Pending Travel Authorization")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Pending Travel Authorization';
                
                    RunObject = Page "Pending Travel Authorization";
                }
                action("Approved Travel Authorization")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Approved Travel Authorization';
                
                    RunObject = Page "Approved Travel Authorization";
                }
                action("Posted Travel Authorization")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Posted Travel Authorization';
                
                    RunObject = Page "Posted Travel Authorization";
                }
            }
            group("Travel Accounting")
            {
                Caption = 'Travel Accounting';
                Image = CostAccounting;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("New Travel Accounting")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'New Travel Accounting';
                
                    RunObject = Page "New Travel Accounting";
                }
                action("Pending Travel Accounting")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Pending Travel Accounting';
                
                    RunObject = Page "Pending Travel Accounting";
                }
                action("Approved Travel Accounting")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Approved Travel Accounting';
                
                    RunObject = Page "Approved Travel Accounting";
                }
                action("Posted Travel Accounting")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Posted Travel Accounting';
                
                    RunObject = Page "Posted Travel Accounting";
                }
            }
            group("Travel Claim")
            {
                Caption = 'Travel Claim';
                Image = CostAccounting;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(" New Claim Authorization")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'New Travel Authorization';
                
                    RunObject = Page "New Claim Authorization";
                }
                action("Pending Claim Authorization")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Pending Claim Authorization';
                
                    RunObject = Page "Pending Claim Authorization";
                }
                action("Approved Claim Authorization")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Approved Claim Authorization';
                
                    RunObject = Page "Approved Claim Authorization";
                }
                action("Posted Claim Authorization")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Posted Claim Authorization';
                
                    RunObject = Page "Posted Claim Authorization";
                }
            }
            group(Payroll)
            {
                Caption = 'Payroll';
                Image = Calculator;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                group("Payroll Employees")
                {
                    action("Payroll Employees K")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Employees KENYA';

                        RunObject = Page "Payroll Employee List_AU";
                    }
                    action("Payroll Employees M")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Employees MALAWI';

                        RunObject = Page "Payroll Employee Malawi";
                    }
                }
                group("Payroll Period")
                {
                    action("Payroll Periods")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Periods Kenya';

                        RunObject = Page "Payroll Calender _AU";
                    }
                    action("Payroll Periods Malawi")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Periods Malawi';

                        RunObject = Page "Payroll CalenderMalawi";
                    }
                }
               group("Payroll Approval")
                {
                    action("Payroll Approval Kenya")
                    {

                        ApplicationArea = Basic, Suite;
                        RunObject = page 80172;
                    }
                    action("Payroll Approval Malawi")
                    {

                        ApplicationArea = Basic, Suite;
                        RunObject = page "Payrol list M";
                    }
                }
                group("Payroll Setups")
                {
                    action("Payroll Earnings Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Earnings Setup';

                        RunObject = Page "Payroll Earnings List_AU";
                    }
                    action("Payroll Deductions Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Deductions Setup';

                        RunObject = Page "Payroll Deductions List_AU";
                    }
                    action("PAYE Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'PAYE Setup';

                        RunObject = Page "Payroll PAYE Setup_AU";
                    }
                    action("NSSF Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'NSSF Setup';

                        RunObject = Page "Payroll NSSF Setup_AU";
                    }
                    action("NHIF Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'NHIF Setup';

                        RunObject = Page "Payroll NHIF Setup_AU";
                    }

                    action("Payroll Posting Group")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Posting Group';

                        RunObject = Page "Payroll Posting Group_AU";
                    }
                    action("Payroll General Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll General Setup';

                        RunObject = Page "Payroll General Setup_AU";
                    }
                }
                action("Payroll Project Allocation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payroll Project Allocation';

                    RunObject = Page "Payroll Project Allocation";
                }
                action("Payroll Journal Transfer")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payroll Journal Transfer Kenya';

                    RunObject = report "Payroll Journal Transfer";
                }
                action("Payroll Journal Transfer M")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payroll Journal Transfer Malawi';

                    RunObject = report "Payroll Journal Transfer M";
                }
                group("Payroll Reports")
                {
                    action("Payroll NetPay Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll NetPay Report';

                        RunObject = report "Payroll Net P_AU";
                    }
                    action("Payroll Summary Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Summary Report';

                        RunObject = report "Payroll Summary P_AU";
                    }
                    action("Payroll Payment Schedule Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Payment Schedule Report';

                        RunObject = report "Payments Summary_AU";
                    }
                    action("PAYE Schedule Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'PAYE Schedule Report';

                        RunObject = report "Paye Schedule_AU";
                    }
                    action("SHIF Schedule Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'SHIF Schedule Report';

                        RunObject = report "SHIF Schedule Ver1";
                    }
                    action("NSSF Schedule Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'NSSF Schedule Report';

                        RunObject = report "NSSF Schedule_AU";
                    }
                    action("Bank Schedule Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Schedule Report';

                        RunObject = report "Bank Schedule_AU";
                    }
                    action("Pension Schedule Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pension Schedule Report';

                        RunObject = report "Pension Report_AU";
                    }
                    action("Pension Malawi")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Malawi Pension';

                        RunObject = report "Malawi Pension";
                    }
                    action("Group Life")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Group Life';
                        RunObject = report "Group Life Insurance";
                    }
                    action("P10 Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'P10 Report';
                        RunObject = report P10;
                    }
                    action("Helb Schedule Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Helb Schedule Report';

                        RunObject = report "Helb Schedule Ver1";
                    }
                    action("Payroll Variance Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Variance Report KES';
                        RunObject = report "Varience Payroll Summary";
                    }
                    action("Payroll Variance Report USD")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Variance Report USD';
                        RunObject = report "USD Varience Payroll Summary";
                    }
                }

            }
            group(Timesheets)
            {
                Caption = 'Timesheets';
                Image = CostAccounting;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("New Timesheet Entries")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'New Timesheet Entries';
                
                    RunObject = Page "New Timesheet Entries";
                }
                action("Pending Timesheet Entries")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Pending Timesheet Entries';
                
                    RunObject = Page "Pending Timesheet Entries";
                }
                action("Approved Timesheet Entries")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Approved Timesheet Entries';
                
                    RunObject = Page "Approved Timesheet Entries";
                }
            }
        }
        
    }

}

