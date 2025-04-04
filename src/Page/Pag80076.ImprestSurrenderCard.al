Page 80076 "Imprest Surrender Card"
{
    Caption = 'Imprest Surrender Card';
    DeleteAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = const(Quote),
                            SR = filter(true));

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
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Imprest No"; Rec."Imprest No")
                {
                    ApplicationArea = Basic;
                    TableRelation = "Purchase Header" where(IM = const(true),
                                                             "User ID" = field("User ID"),
                                                             Surrendered = const(false));

                    trigger OnValidate()
                    begin
                        //CHECK WHETHER HAS LINES AND DELETE
                        if Confirm('If you change the imprest no. the current lines will be deleted. Do you want to continue?') then begin

                            PurchLine.Reset;
                            PurchLine.SetRange(PurchLine."Document No.", Rec."No.");

                            if PurchLine.Find('-') then
                                PurchLine.DeleteAll;

                            PurchaseHeader2.Reset;
                            PurchaseHeader2.SetRange("No.", Rec."Imprest No");
                            if PurchaseHeader2.FindFirst then begin
                                Rec.Validate("Currency Code", PurchaseHeader2."Currency Code");
                                Rec."Mission Proposal No" := PurchaseHeader2."Mission Proposal No";
                                Rec."Shortcut Dimension 1 Code" := PurchaseHeader2."Shortcut Dimension 1 Code";
                                Rec."Shortcut Dimension 2 Code" := PurchaseHeader2."Shortcut Dimension 2 Code";
                                Rec."Shortcut Dimension 3 Code" := PurchaseHeader2."Shortcut Dimension 3 Code";
                                Rec."Shortcut Dimension 4 Code" := PurchaseHeader2."Shortcut Dimension 4 Code";
                                Rec."Shortcut Dimension 5 Code" := PurchaseHeader2."Shortcut Dimension 5 Code";

                                //POPULATTE PURCHASE LINE WHEN USER SELECTS IMP.
                                RFQ.Reset;
                                RFQ.SetRange("Document No.", Rec."Imprest No");
                                if RFQ.Find('-') then begin
                                    repeat
                                        PurchLine2.Init;

                                        LineNo := LineNo + 1000;
                                        PurchLine2."Document Type" := Rec."Document Type";
                                        PurchLine2.Validate("Document Type");
                                        PurchLine2."Document No." := Rec."No.";
                                        PurchLine2.Validate("Document No.");
                                        PurchLine2."Line No." := LineNo;
                                        PurchLine2.Type := RFQ.Type;
                                        PurchLine2."No." := RFQ."No.";
                                        PurchLine2.Validate("No.");
                                        PurchLine2.Description := RFQ.Description;
                                        PurchLine2."Description 2" := RFQ."Description 2";
                                        PurchLine2.Quantity := RFQ.Quantity;
                                        // PurchLine2.VALIDATE(Quantity);
                                        PurchLine2."Unit of Measure Code" := RFQ."Unit of Measure Code";
                                        //PurchLine2.VALIDATE("Unit of Measure Code");
                                        PurchLine2."Direct Unit Cost" := RFQ."Direct Unit Cost";
                                        // PurchLine2.VALIDATE("Direct Unit Cost");
                                        PurchLine2."Line Amount" := RFQ."Line Amount";
                                        PurchLine2."Location Code" := RFQ."Location Code";
                                        PurchLine2."Location Code" := Rec."Location Code";
                                        PurchLine2.Validate("Currency Code", PurchaseHeader2."Currency Code");
                                        PurchLine2."Expense Category" := RFQ."Expense Category";
                                        PurchLine2."Shortcut Dimension 1 Code" := RFQ."Shortcut Dimension 1 Code";
                                        PurchLine2."Shortcut Dimension 2 Code" := RFQ."Shortcut Dimension 2 Code";
                                        PurchLine2."ShortcutDimCode[3]" := RFQ."ShortcutDimCode[3]";
                                        PurchLine2.Insert(true);

                                    until RFQ.Next = 0;
                                end;
                            end;
                        end;
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
            }
            part(ImprestLines; "Surrender Subform")
            {
                SubPageLink = "Document No." = field("No.");
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
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
                    //Reset;
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
                    Caption = 'Surrender';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.TestField(Completed, false);
                        if Confirm('Are you sure you want to post the surrender') then begin
                            Rec.TestField(Status, Rec.Status::Released);

                            GenJnlLine2.Reset;
                            GenJnlLine2.SetRange("Journal Template Name", 'GENERAL');
                            GenJnlLine2.SetRange("Journal Batch Name", 'SURRENDER');
                            if GenJnlLine2.Find then
                                GenJnlLine2.Delete;

                            /*GenJnlLine.INIT;
                            GenJnlLine."Journal Template Name":='PAYMENTS';
                            GenJnlLine."Journal Batch Name":='SURRENDER';
                            GenJnlLine2.RESET;
                            GenJnlLine2.SETRANGE("Journal Template Name",'PAYMENTS');
                            GenJnlLine2.SETRANGE("Journal Batch Name",'SURRENDER');
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
                            GenJnlLine.Description:='Surrender: '+"Account No"+' '+"Imprest No";
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



                            PurchLine6.Reset;
                            PurchLine6.SetRange("Document No.", Rec."No.");
                            PurchLine6.SetFilter("Amount Spent", '<>%1', 0);
                            if PurchLine6.FindSet then begin
                                repeat
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := 'GENERAL';
                                    GenJnlLine."Journal Batch Name" := 'SURRENDER';
                                    GenJnlLine2.Reset;
                                    GenJnlLine2.SetRange("Journal Template Name", 'GENERAL');
                                    GenJnlLine2.SetRange("Journal Batch Name", 'SURRENDER');
                                    if GenJnlLine2.FindLast then
                                        GenJnlLine."Line No." := GenJnlLine2."Line No." + 10000;
                                    GenJnlLine."Source Code" := 'GENJNL';
                                    GenJnlLine."Posting Date" := Today;
                                    //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := Rec."Imprest No";
                                    GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
                                    GenJnlLine."Account No." := Rec."Account No";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Description := PurchLine6."Description 2";
                                    //'Surrender: '+"Account No"+' '+"Imprest No";
                                    GenJnlLine.Amount := -1 * PurchLine6."Amount Spent";
                                    GenJnlLine.Validate(GenJnlLine.Amount);
                                    GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                                    GenJnlLine."Bal. Account No." := PurchLine6."No.";
                                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                    GenJnlLine."Bal. Gen. Posting Type" := GenJnlLine."bal. gen. posting type"::Sale;
                                    //Added for Currency Codes
                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    GenJnlLine.Validate("Currency Code");
                                    GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                    GenJnlLine.Validate("Currency Factor");
                                    GenJnlLine."Shortcut Dimension 1 Code" := PurchLine6."Shortcut Dimension 1 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := PurchLine6."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                    GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                    GenJnlLine.ValidateShortcutDimCode(5, PurchLine6."ShortcutDimCode[5]");
                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;
                                until PurchLine6.Next = 0;
                            end;


                            PurchLine6.Reset;
                            PurchLine6.SetRange("Document No.", Rec."No.");
                            PurchLine6.SetFilter("Cash Refund", '<>%1', 0);
                            if PurchLine6.FindSet then begin
                                repeat
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := 'GENERAL';
                                    GenJnlLine."Journal Batch Name" := 'SURRENDER';
                                    GenJnlLine2.Reset;
                                    GenJnlLine2.SetRange("Journal Template Name", 'GENERAL');
                                    GenJnlLine2.SetRange("Journal Batch Name", 'SURRENDER');
                                    if GenJnlLine2.FindLast then
                                        GenJnlLine."Line No." := GenJnlLine2."Line No." + 10000;
                                    GenJnlLine."Source Code" := 'GENJNL';
                                    GenJnlLine."Posting Date" := Today;
                                    //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := Rec."Imprest No";
                                    GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
                                    GenJnlLine."Account No." := Rec."Account No";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Description := PurchLine6."Description 2";
                                    //'Surrender: '+"Account No"+' '+"Imprest No";
                                    GenJnlLine.Amount := -1 * PurchLine6."Cash Refund";
                                    GenJnlLine.Validate(GenJnlLine.Amount);
                                    GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"Bank Account";
                                    GenJnlLine."Bal. Account No." := PurchLine6."Cash Refund  Account";
                                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                    //Added for Currency Codes
                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    GenJnlLine.Validate("Currency Code");
                                    GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                    GenJnlLine.Validate("Currency Factor");
                                    GenJnlLine."Shortcut Dimension 1 Code" := PurchLine6."Shortcut Dimension 1 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := PurchLine6."Shortcut Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                    GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                    GenJnlLine.ValidateShortcutDimCode(5, PurchLine6."ShortcutDimCode[5]");
                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;
                                until PurchLine6.Next = 0;
                            end;





                            GenJnlLine.Reset;
                            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'GENERAL');
                            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'SURRENDER');
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnlLine);
                            Rec.Completed := true;

                            PurchaseHeader2.Reset;
                            PurchaseHeader2.SetRange("No.", Rec."Imprest No");
                            if PurchaseHeader2.FindFirst then begin
                                PurchaseHeader2.Completed := true;
                                PurchaseHeader2.Surrendered := true;
                                //PurchaseHeader2."Imprest No":="No.";
                                PurchaseHeader2.Modify;
                            end;

                            Rec.Modify;

                            GenJnlLine2.Reset;
                            GenJnlLine2.SetRange("Journal Template Name", 'GENERAL');
                            GenJnlLine2.SetRange("Journal Batch Name", 'SURRENDER');
                            if GenJnlLine2.FindFirst then
                                GenJnlLine2.DeleteAll;

                            Message('Surrender posted Successfully');
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
        PurchasesPayablesSetup.Get;
        Rec."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Surrender Nos.", Today, true);
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec."Assigned User ID" := UserId;
        Rec."User ID" := UserId;
        Rec."Requested Receipt Date" := Today;

        Rec."Document Type" := Rec."document type"::Quote;

        Rec.SR := true;

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
        Rec."Document Type" := Rec."document type"::Quote;
        Rec."Assigned User ID" := UserId;
        Rec.SR := true;
        //SETRANGE("User ID",USERID);
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

