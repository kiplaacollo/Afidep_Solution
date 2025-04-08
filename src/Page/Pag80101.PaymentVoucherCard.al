Page 80101 "Payment Voucher Card"
{
    Caption = 'Payment Voucher Card';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Order,Request Approval,Print/Send,Navigate', Locked = true, Comment = 'Do not change the caption ';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";

    //
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = statuseditable;
                field("Bank Account"; REC."Paying Account No")
                {

                    trigger OnValidate()
                    begin
                        /*  IF Rec."No." = '' THEN BEGIN
                              BankAccount.GET(rec."Paying Account No");
                              Rec."No." := NoSeriesManagement.GetNextNo('PVNO', TODAY, TRUE);
                          END;*/
                        IF Rec."No." = '' THEN BEGIN
                            BankAccount.GET(rec."Paying Account No");
                            Rec."No." := NoSeriesManagement.GetNextNo(BankAccount."Transaction No Series", TODAY, TRUE);
                        END;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date';
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Function Name");
                    end;

                }
                field("Function Name"; Rec."Function Name")
                {
                    Enabled = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Budget Center Name");
                    end;

                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    Enabled = false;
                }

                field("Pay mode"; Rec."Pay mode")
                { }


                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    DecimalPlaces = 5;
                }

                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    //Editable = false;

                    trigger OnAssistEdit()
                    begin
                        Clear(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WorkDate);
                        if ChangeExchangeRate.RunModal = Action::OK then begin
                            Rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.Update;
                        end;
                        Clear(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate;
                    end;
                }
                field("Paying Account No"; Rec."Paying Account No")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var
                        Banks: Record "Bank Account";
                    begin
                        Banks.Reset();
                        Banks.SetRange(Banks."No.", Rec."Paying Account No");
                        IF Banks.Find('-') THEN begin
                            Rec."Currency Code" := Banks."Currency Code";
                            //Rec."Bank No Series" := NoSeriesManagement.GetNextNo(Banks."Transaction No Series", Today, true);
                        end;
                    end;

                }
                field("Bank No Series"; Rec."Bank No Series")
                {
                    ApplicationArea = basic;
                    Editable = false;
                    Visible = false;
                }
                field("Paying Account Name"; Rec."Paying Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Payee Naration"; Rec."Payee Naration")
                {
                    ApplicationArea = all;
                    Caption = 'Payee:';
                }

                field("on-Behalf of"; Rec."on-Behalf of")
                {
                    Visible = false;
                }
                field("Payment Naration"; Rec."Payment Naration")
                {
                    Caption = 'Description:';
                    CaptionClass = 'Payment narration';

                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cashier:';
                    Enabled = false;
                }
                field("Linked Document"; Rec."Linked Document")
                {
                    Caption = 'Creation Document No:';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    // Enabled = false;
                    Editable = true;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                // field("Amount Posted"; Rec."Amount Posted")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Amount(LCY)';
                // }


                field("Net Amount in foreign Currency"; Rec."Net Amount in foreign Currency")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount in foreign Currency';
                }




                field("AU Form Type"; Rec."AU Form Type")
                {
                    ApplicationArea = all;
                    Caption = 'Document Type';
                    Enabled = false;
                }




                field("Mission Proposal No"; Rec."Mission Proposal No")
                {
                    ApplicationArea = basic;
                    Caption = 'IExpense Req No/PR Req No';
                    Visible = false;
                    trigger OnValidate()
                    var
                        PurchaseLine: Record "Purchase Line";
                        NewPurchaseline: Record "Purchase Line";
                        PurchaseHeader: Record "Purchase Header";
                        NewHeader: Record "Purchase Header";
                        Customer: Record "Customer";

                    begin

                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."Mission Proposal No");
                        if PurchaseHeader.FindFirst() then begin
                            Rec."CashBook Naration" := PurchaseHeader."Payee Naration";
                            Rec."Shortcut Dimension 1 Code" := PurchaseHeader."Shortcut Dimension 1 Code";
                            Rec."Due Date" := PurchaseHeader."Due Date";
                            Rec.fromDate := PurchaseHeader.fromDate;
                            Rec."Currency Factor" := PurchaseHeader."Currency Factor";
                            Rec."Currency Code" := PurchaseHeader."Currency Code";
                            Rec.Modify(true);


                        end;
                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."Mission Proposal No");

                        // PurchaseHeader.SetRange(PurchaseHeader."Type of Payment",PurchaseHeader."Type of Payment"::ExpenseRequisition);
                        if PurchaseHeader.FindFirst() then
                            PurchaseLine.Reset();
                        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                        if PurchaseLine.Find('-') then begin

                            repeat
                                NewPurchaseline.Init();
                                NewPurchaseline."Document No." := Rec."No.";

                                NewPurchaseline.Reset();
                                NewPurchaseline.SetRange("Document Type", Rec."Document Type");
                                NewPurchaseline.SetRange("Document No.", NewPurchaseline."Document No.");
                                if NewPurchaseline.FindLast() then
                                    NewPurchaseline."Line No." := NewPurchaseline."Line No." + 1
                                else
                                    NewPurchaseline."Line No." := 0;
                                NewPurchaseline.Type := PurchaseLine.Type::"G/L Account";
                                NewPurchaseline."No." := PurchaseLine."No.";
                                NewPurchaseline.Validate(NewPurchaseline."No.");
                                NewPurchaseline.Quantity := 1;

                                NewPurchaseline."Description 2" := PurchaseLine."Description 2";
                                NewPurchaseline."Description 3" := PurchaseLine."Description 3";
                                NewPurchaseline.remarks := PurchaseLine.remarks;

                                NewPurchaseline."Budget Line description" := PurchaseLine."Budget Line description";

                                NewPurchaseline.Amount := PurchaseLine."Amount In Foreign";
                                NewPurchaseline."Net Amount" := PurchaseLine."Amount In Foreign";
                                NewPurchaseline."Unit Cost (LCY)" := PurchaseLine."Unit Cost (LCY)";
                                NewPurchaseline."Unit Cost" := PurchaseLine."Amount In Foreign";
                                NewPurchaseline."Direct Unit Cost" := PurchaseLine."Direct Unit Cost";
                                NewPurchaseline."Shortcut Dimension 1 Code" := PurchaseLine."Shortcut Dimension 1 Code";
                                NewPurchaseline."Shortcut Dimension 2 Code" := PurchaseLine."Shortcut Dimension 2 Code";
                                NewPurchaseline."ShortcutDimCode[3]" := PurchaseLine."ShortcutDimCode[3]";
                                NewPurchaseline."ShortcutDimCode[4]" := PurchaseLine."ShortcutDimCode[4]";
                                NewPurchaseline."ShortcutDimCode[5]" := PurchaseLine."ShortcutDimCode[5]";
                                NewPurchaseline."ShortcutDimCode[6]" := PurchaseLine."ShortcutDimCode[6]";
                                NewPurchaseline."ShortcutDimCode[7]" := PurchaseLine."ShortcutDimCode[7]";
                                NewPurchaseline."ShortcutDimCode[8]" := PurchaseLine."ShortcutDimCode[8]";
                                NewPurchaseline.Insert(true);
                            until PurchaseLine.Next() = 0;
                        end;
                    end;


                }
                field("Imprest Requisition No"; Rec."Imprest Requisition No")
                {
                    ApplicationArea = basic;
                    Caption = 'Imprest Requisition No';
                    Visible = false;
                    trigger OnValidate()
                    var
                        PurchaseLine: Record "Purchase Line";
                        NewPurchaseline: Record "Purchase Line";
                        PurchaseHeader: Record "Purchase Header";
                        NewHeader: Record "Purchase Header";
                        Customer: Record "Customer";

                    begin

                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."Imprest Requisition No");
                        if PurchaseHeader.FindFirst() then begin
                            Rec."CashBook Naration" := PurchaseHeader."Payee Naration";
                            Rec."Shortcut Dimension 1 Code" := PurchaseHeader."Shortcut Dimension 1 Code";
                            Rec."Due Date" := PurchaseHeader."Due Date";
                            Rec.fromDate := PurchaseHeader.fromDate;
                            Rec."Currency Factor" := PurchaseHeader."Currency Factor";
                            Rec."Currency Code" := PurchaseHeader."Currency Code";
                            Rec.Modify(true);


                        end;
                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."Imprest Requisition No");

                        // PurchaseHeader.SetRange(PurchaseHeader."Type of Payment",PurchaseHeader."Type of Payment"::ExpenseRequisition);
                        if PurchaseHeader.FindFirst() then
                            PurchaseLine.Reset();
                        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                        if PurchaseLine.Find('-') then begin

                            repeat
                                NewPurchaseline.Init();
                                NewPurchaseline."Document No." := Rec."No.";

                                NewPurchaseline.Reset();
                                //NewPurchaseline.SetRange("Document Type", Rec."Document Type");
                                NewPurchaseline.SetRange("Document No.", NewPurchaseline."Document No.");
                                if NewPurchaseline.FindLast() then
                                    NewPurchaseline."Line No." := NewPurchaseline."Line No." + 1
                                else
                                    NewPurchaseline."Line No." := 0;
                                // NewPurchaseline.Type := PurchaseLine.Type::Imprest;
                                // NewPurchaseline."No." := PurchaseHeader."Account No";
                                NewPurchaseline.Validate(NewPurchaseline."No.");
                                NewPurchaseline.Quantity := 1;

                                NewPurchaseline."Description 2" := PurchaseLine."Description 2";
                                NewPurchaseline."Description 3" := PurchaseLine."Description 3";
                                NewPurchaseline.remarks := PurchaseLine.remarks;

                                NewPurchaseline."Budget Line description" := PurchaseLine."Budget Line description";

                                NewPurchaseline.Amount := PurchaseLine."Amount In Foreign";
                                NewPurchaseline."Net Amount" := PurchaseLine."Amount In Foreign";
                                NewPurchaseline."Unit Cost (LCY)" := PurchaseLine."Unit Cost (LCY)";
                                NewPurchaseline."Unit Cost" := PurchaseLine."Amount In Foreign";
                                NewPurchaseline."Direct Unit Cost" := PurchaseLine."Direct Unit Cost";
                                NewPurchaseline."Shortcut Dimension 1 Code" := PurchaseLine."Shortcut Dimension 1 Code";
                                NewPurchaseline."Shortcut Dimension 2 Code" := PurchaseLine."Shortcut Dimension 2 Code";
                                NewPurchaseline."ShortcutDimCode[3]" := PurchaseLine."ShortcutDimCode[3]";
                                NewPurchaseline."ShortcutDimCode[4]" := PurchaseLine."ShortcutDimCode[4]";
                                NewPurchaseline."ShortcutDimCode[5]" := PurchaseLine."ShortcutDimCode[5]";
                                NewPurchaseline."ShortcutDimCode[6]" := PurchaseLine."ShortcutDimCode[6]";
                                NewPurchaseline."ShortcutDimCode[7]" := PurchaseLine."ShortcutDimCode[7]";
                                NewPurchaseline."ShortcutDimCode[8]" := PurchaseLine."ShortcutDimCode[8]";
                                NewPurchaseline.Insert(true);
                            until PurchaseLine.Next() = 0;
                        end;
                    end;


                }







                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.") { ApplicationArea = all; Visible = false; }



                field(Posted; Rec.Posted)
                {
                    ApplicationArea = basic;
                    Enabled = false;
                }

            }
            part(ImprestLines; "Payment Voucher Lines")
            {
                Caption = 'Payment Voucher Lines';
                SubPageLink = "Document No." = field("No.");
            }

        }
        area(factboxes)
        {
            systempart(Control5; Notes)
            {
                Visible = true;
            }
            part(Control20; "Approval FactBox")
            {
                SubPageLink = "Table ID" = const(38),
                              "Document Type" = field("Document Type"),
                              "Document No." = field("No.");
                Visible = true;
            }
            part(Comments; "Approval Comments FactBox")
            {
                SubPageLink = "Table ID" = const(38),
                              "Document Type" = field("Document Type"),
                              "Document No." = field("No.");
                Visible = true;
            }

            systempart(Control17; Links)
            {
                Visible = true;
            }
        }
    }


    actions
    {
        area(navigation)
        {
            group("&Quote")
            {
                Caption = '&Quote';
                Image = Quote;




                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }

                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';


                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(Database::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Attachments)
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page Documents;
                RunPageLink = "Doc No." = field("No.");
            }
            action("Linked Attachments")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                Visible = true;
                PromotedCategory = Process;
                RunObject = page "Portal Uploads";
                RunPageLink = "Document No" = field("Mission Proposal No");
            }

            action("&Print")
            {
                ApplicationArea = Basic;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin

                    if LinesCommitted then
                        Error('All Lines should be committed');
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(80054, true, true, Rec);

                end;
            }
            action(EditRecord)
            {
                ApplicationArea = Basic, Suite;

                Caption = 'Open Record';
                Image = UpdateDescription;
                Promoted = true;
                Visible = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;

                ToolTip = 'Request approval of the document.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    COA: Record "G/L Account";
                begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();

                end;
            }
            action("Cancel A&pproval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Reopen A&pproval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                // Visible = false;

                trigger OnAction()
                var
                    Text001: label 'This Batch is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    // Rec.TestField("Approval Status", Rec."Approval Status"::New);
                    // Rec.TestField(Amount);

                    if Rec.Status = Rec.Status::Released then
                        Rec.Status := Rec.Status::Open;
                    Rec.Modify;

                end;
            }

            action("Update A&pproval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Update A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                // Visible = false;

                trigger OnAction()
                var
                    Text001: label 'This Batch is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    // Rec.TestField("Approval Status", Rec."Approval Status"::New);
                    // Rec.TestField(Amount);

                    if Rec.Status = Rec.Status::Open then
                        Rec.Status := Rec.Status::Released;
                    Rec.Modify;

                end;
            }

            action(ApproveAutomatically)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approve automatically';
                Image = UpdateDescription;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category9;
                PromotedIsBig = true;

                ToolTip = 'Request approval of the document.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    COA: Record "G/L Account";
                begin
                    Rec.Status := Rec.Status::Released;
                    Rec.Modify();

                end;
            }
            group("Direct Approval")
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator(Action148)
                {
                }
                action(PostNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post With W/T';
                    //Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        GetBatches: Record 232;
                    begin

                        UserSetup.Reset();
                        UserSetup.SetRange(UserSetup."User ID", UserId);
                        if UserSetup.FindFirst() then begin
                            if UserSetup."Post Rights" = false then begin
                                Error('You are not allowed to Post payment vouchers');
                            end;
                        end;

                        if Confirm('Are you sure you want to post the Payment Voucher') then begin
                            Rec.TestField(Posted, false);
                            Rec.TestField(Rec.Status, Rec.Status::Released);
                            Rec.TestField(Rec.Completed, FALSE);
                            Rec.CalcFields("Amount Including VAT");
                            rec.CalcFields(Rec."Consultancy Tax Amount");

                            //withholding tax
                            WithholdingTax.Reset();
                            WithholdingTax.SetRange(WithholdingTax.Code, PurchLine6."Withholding Tax Code");
                            if WithholdingTax.Find('-') then begin
                                WithholdingTaxAccount := WithholdingTax."Withholding Tax Account";

                            end;

                            //Consultancy Fee

                            WithholdingTax.Reset();
                            WithholdingTax.SetRange(WithholdingTax.Code, PurchLine6."Withholding Tax Code");
                            if WithholdingTax.Find('-') then begin
                                WithholdingTaxAccountConsultancy := WithholdingTax."Consultancy Fee AC";


                            end;

                            //withholding tax
                            WithholdingTax.Reset();
                            WithholdingTax.SetRange(WithholdingTax.Code, PurchLine6."Withholding Tax Code 2");
                            if WithholdingTax.Find('-') then begin
                                WithholdingTaxAccount := WithholdingTax."Withholding Tax Account";

                            end;

                            //Consultancy Fee

                            WithholdingTax.Reset();
                            WithholdingTax.SetRange(WithholdingTax.Code, PurchLine6."Withholding Tax Code 2");
                            if WithholdingTax.Find('-') then begin
                                WithholdingTaxAccountConsultancy := WithholdingTax."Consultancy Fee AC";


                            end;

                            GenJournalBatch.Reset;
                            GenJournalBatch.SetRange(GenJournalBatch."Journal Template Name", 'PAYMENTS');
                            GenJournalBatch.SetRange(GenJournalBatch.Name, 'PVS');
                            if GenJournalBatch.FindFirst() = false then begin
                                GenJournalBatch.Init;
                                GenJournalBatch."Journal Template Name" := 'PAYMENTS';
                                GenJournalBatch.Name := 'PVS';
                                GenJournalBatch.Insert(true);
                            end;

                            GenJnlLine.Reset;
                            GenJnlLine.SetRange("Journal Template Name", 'PAYMENTS');
                            GenJnlLine.SetRange("Journal Batch Name", 'PVS');
                            if GenJnlLine.Find then begin
                                GenJnlLine.DeleteAll;
                            end;

                            PurchLine6.Reset;
                            PurchLine6.SetRange(PurchLine6."Document No.", Rec."No.");
                            //PurchLine6.SETFILTER("Amount Spent",'<>%1',0);
                            if PurchLine6.FindSet then begin

                                LineNo := LineNo + 1000;
                                GenJnlLine.Reset;
                                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'PAYMENTS');
                                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PVS');
                                if GenJnlLine.Find('-') then begin
                                    GenJnlLine.DeleteAll;
                                end;
                                GenJnlLine.Init;
                                GenJnlLine."Journal Template Name" := 'PAYMENTS';
                                GenJnlLine."Journal Batch Name" := 'PVS';

                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Source Code" := 'PAYMENTJNL';
                                GenJnlLine."Posting Date" := Rec."Posting Date";

                                GenJnlLine."Document No." := Rec."No.";
                                GenJnlLine."External Document No." := Rec."No.";
                                GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
                                GenJnlLine."Account No." := Rec."Paying Account No";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                // GenJnlLine.Description := Rec.descr
                                GenJnlLine.Description := COPYSTR(Rec."Payment Naration", 1, 100);
                                ;
                                GenJnlLine.Payee := Rec."Payee Naration";

                                GenJnlLine.Amount := -1 * Rec."Amount Including VAT" + Rec."Consultancy Tax Amount";//(Rec.Amount + PurchLine6."Consultancy Fee");
                                                                                                                    // Message('Document total: %1', Rec.Amount);
                                GenJnlLine.Validate(GenJnlLine.Amount);

                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.Validate("Currency Code");
                                GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                // GenJnlLine.Validate("Currency Factor");
                                GenJnlLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");

                                GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                GenJnlLine.ValidateShortcutDimCode(5, Rec."Shortcut Dimension 5 Code");
                                GenJnlLine.ValidateShortcutDimCode(6, PurchLine6."ShortcutDimCode[6]");
                                GenJnlLine.ValidateShortcutDimCode(7, PurchLine6."ShortcutDimCode[7]");
                                GenJnlLine.ValidateShortcutDimCode(8, PurchLine6."ShortcutDimCode[8]");


                                if GenJnlLine.Amount <> 0 then
                                    GenJnlLine.Insert;
                            end;

                            PurchLine6.Reset;
                            PurchLine6.SetRange(PurchLine6."Document No.", Rec."No.");
                            //PurchLine6.SETFILTER("Amount Spent",'<>%1',0);
                            if PurchLine6.FindSet then begin
                                repeat
                                    LineNo2 := LineNo2 + 2000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := 'PAYMENTS';
                                    GenJnlLine."Journal Batch Name" := 'PVS';

                                    GenJnlLine."Line No." := LineNo2;
                                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                                    GenJnlLine."Posting Date" := Rec."Posting Date";

                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := Rec."No.";
                                    IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::"G/L Account" THEN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                    GenJnlLine."Account No." := PurchLine6."Account No New";
                                    IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::Supplier THEN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                                    IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::Customer THEN BEGIN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                                        // GenJnlLine."Account No." := PurchLine6."Imprest Account No";
                                    END;
                                    //GenJnlLine."Account No." := PurchLine6."Account No New";
                                    GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::Purchase;
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Description := PurchLine6."Description 2";
                                    GenJnlLine.Payee := Rec."Payee Naration";

                                    GenJnlLine.Amount := PurchLine6."Direct Unit Cost" - PurchLine6."Consultancy Fee";

                                    GenJnlLine.Validate(GenJnlLine.Amount);

                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    GenJnlLine.Validate("Currency Code");
                                    GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                    // GenJnlLine.Validate("Currency Factor");

                                    GenJnlLine."Shortcut Dimension 1 Code" := PurchLine6."Shortcut Dimension 1 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := PurchLine6."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                    GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                    GenJnlLine.ValidateShortcutDimCode(5, Rec."Shortcut Dimension 5 Code");
                                    GenJnlLine.ValidateShortcutDimCode(6, PurchLine6."ShortcutDimCode[6]");
                                    GenJnlLine.ValidateShortcutDimCode(7, PurchLine6."ShortcutDimCode[7]");
                                    GenJnlLine.ValidateShortcutDimCode(8, PurchLine6."ShortcutDimCode[8]");

                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;

                                    //withholding tax
                                    WithholdingTax.Reset();
                                    WithholdingTax.SetRange(WithholdingTax.Code, PurchLine6."Withholding Tax Code");
                                    if WithholdingTax.Find('-') then begin
                                        WithholdingTaxAccount := WithholdingTax."Withholding Tax Account";

                                    end;
                                    //withholding tax
                                    WithholdingTax.Reset();
                                    WithholdingTax.SetRange(WithholdingTax.Code, PurchLine6."Withholding Tax Code 2");
                                    if WithholdingTax.Find('-') then begin
                                        WithholdingTaxAccount := WithholdingTax."Withholding Tax Account";

                                    end;

                                    LineNo2 := LineNo2 + 2000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := 'PAYMENTS';
                                    GenJnlLine."Journal Batch Name" := 'PVS';

                                    GenJnlLine."Line No." := LineNo2;
                                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                                    GenJnlLine."Posting Date" := Rec."Posting Date";

                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := Rec."No.";

                                    GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";

                                    GenJnlLine."Account No." := WithholdingTaxAccount;

                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Description := COPYSTR(Rec."Payment Naration", 1, 100);
                                    GenJnlLine.Payee := Rec."Payee Naration";

                                    GenJnlLine.Amount := -PurchLine6."Consultancy Fee";
                                    GenJnlLine.Validate(GenJnlLine.Amount);
                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    GenJnlLine.Validate("Currency Code");
                                    GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                    // GenJnlLine.Validate("Currency Factor");
                                    GenJnlLine."Shortcut Dimension 1 Code" := PurchLine6."Shortcut Dimension 1 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := PurchLine6."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                    GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                    GenJnlLine.ValidateShortcutDimCode(5, PurchLine6."ShortcutDimCode[5]");
                                    GenJnlLine.ValidateShortcutDimCode(6, PurchLine6."ShortcutDimCode[6]");
                                    GenJnlLine.ValidateShortcutDimCode(7, PurchLine6."ShortcutDimCode[7]");
                                    GenJnlLine.ValidateShortcutDimCode(8, PurchLine6."ShortcutDimCode[8]");

                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;

                                    LineNo2 := LineNo2 + 2000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := 'PAYMENTS';
                                    GenJnlLine."Journal Batch Name" := 'PVS';

                                    GenJnlLine."Line No." := LineNo2;
                                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                                    GenJnlLine."Posting Date" := Rec."Posting Date";


                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := Rec."No.";
                                    IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::"G/L Account" THEN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                    GenJnlLine."Account No." := WithholdingTax."Withholding Tax Account";
                                    GenJnlLine."Account No." := PurchLine6."Account No New";
                                    IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::Supplier THEN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                                    IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::Customer THEN BEGIN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                                        //  GenJnlLine."Account No." := PurchLine6."Imprest Account No";
                                    END;

                                    // GenJnlLine."Document No." := Rec."No.";
                                    // GenJnlLine."External Document No." := Rec."No.";
                                    // if PurchLine6.Type = PurchLine6.Type::"G/L Account" then
                                    //     GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";

                                    // if PurchLine6.Type = PurchLine6.Type::"Fixed Asset" then begin

                                    //     GenJnlLine."Account Type" := GenJnlLine."account type"::"Fixed Asset";
                                    //     GenJnlLine."FA Posting Type" := GenJnlLine."fa posting type"::"Acquisition Cost";
                                    //     GenJnlLine."FA Posting Date" := Rec."Posting Date";
                                    // GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::Purchase;

                                    // end;
                                    // GenJnlLine."Account No." := PurchLine6."No.";

                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Description := COPYSTR(Rec."Payment Naration", 1, 100);
                                    GenJnlLine.Payee := Rec."Payee Naration";

                                    GenJnlLine.Amount := PurchLine6."Consultancy Fee";
                                    GenJnlLine.Validate(GenJnlLine.Amount);

                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    GenJnlLine.Validate("Currency Code");
                                    GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                    //GenJnlLine.Validate("Currency Factor");
                                    GenJnlLine."Shortcut Dimension 1 Code" := PurchLine6."Shortcut Dimension 1 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := PurchLine6."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                    GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                    GenJnlLine.ValidateShortcutDimCode(5, PurchLine6."ShortcutDimCode[5]");
                                    GenJnlLine.ValidateShortcutDimCode(6, PurchLine6."ShortcutDimCode[6]");
                                    GenJnlLine.ValidateShortcutDimCode(7, PurchLine6."ShortcutDimCode[7]");
                                    GenJnlLine.ValidateShortcutDimCode(8, PurchLine6."ShortcutDimCode[8]");

                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;


                                    LineNo2 := LineNo2 + 2000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := 'PAYMENTS';
                                    GenJnlLine."Journal Batch Name" := 'PVS';

                                    GenJnlLine."Line No." := LineNo2;
                                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                                    GenJnlLine."Posting Date" := Rec."Posting Date";

                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := Rec."No.";

                                    GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";

                                    GenJnlLine."Account No." := WithholdingTaxAccountConsultancy;


                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Description := COPYSTR(Rec."Payment Naration", 1, 100);
                                    GenJnlLine.Payee := Rec."Payee Naration";

                                    GenJnlLine.Amount := PurchLine6."Withholding Tax Amount";
                                    GenJnlLine.Validate(GenJnlLine.Amount);
                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    GenJnlLine.Validate("Currency Code");
                                    GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                    //  GenJnlLine.Validate("Currency Factor");
                                    GenJnlLine."Shortcut Dimension 1 Code" := PurchLine6."Shortcut Dimension 1 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := PurchLine6."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                    GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                    GenJnlLine.ValidateShortcutDimCode(5, PurchLine6."ShortcutDimCode[5]");
                                    GenJnlLine.ValidateShortcutDimCode(6, PurchLine6."ShortcutDimCode[6]");
                                    GenJnlLine.ValidateShortcutDimCode(7, PurchLine6."ShortcutDimCode[7]");
                                    GenJnlLine.ValidateShortcutDimCode(8, PurchLine6."ShortcutDimCode[8]");

                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;

                                    LineNo2 := LineNo2 + 2000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := 'PAYMENTS';
                                    GenJnlLine."Journal Batch Name" := 'PVS';

                                    GenJnlLine."Line No." := LineNo2;
                                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                                    GenJnlLine."Posting Date" := Rec."Posting Date";

                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := Rec."No.";
                                    if PurchLine6.Type = PurchLine6.Type::"G/L Account" then
                                        GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";

                                    if PurchLine6.Type = PurchLine6.Type::"Fixed Asset" then begin

                                        GenJnlLine."Account Type" := GenJnlLine."account type"::"Fixed Asset";
                                        GenJnlLine."FA Posting Type" := GenJnlLine."fa posting type"::"Acquisition Cost";
                                        GenJnlLine."FA Posting Date" := Rec."Posting Date";
                                        GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::Purchase;

                                    end;
                                    //GenJnlLine."Account No." := PurchLine6."No.";

                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Description := COPYSTR(Rec."Payment Naration", 1, 100);
                                    GenJnlLine.Payee := Rec."Payee Naration";

                                    GenJnlLine.Amount := -PurchLine6."Withholding Tax Amount";


                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    GenJnlLine.Validate("Currency Code");
                                    GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                    // GenJnlLine.Validate("Currency Factor");
                                    GenJnlLine."Shortcut Dimension 1 Code" := PurchLine6."Shortcut Dimension 1 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := PurchLine6."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                    GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                    GenJnlLine.ValidateShortcutDimCode(5, PurchLine6."ShortcutDimCode[5]");
                                    GenJnlLine.ValidateShortcutDimCode(6, PurchLine6."ShortcutDimCode[6]");
                                    GenJnlLine.ValidateShortcutDimCode(7, PurchLine6."ShortcutDimCode[7]");
                                    GenJnlLine.ValidateShortcutDimCode(8, PurchLine6."ShortcutDimCode[8]");

                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;




                                until PurchLine6.Next = 0;
                            end;
                            BAL := 0;
                            GenJnlLine.RESET;
                            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'PAYMENTS');
                            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PVS');
                            IF GenJnlLine.FINDSET THEN BEGIN
                                REPEAT
                                    BAL := BAL + GenJnlLine."Amount (LCY)";
                                UNTIL GenJnlLine.NEXT = 0;
                            END;
                            ///Message('ba%1', BAL);


                            IF (BAL < 0) AND (BAL > -1) THEN BEGIN
                                GenJnlLine.RESET;
                                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'PAYMENTS');
                                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PVS');
                                GenJnlLine.SETFILTER("Amount (LCY)", '<%1', 0);
                                IF GenJnlLine.FINDFIRST THEN BEGIN
                                    GenJnlLine.VALIDATE("Amount (LCY)", GenJnlLine."Amount (LCY)" + ABS(BAL));
                                    GenJnlLine.MODIFY(TRUE);
                                END;
                            END;

                            IF (BAL > 0) AND (BAL < 1) THEN BEGIN
                                GenJnlLine.RESET;
                                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'PAYMENTS');
                                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PVS');
                                GenJnlLine.SETFILTER("Amount (LCY)", '<%1', 0);
                                IF GenJnlLine.FINDFIRST THEN BEGIN
                                    GenJnlLine.VALIDATE("Amount (LCY)", GenJnlLine."Amount (LCY)" - BAL);
                                    GenJnlLine.MODIFY(TRUE);
                                END;
                            END;
                            // Rec.Completed := true;
                            // Rec.Posted := true;
                            // Rec.Modify(true);
                            // CurrPage.Close();
                            // Message('Journals Inserted Successfully');
                            // exit;
                            GenJnlLine.Reset;
                            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'PAYMENTS');
                            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PVS');
                            if GenJnlLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnlLine);//auto posting of payment voucher
                            end;
                            COMMIT;
                            Rec.Completed := true;
                            Rec.Posted := true;
                            Rec.Modify(true);
                            CurrPage.Close();
                            Message('Payment voucher Posted Successfully');

                        end;
                    end;
                }


                action(Release)
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    Visible = false;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }

                action("Re&open")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Visible = false;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
            }

            group("Request Approval")

            {
                //  Caption = 'Request Approval';
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Without W/T';
                    //Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        GetBatches: Record 232;
                    begin

                        UserSetup.Reset();
                        UserSetup.SetRange(UserSetup."User ID", UserId);
                        if UserSetup.FindFirst() then begin
                            if UserSetup."Post Rights" = false then begin
                                Error('You are not allowed to Post payment vouchers');
                            end;
                        end;

                        if Confirm('Are you sure you want to post the Payment Voucher') then begin
                            Rec.TestField(Posted, false);
                            Rec.TestField(Rec.Status, Rec.Status::Released);
                            Rec.TestField(Rec.Completed, FALSE);

                            GenJournalBatch.Reset;
                            GenJournalBatch.SetRange(GenJournalBatch."Journal Template Name", 'PAYMENTS');
                            GenJournalBatch.SetRange(GenJournalBatch.Name, 'PVS');
                            if GenJournalBatch.FindFirst() = false then begin
                                GenJournalBatch.Init;
                                GenJournalBatch."Journal Template Name" := 'PAYMENTS';
                                GenJournalBatch.Name := 'PVS';
                                GenJournalBatch.Insert(true);
                            end;

                            GenJnlLine.Reset;
                            GenJnlLine.SetRange("Journal Template Name", 'PAYMENTS');
                            GenJnlLine.SetRange("Journal Batch Name", 'PVS');
                            if GenJnlLine.Find then begin
                                GenJnlLine.DeleteAll;
                            end;

                            LineNo := LineNo + 1000;
                            GenJnlLine.Reset;
                            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'PAYMENTS');
                            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PVS');
                            if GenJnlLine.Find('-') then begin
                                GenJnlLine.DeleteAll;
                            end;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := 'PAYMENTS';
                            GenJnlLine."Journal Batch Name" := 'PVS';

                            GenJnlLine."Line No." := LineNo;
                            GenJnlLine."Source Code" := 'PAYMENTJNL';
                            GenJnlLine."Posting Date" := Rec."Posting Date";

                            GenJnlLine."Document No." := Rec."No.";
                            GenJnlLine."External Document No." := Rec."No.";
                            GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
                            GenJnlLine."Account No." := Rec."Paying Account No";
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            // GenJnlLine.Description := Rec.descr
                            GenJnlLine.Description := COPYSTR(Rec."Payment Naration", 1, 100);
                            ;
                            GenJnlLine.Payee := Rec."Payee Naration";

                            GenJnlLine.Amount := -Rec.Amount;
                            GenJnlLine.Validate(GenJnlLine.Amount);

                            GenJnlLine."Currency Code" := Rec."Currency Code";
                            GenJnlLine.Validate("Currency Code");
                            GenJnlLine."Currency Factor" := Rec."Currency Factor";
                            // GenJnlLine.Validate("Currency Factor");
                            GenJnlLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                            PurchLine6.Reset;
                            PurchLine6.SetRange(PurchLine6."Document No.", Rec."No.");
                            //PurchLine6.SETFILTER("Amount Spent",'<>%1',0);
                            if PurchLine6.FindSet then begin
                                GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                GenJnlLine.ValidateShortcutDimCode(5, Rec."Shortcut Dimension 5 Code");
                                GenJnlLine.ValidateShortcutDimCode(6, PurchLine6."ShortcutDimCode[6]");
                                GenJnlLine.ValidateShortcutDimCode(7, PurchLine6."ShortcutDimCode[7]");
                                GenJnlLine.ValidateShortcutDimCode(8, PurchLine6."ShortcutDimCode[8]");
                            end;

                            if GenJnlLine.Amount <> 0 then
                                GenJnlLine.Insert;


                            PurchLine6.Reset;
                            PurchLine6.SetRange(PurchLine6."Document No.", Rec."No.");
                            //PurchLine6.SETFILTER("Amount Spent",'<>%1',0);
                            if PurchLine6.FindSet then begin
                                repeat
                                    LineNo2 := LineNo2 + 2000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := 'PAYMENTS';
                                    GenJnlLine."Journal Batch Name" := 'PVS';

                                    GenJnlLine."Line No." := LineNo2;
                                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                                    GenJnlLine."Posting Date" := Rec."Posting Date";

                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := Rec."No.";
                                    IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::"G/L Account" THEN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                    GenJnlLine."Account No." := PurchLine6."Account No New";
                                    IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::Supplier THEN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                                    IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::Customer THEN BEGIN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                                        // GenJnlLine."Account No." := PurchLine6."Imprest Account No";
                                    END;
                                    //GenJnlLine."Account No." := PurchLine6."Account No New";
                                    GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::Purchase;
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Description := PurchLine6."Description 2";
                                    GenJnlLine.Payee := Rec."Payee Naration";

                                    GenJnlLine.Amount := PurchLine6.Amount;

                                    GenJnlLine.Validate(Amount);

                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    GenJnlLine.Validate("Currency Code");
                                    //  GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                    // GenJnlLine.Validate("Currency Factor");

                                    GenJnlLine."Shortcut Dimension 1 Code" := PurchLine6."Shortcut Dimension 1 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := PurchLine6."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                    GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                    GenJnlLine.ValidateShortcutDimCode(5, Rec."Shortcut Dimension 5 Code");
                                    GenJnlLine.ValidateShortcutDimCode(6, PurchLine6."ShortcutDimCode[6]");
                                    GenJnlLine.ValidateShortcutDimCode(7, PurchLine6."ShortcutDimCode[7]");
                                    GenJnlLine.ValidateShortcutDimCode(8, PurchLine6."ShortcutDimCode[8]");

                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;

                                    //withholding tax
                                    WithholdingTax.Reset();
                                    WithholdingTax.SetRange(WithholdingTax.Code, PurchLine6."Withholding Tax Code");
                                    if WithholdingTax.Find('-') then begin
                                        WithholdingTaxAccount := WithholdingTax."Withholding Tax Account";

                                    end;

                                    LineNo2 := LineNo2 + 2000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := 'PAYMENTS';
                                    GenJnlLine."Journal Batch Name" := 'PVS';

                                    GenJnlLine."Line No." := LineNo2;
                                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                                    GenJnlLine."Posting Date" := Rec."Posting Date";

                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := Rec."No.";

                                    GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";

                                    GenJnlLine."Account No." := WithholdingTaxAccount;

                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Description := COPYSTR(Rec."Payment Naration", 1, 100);
                                    GenJnlLine.Payee := Rec."Payee Naration";

                                    GenJnlLine.Amount := -PurchLine6."Withholding Tax Amount";
                                    GenJnlLine.Validate(GenJnlLine.Amount);
                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    GenJnlLine.Validate("Currency Code");
                                    GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                    //  GenJnlLine.Validate("Currency Factor");
                                    GenJnlLine."Shortcut Dimension 1 Code" := PurchLine6."Shortcut Dimension 1 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := PurchLine6."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                    GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                    GenJnlLine.ValidateShortcutDimCode(5, PurchLine6."ShortcutDimCode[5]");
                                    GenJnlLine.ValidateShortcutDimCode(6, PurchLine6."ShortcutDimCode[6]");
                                    GenJnlLine.ValidateShortcutDimCode(7, PurchLine6."ShortcutDimCode[7]");
                                    GenJnlLine.ValidateShortcutDimCode(8, PurchLine6."ShortcutDimCode[8]");

                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;

                                    LineNo2 := LineNo2 + 2000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := 'PAYMENTS';
                                    GenJnlLine."Journal Batch Name" := 'PVS';

                                    GenJnlLine."Line No." := LineNo2;
                                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                                    GenJnlLine."Posting Date" := Rec."Posting Date";


                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := Rec."No.";
                                    IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::"G/L Account" THEN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                    GenJnlLine."Account No." := PurchLine6."Account No New";
                                    IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::Supplier THEN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                                    IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::Customer THEN BEGIN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                                        //  GenJnlLine."Account No." := PurchLine6."Imprest Account No";
                                    END;

                                    // GenJnlLine."Document No." := Rec."No.";
                                    // GenJnlLine."External Document No." := Rec."No.";
                                    // if PurchLine6.Type = PurchLine6.Type::"G/L Account" then
                                    //     GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";

                                    // if PurchLine6.Type = PurchLine6.Type::"Fixed Asset" then begin

                                    //     GenJnlLine."Account Type" := GenJnlLine."account type"::"Fixed Asset";
                                    //     GenJnlLine."FA Posting Type" := GenJnlLine."fa posting type"::"Acquisition Cost";
                                    //     GenJnlLine."FA Posting Date" := Rec."Posting Date";
                                    GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::Purchase;

                                    // end;
                                    // GenJnlLine."Account No." := PurchLine6."No.";

                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Description := COPYSTR(Rec."Payment Naration", 1, 100);
                                    GenJnlLine.Payee := Rec."Payee Naration";

                                    GenJnlLine.Amount := PurchLine6."Withholding Tax Amount";
                                    GenJnlLine.Validate(GenJnlLine.Amount);

                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    //   GenJnlLine.Validate("Currency Code");
                                    GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                    //  GenJnlLine.Validate("Currency Factor");
                                    GenJnlLine."Shortcut Dimension 1 Code" := PurchLine6."Shortcut Dimension 1 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := PurchLine6."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                    GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                    GenJnlLine.ValidateShortcutDimCode(5, PurchLine6."ShortcutDimCode[5]");
                                    GenJnlLine.ValidateShortcutDimCode(6, PurchLine6."ShortcutDimCode[6]");
                                    GenJnlLine.ValidateShortcutDimCode(7, PurchLine6."ShortcutDimCode[7]");
                                    GenJnlLine.ValidateShortcutDimCode(8, PurchLine6."ShortcutDimCode[8]");

                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;

                                    //Consultancy Fee

                                    WithholdingTax.Reset();
                                    WithholdingTax.SetRange(WithholdingTax.Code, PurchLine6."Withholding Tax Code");
                                    if WithholdingTax.Find('-') then begin
                                        WithholdingTaxAccountConsultancy := WithholdingTax."Consultancy Fee AC";


                                    end;

                                    LineNo2 := LineNo2 + 2000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := 'PAYMENTS';
                                    GenJnlLine."Journal Batch Name" := 'PVS';

                                    GenJnlLine."Line No." := LineNo2;
                                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                                    GenJnlLine."Posting Date" := Rec."Posting Date";

                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := Rec."No.";

                                    GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";

                                    //GenJnlLine."Account No." := WithholdingTaxAccountConsultancy;


                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Description := COPYSTR(Rec."Payment Naration", 1, 100);
                                    GenJnlLine.Payee := Rec."Payee Naration";

                                    GenJnlLine.Amount := -PurchLine6."Consultancy Fee";
                                    GenJnlLine.Validate(GenJnlLine.Amount);
                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    // GenJnlLine.Validate("Currency Code");
                                    GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                    // GenJnlLine.Validate("Currency Factor");
                                    GenJnlLine."Shortcut Dimension 1 Code" := PurchLine6."Shortcut Dimension 1 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := PurchLine6."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                    GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                    GenJnlLine.ValidateShortcutDimCode(5, PurchLine6."ShortcutDimCode[5]");
                                    GenJnlLine.ValidateShortcutDimCode(6, PurchLine6."ShortcutDimCode[6]");
                                    GenJnlLine.ValidateShortcutDimCode(7, PurchLine6."ShortcutDimCode[7]");
                                    GenJnlLine.ValidateShortcutDimCode(8, PurchLine6."ShortcutDimCode[8]");

                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;

                                    LineNo2 := LineNo2 + 2000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := 'PAYMENTS';
                                    GenJnlLine."Journal Batch Name" := 'PVS';

                                    GenJnlLine."Line No." := LineNo2;
                                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                                    GenJnlLine."Posting Date" := Rec."Posting Date";

                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := Rec."No.";
                                    if PurchLine6.Type = PurchLine6.Type::"G/L Account" then
                                        GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";

                                    if PurchLine6.Type = PurchLine6.Type::"Fixed Asset" then begin

                                        GenJnlLine."Account Type" := GenJnlLine."account type"::"Fixed Asset";
                                        GenJnlLine."FA Posting Type" := GenJnlLine."fa posting type"::"Acquisition Cost";
                                        GenJnlLine."FA Posting Date" := Rec."Posting Date";
                                        GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::Purchase;

                                    end;
                                    //GenJnlLine."Account No." := PurchLine6."No.";

                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Description := COPYSTR(Rec."Payment Naration", 1, 100);
                                    GenJnlLine.Payee := Rec."Payee Naration";

                                    GenJnlLine.Amount := PurchLine6."Consultancy Fee";


                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    //  GenJnlLine.Validate("Currency Code");
                                    GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                    //    GenJnlLine.Validate("Currency Factor");
                                    GenJnlLine."Shortcut Dimension 1 Code" := PurchLine6."Shortcut Dimension 1 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := PurchLine6."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                    GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                    GenJnlLine.ValidateShortcutDimCode(5, PurchLine6."ShortcutDimCode[5]");
                                    GenJnlLine.ValidateShortcutDimCode(6, PurchLine6."ShortcutDimCode[6]");
                                    GenJnlLine.ValidateShortcutDimCode(7, PurchLine6."ShortcutDimCode[7]");
                                    GenJnlLine.ValidateShortcutDimCode(8, PurchLine6."ShortcutDimCode[8]");

                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;




                                until PurchLine6.Next = 0;
                            end;
                            BAL := 0;
                            GenJnlLine.RESET;
                            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'PAYMENTS');
                            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PVS');
                            IF GenJnlLine.FINDSET THEN BEGIN
                                REPEAT
                                    BAL := BAL + GenJnlLine."Amount (LCY)";
                                UNTIL GenJnlLine.NEXT = 0;
                            END;
                            ///Message('ba%1', BAL);


                            IF (BAL < 0) AND (BAL > -1) THEN BEGIN
                                GenJnlLine.RESET;
                                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'PAYMENTS');
                                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PVS');
                                GenJnlLine.SETFILTER("Amount (LCY)", '<%1', 0);
                                IF GenJnlLine.FINDFIRST THEN BEGIN
                                    GenJnlLine.VALIDATE("Amount (LCY)", GenJnlLine."Amount (LCY)" + ABS(BAL));
                                    GenJnlLine.MODIFY(TRUE);
                                END;
                            END;

                            IF (BAL > 0) AND (BAL < 1) THEN BEGIN
                                GenJnlLine.RESET;
                                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'PAYMENTS');
                                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PVS');
                                GenJnlLine.SETFILTER("Amount (LCY)", '<%1', 0);
                                IF GenJnlLine.FINDFIRST THEN BEGIN
                                    GenJnlLine.VALIDATE("Amount (LCY)", GenJnlLine."Amount (LCY)" - BAL);
                                    GenJnlLine.MODIFY(TRUE);
                                END;
                            END;
                            COMMIT;
                            // Rec.Posted := true;
                            // Rec.Modify(true);
                            // //  CurrPage.Close();
                            // Message('Journals Inserted Successfully');
                            // exit;

                            GenJnlLine.Reset;
                            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'PAYMENTS');
                            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PVS');
                            if GenJnlLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnlLine);//auto posting of payment voucher
                            end;

                            PurchaseHeader2.Reset;
                            PurchaseHeader2.SetRange("No.", Rec."Linked Document");
                            if PurchaseHeader2.Findset then begin
                                repeat
                                    PurchaseHeader2.Completed := true;
                                    PurchaseHeader2.Posted := true;
                                    PurchaseHeader2.Modify;
                                until PurchaseHeader2.Next = 0;
                            end;

                            Rec.Posted := true;
                            Rec.Modify(true);
                            CurrPage.Close();

                            //CurrPage.Close();


                            Message('payment Voucher Posted Successfully');
                        end;

                    end;
                }

                separator(Action147)
                {
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;

                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        COA: Record "G/L Account";
                    begin
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            Rec.TestField("Posting Date");
                        //  Rec.TestField("Currency Code");
                        Rec.TestField("Paying Account No");
                        Rec.TestField("Payee Naration");
                        ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }





                separator(Action10)
                {
                }
            }

        }
    }

    trigger OnAfterGetCurrRecord()
    begin

    end;

    trigger OnAfterGetRecord()
    begin
        CurrPageUpdate;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        // exit(ConfirmDeletion);
        Error('Not Allowed!');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        PayablesSetup: Record "Purchases & Payables Setup";
        Pheader: Record "Purchase Header";
    begin
        PayablesSetup.Get();
        Rec."AU Form Type" := Rec."au form type"::"Payment Voucher";
        PurchasesPayablesSetup.Get;

        Rec."Assigned User ID" := UserId;
        Rec."User ID" := UserId;
        Rec."Requested Receipt Date" := Today;
        Rec."Posting Description" := format(Rec."AU Form Type"::"Payment Voucher");

        Rec."Buy-from Vendor No." := PayablesSetup."Default Vendor";




    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        PayablesSetup: Record "Purchases & Payables Setup";
        Pheader: Record "Purchase Header";
    begin
        PayablesSetup.Get();
        Rec."AU Form Type" := Rec."au form type"::"Payment Voucher";
        PurchasesPayablesSetup.Get;
        // Rec."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Payment Vouchers Form", Today, true);
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec."Assigned User ID" := UserId;
        Rec."User ID" := UserId;
        Rec."Requested Receipt Date" := Today;

        Rec."Buy-from Vendor No." := PayablesSetup."Default Vendor";
        Rec."Vendor Posting Group" := PayablesSetup."Vendor Posting Group";
        HREmployee.Reset();
        HREmployee.SetRange(HREmployee."Employee UserID", UserId);
        IF HREmployee.FindFirst() then begin
            Rec."Responsibility Center" := HREmployee."Responsibility Center";
            Rec."Responsibility Center Name" := HREmployee."Responsibility Center Name";
            rec."Employee No" := HREmployee."No.";
            Rec.Department := HREmployee."Programme or Department";
            Rec."Employee Name" := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
        end;

        //"Document Type":="Document Type"::Quote;

        //SR:=true;
        Pheader.Reset();
        Pheader.SetRange("No.", Rec."No.");
        if Pheader.Find('-') then begin
            Pheader."Posting Description" := '';
            Pheader.Modify(true);
        end;

        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", '.');
        if Vendor.FindFirst then begin
            Rec."Buy-from Vendor No." := Vendor."No.";
            Rec.Validate("Buy-from Vendor No.");
        end;

        Rec."Posting Description" := '';
        UpdateControls;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin

        if UserMgt.GetPurchasesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetPurchasesFilter);
            Rec.FilterGroup(0);
        end;
        Rec."AU Form Type" := Rec."au form type"::"Payment Voucher";
        //"Document Type":="Document Type"::Quote;
        Rec."Assigned User ID" := UserId;
        //SR:=true;
        //SETRANGE("User ID",USERID);
    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        HREmployee: Record "HR Employees";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchLine: Record "Purchase Line";
        StatusEditable: Boolean;
        Vendor: Record Vendor;
        BAL: Decimal;
        PurchHeader: Record "Purchase Header";
        SHeader: Record "Purchase Header";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        UserSetup: Record "User Setup";
        HREmployees: Record "HR Employees";
        WithholdingTax: Record "Withholding Tax Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        PurchLine2: Record "Purchase Line";
        PurchaseLine3: Record "Purchase Line";
        WithholdingTaxAccountConsultancy: Code[60];
        PurchaseHeader: Record "Purchase Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        GenJnlLine: Record "Gen. Journal Line";
        Amt: Decimal;
        PurchaseHeader2: Record "Purchase Header";
        GenJnlLine2: Record "Gen. Journal Line";
        RFQ: Record "Purchase Line";
        LineNo: Integer;
        PurchLine6: Record "Purchase Line";
        WithholdingTaxAccount: Code[20];
        LineNo2: Decimal;
        GenJournalBatch: Record "Gen. Journal Batch";
        BankAccount: Record "Bank Account";

    local procedure ApproveCalcInvDisc()
    begin
        //CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        if Rec.GetFilter("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                Rec.SetRange("Buy-from Vendor No.");
        CurrPage.Update;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.Update;
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;


    procedure LinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
    end;


    procedure SomeLinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
    end;


    procedure UpdateControls()
    begin
        if Rec.Status = Rec.Status::Open then
            StatusEditable := true
        else
            StatusEditable := false;
    end;


    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        CurrPage.Update;
    end;
}


