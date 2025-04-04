page 80146 "Payments Voucher Card"
{
    Caption = 'Payments Voucher Card';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = CONST(Quote));

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Bank Account"; REC."Paying Account No")
                {

                    trigger OnValidate()
                    begin
                        IF Rec."No." = '' THEN BEGIN
                            BankAccount.GET(rec."Paying Account No");
                            Rec."No." := NoSeriesManagement.GetNextNo('PVNO', TODAY, TRUE);
                        END;
                    end;
                }
                field("No."; Rec."No.")
                {
                    Caption = 'PV No.';
                    Enabled = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(Payee; Rec."Paying Account Name")
                {
                }
                field("Cheque No"; Rec."Cheque No")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("ShortcutDimCode[5]"; Rec."Shortcut Dimension 5 Code")
                {
                    Caption = 'Output';
                }
                field("ShortcutDimCode[4]"; Rec."Shortcut Dimension 4 Code")
                {
                    Caption = 'Objective';
                }

                field("ShortcutDimCode[3]"; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Donor Code';
                }


                field("ShortcutDimCode[6]"; Rec."Shortcut Dimension 6 Code")
                {
                    Caption = 'Region';
                }
                field("ShortcutDimCode[7]"; Rec."Shortcut Dimension 7 Code")
                {
                    Caption = 'County';
                }
                field("ShortcutDimCode[8]"; Rec."Shortcut Dimension 8 Code")
                {
                    Caption = 'Department';
                }
                field(Purpose; Rec.Purpose)
                {
                }
                field("Linked Document"; Rec."Linked Document")
                {
                    Enabled = true;
                }
                // field("Payment Type";Rec."Payment Type")
                // {
                // }
                field("Document Total"; Rec."Document Total")
                {
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        //  CLEAR(ChangeExchangeRate);
                        //  ChangeExchangeRate.SetParameter("Currency Code","Currency Factor",WORKDATE);
                        // IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                        //    VALIDATE("Currency Factor",ChangeExchangeRate.GetParameter);
                        CurrPage.UPDATE;
                    END;
                    // CLEAR(ChangeExchangeRate);
                    //end;

                    trigger OnValidate()
                    begin
                        //CurrencyCodeOnAfterValidate;
                    end;
                }
            }
            // part(PV; 80147)
            part(PV; 80102)
            {
                SubPageLink = "Document No." = FIELD("No.");
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
                Visible = false;
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        // CalcInvDiscForHeader;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action(Vendor)
                {
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page 26;
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 66;
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        //ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "658";
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Attachments)
            {
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 80079;
                RunPageLink = "Doc No." = FIELD("No.");
            }
            action("Linked Attachments")
            {
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 80079;
                RunPageLink = "Doc No." = FIELD("Linked Document");
            }
            action("&Print PV Investments")
            {
                Caption = '&Print PV Investments';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    // IF LinesCommitted THEN
                    //   ERROR('All Lines should be committed');
                    Rec.RESET;
                    Rec.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(80062, TRUE, TRUE, Rec);
                    //  RESET;
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action("Print Payment voucher-New")
            {
                Caption = 'Print Payment voucher-New';
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(80063, TRUE, TRUE, Rec);
                end;
            }
            action("Print Payment voucher-test")
            {
                Caption = 'Print Payment Voucher';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;
                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(80079, TRUE, TRUE, Rec);//17367
                end;
            }
            action("Approval Process")
            {

                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(17367, TRUE, TRUE, Rec);//17367
                end;
            }
            action("Print Grants Voucher")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(80072, TRUE, TRUE, Rec);
                end;
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    // IF LinesCommitted THEN
                    //   ERROR('All Lines should be committed');
                    Rec.RESET;
                    Rec.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(80051, TRUE, TRUE, Rec);
                    //  RESET;
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            group(Release_)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator(I)
                {
                }
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    Visible = false;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "415";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Award Schedule")
                {
                    // RunObject = Page 55947;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Visible = false;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "415";
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
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                separator(V)
                {
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = VendorCode;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "175";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(U)
                {
                }
                action(Post)
                {
                    Caption = 'Post';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        IF Rec.Completed = TRUE THEN ERROR('This document is already posted');
                        IF CONFIRM('Are you sure you want to post the PV') THEN BEGIN

                            GenJnlLine2.RESET;
                            GenJnlLine2.SETRANGE("Journal Template Name", 'PAYMENTS');
                            GenJnlLine2.SETRANGE("Journal Batch Name", 'PV');
                            IF GenJnlLine2.FIND THEN
                                GenJnlLine2.DELETE;

                            GenJnlLine.INIT;
                            GenJnlLine."Journal Template Name" := 'PAYMENTS';
                            GenJnlLine."Journal Batch Name" := 'PV';
                            GenJnlLine2.RESET;
                            GenJnlLine2.SETRANGE("Journal Template Name", 'PAYMENTS');
                            GenJnlLine2.SETRANGE("Journal Batch Name", 'PV');
                            IF GenJnlLine2.FINDLAST THEN
                                GenJnlLine."Line No." := GenJnlLine2."Line No." + 10000;
                            GenJnlLine."Source Code" := 'PAYMENTJNL';
                            GenJnlLine."Posting Date" := Rec."Posting Date";
                            //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                            GenJnlLine."Document No." := Rec."No.";
                            GenJnlLine."External Document No." := Rec."Cheque No";
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                            GenJnlLine."Account No." := Rec."Paying Account No";
                            GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                            GenJnlLine.Description := Rec.Purpose + '-' + Rec."Paying Account Name";
                            Rec.CALCFIELDS(Rec."Document Total");
                            GenJnlLine.Amount := -1 * Rec."Document Total";
                            GenJnlLine.VALIDATE(GenJnlLine.Amount);

                            //Added for Currency Codes
                            GenJnlLine."Currency Code" := Rec."Currency Code";
                            GenJnlLine.VALIDATE("Currency Code");
                            GenJnlLine."Currency Factor" := Rec."Currency Factor";
                            GenJnlLine.VALIDATE("Currency Factor");

                            GenJnlLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                            GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                            GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                            GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                            GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                            GenJnlLine.ValidateShortcutDimCode(5, Rec."Shortcut Dimension 5 Code");
                            GenJnlLine.ValidateShortcutDimCode(6, Rec."Shortcut Dimension 6 Code");
                            GenJnlLine.ValidateShortcutDimCode(7, Rec."Shortcut Dimension 7 Code");
                            GenJnlLine.ValidateShortcutDimCode(8, Rec."Shortcut Dimension 8 Code");

                            IF GenJnlLine.Amount <> 0 THEN
                                GenJnlLine.INSERT;

                            PurchLine.RESET;
                            PurchLine.SETRANGE("Document No.", Rec."No.");
                            IF PurchLine.FINDSET THEN BEGIN
                                REPEAT
                                    GenJnlLine.INIT;
                                    GenJnlLine."Journal Template Name" := 'PAYMENTS';
                                    GenJnlLine."Journal Batch Name" := 'PV';
                                    GenJnlLine2.RESET;
                                    GenJnlLine2.SETRANGE("Journal Template Name", 'PAYMENTS');
                                    GenJnlLine2.SETRANGE("Journal Batch Name", 'PV');
                                    IF GenJnlLine2.FINDLAST THEN
                                        GenJnlLine."Line No." := GenJnlLine2."Line No." + 10000;
                                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                                    GenJnlLine."Posting Date" := Rec."Posting Date";
                                    //  GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := rEC."Cheque No";
                                    IF PurchLine."Account Type" = PurchLine."Account Type"::"G/L Account" THEN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                    IF PurchLine."Account Type" = PurchLine."Account Type"::Supplier THEN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                                    IF PurchLine."Account Type" = PurchLine."Account Type"::Customer THEN
                                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                                    // IF PurchLine."Account Type"=PurchLine."Account Type"::Bank THEN
                                    // GenJnlLine."Account Type":=GenJnlLine."Account Type"::"Bank Account";
                                    GenJnlLine."Account No." := PurchLine."Account No.";
                                    GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                                    GenJnlLine.Description := Rec.Purpose + '-' + Rec."Paying Account Name";

                                    GenJnlLine.Amount := PurchLine."Direct Unit Cost";
                                    GenJnlLine.VALIDATE(GenJnlLine.Amount);

                                    //Added for Currency Codes
                                    GenJnlLine."Currency Code" := Rec."Currency Code";
                                    GenJnlLine.VALIDATE("Currency Code");
                                    GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                    GenJnlLine.VALIDATE("Currency Factor");

                                    GenJnlLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                                    GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                    GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                                    GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                                    GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                                    GenJnlLine.ValidateShortcutDimCode(5, Rec."Shortcut Dimension 5 Code");
                                    GenJnlLine.ValidateShortcutDimCode(6, Rec."Shortcut Dimension 6 Code");
                                    GenJnlLine.ValidateShortcutDimCode(7, Rec."Shortcut Dimension 7 Code");
                                    GenJnlLine.ValidateShortcutDimCode(8, Rec."Shortcut Dimension 8 Code");
                                    IF GenJnlLine.Amount <> 0 THEN
                                        GenJnlLine.INSERT;
                                UNTIL PurchLine.NEXT = 0;
                            END;

                            GenJnlLine.RESET;
                            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", 'PAYMENTS');
                            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", 'PV');
                            IF GenJnlLine.FINDSET THEN BEGIN
                                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnlLine);
                            END;

                            Rec.Posted := true;
                            Rec.Completed := TRUE;
                            Rec.Status := Rec.Status::Released;
                            Rec.MODIFY;

                            /* GenJnlLine2.RESET;
                              GenJnlLine2.SETRANGE("Journal Template Name",'PAYMENTS');
                              GenJnlLine2.SETRANGE("Journal Batch Name",'IMPREST');
                              IF GenJnlLine2.FIND THEN
                              GenJnlLine2.DELETE;*/

                            MESSAGE('payment Posted Successfully');
                        END;

                    end;
                }
                action(CopyDocument)
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("Archive Document")
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        //ArchiveManagement.ArchivePurchDocument(Rec);
                        //CurrPage.UPDATE(FALSE);
                        IF CONFIRM('Are you sure you want to archive the imprest proposal') THEN BEGIN
                            //Archived2:=TRUE;
                            //  MODIFY;
                        END;
                        MESSAGE('Document Archived');
                    end;
                }
                separator(O)
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
                        ApprovalsMgmt: Codeunit "1535";
                    begin
                        //TESTFIELD(Rec.Purpose);

                        IF ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) THEN
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApproval)
                {

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "1535";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
                separator(Y)
                {
                }
            }
            group("Make Order_")
            {
                Caption = 'Make Order';
                Image = MakeOrder;
                action("Make Order")
                {
                    Caption = 'Make &Order';
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        SalesHeader: Record "36";
                    begin
                        //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                        //CODEUNIT.RUN(CODEUNIT::"Purch.-Quote to Order (Yes/No)",Rec);
                    end;
                }
            }
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
        CurrPage.SAVERECORD;
        // EXIT(ConfirmDeletion);
        ERROR('Not Allowed!');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.PV := TRUE;

        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec."Assigned User ID" := USERID;
        Rec."User ID" := USERID;
        Rec."Requested Receipt Date" := TODAY;

        Rec."Document Type" := Rec."Document Type"::Quote;

        Rec.PV := TRUE;

        Vendor.RESET;
        Vendor.SETRANGE(Vendor."No.", '.');
        IF Vendor.FINDFIRST THEN BEGIN
            Rec."Buy-from Vendor No." := Vendor."No.";
            Rec.VALIDATE(Rec."Buy-from Vendor No.");

        END;

        Rec."Posting Description" := '';
        UpdateControls;
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
        //  PurchasesPayablesSetup.GET;
        //  Rec."No.":= NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Payment Voucher Nos",TODAY,TRUE);
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec."Assigned User ID" := USERID;
        Rec."User ID" := USERID;
        Rec."Requested Receipt Date" := TODAY;

        Rec."Document Type" := Rec."Document Type"::Quote;

        Rec.PV := TRUE;

        Vendor.RESET;
        Vendor.SETRANGE(Vendor."No.", '.');
        IF Vendor.FINDFIRST THEN BEGIN
            Rec."Buy-from Vendor No." := Vendor."No.";
            Rec.VALIDATE("Buy-from Vendor No.");
        END;

        Rec."Posting Description" := '';
        UpdateControls;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin

        /*IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
          FILTERGROUP(0);
        END;*/

        //
        // "Document Type":="Document Type"::Quote;
        // "Assigned User ID":=USERID;
        // PV:=TRUE;
        //SETRANGE("User ID",USERID);

    end;

    var
        ChangeExchangeRate: Page "511";
        CopyPurchDoc: Report "492";
        DocPrint: Codeunit "229";
        UserMgt: Codeunit "5700";
        ArchiveManagement: Codeunit "5063";
        PurchLine: Record "39";
        StatusEditable: Boolean;
        Vendor: Record "23";
        PurchHeader: Record "38";
        SHeader: Record "38";
        ApprovalMgt: Codeunit "1535";
        UserSetup: Record "91";
        HREmployees: Record "172021";
        NoSeriesManagement: Codeunit "396";
        PurchLine2: Record "39";
        PurchaseLine3: Record "39";
        PurchaseHeader: Record "38";
        PurchasesPayablesSetup: Record "312";
        GenJnlLine: Record "81";
        Amt: Decimal;
        PurchaseHeader2: Record "38";
        GenJnlLine2: Record "81";
        BankAccount: Record "270";

    local procedure ApproveCalcInvDisc()
    begin
        //CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        IF Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
            IF Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                Rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
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
        CurrPage.UPDATE;
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    procedure LinesCommitted() Exists: Boolean
    var
        PurchLines: Record "39";
    begin
    end;

    procedure SomeLinesCommitted() Exists: Boolean
    var
        PurchLines: Record "39";
    begin
    end;

    procedure UpdateControls()
    begin
        IF Rec.Status = Rec.Status::Open THEN
            StatusEditable := TRUE
        ELSE
            StatusEditable := TRUE;
    end;

    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        CurrPage.UPDATE;
    end;
}

