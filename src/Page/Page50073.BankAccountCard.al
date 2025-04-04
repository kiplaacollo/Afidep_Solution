page 50073 "Bank Account Card Edited"
{
    Caption = 'Bank Account Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Bank Statement Service,Bank Account,Navigate';
    SourceTable = "Bank Account";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = NoFieldVisible;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the name of the bank where you have the bank account.';
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Branch No.';
                    ToolTip = 'Specifies a number of the bank branch.';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account No.';
                    Importance = Promoted;
                    ToolTip = 'Specifies the number used by the bank for the bank account.';
                }
                field("Transaction No Series";Rec."Transaction No Series")
                {
                    Visible=true;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                    Visible = false;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the bank account''s current balance denominated in the applicable foreign currency.';
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the bank account''s current balance in LCY.';
                }
                field("Min. Balance"; Rec."Min. Balance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a minimum balance for the bank account.';
                    Visible = false;
                }
                field("Our Contact Code"; Rec."Our Contact Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies a code to specify the employee who is responsible for this bank account.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';
                }
                field("SEPA Direct Debit Exp. Format"; Rec."SEPA Direct Debit Exp. Format")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the SEPA format of the bank file that will be exported when you choose the Create Direct Debit File button in the Direct Debit Collect. Entries window.';
                }
                field("Credit Transfer Msg. Nos."; Rec."Credit Transfer Msg. Nos.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the number series for bank instruction messages that are created with the export file that you create from the Direct Debit Collect. Entries window.';
                }
                field("Direct Debit Msg. Nos."; Rec."Direct Debit Msg. Nos.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the number series that will be used on the direct debit file that you export for a direct-debit collection entry in the Direct Debit Collect. Entries window.';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies your company as the creditor in connection with payment collection from customers using SEPA Direct Debit.';
                }
                field("Bank Clearing Standard"; Rec."Bank Clearing Standard")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the format standard to be used in bank transfers if you use the Bank Clearing Code field to identify you as the sender.';
                }
                field("Bank Clearing Code"; Rec."Bank Clearing Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the code for bank clearing that is required according to the format standard you selected in the Bank Clearing Standard field.';
                }
                field("Use as Default for Currency"; Rec."Use as Default for Currency")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies whether this is the default company account for payments in sales and service documents in the currency specified for this account. Each currency can have only one default bank account.';
                }
            
                group(Control45)
                {
                    ShowCaption = false;
                    Visible = ShowBankLinkingActions;
                    field(OnlineFeedStatementStatus; OnlineFeedStatementStatus)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account Linking Status';
                        Editable = false;
                        ToolTip = 'Specifies if the bank account is linked to an online bank account through the bank statement service.';

                        trigger OnValidate()
                        begin
                            if not Linked then
                                Rec.UnlinkStatementProvider
                            else
                                Error(OnlineBankAccountLinkingErr);
                        end;
                    }
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the date when the Bank Account card was last modified.';
                }
                group("Payment Matching")
                {
                    Caption = 'Payment Matching';
                    field("Disable Automatic Pmt Matching"; Rec."Disable Automatic Pmt Matching")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Disable Automatic Payment Matching';
                        Importance = Additional;
                        ToolTip = 'Specifies whether to disable automatic payment matching after importing bank transactions for this bank account.';
                    }
                }
                group("Matching Tolerance")
                {
                    Caption = 'Matching Tolerance';
                    field("Match Tolerance Type"; Rec."Match Tolerance Type")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        ToolTip = 'Specifies by which tolerance the automatic payment application function will apply the Amount Incl. Tolerance Matched rule for this bank account.';
                    }
                    field("Match Tolerance Value"; Rec."Match Tolerance Value")
                    {
                        ApplicationArea = Basic, Suite;
                        DecimalPlaces = 0 : 2;
                        Importance = Additional;
                        ToolTip = 'Specifies if the automatic payment application function will apply the Amount Incl. Tolerance Matched rule by Percentage or Amount.';
                    }
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the address of the bank where you have the bank account.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies additional address information.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the city of the bank where you have the bank account.';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'State';
                    ToolTip = 'Specifies the state as a part of the address.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the postal code.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region of the address.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ExtendedDatatype = PhoneNo;
                    ToolTip = 'Specifies the telephone number of the bank where you have the bank account.';
                }
                field(MobilePhoneNo; Rec."Mobile Phone No.")
                {
                    Caption = 'Mobile Phone No.';
                    ApplicationArea = Basic, Suite;
                    ExtendedDatatype = PhoneNo;
                    ToolTip = 'Specifies the mobile telephone number of the bank where you have the bank account.';
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the bank employee regularly contacted in connection with this bank account.';
                }
             
                field("Phone No.2"; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Phone No.';
                    Importance = Promoted;
                    ToolTip = 'Specifies the telephone number of the bank where you have the bank account.';
                    Visible = false;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the fax number of the bank where you have the bank account.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    ExtendedDatatype = EMail;
                    Importance = Promoted;
                    ToolTip = 'Specifies the email address associated with the bank account.';
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the bank web site.';
                }
            
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the relevant currency code for the bank account.';
                }
                field("Last Check No."; Rec."Last Check No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the check number of the last check issued from the bank account.';
                }
               
                field("Last Statement No."; Rec."Last Statement No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the number of the last bank account statement that was reconciled with this bank account.';
                }
                field("Last Payment Statement No."; Rec."Last Payment Statement No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the last bank statement that was imported.';
                }
                field("Balance Last Statement"; Rec."Balance Last Statement")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the balance amount of the last statement reconciliation on the bank account.';

                    trigger OnValidate()
                    begin
                        if Rec."Balance Last Statement" <> xRec."Balance Last Statement" then
                            if not Confirm(Text001, false, Rec."No.") then
                                Error(Text002);
                    end;
                }
                field("Bank Acc. Posting Group"; Rec."Bank Acc. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies a code for the bank account posting group for the bank account.';
                }
            }
            group(Transfer)
            {
                Caption = 'Transfer';
                field("Bank Branch No.2"; Rec."Bank Branch No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Branch No.';
                    Importance = Promoted;
                    ToolTip = 'Specifies a number of the bank branch.';
                    Visible = false;
                }
                field("Bank Account No.2"; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account No.';
                    Importance = Promoted;
                    ToolTip = 'Specifies the number used by the bank for the bank account.';
                    Visible = false;
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the international bank identifier code (SWIFT) of the bank where you have the account.';
                }
                field(IBAN; Rec.IBAN)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the bank account''s international bank account number.';
                }
                field("Bank Statement Import Format"; Rec."Bank Statement Import Format")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the format of the bank statement file that can be imported into this bank account.';
                }
                field("Payment Export Format"; Rec."Payment Export Format")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the format of the bank file that will be exported when you choose the Export Payments to File button in the Payment Journal window.';

                    trigger OnValidate()
                    begin
                        ValidateExportFormats;
                    end;
                }
                field("Positive Pay Export Code"; Rec."Positive Pay Export Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Positive Pay Export Format';
                    LookupPageID = "Bank Export/Import Setup";
                    ToolTip = 'Specifies a code for the data exchange definition that manages the export of positive-pay files.';
                }
             
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Bank Acc.")
            {
                Caption = '&Bank Acc.';
                Image = Bank;
                action(Statistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Bank Account Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Bank Account"),
                                  "No." = FIELD("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                action(Dimensions)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(270),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action("Bank Account Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Bank Account Balance";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ToolTip = 'View a summary of the bank account balance in different periods.';
                }
                action(Statements)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'St&atements';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = AutoMatchSelected;
                    RunObject = Page "Bank Account Statement List";
                    RunPageLink = "Bank Account No." = FIELD("No.");
                    ToolTip = 'View posted bank statements and reconciliations.';
                }
             
              
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ledger E&ntries';
                    Image = BankAccountLedger;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Bank Account Ledger Entries";
                    RunPageLink = "Bank Account No." = FIELD("No.");
                    RunPageView = SORTING("Bank Account No.")
                                  ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action("Chec&k Ledger Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chec&k Ledger Entries';
                    Image = CheckLedger;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Check Ledger Entries";
                    RunPageLink = "Bank Account No." = FIELD("No.");
                    RunPageView = SORTING("Bank Account No.")
                                  ORDER(Descending);
                    ToolTip = 'View check ledger entries that result from posting transactions in a payment journal for the relevant bank account.';
                }
                action("C&ontact")
                {
                    ApplicationArea = All;
                    Caption = 'C&ontact';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'View or edit detailed information about the contact person at the bank.';
                    Visible = ContactActionVisible;

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
                separator(Action81)
                {
                }
                action("Online Map")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Online Map';
                    Image = Map;
                    ToolTip = 'View the address on an online map.';

                    trigger OnAction()
                    begin
                        Rec.DisplayMap;
                    end;
                }
                action(PagePositivePayEntries)
                {
                    ApplicationArea = Suite;
                    Caption = 'Positive Pay Entries';
                    Image = CheckLedger;
                    RunObject = Page "Positive Pay Entries";
                    RunPageLink = "Bank Account No." = FIELD("No.");
                    RunPageView = SORTING("Bank Account No.", "Upload Date-Time")
                                  ORDER(Descending);
                    ToolTip = 'View the bank ledger entries that are related to Positive Pay transactions.';
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Sent Emails")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sent Emails';
                    Image = ShowList;
                    ToolTip = 'View a list of emails that you have sent to the contact person for this bank account.';

                    trigger OnAction()
                    var
                        Email: Codeunit Email;
                    begin
                        Email.OpenSentEmails(Database::"Bank Account", Rec.SystemId);
                    end;
                }
            }
            action(BankAccountReconciliations)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Reconciliation Journals';
                Image = BankAccountRec;
                RunObject = Page "Pmt. Reconciliation Journals";
                RunPageLink = "Bank Account No." = FIELD("No.");
                RunPageView = SORTING("Bank Account No.");
                ToolTip = 'Reconcile your bank account by importing transactions and applying them, automatically or manually, to open customer ledger entries, open vendor ledger entries, or open bank account ledger entries.';
            }
            action("Receivables-Payables")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Receivables-Payables';
                Image = ReceivablesPayables;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "Receivables-Payables Lines";
                ToolTip = 'View a summary of the receivables and payables for the account, including customer and vendor balance due amounts.';
            }
            action(LinkToOnlineBankAccount)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Link to Online Bank Account';
                Enabled = NOT Linked;
                Image = LinkAccount;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Create a link to an online bank account from the selected bank account.';
                Visible = ShowBankLinkingActions;

                trigger OnAction()
                begin
                    Rec.LinkStatementProvider(Rec);
                end;
            }
            action(UnlinkOnlineBankAccount)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Unlink Online Bank Account';
                Enabled = Linked;
                Image = UnLinkAccount;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Remove a link to an online bank account from the selected bank account.';
                Visible = ShowBankLinkingActions;

                trigger OnAction()
                begin
                    Rec.UnlinkStatementProvider;
                    CurrPage.Update(true);
                end;
            }
            action(RefreshOnlineBankAccount)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Refresh Online Bank Account';
                Enabled = Linked;
                Image = RefreshRegister;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Refresh the online bank account for the selected bank account.';
                Visible = ShowBankLinkingActions;

                trigger OnAction()
                begin
                    Rec.RefreshStatementProvider(Rec);
                end;
            }
            action(EditOnlineBankAccount)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Edit Online Bank Account Information';
                Enabled = Linked;
                Image = EditCustomer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Edit the information about the online bank account linked to the selected bank account.';
                Visible = ShowBankLinkingActions;

                trigger OnAction()
                begin
                    Rec.EditAccountStatementProvider(Rec);
                end;
            }
            action(RenewAccessConsentOnlineBankAccount)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Manage Access Consent for Online Bank Account';
                Enabled = Linked;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Manage access consent for the online bank account linked to the selected bank account.';
                Visible = ShowBankLinkingActions;

                trigger OnAction()
                begin
                    Rec.RenewAccessConsentStatementProvider(Rec);
                end;
            }
            action(AutomaticBankStatementImportSetup)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Automatic Bank Statement Import Setup';
                Enabled = Linked;
                Image = ElectronicBanking;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Auto. Bank Stmt. Import Setup";
                RunPageOnRec = true;
                ToolTip = 'Set up the information for importing bank statement files.';
                Visible = ShowBankLinkingActions;
            }
        }
        area(processing)
        {
            action("Cash Receipt Journals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cash Receipt Journals';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "Cash Receipt Journal";
                ToolTip = 'Create a cash receipt journal line for the bank account, for example, to post a payment receipt.';
            }
            action("Payment Journals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Journals';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "Payment Journal";
                ToolTip = 'Open the list of payment journals where you can register payments to vendors.';
            }
            action(PagePosPayExport)
            {
                ApplicationArea = Suite;
                Caption = 'Positive Pay Export';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Positive Pay Export";
                RunPageLink = "No." = FIELD("No.");
                ToolTip = 'Export a Positive Pay file with relevant payment information that you then send to the bank for reference when you process payments to make sure that your bank only clears validated checks and amounts.';
            }
            action(Email)
            {
                ApplicationArea = All;
                Caption = 'Send Email';
                Image = Email;
                ToolTip = 'Send an email to the contact person for this bank account.';

                trigger OnAction()
                var
                    TempEmailItem: Record "Email Item" temporary;
                    EmailScenario: Enum "Email Scenario";
                begin
                    TempEmailItem.AddSourceDocument(Database::"Bank Account", Rec.SystemId);
                    TempEmailitem."Send to" := Rec."E-Mail";
                    TempEmailItem.Send(false, EmailScenario::Default);
                end;
            }
        }
        area(reporting)
        {
            action(List)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'List';
                Image = "Report";
                ToolTip = 'View a list of general information about bank accounts, such as posting group, currency code, minimum balance, and balance.';

                trigger OnAction()
                begin
                    RunReport(REPORT::"Bank Account - List", Rec."No.");
                end;
            }
            action("Detail Trial Balance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Detail Trial Balance';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                ToolTip = 'View a detailed trial balance for selected checks.';

                trigger OnAction()
                begin
                    RunReport(REPORT::"Bank Acc. - Detail Trial Bal.E", Rec."No.");
                end;
            }
            action(Action1906306806)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Receivables-Payables';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Receivables-Payables";
                ToolTip = 'View a summary of the receivables and payables for the account, including customer and vendor balance due amounts.';
            }
            action("Check Details")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Check Details';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                ToolTip = 'View a detailed trial balance for selected checks.';

                trigger OnAction()
                begin
                    RunReport(REPORT::"Bank Account - Check Details", Rec."No.");
                end;
            }
            
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.GetOnlineFeedStatementStatus(OnlineFeedStatementStatus, Linked);
        ShowBankLinkingActions := Rec.StatementProvidersExist;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.GetOnlineFeedStatementStatus(OnlineFeedStatementStatus, Linked);
        Rec.CalcFields("Check Report Name");
        AfterGetCurrentRecord;
    end;

    trigger OnInit()
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        "Input QualifierEnable" := true;
        "Client NameEnable" := true;
        "Client No.Enable" := true;

        GeneralLedgerSetup.Get();
        //AutoMatchSelected := GeneralLedgerSetup."Bank Recon. with Auto. Match";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        AfterGetCurrentRecord;
    end;

    trigger OnOpenPage()
    var
        Contact: Record Contact;
