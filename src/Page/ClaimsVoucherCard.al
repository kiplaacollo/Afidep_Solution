Page 17202 "Claims Voucher Card"
{
    Caption = 'Claims Voucher Card';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Create PV(Payment Voucher),Category7_caption,Category8_caption,Category9_caption,Category10_caption', Locked = true;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;

                    Enabled = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date';
                    Enabled = false;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Visible = false;
                }


                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = statuseditable;
                    trigger OnValidate()
                    var
                        DimVal: Record "Dimension Value";
                    begin
                        Rec.CalcFields("Function Name");
                        if Rec."No." = '' then begin

                            OninsertRecords();


                        end;
                    end;

                }
                field("Function Name"; Rec."Function Name")
                {
                    Editable = statuseditable;
                }

                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = statuseditable;
                    trigger OnValidate()
                    var
                        Dim: Record "Dimension Value";
                    begin
                        Rec.CalcFields("Budget Center Name");
                        Dim.Reset();
                        Dim.SetRange(Code, Rec."Shortcut Dimension 2 Code");
                        if Dim.FindFirst() then begin
                            Rec."Shortcut Dimension 5 Code" := Dim."Thematic Code";
                        end;
                    end;

                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    Enabled = false;
                    Editable = statuseditable;
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
                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Activity Discription");
                    end;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code") { Enabled = false; Editable = statuseditable; }
                field("Activity Discription"; Rec."Activity Discription")
                {
                    Visible = false;
                    Enabled = false;

                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = basic;
                    Enabled = false;
                    Editable = statuseditable;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                    Enabled = false;
                    Editable = statuseditable;
                }

                field("Payee Naration"; Rec."Payee Naration")
                {
                    ApplicationArea = all;
                    Editable = statuseditable;
                }


                field("Paying Account No"; Rec."Paying Account No")
                {
                    ApplicationArea = Basic;
                    Editable = PayingBanlk;
                }
                field("Paying Account Name"; Rec."Paying Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Posting Description"; Rec."Posting Description")
                {
                    Caption = 'Claim Description';
                    Editable = statuseditable;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Caption = 'Requster ID';
                    Enabled = false;
                    Editable = statuseditable;
                }
                field("Supervisor"; Rec.Supervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor';
                    Enabled = false;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Editable = statuseditable;
                }

                field(Amount; Rec."Travel Total")
                {
                    ApplicationArea = Basic;
                    Editable = statuseditable;
                }
                field("Net Amount in foreign Currency"; Rec."Net Amount in foreign Currency")
                {
                    Caption = 'Foreign Currency';

                }




                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = statuseditable;

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
                    //Editable = statuseditable;
                }
                field("AU Form Type"; Rec."AU Form Type")
                {
                    ApplicationArea = all;
                    Caption = 'Document Type';
                    Enabled = false;
                    Editable = statuseditable;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Visible = false;
                    Editable = statuseditable;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group") { Visible = false; Editable = statuseditable; }

            }
            part("Claim Lines"; "Claim Lines")
            {
                Caption = 'Claim Lines';
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
                action(CreatePv)
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Payment Voucher';
                    Image = MakeOrder;
                    Ellipsis = true;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        PVNO: Code[20];
                    begin
                        Rec.TestField("Paying Account No");
                        Rec.TestField(Rec.Status, Rec.Status::Released);
                        //Rec.TestField(Rec.Completed, false);
                        PurchasesPayablesSetup.Get();
                        if Confirm('Are you sure you want to generate payment voucher?') = false then exit;
                        PurchaseHeader.Init();
                        PurchaseHeader."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Payment Vouchers Form", Today, true);
                        PVNO := PurchaseHeader."No.";
                        PurchaseHeader."AU Form Type" := PurchaseHeader."AU Form Type"::"Payment Voucher";
                        PurchaseHeader."Paying Account No" := Rec."Paying Account No";
                        PurchaseHeader."Paying Account Name" := Rec."Paying Account Name";
                        PurchaseHeader."Currency Code" := Rec."Currency Code";
                        PurchaseHeader."Currency Factor" := Rec."Currency Factor";
                        PurchaseHeader."User ID" := UserId;
                        PurchaseHeader."Buy-from Vendor No." := Rec."Buy-from Vendor No.";
                        PurchaseHeader."Vendor Posting Group" := Rec."Vendor Posting Group";
                        PurchaseHeader."Payee Naration" := Rec."Payee Naration";
                        PurchaseHeader."on-Behalf of" := Rec."Employee Name";
                        PurchaseHeader."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";

                        PurchaseHeader."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";

                        PurchaseHeader."Shortcut Dimension 3 Code" := Rec."Shortcut Dimension 3 Code";

                        PurchaseHeader."Shortcut Dimension 4 Code" := Rec."Shortcut Dimension 4 Code";
                        PurchaseHeader."Shortcut Dimension 5 Code" := Rec."Shortcut Dimension 5 Code";

                        PurchaseHeader."Linked Document" := Rec."No.";
                        PurchaseHeader.Insert(true);

                        PurchaseLine3.Reset();
                        PurchaseLine3.SetRange(PurchaseLine3."Document No.", Rec."No.");
                        if PurchaseLine3.FindSet() then begin
                            repeat

                                PurchLine.Init();
                                PurchLine.TransferFields(PurchaseLine3);
                                PurchLine."Document No." := PVNO;
                                // PurchLine."Document Type" := PurchaseHeader."Document Type";
                                PurchLine.Reset();
                                PurchLine.SetRange("Document No.", PVNO);
                                // PurchLine.SetRange("Line No.", PurchaseLine3."Line No.");
                                // PurchLine.SetRange("Document Type", PurchaseLine3."Document Type");
                                if PurchLine.FindLast() then begin
                                    PurchLine."Line No." := PurchLine."Line No." + 1;
                                end else begin
                                    PurchLine."Line No." := 1;
                                end;

                                PurchLine."Claim Type" := PurchaseLine3."Claim Type"::"G/L Account";
                                PurchLine.Validate("Claim Type");
                                PurchLine."Account No New" := PurchaseLine3."Account No New";
                                PurchLine.Validate("Account No New");
                                PurchLine.Description := PurchaseLine3."Description 3";
                                PurchLine."Description 2" := PurchaseLine3."Description 2";
                                PurchLine.Quantity := PurchaseLine3.Quantity;
                                PurchLine.Validate(Quantity);
                                PurchLine."Currency Code" := Rec."Currency Code";
                                PurchLine.Validate("Currency Code");
                                PurchLine."Currency Factor" := Rec."Currency Factor";
                                PurchLine.Validate("Currency Factor");
                                PurchLine."Direct Unit Cost" := PurchaseLine3."Direct Unit Cost";
                                PurchLine.Validate(PurchLine."Direct Unit Cost");
                                PurchLine."Shortcut Dimension 1 Code" := PurchaseLine3."Shortcut Dimension 1 Code";
                                PurchLine."Shortcut Dimension 2 Code" := PurchaseLine3."Shortcut Dimension 2 Code";
                                PurchLine."ShortcutDimCode[3]" := PurchaseLine3."ShortcutDimCode[3]";
                                PurchLine."ShortcutDimCode[4]" := PurchaseLine3."ShortcutDimCode[4]";
                                PurchLine."ShortcutDimCode[5]" := PurchaseLine3."ShortcutDimCode[5]";
                                PurchLine.Insert(true);
                            // Commit();
                            until PurchaseLine3.Next() = 0;
                            Commit();
                            Rec.Completed := true;
                            rec.Posted := true;
                            Rec.Modify();

                        end;
                        Message('Payment voucher ' + PVNO + ' has been created successfully.');
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
            action("Attachments Portal")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                Visible = true;
                PromotedCategory = Process;
                RunObject = page "Portal Uploads";
                RunPageLink = "Document No" = field("No.");
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
                    Report.Run(50089, true, true, Rec);
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

                action("Re&open")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    //  Visible = false;

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

                separator(Action144)
                {
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
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.TestField("Posting Date");
                        //TESTFIELD(Completed,FALSE);
                        if Confirm('Are you sure you want to post the Payment Voucher') then begin
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

                                    GenJnlLine."Line No." := LineNo2;
                                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                                    GenJnlLine."Posting Date" := Rec."Posting Date";
                                    //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                                    GenJnlLine."Document No." := Rec."No.";
                                    GenJnlLine."External Document No." := PurchLine6."Document No.";
                                    if PurchLine6.Type = PurchLine6.Type::"G/L Account" then
                                        GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";

                                    GenJnlLine."Account No." := PurchLine6."No.";

                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Description := PurchLine6.Description;
                                    //'Paymentvoucher: '+"Account No"+' '+"Imprest No";
                                    GenJnlLine.Amount := PurchLine6.Amount;

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
                            //MESSAGE('HOME %1|%2',GenJnlLine."Journal Batch Name",GenJnlLine."Journal Template Name");
                            //EXIT;
                            GenJnlLine.Reset;
                            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'PAYMENTS');
                            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PVS');
                            if GenJnlLine.Find('-') then begin
                                Message('HOME');
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



                            Message('payment Voucher posted Successfully');
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

            }

        }
    }

    trigger OnAfterGetCurrRecord()
    begin



    end;

    trigger OnAfterGetRecord()
    begin
        CurrPageUpdate;
        PayingBanlk := false;
        if Rec.Status = Rec.Status::Released then begin
            PayingBanlk := true;
        end else begin
            PayingBanlk := false;

        end;


    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        //exit(ConfirmDeletion);
        Error('Not Allowed!');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        if Rec."No." = '' then begin
            OninsertRecords();
        end;


    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

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
        Rec."AU Form Type" := Rec."au form type"::"Claim Voucher";

        Rec."Assigned User ID" := UserId;

    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchLine: Record "Purchase Line";
        StatusEditable: Boolean;
        PayingBanlk: Boolean;
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

    procedure OninsertRecords()

    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // Rec.InitInsert();
        //OnBeforeInitInsert(Rec, xRec, IsHandled);
        Rec."AU Form Type" := Rec."au form type"::"Claim Voucher";
        PurchasesPayablesSetup.Get;
        Rec."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Claims Voucher Form", Today, true);
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec."Assigned User ID" := UserId;
        Rec."User ID" := UserId;
        Rec."Requested Receipt Date" := Today;
        Rec."Document Date" := Today;
        Rec."Posting Date" := WorkDate();
        Rec."Buy-from Vendor No." := PurchasesPayablesSetup."Default Vendor";
        Rec."Vendor Posting Group" := PurchasesPayablesSetup."Vendor Posting Group";


        ;


        HREmployees.Reset();
        HREmployees.SetRange("Employee UserID", UserId);
        if HREmployees.Find('-') then begin
            Rec."Employee No" := HREmployees."No.";
            Rec."Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
            Rec."Payee Naration" := Rec."Employee Name";
            Rec.Supervisor := HREmployees."Supervisor ID";
        end;
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeInitInsert(var PurchaseHeader: Record "Purchase Header"; var xPurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;
}

