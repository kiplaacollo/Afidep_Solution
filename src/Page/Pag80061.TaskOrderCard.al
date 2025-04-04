Page 80061 "Task Order Card"
{
    Caption = 'Purchase Requisition';
    DeleteAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    //SourceTableView = where("Document Type"=const(Quote),
    //DocApprovalType=const(Requisition));

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
                    Editable = statuseditable;
                    Enabled = true;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date';
                    Editable = statuseditable;
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

                            //OninsertRecords();


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
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    // Enabled = false;
                    // Editable = statuseditable;
                }

                field(Amount; Rec."Travel Total")
                {
                    ApplicationArea = Basic;
                    Editable = statuseditable;
                }
                //field(line)
                field("Net Amount in foreign Currency"; Rec."Net Amount in foreign Currency")
                {
                    Caption = 'Foreign Currency';
                    // Visible = false;

                }
                field("Net Amount in foreign"; Rec."Net Amount in foreign")
                {
                    Caption = 'Foreign Test';
                    Visible = false;
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
                Caption = 'Lines';
                SubPageLink = "Document No." = field("No.");
                Editable = statuseditable;
            }
            // part(PurchLines; "Requisition Subform")
            // {
            //     Editable = statuseditable;
            //     SubPageLink = "Document No." = field("No.");
            // }
            group("Foreign Trade")
            {
                Visible = false;
                Caption = 'Foreign Trade';
                // field("Currency Code";Rec."Currency Code")
                // {
                //     ApplicationArea = Basic;
                //     Importance = Promoted;

                //     trigger OnAssistEdit()
                //     begin
                //         Clear(ChangeExchangeRate);
                //         ChangeExchangeRate.SetParameter(Rec."Currency Code",Rec."Currency Factor",WorkDate);
                //         if ChangeExchangeRate.RunModal = Action::OK then begin
                //           Rec.Validate("Currency Factor",ChangeExchangeRate.GetParameter);
                //           CurrPage.Update;
                //         end;
                //         Clear(ChangeExchangeRate);
                //     end;

                //     trigger OnValidate()
                //     begin
                //         CurrencyCodeOnAfterValidate;
                //     end;
                // }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = Basic;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = Basic;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = Basic;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
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
                action("Send Approval Request")
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
                    if Rec.Status = Rec.Status::"Pending Approval" then begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                    end;

                end;
            }
            action(UpdateCompletion)
            {
                ApplicationArea = Basic, Suite;

                Caption = 'Update Completion';
                Image = UpdateDescription;
                Promoted = true;
                //Visible = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                ToolTip = 'Mark the record as completed if it is completed.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    COA: Record "G/L Account";
                begin
                    if Rec.Status <> Rec.Status::Released then
                        Error('The record must have been approved first');
                    if Rec.Completed = false then begin
                        Rec.Completed := true;
                        Rec.Modify();
                        Message('The record has been marked completed');
                    end;

                end;
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
                Visible = false;
                PromotedCategory = Process;
                RunObject = Page Documents;
                RunPageLink = "Doc No." = field("No.");
            }
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
            action(Email)
            {
                ApplicationArea = all;
                Caption = 'Send Email';
                Image = Email;
                ToolTip = 'Send an email to this customer.';
                Visible = false;

                trigger OnAction()
                var
                    TempEmailItem: Record "Email Item" temporary;
                    EmailScenario: Enum "Email Scenario";
                begin
                    TempEmailItem.AddSourceDocument(Database::Customer, Rec.SystemId);
                    //TempEmailitem."Send to" := Rec."E-Mail";
                    TempEmailItem.Send(false, EmailScenario::Default);
                end;
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
                    Report.Run(80024, true, true, Rec);
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
                Visible = false;
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
                        //ArchiveManagement.ArchivePurchDocument(Rec);
                        //CurrPage.UPDATE(FALSE);
                        if Confirm('Are you sure you want to archive the requisition') then begin
                            Rec.Archived := true;
                            Rec.Modify;
                        end;
                        Message('Document Archived');
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
                action(CancelApproval)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Request';
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        COA: Record "G/L Account";
                    begin
                        if Rec.Status = Rec.Status::"Pending Approval" then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify();
                        end;

                    end;
                }
                action(ApproveAuto)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approver Approver Auto';
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
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
                action(UPdateRecord)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approver Update Record';
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        COA: Record "G/L Account";
                    begin
                        Rec.Status := Rec.Status::"Pending Approval";
                        Rec.Modify();

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
        Rec.DocApprovalType2 := Rec.Docapprovaltype2::Requisition;

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
        Rec."Doc Type" := Rec."doc type"::PurchReq;
        rec."AU Form Type" := Rec."AU Form Type"::"Purchase Requisition";
        Rec."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Requisition Nos.", Today, true);
        //Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec."Assigned User ID" := UserId;
        Rec."User ID" := UserId;
        Rec."Requested Receipt Date" := Today;
        Rec."Buy-from Vendor No." := PurchasesPayablesSetup."Default Vendor";
        Rec."Vendor Posting Group" := PurchasesPayablesSetup."Vendor Posting Group";
        HREmployee.Reset();
        HREmployee.SetRange(HREmployee."Employee UserID", UserId);
        Message('%1', PurchasesPayablesSetup."Requisition Nos.");
        IF HREmployee.FindFirst() then begin
            Rec."Responsibility Center" := HREmployee."Responsibility Center";
            Rec."Responsibility Center Name" := HREmployee."Responsibility Center Name";
            rec."Employee No" := HREmployee."No.";
            Rec.Department := HREmployee."Programme or Department";
            Rec."Employee Name" := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
        end;




        Rec.PR := true;
        Rec.Requisition := true;
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", '.');
        if Vendor.FindFirst then begin
            Rec."Buy-from Vendor No." := Vendor."No.";
            Rec.Validate("Buy-from Vendor No.");
        end;


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
        Rec."Doc Type" := Rec."doc type"::PurchReq;
        // Rec."Assigned User ID" := UserId;
        Rec.Requisition := true;
        //SETRANGE("User ID",USERID);
        // Rec.Reset();
        // // Rec.SetRange(Rec."No.","No.");
        // if Rec.Find('-') then begin
        //Error('Currency code: %1', Rec."Currency Code");
        if Rec."Currency Factor" = 0 then
            Rec."Currency Factor" := 1;

        if Rec."Currency Code" = 'USD' then
            Rec."Currency Code" := '';


        Rec.Modify(true);
        // end;


    end;
    //end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchLine: Record "Purchase Line";
        HREmployee: Record "HR Employees";
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
        if Rec."Currency Factor" = 0 then begin
            Rec."Currency Factor" := 1;
        end;
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
            StatusEditable := true;
    end;


    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        CurrPage.Update;
    end;
}

