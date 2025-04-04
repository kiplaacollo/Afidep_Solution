page 17391 "RFQ Header"
{
    PageType = Document;
    SourceTable = "Purchase Quote Header";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Purchase requisition"; rec."Requisition No")
                {

                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ShowMandatory = true;
                    // Editable = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Editable = true;
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Expected Opening Date"; Rec."Expected Opening Date")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        // "Expected Closing Date":=Rec."Expected Opening Date";
                        // MODIFY;
                    end;
                }
                field("Expected Closing Date"; Rec."Expected Closing Date")
                {

                    trigger OnValidate()
                    begin

                        //  "Expected Opening Date":="Expected Closing Date";
                        //  MODIFY;
                    end;
                }
                field("Expected Opening Time"; Rec."Expected Opening Time")
                {
                    Caption = 'Expected Closing Time';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = true;
                    Visible = false;
                }

                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = true;
                    Visible = true;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = true;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                field(Note; Rec.Note)
                {
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;
                    Enabled = false;
                    //  Visible = false;
                }
                field(ConvertedRec; Rec.Converted)
                {
                    Editable = false;
                }
                field("Procurement Email Address"; Rec."Procurement Email Address")
                {
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    Enabled = false;
                }

            }
            part(rfq; "RFQ Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }

            part("Mandatory requirements"; 17413)
            {
                SubPageLink = "Tendor No" = FIELD("No.");
            }

            field(Observations; Rec.Observations)
            {
            }
            field(Recommendations; Rec.Recommendations)
            {
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; Documents)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Doc No." = field("No.");
                // SubPageLink = "Table ID" = CONST(170160),
                //               "Document Type" = FIELD("Document Type"),
                //              "No." = FIELD("No.");
            }
            // part(IncomingDocAttachFactBox; 193)
            // {
            //     ApplicationArea = Basic, Suite;
            //     ShowFilter = false;
            // }

        }
    }

    actions
    {
        area(creation)
        {
        }
        area(processing)
        {
            group(Approval)
            {
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := DocumentType::" ";

                        ApprovalEntries.SetRecordFilters(Database::"Purchase Quote Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.Run;

                        ApprovalEntry.reset;


                    end;
                }

                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField("Approval Status", Rec."Approval Status"::New);
                        Rec.TestField(Amount);

                        varrvariant := Rec;

                        if CustomApprovalsCodeunit.CheckApprovalsWorkflowEnabled(varrvariant) then
                            CustomApprovalsCodeunit.OnSendDocForApproval(varrvariant);

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalMgt.CancelBatchAppr(Rec,TRUE,TRUE) THEN;
                        //varrvariant:=Rec;
                        //CustomApprovalsCodeunit.OnCancelDocApprovalRequest(varrvariant);
                        if Rec."Approval Status" = Rec."Approval Status"::"Pending Approval" then begin
                            ApprovalEntry.Reset;
                            ApprovalEntry.SetRange("Document No.", Rec."No.");
                            if ApprovalEntry.FindSet then begin
                                repeat
                                    ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                                    ApprovalEntry."Approver ID" := '';
                                    ApprovalEntry.Modify;
                                until ApprovalEntry.Next = 0;
                            end;
                            Rec."Approval Status" := Rec."Approval Status"::New;
                            Rec.Modify;
                        end;
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
                                        emailMessage.AppendToBody('Closing Date ' + FORMAT(Rec."Expected Closing Date"));
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
                        //RFQLines: Record "Vendor Rfqs";
                        RFQLines: Record "Purchase Quote Line";
                        PurchaseHeader: Record 38;
                        PurchaseLines: Record 39;
                        Vends: Record 170165;
                        PurchaseLines6: Record 39;
                    begin
                        //TESTFIELD(Rec.Converted,FALSE);
                        Rec.TESTFIELD(Rec."Approval Status", Rec."Approval Status"::Approved);

                        IF CONFIRM('Are you sure you want to create the LPO ') THEN BEGIN


                            Rec.TestField(Rec.Converted, false);
                            Vends.SETRANGE(Vends."Requisition Document No.", Rec."No.");
                            Vends.SETRANGE(Selected, TRUE);
                            IF Vends.FINDSET THEN BEGIN
                                REPEAT
                                    //create header
                                    PurchaseHeader.INIT;
                                    PurchaseHeader."Document Type" := Rec."Document Type"::Order;
                                    //PurchaseHeader.DocApprovalType:=PurchaseHeader.DocApprovalType::Purchase;
                                    PurchasesPayablesSetup.GET();

                                    PurchaseHeader."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Order Nos.", TODAY, TRUE);
                                    PurchaseHeader."Responsibility Center" := Rec."Responsibility Center";
                                    PurchaseHeader."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                                    PurchaseHeader."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                    PurchaseHeader."RFQ Amount" := Rec.Amount;
                                    PurchaseHeader."RFQ No." := Rec."No.";
                                    PurchaseHeader."PRF No." := Rec."Requisition No";
                                    //PurchaseHeader.INSERT(TRUE);
                                    PurchaseHeader.VALIDATE("Buy-from Vendor No.", Vends."Vendor No.");
                                    PurchaseHeader.VALIDATE("Currency Code", Vends."Currency Code");
                                    PurchaseHeader."Responsibility Center" := Rec."Responsibility Center";

                                    PurchaseHeader."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                                    PurchaseHeader."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                    PurchaseHeader."User ID" := UserId;

                                    HREmployee.Reset();
                                    HREmployee.SetRange(HREmployee."Employee UserID", UserId);
                                    IF HREmployee.FindFirst() then begin
                                        PurchaseHeader."Responsibility Center" := HREmployee."Responsibility Center";
                                        PurchaseHeader."Responsibility Center Name" := HREmployee."Responsibility Center Name";
                                        PurchaseHeader."Employee No" := HREmployee."No.";
                                        PurchaseHeader.Department := HREmployee."Programme or Department";
                                        PurchaseHeader."Employee Name" := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                                    end;
                                    //PurchaseHeader.VALIDATE("RFQ No","No.");
                                    //PurchaseHeader.MODIFY;
                                    //  Error('branch', PurchaseHeader."Shortcut Dimension 1 Code");
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
                                            PurchaseLines.Type := RFQLines.Type;

                                            //PurchaseLines."Buy-from Vendor No.":=Vends."Vendor No.";
                                            //PurchaseLines.Quantity := RFQLines."Quantity (Base)";
                                            PurchaseLines.Quantity := RFQLines.Quantity;
                                            PurchaseLines.VALIDATE("Currency Code", Vends."Currency Code");
                                            PurchaseLines.VALIDATE(Description, RFQLines.Description);
                                            PurchaseLines.VALIDATE("Description 2", RFQLines."Description 2");
                                            PurchaseLines.VALIDATE(Quantity, RFQLines.Quantity);
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
                            Rec.Converted := TRUE;
                            Rec.MODIFY;

                        END;

                    end;
                }
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
            }
            group(Status)
            {
                Caption = 'Status';
                action(Cancel)
                {
                    Caption = 'Cancel';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        IF CONFIRM('Cancel Document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Rec.Status := Rec.Status::Cancelled;
                        Rec.MODIFY;

                    end;
                }
                action(Stop)
                {
                    Caption = 'Stop';
                    Image = Stop;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        IF CONFIRM('Close Document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Rec.Status := Rec.Status::Closed;
                        Rec.MODIFY;

                    end;
                }
                action(Close)
                {
                    Caption = 'Close';
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        IF CONFIRM('Close Document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Rec.Status := Rec.Status::Closed;
                        Rec.MODIFY;

                    end;
                }
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin

                        IF CONFIRM('Release document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        //check if the document has any lines
                        Lines.RESET;
                        Lines.SETRANGE(Lines."Document Type", Rec."Document Type");
                        Lines.SETRANGE(Lines."Document No.", Rec."No.");
                        IF Lines.FINDFIRST THEN BEGIN
                            REPEAT
                                Lines.TESTFIELD(Lines.Quantity);
                                //Lines.TESTFIELD(Lines."Direct Unit Cost");
                                Lines.TESTFIELD("No.");
                            UNTIL Lines.NEXT = 0;
                        END
                        ELSE BEGIN
                            ERROR('Document has no lines');
                        END;
                        Rec.Status := Rec.Status::Approved;
                        Rec."Released By" := USERID;
                        Rec."Release Date" := TODAY;
                        Rec.MODIFY;
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type", PurchHeader."Document Type"::Quote);
                        //PurchHeader.SETRANGE(purchheader."request for quote no","No.");
                        IF PurchHeader.FINDFIRST THEN BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                        END;

                        IF CONFIRM('Reopen Document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Rec.Status := Rec.Status::Open;
                        Rec.MODIFY;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        //  if Rec.Converted = true then
        IF Rec."Approval Status" <> Rec."Approval Status"::New THEN begin
            Editable := False;


        end;


    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF Rec."Approval Status" <> Rec."Approval Status"::New THEN
            ERROR('Only new records can be modified');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*Location.RESET;
        Location.SETRANGE(Location.Code,'MOMBASA');
        IF Location.FINDFIRST THEN BEGIN
          "Ship-to Code":= Location.Code;
          VALIDATE("Ship-to Code");
        END;
        //"Ship-to Code":='KIAMBU';
        "Location Code":='MOMBASA';
        "Shortcut Dimension 1 Code":='BOSA';
        "Shortcut Dimension 2 Code":='MOMBASA';*/

    end;

    var
        PurchHeader: Record 38;
        ApprovalEntry: Record "Approval Entry";
        CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
        varrvariant: Variant;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ",Leave,Training,Payroll,BankRec,Timesheet,RFQ;
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
        HREmployee: Record "HR Employees";

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

