Page 50030 "Finance Officer Role Center"
{


    Caption = 'Business Manager', Comment = '{Dependency=Match,"ProfileDescription_SMALLBUSINESS"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(DashbordVisualizationCardPar; "Dashbord Visualization CardPar")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;

            }
            part(Control139; "Headline RC Business Manager")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            group(ImprestApp)
            {
                part(ImprestAccounting; "Imp. Acc Dashboard Cue")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                part(ApprovalActivities; "Approvals Activities")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
            }
            part(EmailActivities; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part(OtherDocActivities; "Staff Dashboard Cue")
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

                Visible = false;
            }
            part(Control7; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Favorite Accounts';
            }
            part(Control9; "Trial Balance")
            {
                AccessByPermission = TableData "G/L Entry" = R;
                ApplicationArea = Basic, Suite;
            }

            part(Control46; "Team Member Activities No Msgs")
            {
                ApplicationArea = Suite;
                Visible = false;
            }
            part(Control113; "O365 Link to Financials")
            {
                ApplicationArea = Invoicing;
                Caption = ' ';
            }
            part(Control96; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Payment Voucher")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Voucher';
                Image = NewSalesInvoice;
                RunObject = Page "Payment Voucher Card";
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for the sales of items or services. Invoice quantities cannot be posted partially.';
            }
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
                Visible = false;
                RunObject = Page "Task Order Card";
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for the sales of items or services. Invoice quantities cannot be posted partially.';
            }
            action("Donor Invoice")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Donor Invoice';
                Image = NewSalesInvoice;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
                Visible = false;
                ToolTip = 'Create a new invoice for the sales of items or services. Invoice quantities cannot be posted partially.';
            }
            action("Purchase Quote")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Suite;
                Caption = 'Purchase Quote';
                Image = NewSalesQuote;
                RunObject = Page "Purchase Quote";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase quote.';
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
            action("Purchase Invoice")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Basic, Suite;
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
                    AccessByPermission = TableData Customer = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    Image = Customer;
                    RunObject = Page "Customer Card";
                    RunPageMode = Create;
                    ToolTip = 'Register a new customer.';
                }
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
            group(Payments)
            {
                Caption = 'Payments';
                action("Payment Reconciliation Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reconcile Imported Payments';
                    Image = ApplyEntries;
                    RunObject = Codeunit "Pmt. Rec. Journals Launcher";
                    ToolTip = 'Reconcile your bank account by importing transactions and applying them, automatically or manually, to open customer ledger entries, open vendor ledger entries, or open bank account ledger entries.';
                }
                action("Import Bank Transactions")
                {
                    AccessByPermission = TableData "Bank Export/Import Setup" = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Bank Transactions...';
                    Image = Import;
                    RunObject = Codeunit "Pmt. Rec. Jnl. Import Trans.";
                    ToolTip = 'To start the process of reconciling new payments, import a bank feed or electronic file containing the related bank transactions.';
                }
                action("Register Customer Payments")
                {
                    AccessByPermission = TableData "Payment Registration Setup" = IMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Register Customer Payments';
                    Image = Payment;
                    RunObject = Page "Payment Registration";
                    ToolTip = 'Process your customer payments by matching amounts received on your bank account with the related unpaid sales invoices, and then post the payments.';
                }
                action("Create Vendor Payments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Vendor Payments';
                    Image = SuggestVendorPayments;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageView = where("Document Type" = filter(Invoice),
                                        "Remaining Amount" = filter(< 0),
                                        "Applies-to ID" = filter(''));
                    ToolTip = 'Opens vendor ledger entries for all vendors with invoices that have not been paid yet.';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                group("Trial Balance Reports")
                {
                    Caption = 'Trial Balance Reports';
                    Image = ReferenceData;
                    action("Trial. Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Trial Balance';
                        Image = "Report";

                        RunObject = Report "Trial Balancever2";
                        ToolTip = 'View your company''s assets, liabilities, and equity.';
                    }


                    action("Dimension-Total")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Dimension-Total';
                        Image = "Report";

                        RunObject = Report "Dimensions - Total";
                        ToolTip = 'View your company''s assets, liabilities, and equity.';
                    }


                    action("Balance Sheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";

                        RunObject = Report "Balance Sheet";
                        ToolTip = 'View your company''s assets, liabilities, and equity.';
                    }
                    action("Income Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Statement';
                        Image = "Report";

                        RunObject = Report "Income Statement";
                        ToolTip = 'View your company''s income and expenses.';
                    }
                    action("Statement of Cash Flows")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Cash Flows';
                        Image = "Report";

                        RunObject = Report "Statement of Cashflows";
                        ToolTip = 'View a financial statement that shows how changes in balance sheet accounts and income affect the company''s cash holdings, displayed for operating, investing, and financing activities respectively.';
                    }
                    action("Statement of Retained Earnings")
                    {
                        ApplicationArea = Basic, Suite;
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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Company Settings';
                    Image = CompanyInformation;
                    RunObject = Page "Company Information";
                    ToolTip = 'Enter the company name, address, and bank information that will be inserted on your business documents.';
                }
                action("Assisted Setup")
                {
                    ApplicationArea = Basic, Suite;
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
                        ApplicationArea = Basic, Suite;
                        Caption = 'Extensions';
                        Image = NonStockItemSetup;
                        // RunObject = Page UnknownPage2500;
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
                Caption = 'Chart Of Accounts';
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
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;

                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(General),
                                        Recurring = const(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action(Action3)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart Of Accounts';

                    RunObject = Page "Chart of Accounts";
                    ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
                }
                action("Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance';

                    Visible = true;

                    RunObject = report "Trial Balancever2";
                }
                action("General Ledger Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Ledger Report';

                    Visible = true;

                    RunObject = report GeneralLedgerReport;
                }

                action("GL Report Grouped by BudgetLine")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'GL Report Grouped by BudgetLine';

                    Visible = true;

                    RunObject = report "GeneralLedgerReport-Budgetline";
                }
                action("Budget Line Detailed Exp.Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Budget Line Detailed Exp.Report';

                    Visible = true;

                    RunObject = report "Detailed Budget Line Report";
                }
                action("Detailed GL Expenditure Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Detailed GL Expenditure Report';

                    Visible = true;

                    RunObject = report "Detailed GL Expenditure Report";
                }

                action("General Ledger Register List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Registers';

                    Visible = true;

                    RunObject = page "G/L Registers";
                }

                action("General Ledger Entries List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Ledger Entries';

                    Visible = true;

                    RunObject = page "General Ledger Entries";
                }
                action("Import Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Journals';

                    Visible = false;

                    RunObject = xmlport "Import Journals";
                }


                action("Fixed Assets")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action("G/L Budget")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'G/L Budget';
                    RunObject = Page "G/L Budget Names";

                }
                action("Account Schedules")
                {
                    ApplicationArea = Basic, Suite;
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
                    Caption = 'List Of Approvers';

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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;

                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const("Cash Receipts"),
                                        Recurring = const(false));
                    ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
                }
                group(Receipts)
                {
                    action(ReceiptsNew)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Receipts New';
                        Image = List;

                        // Visible = false;

                        RunObject = Page "Receipt Lists";
                        RunPageView = where(Status = filter(Open));//,
                                                                   //                     Recurring = const(false));
                        ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                    }
                    action(ReceiptsPending)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Receipts Pending';
                        Image = List;

                        // Visible = false;

                        RunObject = Page "Receipt Lists";
                        RunPageView = where(Status = filter("Pending Approval"));//,
                                                                                 //                     Recurring = const(false));
                        ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                    }
                    action(ReceiptsApproved)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Receipts';
                        Image = List;

                        // Visible = false;

                        RunObject = Page "Receipt Lists";
                        RunPageView = where(Status = filter(Released), Posted = const(false));//,
                                                                                              //                     Recurring = const(false));
                        ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                    }
                    action(ReceiptsPosted)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Receipts';
                        Image = List;

                        // Visible = false;

                        RunObject = Page "Receipt Lists";
                        RunPageView = where(Status = filter(Released), Posted = const(true));//,
                                                                                             //                     Recurring = const(false));
                        ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                    }


                }
                action(PaymentJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Journals';
                    Image = Journals;

                    Visible = false;

                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(Payments),
                                        Recurring = const(false));
                    ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                }
                action(Action23)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;

                    RunObject = Page "Bank Account List Edited";
                    ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                }
                group("Bank Acc. Reconciliation")
                {
                    action("New Bank Rec")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Bank Rec';
                        Image = BankAccount;

                        RunObject = Page "Bank Acc. Reconciliation List";
                        RunPageView = order(ascending) where(Status = filter('New'));
                    }
                    action("Pending Approval Bank Rec")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending Approval Bank Rec';
                        Image = BankAccount;

                        RunObject = Page "Bank Acc. Reconciliation List";
                        RunPageView = order(ascending) where(Status = filter('Pending Approval'));
                    }
                    action("Approved Bank Rec")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Bank Rec';
                        Image = BankAccount;

                        RunObject = Page "Bank Acc. Reconciliation List";
                        RunPageView = order(ascending) where(Status = filter('Approved'));
                    }
                }
                action("Bank Acc. Statements")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Bank Reconcilliation List';
                    Image = BankAccountStatement;

                    Visible = true;

                    RunObject = Page "Bank Account Statement List";
                    ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
                }
                action("Payment Terms")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Terms';
                    Image = Payment;

                    Visible = false;

                    RunObject = Page "Payment Terms";
                    ToolTip = 'Set up the payment terms that you select from on customer cards to define when the customer must pay, such as within 14 days.';
                }
            }
            group("Grants Management")
            {

                Visible = false;
                action("Donors List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Donors List';

                    RunObject = page 80128;

                }
                action("Donor Pledges List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Donor Pledges List';

                    RunObject = page 80135;

                }
                action("Donor Committment List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Donor Committment List';

                    RunObject = page 80133;

                }
                action("Donor Invoices List/Invoice Accruing")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Donor Invoices List/Invoice Accruing';

                    RunObject = page 80131;

                }
                action("Accrued Invoices Posted")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Accrued Invoices Posted';

                    RunObject = page 143;

                }
            }
            group("Payment Process")
            {
                action("Payment Voucher Process")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Voucher List New';

                    RunObject = page "Payment Voucher List";

                }
                action("Payment Voucher Pending Approval")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Voucher Pending Approval';

                    RunObject = page "Payment Voucher List(Pending)";

                }
                action("Payment Voucher Approved List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Voucher Approved List';

                    RunObject = page "Payment Voucher List(Approved)";

                }
                action("Payment Voucher Posted List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Voucher Posted List';

                    RunObject = page "Payment Voucher List(Posted)";

                }
                group("Petty Cash Kenya")
                {
                    action("Petty Cash New K")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Petty Cash New Kenya';

                        RunObject = page "Petty Cash Voucher List";
                        RunPageView = order(ascending) where(Status = filter('Open'), "Shortcut Dimension 1 Code" = const('KENYA'));

                    }
                    action("Petty Cash Pending K")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Petty Cash Pending Kenya';

                        RunObject = page "Petty Cash Voucher List";
                        RunPageView = order(ascending) where(Status = filter('Pending Approval'), "Shortcut Dimension 1 Code" = const('KENYA'));

                    }
                    action("Petty Cash Approved K")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Petty Cash Approved Kenya';

                        RunObject = page "Petty Cash Voucher List";
                        RunPageView = order(ascending) where(Status = filter('Released'), "Shortcut Dimension 1 Code" = const('KENYA'));

                    }
                }
                group("Petty Cash Malawi")
                {
                    action("Petty Cash New M")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Petty Cash New Malawi';

                        RunObject = page "Petty Cash Voucher List";
                        RunPageView = order(ascending) where(Status = filter('Open'), "Shortcut Dimension 1 Code" = const('MALAWI'));

                    }
                    action("Petty Cash Pending M")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Petty Cash Pending Malawi';

                        RunObject = page "Petty Cash Voucher List";
                        RunPageView = order(ascending) where(Status = filter('Pending Approval'), "Shortcut Dimension 1 Code" = const('MALAWI'));

                    }
                    action("Petty Cash Approved M")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Petty Cash Approved Malawi';

                        RunObject = page "Petty Cash Voucher List";
                        RunPageView = order(ascending) where(Status = filter('Released'), "Shortcut Dimension 1 Code" = const('MALAWI'));

                    }
                }
                action("Petty Cash Process")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Petty Cash List New';
                    Visible = false;

                    RunObject = page "Petty Cash Voucher List";

                }
                action("Witholding Tax Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Witholding Tax Setup';

                    RunObject = page "Withholding Tax Setups";

                }
            }
            group("Purchase Invoices ")
            {
                action("New Purchase Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Purchase Invoice';

                    RunObject = page "Purchase Invoice List";

                }
                action("Purchase Invoice Pending Approval")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoice Pending Approval';

                    RunObject = page "Purchase Invoice List Pend";

                }
                action("Purchase Invoice Approved List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoice Approved List';

                    RunObject = page "Purchase Invoice List Appr";

                }
                action("Purchase Invoice Posted List")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoice Posted List';

                    RunObject = page "Purchase Invoice List Appr";

                }
            }
            group(Transfers)
            {
                action("Funds Transfer")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Funds Transfer';

                    RunObject = page "Funds Transfer List";

                }
                action("Posted Funds Transfer")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Funds Transfer';

                    RunObject = page "Posred Funds Transfer List";

                }



            }
            grouP(Project)
            {
                action("Active Project Management")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Project Management';
                    RunPageMode = view;
                    RunObject = Page "Project Tracker List";
                    RunPageLink = Blocked = filter(<> Closed);
                }



                action("Closed project")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Closed Projects';
                    RunPageMode = view;
                    RunObject = Page "Award List";
                    RunPageLink = Blocked = filter(Closed);
                }
                // Caption = 'Project Management';
                // action("Project M")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Project List';

                //     RunObject = page "Project Management";

                // }
                // action("Project Approved")

                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Project List Approved';

                //     RunObject = page "Project Management Approved";

                // }
            }
            group("Resource Mobilization")
            {
                action(Persons)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Persons ';


                    RunObject = Page "Contact List";
                    RunPageView = order(ascending) where(Type = const("Contact Type"::Person));
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }


                action(Organisations)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Organisations';


                    RunObject = Page "Contact List";
                    RunPageView = order(ascending) where(Type = const("Contact Type"::Company));
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action("Conferences+Events Map")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Events';


                    RunObject = Page "Confernces";
                }
                action("Meeting tracket")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Meetings';


                    RunObject = Page "Meeting tacker ";
                }
                action("Meeting tracker")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Converted Meetings';


                    RunObject = Page "Converted Meeting tacker";
                }
                action(EngagementPlan)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Engagements (New)';


                    RunObject = Page "engagements planner";
                    RunPageView = order(ascending) where(Converted = const(false));
                }
                action("Converted Engagement plans")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Engagements (Converted)';


                    RunObject = Page "Engagements Planner";
                    RunPageView = order(ascending) where(Converted = const(true));
                }
                action(gonogo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Go-No-Go Decision (New)';


                    RunObject = Page "Gonogo decision";
                    RunPageView = order(ascending) where(Converted = const(false), Decision = filter(Open));

                }
                action("Pending Go decisions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = ' Go-No-Go Decision (Pending)';


                    RunObject = Page "Gonogo decision";
                    RunPageView = order(ascending) where(Converted = const(false), Decision = filter("Pending approval"));
                }
                action("Go decisions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = ' Go-No-Go Decision (Go)';


                    RunObject = Page "Gonogo decision";
                    RunPageView = order(ascending) where(Converted = const(false), Decision = filter(Go));
                }
                action("Converted Go no go decisions")
                {

                    ApplicationArea = Basic, Suite;
                    Caption = ' Go-No-Go Decision (Converted)';


                    RunObject = Page "Gonogo decision";
                    RunPageView = order(ascending) where(Converted = const(true));
                }
                action("Nogodecision")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = ' Go-No-Go Decision (No-go)';


                    RunObject = Page "Gonogo decision";
                    RunPageView = order(ascending) where(Converted = const(false), Decision = filter("No-go"));
                }
                action(Proposaldevelopment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Proposal Development (New)';


                    RunObject = Page "Proposal development tracker";
                    RunPageView = order(ascending) where(Status = filter(New));

                }
                action("Pendingproposaldevelopment")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Proposal Development (Pending)';


                    RunObject = Page "Proposal development tracker";
                    RunPageView = order(ascending) where(Status = filter("Pending approval"));
                }
                action("Approved Proposal development ")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Proposal Development (Approved)';


                    RunObject = Page "Proposal development tracker";
                    RunPageView = order(ascending) where(Status = filter(approved));
                }
                action("Resource mobilization setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Resource Mobilization Setup';
                    RunObject = page "Resource mobilization setup";
                }
            }
            group("Staff claims")
            {
                Image = CostAccounting;
                action("Staff Claim")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Staff Claims';

                    RunObject = page "Claims Voucher List";

                }
                action("Staff Claim Pendig Approved")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Staff Claims Pending Approved';

                    RunObject = page "Claims Pending Approvals";

                }
                action("Staff Claim Approved")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Staff Claims Approved';

                    RunObject = page "Claims Approved";

                }
            }
            group(Receivables)
            {
                Caption = 'Receivables';
                Image = Sales;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("Customer Posting Groups")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Posting Groups';

                    RunObject = Page "Customer Posting Groups";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
                action("Sales & Receivables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales & Receivables Setup';

                    RunObject = Page "Sales & Receivables Setup";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
                action(Sales_CustomerList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';

                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
                action(Action129)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';

                    RunObject = Page "Item List";
                    ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit.';
                }
                action("Item Charges")
                {
                    ApplicationArea = Suite;
                    Caption = 'Item Charges';
                    Visible = false;
                    RunObject = Page "Item Charges";
                    ToolTip = 'View or edit the codes for item charges that you can assign to purchase and sales transactions to include any added costs, such as freight, physical handling, and insurance that you incur when purchasing or selling items. This is important to ensure correct inventory valuation. For purchases, the landed cost of a purchased item consists of the vendor''s purchase price and all additional direct item charges that can be assigned to individual receipts or return shipments. For sales, knowing the cost of shipping sold items can be as vital to your company as knowing the landed cost of purchased items.';
                }
                action("Sales Quotes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Quotes';

                    Visible = false;

                    RunObject = Page "Sales Quotes";
                    ToolTip = 'Make offers to customers to sell certain products on certain delivery and payment terms. While you negotiate with a customer, you can change and resend the sales quote as much as needed. When the customer accepts the offer, you convert the sales quote to a sales invoice or a sales order in which you process the sale.';
                }
                action("Sales Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Orders';

                    Visible = false;

                    RunObject = Page "Sales Order List";
                    ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
                }
                action("Blanket Sales Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Sales Orders';
                    Image = Reminder;

                    Visible = false;

                    RunObject = Page "Blanket Sales Orders";
                    ToolTip = 'Use blanket sales orders as a framework for a long-term agreement between you and your customers to sell large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a sales order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes..';
                }
                action("Funds Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Funds Request';

                    Visible = false;

                    RunObject = Page "Sales Invoice List";
                    ToolTip = 'Register your sales to customers and invite them to pay according to the delivery and payment terms by sending them a sales invoice document. Posting a sales invoice registers shipment and records an open receivable entry on the customer''s account, which will be closed when payment is received. To manage the shipment process, use sales orders, in which sales invoicing is integrated.';
                }
                action("Fund Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Fund Credit Memos';

                    Visible = false;

                    RunObject = Page "Sales Credit Memos";
                    ToolTip = 'Revert the financial transactions involved when your customers want to cancel a purchase or return incorrect or damaged items that you sent to them and received payment for. To include the correct information, you can create the sales credit memo from the related posted sales invoice or you can create a new sales credit memo with copied invoice information. If you need more control of the sales return process, such as warehouse documents for the physical handling, use sales return orders, in which sales credit memos are integrated. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
                }
                action("Sales Return Orders")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Sales Return Orders';

                    Visible = false;

                    RunObject = Page "Sales Return Order List";
                    ToolTip = 'Compensate your customers for incorrect or damaged items that you sent to them and received payment for. Sales return orders support warehouse documents for the item handling, the ability to return items from multiple sales documents with one return, and automatic creation of related sales credit memos or other return-related documents, such as a replacement sales order.';
                }
                action(Reminders)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reminders';
                    Image = Reminder;
                    Visible = false;

                    RunObject = Page "Reminder List";
                    ToolTip = 'Remind customers about overdue amounts based on reminder terms and the related reminder levels. Each reminder level includes rules about when the reminder will be issued in relation to the invoice due date or the date of the previous reminder and whether interests are added. Reminders are integrated with finance charge memos, which are documents informing customers of interests or other money penalties for payment delays.';
                }
                action("Finance Charge Memos")
                {
                    ApplicationArea = Suite;
                    Caption = 'Finance Charge Memos';
                    Image = FinChargeMemo;
                    Visible = false;

                    RunObject = Page "Finance Charge Memo List";
                    ToolTip = 'Send finance charge memos to customers with delayed payments, typically following a reminder process. Finance charges are calculated automatically and added to the overdue amounts on the customer''s account according to the specified finance charge terms and penalty/interest amounts.';
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    Visible = false;
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    Visible = false;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action("Posted Sales Return Receipts")
                {
                    ApplicationArea = SalesReturnOrder;
                    Visible = false;
                    Caption = 'Posted Sales Return Receipts';
                    RunObject = Page "Posted Return Receipts";
                    ToolTip = 'Open the list of posted sales return receipts.';
                }
                action("Issued Reminders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Issued Reminders';
                    Image = OrderReminder;
                    Visible = false;
                    RunObject = Page "Issued Reminder List";
                    ToolTip = 'View the list of issued reminders.';
                }
                action("Issued Finance Charge Memos")
                {
                    ApplicationArea = Suite;
                    Caption = 'Issued Finance Charge Memos';
                    Image = PostedMemo;
                    Visible = false;
                    RunObject = Page "Issued Fin. Charge Memo List";
                    ToolTip = 'View the list of issued finance charge memos.';
                }
            }

            group(Payables)
            {
                Caption = 'Payables';
                Visible = false;
                Image = AdministrationSalesPurchases;
                ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action(Purchase_VendorList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';

                    RunObject = Page "Vendor List";
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action("Incoming Documents")
                {
                    ApplicationArea = Basic, Suite;
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
            group("Travel Claim")
            {
                Caption = 'Travel Claim';
                Visible = false;
                Image = CostAccounting;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(" New Claim Authorization")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Travel Authorization';

                    RunObject = Page "New Claim Authorization";
                }
                action("Pending Claim Authorization")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Claim Authorization';

                    RunObject = Page "Pending Claim Authorization";
                }
                action("Approved Claim Authorization")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Claim Authorization';

                    RunObject = Page "Approved Claim Authorization";
                }
                action("Posted Claim Authorization")
                {
                    ApplicationArea = Basic, Suite;
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
                action("Update Payroll Allocation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Update Payroll Allocation';

                    RunObject = report "Fix Payroll Allocation";
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
                    action("Donor Claim Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Donor Claim Report';

                        RunObject = report "Donor Claim";
                    }
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

                    Visible = false;

                    RunObject = page "Posted Purchase Requisitions";
                    Image = Vendor;
                }
                group("Request For Quotes")
                {
                    group("New RFQ")
                    {
                        action("New RFQ Kenya")
                        {
                            Caption = 'New RFQ Kenya';
                            // RunObject = page "Request For Quotes List";

                            RunObject = page "RFQ List";
                            RunPageView = order(ascending) where("Approval Status" = filter('New'), "Shortcut Dimension 1 Code" = const('KENYA'));
                        }
                        action("New RFQ Malawi")
                        {
                            Caption = 'New RFQ Malawi';
                            // RunObject = page "Request For Quotes List";

                            RunObject = page "RFQ List";
                            RunPageView = order(ascending) where("Approval Status" = filter('New'), "Shortcut Dimension 1 Code" = const('MALAWI'));
                        }
                    }
                    group("Pending RFQ")
                    {
                        action("Pending RFQ Kenya")
                        {
                            Caption = 'Pending RFQ Kenya';
                            Enabled = false;
                            // RunObject = page "Request For Quotes List";

                            RunObject = page "RFQ List";
                            RunPageView = order(ascending) where("Approval Status" = filter('Pending Approval'), "Shortcut Dimension 1 Code" = const('KENYA'));
                        }
                        action("Pending RFQ Malawi")
                        {
                            Caption = 'Pending RFQ Malawi';
                            Enabled = false;
                            // RunObject = page "Request For Quotes List";

                            RunObject = page "RFQ List";
                            RunPageView = order(ascending) where("Approval Status" = filter('Pending Approval'), "Shortcut Dimension 1 Code" = const('Malawi'));
                        }
                    }
                    group("Approved RFQ")
                    {
                        action("Approved RFQ Kenya")
                        {
                            Caption = 'Approved RFQ Kenya';
                            Enabled = false;
                            // RunObject = page "Request For Quotes List";

                            RunObject = page "RFQ List";
                            RunPageView = order(ascending) where("Approval Status" = filter('APPROVED'), Converted = filter(false), "Shortcut Dimension 1 Code" = const('KENYA'));
                        }
                        action("Approved RFQ Malawi")
                        {
                            Caption = 'Approved RFQ Malawi';
                            Enabled = false;
                            // RunObject = page "Request For Quotes List";

                            RunObject = page "RFQ List";
                            RunPageView = order(ascending) where("Approval Status" = filter('APPROVED'), Converted = filter(false), "Shortcut Dimension 1 Code" = const('MALAWI'));
                        }
                    }
                    action("Completed RFQ")
                    {
                        Caption = 'Converted RFQ';
                        RunObject = page 17451;
                    }
                }
                action("Purchase Quotes")
                {
                    Caption = 'Purchase Quotes';

                    RunObject = page "Purchase Quotes List";
                }


                group("LPO List")

                {
                    action("New Lpo List")
                    {
                        Caption = 'New LPO Lists';

                        RunObject = page "LPO Lists";
                        RunPageView = order(ascending) where(Status = filter(Open));
                    }
                    action("Pending Lpo List")
                    {
                        Caption = 'Pending LPO Lists';

                        RunObject = page "LPO Lists";
                        RunPageView = order(ascending) where(Status = filter("Pending Approval"));
                    }
                    action("Approved Lpo List")
                    {
                        Caption = 'Approved LPO Lists';

                        RunObject = page "LPO Lists";
                        RunPageView = order(ascending) where(Status = filter(Released));
                    }
                }
                action("Purchase Invoices")
                {
                    Caption = 'Purchase Invoices';

                    RunObject = page "Purchase Invoices";
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';

                    RunObject = page "Posted Purchase Invoices";
                }
            }

            group("Fleet Management")
            {
                action("Drivers List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diver Management';

                    RunObject = Page "Drivers List";
                }

                action("Vehicle List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vehicle Management';

                    RunObject = Page "Vehicle List";
                }
                group("Vehicle Requisition")
                {
                    action("Vehicle Requestion")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vehicle Requisition Open ';

                        RunObject = Page "Vehicle Requisition List";

                    }
                    action("Vehicle Requestion Pending")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vehicle Requisition Pending Approval';

                        RunObject = Page "Vehicle Requisition Pending";

                    }
                    action("Vehicle Requestion Approved")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vehicle Requisitions Approved';

                        RunObject = Page "Vehicle Requsition Approved";

                    }

                }

            }


            group("Contracts")
            {
                action("Initiated contract list ")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Contracts';

                    RunObject = Page "contract list";
                    RunPageLink = Status = filter(<> Expired);
                }

                action("Expired contract list")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Expired Contracts';

                    RunObject = Page "contract list";
                    RunPageLink = Status = filter(Expired);
                }

            }
            group("Hr Management")
            {
                group("Company Jobs")
                {
                    action("Hr Job List")
                    {
                        Caption = 'HR Jobs List';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "HR Jobs List";
                    }
                    action("Company job Industries")
                    {
                        Caption = 'Company job Industries';
                        ApplicationArea = basic, suite;
                        Image = Job;
                        RunObject = page "Company Job Prof course";
                    }



                }



                group("HR Base")
                {
                    action("HR Employee List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'HR Employee List';

                        RunObject = Page "HR Employee List";
                    }

                    action("HR Employee List(Inactive)")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'HR Employee InActive';

                        RunObject = Page "Inactive Employees";
                    }

                }
                group(Forms)
                {
                    action("Exit form")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Exit Interview Form';
                        RunObject = page 80200;
                    }
                    action("clearance Form")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Clearance Form';
                        RunObject = page 80182;
                    }
                    action("appraisal Form")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Appraisal Form';
                        RunObject = page 50011;
                    }
                }
                group("Leave Management")
                {


                    action("HR Leave Periods")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'HR Leave Periods';

                        RunObject = Page "HR Leave Period";
                    }
                    action("HR Leave Types")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'HR Leave Types';

                        RunObject = Page "HR Leave Types";
                    }


                    action("New HR Leave Applications List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New HR Leave Application';

                        RunObject = Page "HR Leave Applications List";
                        RunPageView = order(ascending) where(Status = filter('New'));
                    }
                    action("Pending HR Leave Applications List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending HR Leave Application';

                        RunObject = Page "HR Leave Applications List";
                        RunPageView = order(ascending) where(Status = filter('Pending Approval'));
                    }
                    action("Posted HR Leave Applications List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted HR Leave Application';

                        RunObject = Page "HR Leave Applications List";
                        RunPageView = order(ascending) where(Status = filter('Posted'));
                    }
                    action("HR Leave Journal Lines")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'HR Leave Journal Lines';

                        RunObject = Page "HR Leave Journal Lines";
                    }
                    action("Leave Balances")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Leave Balances';

                        RunObject = report "HR Leave Balance Report";
                    }




                }

                group("Performance Management")
                {
                    action("Appraisal List")
                    {
                        Caption = 'Target Setting List(Appraisee)';
                        ApplicationArea = basic, suite;

                        RunObject = page "Appraissal List";
                        RunPageLink = "Appraisal Status" = filter(Appraisee);
                    }
                    action("Supervisor Appraisal List")
                    {

                        ApplicationArea = All;
                        RunObject = page "Appraissal List";
                        RunPageLink = "Appraisal Stage" = filter("Target Approval");
                        Caption = 'Target Setting Approval(Supervisor)';

                    }
                    action("Appraisee's Evaluation List")
                    {
                        ApplicationArea = All;
                        RunObject = page "Appraissal List";
                        RunPageLink = "Appraisal Stage" = filter("End Year Evaluation");
                        Caption = 'Appraisee Evaluation List';

                    }
                    action("Supervisor Evaluation List")
                    {
                        ApplicationArea = All;
                        RunObject = page "Appraissal List";
                        RunPageLink = "Appraisal Stage" = filter("Supervisor Evaluation");
                        Caption = 'Supervisor Evaluation List';

                    }

                    action("HR Completed Appraisal List")
                    {
                        ApplicationArea = All;
                        RunObject = page "Appraissal List";
                        RunPageLink = "Appraisal Stage" = filter("Appraisal Completed");
                        Caption = 'HR Completed Appraisal List';

                    }



                }

                group(Recruitment)
                {
                    action("Employee Requisition")
                    {
                        Caption = 'Employee Requisition';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "HR Employee Requisitions List";
                    }
                    action("Job Application")
                    {
                        Caption = 'Job Application';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "HR Job Applications List";
                    }
                    action("Short Listed")
                    {
                        Caption = 'Short Listed';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "HR Shortlisting List";
                    }
                    action("Qualified")
                    {
                        Caption = 'Qualified Listed';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "HR Job Applicants Qualified";
                    }
                    action("Un-Qualified")
                    {
                        Caption = 'Un-Qualified Listed';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "HR Applicants UnQualified List";
                    }
                }



                group("Hr Setup")
                {
                    action("HR Setups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'HR Setups';

                        RunObject = Page "HR Setup";
                    }
                    action("Performance Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Appraisal Setups';

                        RunObject = Page Perfomacesetup;
                    }
                    action("Appraisal Period")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Appraisal Period';

                        RunObject = Page "Appraisal Periods";
                    }
                    action("HR Leave journal Template")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'HR Leave Journal Template';

                        RunObject = Page "HR Leave journal Template";
                    }
                    action("HR Lookup Values List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'HR Lookup Values List';

                        RunObject = page "HR Lookup Values List";
                    }
                    action("Bank Codes List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Codes List';

                        RunObject = page "Bank Codes Listing";
                    }
                    action("Base calendar")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Base Calendar';

                        RunObject = page "Base Calendar List";
                    }





                }
                group(MEL)
                {
                    action("Project Evaluation")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Monitoring & Evaluation";
                    }
                    action("Project Budget")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Project Budget Card";
                    }
                }
            }

            group("Administration Management")
            {
                action(Users)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Users List';
                    RunObject = page Users;
                }
                action("Active Users")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Users';
                    RunObject = page "Active User";
                }
                action("InActive Users")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Disabled Users';
                    RunObject = page "InActive User";
                }
                action("Work Plan")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Workplan List";
                }
                action("Workflow User Group")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Workflow Report";
                }
                group(InquiryTool)
                {
                    Caption = 'Help Desk';

                    group("Case Management")
                    {
                        action("Case Registration")
                        {
                            Caption = 'Case Enquiry Registration List';
                            ApplicationArea = basic, suite;
                            Image = Capacity;
                            RunObject = page "Crm Log List";
                            ToolTip = 'Book a New Case enquiry';

                        }

                        action("Assigned Cases")
                        {
                            Caption = 'Cases List';
                            ApplicationArea = basic, suite;
                            Image = Capacity;
                            RunObject = page "Case Assigned  list";
                            ToolTip = 'New Cases';

                        }

                        action("Resolved Cases")
                        {
                            Caption = 'Resolved Cases';
                            ApplicationArea = basic, suite;
                            Image = Capacity;
                            RunObject = page "Case Assigned  solved";
                            ToolTip = 'Resolved Cases';

                        }
                    }
                    group("CRM Gen Setup")
                    {
                        action("CRM General setup")
                        {
                            Caption = 'CRM General Setup';
                            ApplicationArea = basic, suite;
                            Image = Capacity;
                            RunObject = page "Crm Nos series Card";
                            ToolTip = 'CRM Setup';

                        }
                        action("CRM Case types")
                        {
                            Caption = 'CRM Case types';
                            ApplicationArea = basic, suite;
                            Image = Capacity;
                            RunObject = page "CRM Case Types";
                            ToolTip = 'CRM Case Types';

                        }
                    }

                }

            }

            group("Grants management ")
            {
                action("Donors")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Donors List';

                    RunObject = Page 560;
                    RunPageLink = "Dimension Code" = filter('DONOR');
                }

                action("Donor Claim Report G")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Donor Claim Report';

                    RunObject = report "Donor Claim";
                }

                action("Active projects")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Projects';

                    RunObject = Page "Award List";
                    RunPageLink = Blocked = filter(<> Closed);
                }



                action("Closed projects")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Closed Projects';

                    RunObject = Page "Award List";
                    RunPageLink = Blocked = filter(Closed);
                }

            }



            group(Timesheets)
            {
                action("New Timesheet Entries2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Timesheet ';

                    RunObject = Page "Timesheet header2";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }//TimeSheetsC
                action("New Timesheet EntriesSub")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send Awaiting Approval Timesheets';
                    Visible = false;
                    RunObject = Page "Timesheet header Await";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("New Timesheet Entries Proj")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Line Manager Approval Timesheets';

                    RunObject = Page "Timesheet header Project";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("New Timesheet EntriesLine")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending SMT Lead Approval Timesheets';

                    RunObject = Page "Timesheet header Line Manager";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("New Timesheet EntriesSMT")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SMT Lead Approved Timesheets';
                    Visible = false;
                    RunObject = Page "Timesheet header SMT Lead";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("New Timesheet EntriesHR")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Approved Timesheets';
                    Visible = false;

                    RunObject = Page "Timesheet header HR Approved";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("New Timesheet EntriesApprov")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Timesheets';

                    RunObject = Page "Timesheet header Approved";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("Detailed Timesheet Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Timesheet-personel';

                    RunObject = report "TimesheetReport Detail";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("Timesheet Activity Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Timesheets  activity report';
                    RunObject = report "Timesheet Activity Report";
                    // RunObject = report "TimeSheet Report Summary";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("Timesheet Summary Report 2")
                {
                    ApplicationArea = Basic, Suite;
                    //Visible=false;
                    Caption = 'Timesheet Status summary';
                    RunObject = report "TimesheetReport Summary";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("Timesheets Monthly")
                {
                    Caption = 'Timesheet summary';
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Timesheet Monthly Summary";
                }
                action("Timesheets SMT")
                {
                    Caption = 'Timesheet summary SMT Lead';
                    ApplicationArea = Basic, Suite;
                    RunObject = report "TimesheetReport SMT LEAD";
                }

                action("Timesheets Line Manager")
                {
                    Caption = 'Timesheet summary Line Manage';
                    ApplicationArea = Basic, Suite;
                    RunObject = report "TimesheetReport Line M";
                }
                action("update Timesheets")
                {
                    ApplicationArea = Basic, Siuite;
                    Visible = false;
                    RunObject = report "Update Timesheet status";
                }
            }


        }
    }
}
profile "Finance Custom RoleCenter"
{
    Caption = 'Finance Role Center';
    RoleCenter = "Finance Officer Role Center";
    ProfileDescription = 'Finance Role Center Custom';
}
