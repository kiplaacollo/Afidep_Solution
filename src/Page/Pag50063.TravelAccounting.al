Page 50063 "Travel Accounting"
{

    Editable = true;
    PageType = Card;
    SourceTable = "Purchase Header";
    PromotedActionCategories = 'New,Process,Report,Posting,Attachments,Invoice,Release,Request Approval,View,Navigate';
    Caption = 'Expense Report Voucher';

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }

                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Destination';
                    Editable = false;
                    Visible = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = true;
                    trigger OnValidate()
                    begin
                        UpdateEmployee();
                    end;

                }

                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = true;


                }

                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {

                }

                field(CustomerBalance; Rec.CustomerBalance)
                {
                    ApplicationArea = all;
                }
                field("Applies To Document No"; Rec."Applies To Document No")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    Caption = 'Imprest Requisition No';
                    trigger OnValidate()
                    var
                        PurchaseLine: Record "Purchase Line";
                        NewPurchaseline: Record "Purchase Line";
                        PurchaseHeader: Record "Purchase Header";
                        NewHeader: Record "Purchase Header";
                    //RequestFromType: Record "Request Form Types";
                    begin

                        IF CONFIRM('If you change the imprest no. the current lines will be deleted. Do you want to continue?') = false THEN exit;

                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");

                        IF PurchLine.FIND('-') THEN begin
                            PurchLine.DELETEALL;
                        end;

                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."Applies To Document No");
                        if PurchaseHeader.FindFirst() then begin
                            PurchaseHeader.CalcFields("Function Name", "Activity Discription", "Budget Center Name");
                            Rec."Payee Naration" := PurchaseHeader."Payee Naration";
                            Rec."Shortcut Dimension 1 Code" := PurchaseHeader."Shortcut Dimension 1 Code";
                            Rec."Due Date" := PurchaseHeader."Due Date";
                            Rec.fromDate := PurchaseHeader.fromDate;
                            Rec."Currency Factor" := PurchaseHeader."Currency Factor";
                            Rec."Currency Code" := PurchaseHeader."Currency Code";
                            Rec."Imprest Issue Date" := PurchaseHeader."Document Date";
                            Rec."Shortcut Dimension 1 Code" := PurchaseHeader."Shortcut Dimension 1 Code";
                            Rec."Shortcut Dimension 2 Code" := PurchaseHeader."Shortcut Dimension 2 Code";
                            Rec."Shortcut Dimension 3 Code" := PurchaseHeader."Shortcut Dimension 3 Code";
                            Rec."Shortcut Dimension 4 Code" := PurchaseHeader."Shortcut Dimension 4 Code";
                            Rec."Activity Discription" := PurchaseHeader."Activity Discription";
                            Rec."Function Name" := PurchaseHeader."Function Name";
                            Rec."Budget Center Name" := PurchaseHeader."Budget Center Name";
                            Rec.Modify(true);


                        end;

                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."Applies To Document No");
                        if PurchaseHeader.FindFirst() then begin
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
                                    NewPurchaseline."Budget Speed key" := PurchaseLine."Budget Speed key";
                                    NewPurchaseline.Type := PurchaseLine.Type;
                                    NewPurchaseline."Claim Type" := PurchaseLine."Claim Type"::Customer;
                                    NewPurchaseline."Account No New" := PurchaseHeader."Employee Imprest Account No";
                                    NewPurchaseline."No." := PurchaseLine."No.";
                                    NewPurchaseline.Description := PurchaseLine.Description;
                                    NewPurchaseline."Description 2" := PurchaseLine."Description 2";
                                    NewPurchaseline."Description 3" := PurchaseLine."Description 3";
                                    NewPurchaseline.remarks := PurchaseLine.remarks;
                                    NewPurchaseline.Quantity := PurchaseLine.Quantity;
                                    //NewPurchaseline."Currency Code" := PurchaseLine."Currency Code";
                                    NewPurchaseline.Amount := PurchaseLine.Amount;
                                    NewPurchaseline."Unit Cost (LCY)" := PurchaseLine."Unit Cost (LCY)";
                                    NewPurchaseline."Net Amount" := PurchaseLine."Net Amount";
                                    NewPurchaseline."Unit Cost" := PurchaseLine."Unit Cost";
                                    NewPurchaseline."Direct Unit Cost" := PurchaseLine."Direct Unit Cost";
                                    //Message('%1-%2-%3-%4', NewPurchaseline."Direct Unit Cost", NewPurchaseline.Amount, NewPurchaseline."Unit Cost (LCY)");
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

                    end;

                }

                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code") { ShowMandatory = true; Editable = false; Enabled = false; }
                field("Activity Discription"; Rec."Activity Discription") { }
                field("Surrender Narration"; Rec."Surrender Narration") { }

                field("Total Amount Spent"; Rec."Total Amount Spent")
                {
                    ApplicationArea = basic;
                }
                field("Total Cash Refund"; Rec."Total Cash Refund") { ApplicationArea = basic; }
                field(Amount; Rec."Travel Total")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Total Imprest Amount ';
                }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = all; }
                field("Currency Factor"; Rec."Currency Factor") { ApplicationArea = all; }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Posted';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;

                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = basic;
                    Editable = false;
                }
            }
            part(Control9; "Imprest Accounting Lines")
            {
                SubPageLink = "Document No." = field("No.");
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
                    PromotedCategory = Category4;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader;
                        Commit;
                        Page.RunModal(Page::"Purchase Statistics", Rec);
                    end;
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
                    end;
                }
                action(Action1102601024)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category8;

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
                Visible = true;
                PromotedCategory = Category5;
                RunObject = Page Documents;
                RunPageLink = "Doc No." = field("No.");
            }
            action(Email)
            {
                ApplicationArea = all;
                Caption = 'Send Email';
                Image = Email;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Send an email to this customer.';

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
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category5;
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

            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post';
                Ellipsis = true;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    GetBatch: Record 232;
                begin
                    Rec.TestField(Completed, false);
                    if Confirm('Are you sure you want to post the accounting') then begin
                        //Rec.TestField(Status, Rec.Status::Released);
                        UserSetup.Reset();
                        UserSetup.SetRange(UserSetup."User ID", UserId);
                        if UserSetup.FindFirst() then begin
                            if UserSetup."Post Rights" = false then begin
                                Error('You are not allowed to Post payment vouchers');
                            end;
                        end;
                        GetBatch.Reset();
                        GetBatch.SetRange("Journal Template Name", 'GENERAL');
                        GetBatch.SetRange(Name, 'SURRENDER');
                        IF GetBatch.FindFirst() = false THEN begin
                            GetBatch.Init();
                            GetBatch."Journal Template Name" := 'GENERAL';
                            GetBatch.Name := 'SURRENDER';
                            GetBatch.Description := 'Surrender';
                            GetBatch.Insert(true);
                        end;
                        GenJnlLine2.Reset;
                        GenJnlLine2.SetRange("Journal Template Name", 'GENERAL');
                        GenJnlLine2.SetRange("Journal Batch Name", 'SURRENDER');
                        if GenJnlLine2.FindFirst() then
                            GenJnlLine2.Delete;


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
                                GenJnlLine."Posting Date" := Rec."Posting Date";

                                GenJnlLine."Document No." := Rec."No.";
                                GenJnlLine."External Document No." := Rec."Imprest No";
                                GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
                                GenJnlLine."Account No." := Rec."Account No";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine.Description := PurchLine6."Description 2";
                                GenJnlLine.Amount := -1 * PurchLine6."Amount Spent";
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                                GenJnlLine."Bal. Account No." := PurchLine6."No.";
                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");

                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                // GenJnlLine.Validate("Currency Code");

                                GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                // GenJnlLine.Validate("Currency Factor");
                                GenJnlLine."Bal. Gen. Posting Type" := GenJnlLine."Bal. Gen. Posting Type"::Sale;

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
                                GenJnlLine."Posting Date" := Rec."Posting Date";
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

                                GenJnlLine."Currency Code" := PurchLine6."Currency Code";
                                //  GenJnlLine.Validate("Currency Code");
                                GenJnlLine."Currency Factor" := PurchLine6."Currency Factor";
                                // GenJnlLine.Validate("Currency Factor");
                                GenJnlLine."Bal. Gen. Posting Type" := GenJnlLine."Bal. Gen. Posting Type"::Sale;

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
                        Rec.Posted := true;
                        Rec.Modify(true);
                        CurrPage.Close();

                        Message('Accounting transferred to journals');
                        exit;



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
                            PurchaseHeader2.Modify;
                        end;
                        Rec.Posted := true;
                        Rec.Modify(true);
                        CurrPage.Close();


                        GenJnlLine2.Reset;
                        GenJnlLine2.SetRange("Journal Template Name", 'GENERAL');
                        GenJnlLine2.SetRange("Journal Batch Name", 'SURRENDER');
                        if GenJnlLine2.FindFirst then
                            GenJnlLine2.DeleteAll;

                        Message('Accounting posted Successfully');
                    end;

                end;
            }
            action("Attachments Portal")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                Visible = true;
                PromotedCategory = Category5;
                RunObject = page "Portal Uploads";
                RunPageLink = "Document No" = field("No.");
            }
            action("Make &Order")
            {
                ApplicationArea = Basic;
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                    // CODEUNIT.RUN(CODEUNIT::"Purch.-Quote to Order (Yes/No)",Rec);
                end;
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
                    Report.Run(80052, true, true, Rec);
                    //Reset;
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                begin
                    //WorkflowsEntriesBuffer.RunWorkflowEntriesPage(Rec.RecordId, Database::"Purchase Header", Rec."Document Type", Rec."No.");
                end;
            }
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator(Action1102601013)
                {
                }
                action("Re&lease")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

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
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;

                    PromotedIsBig = true;
                    PromotedOnly = true;

                    PromotedCategory = Category8;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category8;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        PayablesSetup: Record "Purchases & Payables Setup";
        Pheader: Record "Purchase Header";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        HREmp: Record "HR Employees";
        usersetup3: Record "User Setup";
        Customer: Record Customer;
    begin
        PayablesSetup.Get();
        Rec."AU Form Type" := Rec."au form type"::"Imprest Accounting";
        Rec."Document Type" := Rec."Document Type"::Quote;
        PurchasesPayablesSetup.Get;
        //Rec."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Surrender Nos.", Today, true);
        //Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec."Assigned User ID" := UserId;
        Rec."User ID" := UserId;
        Rec."Requested Receipt Date" := Today;
        Rec."Buy-from Vendor No." := PayablesSetup."Default Vendor";
        Rec."Vendor Posting Group" := PayablesSetup."Vendor Posting Group";
        HREmployees.Reset();
        HREmp.Reset();
        HREmp.SetRange(HREmp."Employee UserID", UserId);
        if HREmp.Find('-') then begin
            Rec."Account No" := HREmp.Travelaccountno;
            Rec."Employee No" := HREmp."No.";
            Rec.Department := HREmp."Programme or Department";
            Rec."Responsibility Center" := HREmp."Responsibility Center";
            rec."Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            Customer.Reset();
            Customer.SetRange("No.", Rec."Account No");
            if Customer.Find('-') then begin
                //Rec."Employee Name" := Customer.Name;
                Customer.CalcFields("Balance (LCY)");
                Rec.CustomerBalance := Customer."Balance (LCY)";

            end;
        end;

        //Rec."Employee Name" := UserId;




    end;

    trigger OnOpenPage()

    var
        HREmp: Record "HR Employees";
        Customer: Record Customer;
    begin

        // Rec."Assigned User ID" := UserId;
        HREmp.Reset();
        HREmp.SetRange(HREmp."Employee UserID", UserId);
        if HREmp.Find('-') then begin
            Rec."Account No" := HREmp.Travelaccountno;
            Rec."Employee No" := HREmp."No.";
            Rec.Department := HREmp."Programme or Department";
            Rec."Responsibility Center" := HREmp."Responsibility Center";
            rec."Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            Customer.Reset();
            Customer.SetRange("No.", Rec."Account No");
            if Customer.Find('-') then begin
                //Rec."Employee Name" := Customer.Name;
                Customer.CalcFields("Balance (LCY)");
                Rec.CustomerBalance := Customer."Balance (LCY)";
                //Rec.Modify(true);
            end;
        end;
    end;

    //SetSecurityFilterOnRespCenter;

    /*HREmp.RESET;
    HREmp.SETRANGE(HREmp."User ID",USERID);
    IF HREmp.GET THEN
    SETRANGE("User ID",HREmp."User ID")
    ELSE
    //user id may not be the creator of the doc
    SETRANGE("Assigned User ID",USERID);*/
    /*FILTERGROUP(10);
    SETRANGE("User ID",USERID);
    */

    //end;

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


    procedure LinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
        /*IF BCSetup.GET() THEN  BEGIN
           IF NOT BCSetup.Mandatory THEN BEGIN
              Exists:=FALSE;
              EXIT;
           END;
        END ELSE BEGIN
              Exists:=FALSE;
              EXIT;
        END;
       IF BCSetup.GET THEN BEGIN
        Exists:=FALSE;
        PurchLines.RESET;
        PurchLines.SETRANGE(PurchLines."Document Type","Document Type");
        PurchLines.SETRANGE(PurchLines."Document No.","No.");
        PurchLines.SETRANGE(PurchLines.Committed,FALSE);
         IF PurchLines.FIND('-') THEN
            Exists:=TRUE;
       END ELSE
           Exists:=FALSE;*/

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        PayablesSetup: Record "Purchases & Payables Setup";
        Pheader: Record "Purchase Header";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        HREmp: Record "HR Employees";
        usersetup3: Record "User Setup";
        Customer: Record Customer;
    begin
        PayablesSetup.Get();
        Rec."AU Form Type" := Rec."au form type"::"Imprest Accounting";
        Rec."Document Type" := Rec."Document Type"::Quote;
        PurchasesPayablesSetup.Get;
        Rec."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Surrender Nos.", Today, true);
        //Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec."Assigned User ID" := UserId;
        Rec."User ID" := UserId;
        Rec."Requested Receipt Date" := Today;
        Rec."Buy-from Vendor No." := PayablesSetup."Default Vendor";
        Rec."Vendor Posting Group" := PayablesSetup."Vendor Posting Group";
        HREmployees.Reset();
        HREmp.Reset();
        HREmp.SetRange(HREmp."Employee UserID", UserId);
        if HREmp.Find('-') then begin
            Rec."Account No" := HREmp.Travelaccountno;
            Rec."Employee No" := HREmp."No.";
            Rec.Department := HREmp."Programme or Department";
            Rec."Responsibility Center" := HREmp."Responsibility Center";
            rec."Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            Customer.Reset();
            Customer.SetRange("No.", Rec."Account No");
            if Customer.Find('-') then begin
                //Rec."Employee Name" := Customer.Name;
                Customer.CalcFields("Balance (LCY)");
                Rec.CustomerBalance := Customer."Balance (LCY)";

            end;
        end;

        //Rec."Employee Name" := UserId;




    end;

    procedure UpdateEmployee()
    var
        usersetup3: Record "User Setup";
        Customer: Record Customer;
    begin


        Customer.Reset();
        Customer.SetRange("No.", Rec."Account No");
        if Customer.Find('-') then begin
            Rec."Employee Name" := Customer.Name;
            Customer.CalcFields("Balance (LCY)");
            Rec.CustomerBalance := Customer."Balance (LCY)";
            Rec.Modify(true);
        end;

    end;
}

