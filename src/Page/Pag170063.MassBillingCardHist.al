Page 170063 "Mass Billing Card Hist"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Mass Unit Billing";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(Property; Rec.Property)
                {
                    ApplicationArea = Basic;
                }
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Time Created"; Rec."Time Created")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Post)
            {
                Caption = 'Post';
                action(Attachments)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
                action("Post Invoice")
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        UnitBills: Record "Unit Billing Lines";
                    begin
                        // IF CONFIRM('Are you sure you want to post this receipt?',TRUE,FALSE)=TRUE THEN BEGIN
                        // Receipt.RESET;
                        // Receipt.SETRANGE(Receipt."No.","No.");
                        // IF Receipt.FINDFIRST THEN BEGIN
                        // GenJournalLine.RESET;
                        // GenJournalLine.SETRANGE("Journal Template Name",JTemplate);
                        // GenJournalLine.SETRANGE("Journal Batch Name",JBatch);
                        // GenJournalLine.DELETEALL;
                        // PropertyDet.RESET;PropertyDet.SETRANGE(PropertyDet.No,Property); IF PropertyDet.FINDFIRST
                        // THEN BEGIN
                        // LandlordNo:=PropertyDet."Property Owner";
                        // Units.RESET;
                        // Units.SETRANGE(Units.Property,PropertyDet.No);
                        // Units.SETRANGE(Units."Unit Status",Units."Unit Status"::Occupied);
                        // IF Units.FIND('-') THEN BEGIN
                        // REPEAT
                        // UnitBills.RESET;
                        // UnitBills.SETRANGE(UnitBills."Unit Code",Units."No.");
                        // IF UnitBills.FINDFIRST THEN BEGIN
                        // REPEAT
                        // PurchaseSetup.GET();
                        // JTemplate:=PurchaseSetup."Unit Receipt Template";
                        // JBatch:=PurchaseSetup."Unit Receipting Batch";
                        //
                        //
                        // LineNo:=LineNo+10000;
                        // AUFactory.FnInsertJournalLines(JTemplate,JBatch,Receipt."No.",Units.Tenant,AccountType::Vendor,LandlordNo,Units."Account No.",TODAY
                        // ,Units."Account No."+' '+Units."Tenant Full Name","Global Dimension 1 Code","Global Dimension 2 Code",-UnitBills.Rate,LineNo,AccountType::"G/L Account",PurchaseSetup."Payments Control Account");
                        //
                        //
                        // LineNo:=LineNo+100000;
                        // AUFactory.FnInsertJournalLines(JTemplate,JBatch,Receipt."No.",Units.Tenant,AccountType::Customer,Units."No.",Units."Account No.",
                        // TODAY,Units."Account No."+' '+Units."Tenant Full Name","Global Dimension 1 Code","Global Dimension 2 Code",UnitBills.Rate,LineNo,AccountType::"G/L Account",PurchaseSetup."Payments Control Account");
                        //
                        //
                        // //Update Unit Card Billing
                        // //FnUpdateUnitCardBillingLines("Unit No.","No.");
                        // //End Unit Card Billing Lines
                        //
                        // UNTIL UnitBills.NEXT=0;
                        // END;
                        // UNTIL Units.NEXT=0;
                        // END;
                        // END;
                        // END;
                        // //Post
                        // GenJournalLine.RESET;
                        // GenJournalLine.SETRANGE("Journal Template Name",JTemplate);
                        // GenJournalLine.SETRANGE("Journal Batch Name",JBatch);
                        // IF GenJournalLine.FIND('-') THEN BEGIN
                        // CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJournalLine);
                        // END;
                        // Posted:=TRUE;
                        // "Posted By":=USERID;
                        // "Posting Date":=TODAY;
                        // END;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
            }
        }
    }

    var
        Receipt: Record "Mass Unit Billing";
        AUFactory: Codeunit "AU factory";
        PurchaseSetup: Record "Purchases & Payables Setup";
        AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        JTemplate: Code[20];
        JBatch: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ApprovalEntry: Record "Approval Entry";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        PurchasesSetup: Record "Purchases & Payables Setup";
        PropertyDet: Record "Property Details";
        LandlordNo: Code[20];
        WaterBill: Record "Water Billing";
        Units: Record Customer;

    local procedure FnUpdateUnitCardBillingLines(UnitCode: Code[20]; DocumentNo: Code[20])
    var
        UnitReceipting: Record "Unit Billing";
        UnitLines: Record "Unit Receipting Line";
        UnitBillingLines: Record "Unit Billing Lines";
        UnitLine: Integer;
    begin
        UnitBillingLines.Reset;
        UnitBillingLines.SetRange(UnitBillingLines."Unit Code", UnitCode);
        ;
        if UnitBillingLines.FindSet then begin
            UnitBillingLines.Delete;
        end;


        UnitReceipting.Reset;
        UnitReceipting.SetRange(UnitReceipting."No.", DocumentNo);
        UnitReceipting.SetRange(UnitReceipting."No.", UnitCode);
        if UnitReceipting.FindFirst then begin
            if UnitBillingLines.FindLast then
                UnitLine := UnitBillingLines.EntryNo
            else
                UnitLine := 0;

            UnitLines.Reset;
            UnitLines.SetRange(UnitLines."Document No", UnitReceipting."No.");
            if UnitLines.FindFirst then begin
                repeat
                    UnitLine := UnitLine + 1;
                    UnitBillingLines.Init;
                    UnitBillingLines.EntryNo := UnitLine;
                    UnitBillingLines.Ammenity := UnitLines."Transaction Type";
                    UnitBillingLines.Description := UnitLines.Description;
                    UnitBillingLines."Unit Code" := UnitCode;
                    UnitBillingLines.Rate := UnitLines.Amount;
                    UnitBillingLines.Insert;

                until UnitLines.Next = 0;
            end;
        end;
    end;
}

