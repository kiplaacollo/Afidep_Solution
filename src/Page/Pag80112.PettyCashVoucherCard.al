Page 80112 "Petty Cash Voucher  Card"
{
    Caption = 'Petty Cash Voucher  Card';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = statuseditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment Narration';
                    Visible = false;
                    //ShowMandatory = true;
                }
                field("Paying Account No"; Rec."Paying Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Account Name"; Rec."Paying Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    // Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount(LCY)';
                }
                field("Net Amount in foreign Currency"; Rec."Net Amount in foreign Currency")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Amount Converted to Base Currency';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;

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
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(ImprestLines; "Petty Cash Lines")
            {
                Caption = 'Petty Cash Lines';
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
                Visible = false;
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
                action(Statistics)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader;
                        Commit;
                        Page.RunModal(Page::"Purchase Statistics", Rec);
                    end;
                }
                action(Vendor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = field("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                }
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
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

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
            action("&Print")
            {
                ApplicationArea = Basic;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    if LinesCommitted then
                        Error('All Lines should be committed');
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(80028, true, true, Rec);
                    // Reset;
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            group(ActionGroup3)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator(Action148)
                {
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
                action("Award Schedule")
                {
                    ApplicationArea = Basic;
                    //RunObject = Page UnknownPage55947;
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
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate &Invoice Discount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                separator(Action144)
                {
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    ApplicationArea = Basic;
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = VendorCode;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(Action146)
                {
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.TestField("Posting Date");
                        Rec.TestField(Rec.Status, Rec.Status::Released);
                        Rec.TestField(Completed, FALSE);
                        if Confirm('Are you sure you want to post the Petty Cash') then begin
                            //TESTFIELD(Status,Status::Released);

                            GenJnlLine.Reset;
                            GenJnlLine.SetRange("Journal Template Name", 'PAYMENTS');
                            GenJnlLine.SetRange("Journal Batch Name", 'PVS');
                            if GenJnlLine.Find then begin
                                GenJnlLine.DeleteAll;
                            end;
                            GenJournalBatch.Reset;
                            GenJournalBatch.SetRange(GenJournalBatch."Journal Template Name", 'PAYMENTS');
                            GenJournalBatch.SetRange(GenJournalBatch.Name, 'PVS');
                            if GenJournalBatch.Find('-') = false then begin
                                GenJournalBatch.Init;
                                GenJournalBatch."Journal Template Name" := 'PAYMENTS';
                                GenJournalBatch.Name := 'PVS';
                                GenJournalBatch.Insert(true);
                            end;
                            /*GenJnlLine.INIT;
                            GenJnlLine."Journal Template Name":='PAYMENTS';
                            GenJnlLine."Journal Batch Name":='Paymentvoucher';
                            GenJnlLine2.RESET;
                            GenJnlLine2.SETRANGE("Journal Template Name",'PAYMENTS');
                            GenJnlLine2.SETRANGE("Journal Batch Name",'Paymentvoucher');
                            IF GenJnlLine2.FINDLAST THEN
                            GenJnlLine."Line No.":=GenJnlLine2."Line No."+10000;
                            GenJnlLine."Source Code":='PAYMENTJNL';
                            GenJnlLine."Posting Date":=TODAY;
                            //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                            GenJnlLine."Document No.":="No.";
                            GenJnlLine."External Document No.":="Cheque No";
                            GenJnlLine."Account Type":=GenJnlLine."Account Type"::Customer;
                            GenJnlLine."Account No.":="Account No";
                            GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                            GenJnlLine.Description:='Paymentvoucher: '+"Account No"+' '+"Imprest No";
                            Amt:=0;
                            PurchLine.RESET;
                            PurchLine.SETRANGE("Document No.","No.");
                            IF PurchLine.FINDSET THEN BEGIN
                              REPEAT
                                Amt:=Amt+PurchLine."Line Amount";
                                UNTIL PurchLine.NEXT=0;
                              END;
                            GenJnlLine.Amount:=-1*Amt;
                            GenJnlLine.VALIDATE(GenJnlLine.Amount);
                           // GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"Bank Account";
                           // GenJnlLine."Bal. Account No.":="Paying Account No";
                           // GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                            //Added for Currency Codes
                            GenJnlLine."Currency Code":="Currency Code";
                            GenJnlLine.VALIDATE("Currency Code");
                            GenJnlLine."Currency Factor":="Currency Factor";
                            GenJnlLine.VALIDATE("Currency Factor");
                            GenJnlLine."Shortcut Dimension 1 Code":="Shortcut Dimension 1 Code";
                            GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                            GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                        
                        
                            IF GenJnlLine.Amount<>0 THEN
                            GenJnlLine.INSERT;*/
                            //
                            //
                            //    PurchLine6.RESET;
                            //    PurchLine6.SETRANGE("Document No.",PurchaseHeader."No.");
                            //    //PurchLine6.SETFILTER("Amount Spent",'<>%1',0);
                            //    IF PurchLine6.FINDSET THEN BEGIN
                            //      REPEAT
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
                            //MESSAGE('tuko hapa');
                            //          GenJnlLine2.RESET;
                            //          GenJnlLine2.SETRANGE("Journal Template Name",'PAYMENTS');
                            //          GenJnlLine2.SETRANGE("Journal Batch Name",'PVS');
                            //          IF GenJnlLine2.FINDLAST THEN
                            GenJnlLine."Line No." := LineNo;
                            GenJnlLine."Source Code" := 'PAYMENTJNL';
                            GenJnlLine."Posting Date" := Rec."Posting Date";
                            //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                            GenJnlLine."Document No." := Rec."No.";
                            GenJnlLine."External Document No." := Rec."No.";
                            GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
                            GenJnlLine."Account No." := Rec."Paying Account No";
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            GenJnlLine.Description := Rec."Posting Description";
                            //'Paymentvoucher: '+"Account No"+' '+"Imprest No";
                            GenJnlLine.Amount := -Rec.Amount;
                            GenJnlLine.Validate(GenJnlLine.Amount);
                            //          GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                            //          GenJnlLine."Bal. Account No.":=PurchLine6."No.";
                            //          GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                            //           GenJnlLine."Bal. Gen. Posting Type":=GenJnlLine."Bal. Gen. Posting Type"::Sale;
                            //Added for Currency Codes
                            GenJnlLine."Currency Code" := Rec."Currency Code";
                            GenJnlLine.Validate("Currency Code");
                            GenJnlLine."Currency Factor" := Rec."Currency Factor";
                            GenJnlLine.Validate("Currency Factor");
                            GenJnlLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                            // GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                            // GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                            // GenJnlLine.ValidateShortcutDimCode(5, Rec."Shortcut Dimension 5 Code");
                            if GenJnlLine.Amount <> 0 then
                                GenJnlLine.Insert;
                            //              UNTIL PurchLine6.NEXT=0;
                            //            END;

                            PurchLine6.Reset;
                            PurchLine6.SetRange(PurchLine6."Document No.", Rec."No.");
                            //PurchLine6.SETFILTER("Amount Spent",'<>%1',0);
                            if PurchLine6.FindSet then begin
                                repeat
                                    LineNo2 := LineNo2 + 2000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := 'PAYMENTS';
                                    GenJnlLine."Journal Batch Name" := 'PVS';
                                    //MESSAGE('tuko hapa');
                                    //          GenJnlLine2.RESET;
                                    //          GenJnlLine2.SETRANGE("Journal Template Name",'PAYMENTS');
                                    //          GenJnlLine2.SETRANGE("Journal Batch Name",'PVS');
                                    //          IF GenJnlLine2.FINDLAST THEN
                                    GenJnlLine."Line No." := LineNo2;
                                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                                    GenJnlLine."Posting Date" := Rec."Posting Date";
                                    //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := PurchLine6."Document No.";
                                    if PurchLine6.Type = PurchLine6.Type::"G/L Account" then
                                        GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account"


                                    else
                                        if PurchLine6.Type = PurchLine6.Type::"Fixed Asset" then begin

                                            GenJnlLine."Account Type" := GenJnlLine."account type"::"Fixed Asset";
                                            GenJnlLine."FA Posting Type" := GenJnlLine."fa posting type"::"Acquisition Cost";
                                            GenJnlLine."FA Posting Date" := Rec."Posting Date";
                                            GenJnlLine."Gen. Posting Type" := GenJnlLine."gen. posting type"::Purchase;
                                        end;
                                    GenJnlLine."Account No." := PurchLine6."Account No New";

                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Description := PurchLine6.Description;
                                    //'Paymentvoucher: '+"Account No"+' '+"Imprest No";
                                    GenJnlLine.Amount := PurchLine6.Amount;
                                    GenJnlLine.Validate(GenJnlLine.Amount);
                                    //          GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                                    //          GenJnlLine."Bal. Account No.":=PurchLine6."No.";
                                    //          GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                                    //           GenJnlLine."Bal. Gen. Posting Type":=GenJnlLine."Bal. Gen. Posting Type"::Sale;
                                    //Added for Currency Codes
                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    GenJnlLine.Validate("Currency Code");
                                    GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                    GenJnlLine.Validate("Currency Factor");
                                    GenJnlLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                                    GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                                    GenJnlLine.ValidateShortcutDimCode(5, Rec."Shortcut Dimension 5 Code");
                                    // MESSAGE('HOME %1|%2',GenJnlLine."Journal Batch Name",GenJnlLine."Journal Template Name");
                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;
                                until PurchLine6.Next = 0;
                            end;
                            MESSAGE('Kait yu %1|%2', GenJnlLine."Journal Batch Name", GenJnlLine."Journal Template Name");
                            EXIT;
                            GenJnlLine.Reset;
                            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'PAYMENTS');
                            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PVS');
                            if GenJnlLine.Find('-') then begin
                                //    Message('HOME');
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnlLine);
                                Rec.Completed := true;
                            end;
                            PurchaseHeader2.Reset;
                            PurchaseHeader2.SetRange("No.", Rec."Imprest No");
                            if PurchaseHeader2.FindFirst then begin
                                PurchaseHeader2.Completed := true;
                                //PurchaseHeader2.:=TRUE;
                                //PurchaseHeader2."Imprest No":="No.";
                                PurchaseHeader2.Modify;
                            end;

                            Rec.Modify;

                            //   GenJnlLine2.RESET;
                            //   GenJnlLine2.SETRANGE("Journal Template Name",'PAYMENTS');
                            //   GenJnlLine2.SETRANGE("Journal Batch Name",'PVS');
                            //   IF GenJnlLine2.FINDFIRST THEN
                            //   GenJnlLine2.DELETEALL;

                            Message('payment Voucher posted Successfully');
                        end;

                    end;
                }
                action(CopyDocument)
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RunModal;
                        Clear(CopyPurchDoc);
                    end;
                }
                action("Archive Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.Update(false);
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
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                separator(Action10)
                {
                }
            }
            // group("Make Order")
            // {
            //     Caption = 'Make Order';
            //     Image = MakeOrder;
            //     action("Make Order")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Make &Order';
            //         Image = MakeOrder;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         Visible = false;

            //         trigger OnAction()
            //         var
            //             SalesHeader: Record "Sales Header";
            //         begin
            //             //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
            //               //CODEUNIT.RUN(CODEUNIT::"Purch.-Quote to Order (Yes/No)",Rec);
            //         end;
            //     }
            // }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*   UpdateControls;
        PurchHeader.RESET;
        PurchHeader.SETRANGE("User ID",USERID);
        PurchHeader.SETRANGE(PurchHeader.Status,PurchHeader.Status::Open);
        //PurchHeader.SETRANGE(SHeader."Request date",TODAY);
         IF PurchHeader.COUNT>1 THEN
           ERROR('You have unused requisition records under your account,Please utilize/release them for approval'+
             ' before creating a new record');
           */

    end;

    trigger OnAfterGetRecord()
    begin
        CurrPageUpdate;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        //exit(ConfirmDeletion);
        Error('Not Allowed!');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.SR := true;

        /*SHeader.RESET;
        SHeader.SETRANGE("User ID",USERID);
        SHeader.SETRANGE(SHeader.Status,SHeader.Status::Open);
       // SHeader.SETRANGE(SHeader."Request date",TODAY);
        IF SHeader.COUNT>1 THEN
          ERROR('You have unused requisition records under your account,please utilize/release them for approval'+
            ' before creating a new record');
            */

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."AU Form Type" := Rec."au form type"::"Petty Cash Voucher";
        PurchasesPayablesSetup.Get;
        Rec."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Petty Cash Payment Form", Today, true);
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec."Assigned User ID" := UserId;
        Rec."User ID" := UserId;
        Rec."Requested Receipt Date" := Today;
        Rec.Status := Rec.Status::Open;
        Rec."Buy-from Vendor No." := 'VEND9999';
        Rec.Validate("Buy-from Vendor No.");

        //"Document Type":="Document Type"::Quote;

        Rec.SR := true;

        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", '');
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
        Rec."AU Form Type" := Rec."au form type"::"Petty Cash Voucher";
        //"Document Type":="Document Type"::Quote;
        // Rec."Assigned User ID" := UserId;
        // Rec."Buy-from Vendor No." := 'VEND9999';
        // Rec.Validate("Buy-from Vendor No.");
        // Rec.Status := Rec.Status::Open;
        //Rec.SR := true;
        //SETRANGE("User ID",USERID);
        if Rec."Currency Code" = '' then
            Rec."Currency Factor" := 1;

        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", '');
        if Vendor.FindFirst then begin
            Rec."Buy-from Vendor No." := 'VEND9999';
            Rec.Validate("Buy-from Vendor No.");
        end;

    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchLine: Record "Purchase Line";
        StatusEditable: Boolean;
        Vendor: Record Vendor;
        PurchHeader: Record "Purchase Header";
        SHeader: Record "Purchase Header";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        UserSetup: Record "User Setup";
        HREmployees: Record "HR Employees";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        PurchLine2: Record "Purchase Line";
        PurchaseLine3: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        GenJnlLine: Record "Gen. Journal Line";
        Amt: Decimal;
        PurchaseHeader2: Record "Purchase Header";
        GenJnlLine2: Record "Gen. Journal Line";
        RFQ: Record "Purchase Line";
        LineNo: Integer;
        PurchLine6: Record "Purchase Line";
        LineNo2: Decimal;
        GenJournalBatch: Record "Gen. Journal Batch";

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

