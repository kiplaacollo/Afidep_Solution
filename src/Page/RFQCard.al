page 80115 "Request For Quotes card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Purchase Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Enabled = false;

                }


                field("Purcahse Requisition No"; Rec."Purcahse Requisition No")
                {
                    ApplicationArea = ALL;
                    trigger OnValidate()
                    var
                        PurchaseLine: Record "Purchase Line";
                        NewPurchaseline: Record "Purchase Line";
                        PurchaseHeader: Record "Purchase Header";
                        NewHeader: Record "Purchase Header";
                    //RequestFromType: Record "Request Form Types";
                    begin

                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."Purcahse Requisition No");
                        if PurchaseHeader.FindFirst() then begin

                            Rec."Currency Factor" := PurchaseHeader."Currency Factor";
                            Rec."Currency Code" := PurchaseHeader."Currency Code";
                            Rec."Payee Naration" := PurchaseHeader."Payee Naration";
                            Rec.Modify(true);


                        end;
                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."Purcahse Requisition No");
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
                                    NewPurchaseline.Type := PurchaseLine.Type;
                                    NewPurchaseline."No." := PurchaseLine."No.";
                                    //NewPurchaseline."Document No.":=Rec."No.";
                                    //NewPurchaseline."Type of Request" := PurchaseLine."Type of Request";
                                    NewPurchaseline.Description := PurchaseLine.Description;
                                    NewPurchaseline."Description 2" := PurchaseLine."Description 2";
                                    NewPurchaseline."Description 3" := PurchaseLine."Description 3";
                                    NewPurchaseline.remarks := PurchaseLine.remarks;
                                    NewPurchaseline.Quantity := PurchaseLine.Quantity;
                                    NewPurchaseline."Currency Code" := PurchaseLine."Currency Code";
                                    //NewPurchaseline.Amount := PurchaseLine.Amount;
                                    NewPurchaseline.Insert(true);
                                until PurchaseLine.Next() = 0;
                            end;
                        end;

                    end;
                }
                field("Payee Naration"; Rec."Payee Naration") { ApplicationArea = all; Visible = true; Caption = 'Memo'; }
                //field("Responsibility Center"; Rec."Responsibility Center") { ApplicationArea = all; Enabled = false; Caption = 'Department'; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = all; Visible = true; }
                field("Currency Factor"; Rec."Currency Factor") { ApplicationArea = ALL; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = all; Caption = 'Date'; Visible = false; }
                field(fromDate; Rec.fromDate) { ApplicationArea = all; Caption = 'Tender Openning Date'; }
                field("Due Date"; Rec."Due Date") { ApplicationArea = all; Caption = 'Tender Clossing Date'; }
                field("Assigned User ID"; Rec."Assigned User ID") { ApplicationArea = all; Caption = 'Captured By'; Editable = false; }
                field("AU Form Type"; Rec."AU Form Type") { ApplicationArea = all; Visible = false; }
                field(Status; Rec.Status) { ApplicationArea = all; }
                field("Document Type"; Rec."Document Type") { ApplicationArea = ALL; Visible = false; }


            }
            // part(RequestFormLines; "Request Form Lines")
            // {
            //     Caption = 'Request Form Lines';
            //     SubPageLink = "Document No." = field("No.");
            //     Visible = false;
            // }
            part(RFQLines; "RFQ Lines")
            {
                SubPageLink = "Document No." = field("No.");
                Caption = 'RFQ  Lines';
                Visible = false;
            }

            part(rfq; "RFQ Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }

            part("Mandatory requirements"; 17413)
            {
                SubPageLink = "Tendor No" = FIELD("No.");
            }

            // field(Observations; Rec.Observations)
            // {
            // }
            // field(Recommendations; Rec.Recommendations)
            // {
            // }

        }
    }

    actions
    {
        area(Processing)
        {
            group(Approvals)
            {
                Caption = 'Approvals';
                // Visible = false;
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }

                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        ApprovalMgt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
                action("Attachment Document")
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page Documents;
                    RunPageLink = "Doc No." = field("No.");
                }
                action("RFQ Vendors")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "RFQ Vendors";
                    RunPageLink = No = field("No.");
                }

                action("Bid Analysis Committee")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bid Analysis Committee";
                    RunPageLink = No = field("No.");
                }
                action("Bid Analysis Comment")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bid Analysis Comment";
                    RunPageLink = No = field("No.");
                }
                action(Email)
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Send Email';
                    Image = Email;
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
                action("&Print")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin


                        Rec.Reset;
                        Rec.SetRange("No.", Rec."No.");
                        Report.Run(50000, true, true, Rec);

                    end;
                }
            }
            group(Group)
            {
                action("Assign Vendor(s)")
                {
                    Caption = 'Assign Vendor(s)';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Vends: Record "170165";
                    begin

                        Vends.RESET;
                        Vends.SETRANGE(Vends."Document Type", Rec."Document Type");
                        Vends.SETRANGE(Vends."Requisition Document No.", Rec."No.");

                        PAGE.RUN(PAGE::"Quotation Request Vendors", Vends);
                    end;
                }

                action("Evaluation Committee")
                {
                    Caption = 'Evaluation Committee';
                    Image = Company;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()

                    var
                        TenderOpeningCommittee: Record "Tender Committee";

                    begin
                        TenderOpeningCommittee.SETRANGE("Tender No", Rec."No.");
                        PAGE.RUN(PAGE::tender, TenderOpeningCommittee);
                    end;
                }

                action(Quotations)
                {
                    Caption = 'Quotations';
                    Image = ViewOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Quotation Evaluation";
                    RunPageLink = "Requisition Document No." = FIELD("No.");

                    trigger OnAction()
                    var
                        Vends: Record "170165";
                    begin
                        BiddersMandatoryrequirements.RESET;
                        BiddersMandatoryrequirements.SETRANGE("Tendor No", Rec."No.");
                        IF NOT BiddersMandatoryrequirements.FINDFIRST THEN BEGIN
                            TenderMandatoryRequirements.RESET;
                            TenderMandatoryRequirements.SETRANGE("Tendor No", Rec."No.");
                            IF TenderMandatoryRequirements.FINDSET THEN BEGIN
                                REPEAT
                                    QuotationRequestVendors5.RESET;
                                    QuotationRequestVendors5.SETRANGE("Requisition Document No.", Rec."No.");
                                    IF QuotationRequestVendors5.FINDSET THEN BEGIN
                                        REPEAT
                                            BiddersMandatoryrequirements.INIT;
                                            BiddersMandatoryrequirements."Tendor No" := TenderMandatoryRequirements."Tendor No";
                                            BiddersMandatoryrequirements.Code := TenderMandatoryRequirements.Code;
                                            BiddersMandatoryrequirements.Requirement := TenderMandatoryRequirements.Requirement;
                                            BiddersMandatoryrequirements."Vendor No" := QuotationRequestVendors5."Vendor No.";
                                            BiddersMandatoryrequirements.INSERT;
                                            COMMIT;
                                        UNTIL QuotationRequestVendors5.NEXT = 0;
                                    END;
                                UNTIL TenderMandatoryRequirements.NEXT = 0;
                            END;
                        END;
                    end;
                }
                action("Bid Analysis")
                {
                    Caption = 'Bid Analysis';
                    Image = Worksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "38";
                        PurchaseLines: Record "39";
                        ItemNoFilter: Text[250];
                        RFQNoFilter: Text[250];
                        InsertCount: Integer;
                    begin
                        PQH.RESET;
                        PQH.SETRANGE("No.", Rec."No.");
                        IF PQH.FINDFIRST THEN BEGIN

                            REPORT.RUN(REPORT::"Quotations Bidders List", TRUE, TRUE, PQH);

                        END;
                    end;
                }

                action("Send email")
                {
                    Caption = 'Send email to vendors';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;

                    trigger OnAction()
                    var
                        vendors: Record "Quotation Request Vendors";
                        email: Codeunit Email;
                        emailMessage: Codeunit "Email Message";
                        Lines: Record "Purchase Quote Line";
                    begin
                        vendors.reset;
                        vendors.SetRange(vendors."Requisition Document No.", Rec."No.");
                        vendors.SetRange(vendors."Document Type", Rec."Document Type");
                        if vendors.Find('-') then begin
                            repeat
                                emailMessage.Create(vendors.Email, 'Request for quotation', 'Dear ' + vendors."Vendor Name" + ' Please provide quotation for the following items: ');
                                Lines.reset;
                                Lines.SetRange("Document No.", rec."No.");
                                if Lines.Find('-') then begin
                                    repeat
                                        emailMessage.AppendToBody('<br><br>');
                                        emailMessage.AppendToBody(FORMAT(Lines.Quantity) + '-' + Lines."Unit of Measure" + '-' + Lines.Description + '-' + Lines."Description 2");
                                        emailMessage.AppendToBody('<br><br>');
                                        emailMessage.AppendToBody('Closing Date ');// + FORMAT(Rec."Expected Closing Date"));
                                    until Lines.Next = 0;
                                end;


                                TenderMandatoryRequirements.RESET;
                                TenderMandatoryRequirements.SETRANGE(TenderMandatoryRequirements."Tendor No", Rec."No.");
                                IF TenderMandatoryRequirements.FINDSET THEN BEGIN
                                    REPEAT
                                        emailMessage.AppendToBody('<br><br>');
                                        emailMessage.AppendToBody(FORMAT(TenderMandatoryRequirements.Code) + '-' + TenderMandatoryRequirements.Requirement);
                                    UNTIL TenderMandatoryRequirements.NEXT = 0;
                                END;

                                emailMessage.AppendToBody('<br><br>');
                                emailMessage.AppendToBody('Regards');
                                emailMessage.AppendToBody('<br>');
                                emailMessage.AppendToBody('______________________________________');
                                emailMessage.AppendToBody('<br>');
                                //SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                                //SMTPMail.AppendBody('<br><br>');
                                emailMessage.AppendToBody('<ERP System Alert>');
                                emailMessage.AppendToBody('<br>');
                                emailMessage.AppendToBody('Please Respond to this email.');
                                Email.Send(emailMessage, Enum::"Email Scenario"::Default);
                            until vendors.Next = 0;


                        end;
                    end;
                }
                action("Create LPO")
                {
                    Caption = 'Convert to LPO';
                    Image = VendorPayment;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;

                    trigger OnAction()
                    var
                        RFQLines: Record "Vendor Rfqs";
                        PurchaseHeader: Record "38";
                        PurchaseLines: Record "39";
                        Vends: Record "170165";
                        PurchaseLines6: Record "39";
                    begin
                        //TESTFIELD(Rec.Converted,FALSE);

                        IF CONFIRM('Are you sure you want to create the LPO ') THEN BEGIN

                            //TESTFIELD("Approval Status","Approval Status"::Approved);
                            Vends.SETRANGE(Vends."Requisition Document No.", Rec."No.");
                            Vends.SETRANGE(Selected, TRUE);
                            IF Vends.FINDSET THEN BEGIN
                                REPEAT
                                    //create header
                                    PurchaseHeader.INIT;
                                    PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
                                    //PurchaseHeader.DocApprovalType:=PurchaseHeader.DocApprovalType::Purchase;
                                    PurchasesPayablesSetup.GET();

                                    PurchaseHeader."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Order Nos.", TODAY, TRUE);
                                    PurchaseHeader."Responsibility Center" := Rec."Responsibility Center";
                                    PurchaseHeader."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                                    PurchaseHeader."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                    //PurchaseHeader.INSERT(TRUE);
                                    PurchaseHeader.VALIDATE("Buy-from Vendor No.", Vends."Vendor No.");
                                    PurchaseHeader.VALIDATE("Currency Code", Vends."Currency Code");
                                    PurchaseHeader."Responsibility Center" := Rec."Responsibility Center";

                                    PurchaseHeader."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                                    PurchaseHeader."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                    //PurchaseHeader.VALIDATE("RFQ No","No.");
                                    //PurchaseHeader.MODIFY;
                                    PurchaseHeader.INSERT(TRUE);

                                    //create lines

                                    RFQLines.SETRANGE(RFQLines."Document No.", Rec."No.");
                                    // RFQLines.SETRANGE(RFQLines."Vendor No",Vends."Vendor No.");
                                    //  RFQLines.SETRANGE(Selected,TRUE);
                                    IF RFQLines.FINDSET THEN
                                        REPEAT
                                            PurchaseLines.INIT;
                                            //PurchaseLines.TRANSFERFIELDS(RFQLines);
                                            //PurchaseLines.Type:=RFQLines.Type;
                                            //PurchaseLines."No.":=RFQLines."No.";
                                            PurchaseLines."Document Type" := PurchaseLines."Document Type"::Order;
                                            PurchaseLines."Document No." := PurchaseHeader."No.";
                                            // PurchaseLines
                                            PurchaseLines6.RESET;
                                            IF PurchaseLines6.FINDLAST THEN
                                                PurchaseLines."Line No." := PurchaseLines6."Line No." + 1;
                                            //PurchaseLines."Buy-from Vendor No.":=Vends."Vendor No.";
                                            PurchaseLines.Quantity := RFQLines."Quantity (Base)";
                                            PurchaseLines.VALIDATE("Currency Code", Vends."Currency Code");
                                            //PurchaseLines.VALIDATE(Description, RFQLines.Description);
                                            PurchaseLines.VALIDATE(Quantity, RFQLines."Quantity (Base)");
                                            PurchaseLines.VALIDATE("Direct Unit Cost", RFQLines."Direct Unit Cost");
                                            //PurchaseLines.VALIDATE("Line Amount",RFQLines."Direct Unit Cost"*RFQLines.Quantity);
                                            PurchaseLines.VALIDATE("Shortcut Dimension 1 Code", PurchaseLines."Shortcut Dimension 1 Code");
                                            PurchaseLines.VALIDATE("Shortcut Dimension 2 Code", PurchaseLines."Shortcut Dimension 2 Code");
                                            // PurchaseLines.VALIDATE("Dimension Speedkey Code",PurchaseLines."Dimension Speedkey Code");
                                            //PurchaseLines.VALIDATE("Direct Unit Cost",0);
                                            PurchaseLines.INSERT;

                                        /*
                                          ReqLines.VALIDATE(ReqLines."No.");
                                          ReqLines.VALIDATE(ReqLines.Quantity);
                                          ReqLines.VALIDATE(ReqLines."Direct Unit Cost");
                                          ReqLines.MODIFY;
                                        */
                                        UNTIL RFQLines.NEXT = 0;
                                UNTIL Vends.NEXT = 0;
                                MESSAGE('LPOs have been Generated Successfully');
                            END;
                            // Rec.Converted := TRUE;
                            Rec.MODIFY;

                        END;

                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        usersetup3: Record "User Setup";
        Customer: Record Customer;
    //PayablesSetup: Record payable
    begin
        Rec."AU Form Type" := Rec."AU Form Type"::RFQ;
        Rec."Assigned User ID" := UserId;
        //Rec."Type of Request" := Rec."Type of Request"::Cash;
        //Rec."Document Type" := Rec."Document Type"::"Request Form";
        Rec.Status := Rec.Status::Open;
        PurchasesPayablesSetup.Get();
        Rec."User ID" := UserId;

        Rec."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Landlord Nos", Today, true);
        Rec."Buy-from Vendor No." := PurchasesPayablesSetup."Default Vendor";
        Rec."Vendor Posting Group" := PurchasesPayablesSetup."Vendor Posting Group";
        usersetup3.Reset();
        usersetup3.SetRange("User ID", UserId);
        if usersetup3.Find('-') then begin
            Rec."Account No" := usersetup3.ImprestAccount;
            Rec."Responsibility Center" := usersetup3."Responsibility Center";
            Customer.Reset();
            Customer.SetRange("No.", usersetup3.ImprestAccount);
            if Customer.Find('-') then begin
                Rec."Employee Name" := Customer.Name;
            end;
        end;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange("User ID", UserId);
        if Rec.Status <> Rec.Status::Open then
            Editable := false;
    end;

    var
        myInt: Integer;
        PurchHeader: Record "38";
        PParams: Record "170166";
        Lines: Record "170161";
        PQH: Record "170160";
        Location: Record "14";
        PurchaseQuoteHeader: Record "170160";
        QuotationRequestVendors5: Record "170165";
        QuotationRequestVendors2: Record "170165";

        Email: Text;
        Vendor: Record "23";
        PurchaseQuoteHeader6: Record "170160";
        Filename: Text;
        Attachment: Text[250];
        QuotationRequestVendors6: Record "170165";
        Vend: Record "170165";
        Ok: Boolean;
        QuotationRequestVendors8: Record "170165";
        TenderMandatoryRequirements: Record "170173";
        BiddersMandatoryrequirements: Record "170174";
        ApprovalMgt: Codeunit "1535";
        PurchasesPayablesSetup: Record "312";
        NoSeriesManagement: Codeunit "396";
        Dearstatement: Text;

        TenderOpeningCommittee: Record "170178";
        PurchaseQuoteLine: Record "170161";

    procedure InsertRFQLines()
    var
        Counter: Integer;
        Collection: Record "39";
    begin
        /*CollectionList.LOOKUPMODE(TRUE);
        IF CollectionList.RUNMODAL = ACTION::LookupOK THEN BEGIN
          CollectionList.SetSelection(Collection);
          Counter := Collection.COUNT;
          IF Counter > 0 THEN BEGIN
            IF Collection.FINDSET THEN
              REPEAT
                Lines.INIT;
                Lines.TRANSFERFIELDS(Collection);
                Lines."Document Type":="Document Type";
                Lines."Document No.":="No.";
                Lines."Line No.":=0;
                Lines."PRF No":=Collection."Document No.";
                Lines."PRF Line No.":=Collection."Line No.";
                Lines.INSERT(TRUE);
                //Collection.Copied:=TRUE;
                //Collection.MODIFY;
             UNTIL Collection.NEXT = 0;
          END;
        END;
        */

    end;
}