#if not CLEAN21
        ///BankDepositFeatureMgt: Codeunit bank depo;
#endif
    begin
        OnBeforeOnOpenPage();
        ContactActionVisible := Contact.ReadPermission;
        SetNoFieldVisible;
        BankDepositFeatureEnabled := true;
#if not CLEAN21
        //BankDepositFeatureEnabled := BankDepositFeatureMgt.IsEnabled();
#endif
    end;

    var
        BankDepositFeatureEnabled: Boolean;
        [InDataSet]
        "Client No.Enable": Boolean;
        [InDataSet]
        "Client NameEnable": Boolean;
        [InDataSet]
        "Input QualifierEnable": Boolean;
        Text001: Label 'There may be a statement using the %1.\\Do you want to change Balance Last Statement?';
        Text002: Label 'Canceled.';
        [InDataSet]
        ContactActionVisible: Boolean;
        Linked: Boolean;
        AutoMatchSelected: Boolean;
        OnlineBankAccountLinkingErr: Label 'You must link the bank account to an online bank account.\\Choose the Link to Online Bank Account action.';
        ShowBankLinkingActions: Boolean;
        NoFieldVisible: Boolean;
        OnlineFeedStatementStatus: Option "Not Linked",Linked,"Linked and Auto. Bank Statement Enabled";
        EFTNotSupportedMsg: Label 'The specified payment export format does not support EFT. To use a format other than EFT, set the Country Export Format field to Other.';
        EFTSupportedMsg: Label 'The specified payment export format supports EFT. Set the Country Export Format field to the relevant country/region.';

    local procedure SetCountrySpecificControls()
    begin
       
        OnAfterSetCountrySpecificControls();
    end;

    local procedure ExportFormatOnAfterValidate()
    begin
        SetCountrySpecificControls;
    end;

    local procedure AfterGetCurrentRecord()
    begin
        xRec := Rec;
        SetCountrySpecificControls;
        OnAfterAfterGetCurrentRecord();
    end;

    local procedure ValidateExportFormats()
    var
        BankExportImportSetup: Record "Bank Export/Import Setup";
    begin
  
    end;

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.BankAccountNoIsVisible;
    end;

    local procedure RunReport(ReportNumber: Integer; BankActNumber: Code[20])
    var
        BankAccount: Record "Bank Account";
    begin
        BankAccount.SetRange("No.", BankActNumber);
        REPORT.RunModal(ReportNumber, true, true, BankAccount);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeOnOpenPage()
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterAfterGetCurrentRecord()
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterSetCountrySpecificControls()
    begin
    end;
}

