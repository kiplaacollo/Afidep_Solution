Page 50049 "Imprest Requisition"
{
    Caption = 'Imprest Requisition';
    Editable = true;
    PageType = Card;
    SourceTable = "Purchase Header";
    PromotedActionCategories = 'New,Process,Report,Approval,Attachments,Raise PV';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        HREmp.Reset();
                        HREmp.SetRange(HREmp."Employee UserID", UserId);
                        if HREmp.FindFirst() then begin
                            Rec."Account No" := HREmp.Travelaccountno;
                            Customer.SetRange("No.", Rec."Account No");
                            if Customer.Find('-') then begin
                                Customer.CalcFields("Balance (LCY)");
                                Rec.CustomerBalance := Customer."Balance (LCY)";
                                Rec."Responsibility Center" := HREmp."Responsibility Center";
                                rec."Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";

                            end;



                            Customer.Reset();
                            Customer.SetRange("No.", Rec."Account No");
                            if Customer.Find('-') then begin
                                Rec."Employee Name" := Customer.Name;
                                Customer.CalcFields("Balance (LCY)");
                                Rec.CustomerBalance := Customer."Balance (LCY)";
                            end;


                        end;
                    end;


                }

                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Employee Imprest Account No"; Rec."Employee Imprest Account No")
                {
                    Enabled = false;
                }
                field(CustomerBalance; Rec.CustomerBalance)
                {
                    ApplicationArea = basic;
                }
                field("Expense Requisition No"; Rec."Expense Requisition No")
                {
                    ApplicationArea = basic;
                    Visible = false;
                    trigger OnValidate()
                    var
                        PurchaseLine: Record "Purchase Line";
                        NewPurchaseline: Record "Purchase Line";
                        PurchaseHeader: Record "Purchase Header";
                        NewHeader: Record "Purchase Header";
                    //RequestFromType: Record "Request Form Types";
                    begin

                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."Expense Requisition No");
                        if PurchaseHeader.FindFirst() then begin
                            Rec."Payee Naration" := PurchaseHeader."Payee Naration";
                            Rec."Shortcut Dimension 1 Code" := PurchaseHeader."Shortcut Dimension 1 Code";
                            Rec."Shortcut Dimension 4 Code" := PurchaseHeader."Shortcut Dimension 4 Code";
                            Rec."Posting Date" := PurchaseHeader."Posting Date";
                            Rec."Currency Factor" := PurchaseHeader."Currency Factor";
                            Rec."Currency Code" := PurchaseHeader."Currency Code";
                            Rec.Modify(true);


                        end;
                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."Expense Requisition No");
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
                                    //NewPurchaseline."Budget Speed key":=PurchaseLine."Budget Speed key";
                                    NewPurchaseline.Type := PurchaseLine.Type;
                                    NewPurchaseline."No." := PurchaseLine."No.";
                                    NewPurchaseline.Quantity := PurchaseLine.Quantity;
                                    NewPurchaseline."Currency Code" := PurchaseLine."Currency Code";
                                    NewPurchaseline."Budget Line description" := PurchaseLine."Budget Line description";
                                    NewPurchaseline.Description := PurchaseLine.Description;
                                    NewPurchaseline."Description 2" := PurchaseLine."Description 2";
                                    NewPurchaseline."Description 3" := PurchaseLine."Description 3";
                                    NewPurchaseline.remarks := PurchaseLine.remarks;
                                    NewPurchaseline."Budget Amount" := PurchaseLine."Budget Amount";
                                    NewPurchaseline."Committed Amount" := PurchaseLine."Committed Amount";
                                    NewPurchaseline."Budget Balance" := PurchaseLine."Budget Balance";
                                    NewPurchaseline."Remaining Budget Amount" := PurchaseLine."Remaining Budget Amount";
                                    NewPurchaseline.Quantity := PurchaseLine.Quantity;
                                    //NewPurchaseline."Currency Code" := PurchaseLine."Currency Code";
                                    NewPurchaseline.Amount := PurchaseLine.Amount;
                                    NewPurchaseline."Amount New" := PurchaseLine."Amount New";
                                    NewPurchaseline."Unit Cost (LCY) New" := PurchaseLine."Unit Cost (LCY) New";
                                    NewPurchaseline."Net Amount" := PurchaseLine."Net Amount";
                                    NewPurchaseline."Unit Cost" := PurchaseLine."Unit Cost";
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

                    end;

                }

                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Basic;

                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = Basic;
                    Caption = 'Purpose';
                }
                field("Payee Naration"; Rec."Payee Naration")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payee Naration';
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'Requestor ID';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var

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
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Activity Discription");
                    end;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic;

                }

                field("Activity Discription"; Rec."Activity Discription")
                {
                    Enabled = false;
                    MultiLine = true;
                    Caption = 'Deliverables / Activity';


                }

                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code") { }
                field(Department; Rec.Department) { Editable = false; Visible = false; }


                field(Amount; Rec."Travel Total")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Total Imprest Amount (USD)';
                }
                field("Net Amount in foreign Currency"; Rec."Net Amount in foreign Currency")
                {
                    Caption = 'Amount in foreign Currency';

                }



                field("Responsibility Center"; Rec."Responsibility Center") { ApplicationArea = all; Editable = false; Caption = 'Reporing To'; Visible = false; }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }

                field("Document Type"; Rec."Document Type") { ApplicationArea = all; Visible = false; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = all; Editable = false; }
                field("Invoice Received Date"; Rec."Invoice Received Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Activity Start Date';
                    ShowMandatory = true;
                }
                field("Due Date"; Rec."Due Date") { ApplicationArea = all; Caption = 'Activity End Date'; }



                field("Paying Account No"; Rec."Paying Account No")
                {
                    Caption = 'Paying Account No(Finance)';
                    ApplicationArea = Basic;
                    //Visible = false;
                    trigger OnValidate()
                    var
                        Banks: Record "Bank Account";
                        PurchaseLine43: Record "Purchase Line";
                    begin
                        Banks.Reset();
                        Banks.SetRange(Banks."No.", Rec."Paying Account No");
                        IF Banks.Find('-') THEN begin
                            Rec."Currency Code" := Banks."Currency Code";

                        end;
                    end;
                }
                field("Paying Account Name"; Rec."Paying Account Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    //Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                    Enabled = true;
                    Caption = 'Currency Code';

                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = all;
                    Enabled = true;
                    Editable = true;
                }
                field("AU Form Type"; Rec."AU Form Type") { Editable = false; }


                field(Posted; Rec.Posted) { ApplicationArea = all; Enabled = false; Visible = false; }

            }
            part(Control9; "Imprest Requisition Lines")
            {
                SubPageLink = "Document No." = field("No.");
            }

            part(Control10; "Travel Accomodation Details")
            {
                SubPageLink = "Document No." = field("No.");
                Visible = false;
            }
            part(Control11; "Travel Meals Details")
            {
                SubPageLink = "Document No." = field("No.");
                Visible = false;
            }
            part(Control12; "Travel Other Details")
            {
                SubPageLink = "Document No." = field("No.");
                Visible = false;
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

                action(CreatePv)
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Payment Voucher';
                    Image = MakeOrder;
                    Ellipsis = true;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    //
                    trigger OnAction()
                    var
                        PVNO: Code[20];
                    begin
                        Rec.TestField("Paying Account No");
                        Rec.TestField(Rec.Status, Rec.Status::Released);
                        PurchasesPayablesSetup.Get();
                        if Confirm('Are you sure you want to generate payment voucher?') = false then exit;
                        if Rec.Posted = true then Error('The record is already posted');
                        PurchaseHeader.Init();
                        PurchaseHeader."Paying Account No" := Rec."Paying Account No";
                        PurchaseHeader.Validate("Paying Account No");
                        BankAccount.GET(rec."Paying Account No");
                        PurchaseHeader."No." := NoSeriesManagement.GetNextNo(BankAccount."Transaction No Series", TODAY, TRUE);
                        // PurchaseHeader."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Payment Vouchers Form", Today, true);
                        PVNO := PurchaseHeader."No.";
                        PurchaseHeader.PV := true;
                        PurchaseHeader.Validate("No.");
                        PurchaseHeader."AU Form Type" := PurchaseHeader."AU Form Type"::"Payment Voucher";
                        PurchaseHeader."Paying Account Name" := Rec."Paying Account Name";
                        PurchaseHeader."Buy-from Vendor No." := Rec."Buy-from Vendor No.";
                        PurchaseHeader."Vendor Posting Group" := Rec."Vendor Posting Group";

                        PurchaseHeader."Currency Code" := Rec."Currency Code";
                        PurchaseHeader.Validate("Currency Code");
                        PurchaseHeader."Currency Factor" := Rec."Currency Factor";
                        PurchaseHeader.Validate("Currency Factor");
                        PurchaseHeader."User ID" := UserId;

                        PurchaseHeader."Payee Naration" := Rec."Employee Name";
                        PurchaseHeader."Payment Naration" := Rec.Purpose;
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
                                PurchLine.Reset();
                                PurchLine.SetRange("Document No.", PVNO);
                                if PurchLine.FindLast() then begin
                                    PurchLine."Line No." := PurchLine."Line No." + 1;
                                end else begin
                                    PurchLine."Line No." := 1;
                                end;
                                PurchLine."Claim Type" := PurchaseLine3."Claim Type"::Customer;
                                PurchLine."Account Type" := PurchLine."Account Type"::Customer;
                                PurchLine."Account No." := PurchaseLine3."No.";
                                PurchLine."Direct Unit Cost" := PurchaseLine3."Amount New";
                                PurchLine.Validate(Amount);
                                PurchLine.Validate("Claim Type");
                                PurchLine."Account No New" := Rec."Employee Imprest Account No";
                                PurchLine.Validate("Account No New");
                                PurchLine."VAT Prod. Posting Group" := PurchaseLine3."VAT Prod. Posting Group";
                                PurchLine.Validate("VAT Prod. Posting Group");
                                PurchLine."VAT Identifier" := '0';
                                PurchLine."Line Discount %" := PurchaseLine3."Line Discount %";
                                PurchLine.Validate("Line Discount %");
                                PurchLine."Description 2" := PurchaseLine3."Description 2";
                                PurchLine.Quantity := PurchaseLine3.Quantity;
                                // PurchLine.Validate(Quantity);
                                PurchLine."Currency Code" := Rec."Currency Code";
                                PurchLine.Validate("Currency Code");
                                PurchLine."Currency Factor" := Rec."Currency Factor";
                                PurchLine.Validate("Currency Factor");
                                PurchLine."Direct Unit Cost" := PurchaseLine3."Direct Unit Cost";
                                //PurchLine.Validate(PurchLine."Direct Unit Cost");
                                PurchLine."Amount New" := PurchaseLine3."Amount New";
                                //PurchLine.Validate(Amount);
                                PurchLine."Shortcut Dimension 1 Code" := PurchaseLine3."Shortcut Dimension 1 Code";
                                //  PurchLine.Validate("Shortcut Dimension 1 Code");
                                PurchLine."Shortcut Dimension 2 Code" := PurchaseLine3."Shortcut Dimension 2 Code";
                                // PurchLine.Validate("Shortcut Dimension 2 Code");
                                PurchLine."ShortcutDimCode[3]" := PurchaseLine3."ShortcutDimCode[3]";
                                // PurchLine.Validate("ShortcutDimCode[3]");
                                PurchLine."ShortcutDimCode[4]" := PurchaseLine3."ShortcutDimCode[4]";
                                // PurchLine.Validate("ShortcutDimCode[4]");
                                PurchLine.Insert(true);
                            until PurchaseLine3.Next() = 0;
                            Rec.Completed := true;
                            Rec.Posted := true;
                            Rec.Modify();

                        end;
                        Message('Payment voucher ' + PVNO + ' has been created successfully.');
                    end;
                }
                action(Action1102601024)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(Database::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                action(ApproveAutomatically)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approver edit Record';
                    Image = UpdateDescription;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
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
                action(ApproveAutomaticall)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'PushtoApproved';
                    Image = UpdateDescription;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Category4;
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


            }

        }
        area(processing)
        {
            action(Attachments)
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Visible = false;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = Page Documents;
                RunPageLink = "Doc No." = field("No.");
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
            action("&Print")
            {
                ApplicationArea = Basic;
                Caption = '&Print';
                //Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin


                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(80055, true, true, Rec);

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


            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                //PromotedCategory = Category4;
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

            action("Cancel Approval Re&quest")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                PromotedCategory = Category4;
                Promoted = true;


                trigger OnAction()
                var
                    ReleasePurchDoc: Codeunit "Release Purchase Document";
                begin
                    ReleasePurchDoc.PerformManualReopen(Rec);
                end;

            }
            action("Re&open1")
            {
                ApplicationArea = Basic;
                Caption = 'Re&open';
                Image = ReOpen;
                Visible = false;

                // trigger OnAction()
                // var
                //     ReleasePurchDoc: Codeunit "Release Purchase Document";
                // begin
                //     ReleasePurchDoc.PerformManualReopen(Rec);
                // end;
            }
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
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
                Visible = false;
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
                action("Send A&pproval Request2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Category4;


                    trigger OnAction()
                    begin
                        ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }

            }
        }
    }
    trigger OnOpenPage()
    begin
        if Rec."Currency Code" = '' then
            Rec."Currency Factor" := 1;
        Rec.Modify(true);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        PayablesSetup: Record "Purchases & Payables Setup";
        Pheader: Record "Purchase Header";
    begin
        PayablesSetup.Get();
        Rec."AU Form Type" := Rec."AU Form Type"::"Imprest Requisition";
        PurchasesPayablesSetup.Get;
        //Rec."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Payment Vouchers Form", Today, true);
        //Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec."Assigned User ID" := UserId;
        Rec."User ID" := UserId;
        Rec."Requested Receipt Date" := Today;
        Rec."Posting Description" := format(Rec."AU Form Type"::"Imprest Requisition");

        Rec."Buy-from Vendor No." := PayablesSetup."Default Vendor";


        exit(true);


    end;


    var
        usersetup3: Record "User Setup";

        DimMgt: Codeunit DimensionManagement;
        DocPrint: Codeunit "Document-Print";
        HREmp: Record "HR Employees";
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
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
        BankAccount: Record "Bank Account";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        GenJnlLine: Record "Gen. Journal Line";
        Amt: Decimal;
        PurchaseHeader2: Record "Purchase Header";
        Customer: Record Customer;
        GenJnlLine2: Record "Gen. Journal Line";


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        PayablesSetup: Record "Purchases & Payables Setup";
        Pheader: Record "Purchase Header";
    begin
        PayablesSetup.Get();
        Rec."AU Form Type" := Rec."AU Form Type"::"Imprest Requisition";
        PurchasesPayablesSetup.Get;
        Rec."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Imprest Nos.", Today, true);
        //Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec."Assigned User ID" := UserId;
        Rec."User ID" := UserId;
        Rec."Requested Receipt Date" := Today;

        Rec."Buy-from Vendor No." := PayablesSetup."Default Vendor";
        Rec."Vendor Posting Group" := PayablesSetup."Vendor Posting Group";


        HREmp.Reset();
        HREmp.SetRange(HREmp."Employee UserID", UserId);
        if HREmp.Find('-') then begin
            Rec."Account No" := HREmp.Travelaccountno;
            Rec."Employee No" := HREmp."No.";
            Rec."Responsibility Center" := HREmp."Responsibility Center";
            Rec.Department := HREmp."Programme or Department";
            rec."Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            Rec."Employee Imprest Account No" := HREmp.Travelaccountno;
            Customer.Reset();
            Customer.SetRange("No.", Rec."Account No");
            if Customer.Find('-') then begin
                //Rec."Employee Name" := Customer.Name;
                Customer.CalcFields("Balance (LCY)");
                Rec.CustomerBalance := Customer."Balance (LCY)";
            end;
        end;

        //"Document Type":="Document Type"::Quote;
        UpdateControls;

    end;

    trigger OnModifyRecord(): Boolean
    begin

        HREmp.Reset();

        HREmp.SetRange(HREmp."Employee UserID", UserId);
        if HREmp.Find('-') then begin
            Rec."Account No" := HREmp.Travelaccountno;
            Customer.Reset();
            Customer.SetRange("No.", HREmp.Travelaccountno);
            if Customer.Find('-') then begin
                Rec."Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                ;
                Customer.CalcFields("Balance (LCY)");
                Rec.CustomerBalance := Customer."Balance (LCY)";
                Rec.Modify(true);
            end;
        end;

    end;

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

