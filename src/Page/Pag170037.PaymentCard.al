Page 170037 "Payment Card"
{
    PageType = Card;
    SourceTable = "Unit Billing";
    UsageCategory = Lists;
    ApplicationArea = ALL;
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
                field("Lease Number"; Rec."Lease Number")
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
                field("Unit No."; Rec."Unit No.")
                {
                    ApplicationArea = Basic;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = Basic;
                }
                field(Tenant; Rec.Tenant)
                {
                    ApplicationArea = Basic;
                }
                field("Tenant Name"; Rec."Tenant Name")
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
                field("Total Amount"; Rec."Total Amount")
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
            group(Control10)
            {
                part("Unit Transactions"; "Unit Receipting Lines")
                {
                    SubPageLink = "Document No" = field("No.");
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

                    trigger OnAction()
                    var
                        PayPeriods: Record "Billing and Payments Periods";
                    begin
                        if Confirm('Are you sure you want to post this receipt?', true, false) = true then begin
                            //IF SMS.FINDLAST THEN
                            //Ientry:=Ientry+1
                            //ELSE
                            //Ientry:=1;


                            Receipt.Reset;
                            Receipt.SetRange(Receipt."No.", Rec."No.");
                            if Receipt.FindFirst then begin
                                Receipt.CalcFields("Total Amount");

                                PropertyDet.Reset;
                                PropertyDet.SetRange(PropertyDet.No, Rec.Property);
                                if PropertyDet.FindFirst
then begin
                                    LandlordNo := PropertyDet."Property Owner";
                                end;

                                PurchaseSetup.Get();
                                JTemplate := PurchaseSetup."Unit Receipt Template";
                                JBatch := PurchaseSetup."Unit Receipting Batch";
                                PayPeriods.Reset;
                                PayPeriods.SetRange(PayPeriods.Closed, false);
                                if PayPeriods.FindLast then
                                    GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", JTemplate);
                                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                                if GenJournalLine.FindFirst then begin
                                    GenJournalLine.DeleteAll;
                                end;
                                LineNo := LineNo + 10000;
                                AUFactory.FnInsertJournalLines(JTemplate, JBatch, Receipt."No.", Rec.Tenant, Accounttype::Vendor, LandlordNo, Rec."Lease Number", Today
                                , Rec."Lease Number" + ' ' + Rec."Tenant Name", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", -Rec."Total Amount", LineNo, Accounttype::"G/L Account", PurchaseSetup."Payments Control Account", PayPeriods."Starting Date", '', Rec.Property);

                                ReceiptLines.Reset;
                                ReceiptLines.SetRange(ReceiptLines."Document No", Receipt."No.");
                                if ReceiptLines.FindFirst then begin
                                    repeat
                                        LineNo := LineNo + 10000;
                                        AUFactory.FnInsertJournalLines(JTemplate, JBatch, Receipt."No.", Rec.Tenant, ReceiptLines."account type"::Customer, Rec."Unit No.", Rec."Lease Number",
                                        Today, Rec."Lease Number" + ' ' + Rec."Tenant Name", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", ReceiptLines.Amount, LineNo, Accounttype::"G/L Account", PurchaseSetup."Payments Control Account", PayPeriods."Starting Date", ReceiptLines."Transaction Type"
                                        , Rec.Property);
                                    until ReceiptLines.Next = 0;
                                end;

                                //send sms
                                Rec.CalcFields("Total Amount");
                                /*SMS.INIT;
                                SMS."Entry No":=Ientry;
                                SMS."Date Entered":=TODAY;
                                SMS."Time Entered":=TIME;
                                SMS."Recipient Name":="Tenant Name";
                                SMS."Recipient Phone No":=Units."Phone No.";
                                SMS."SMS Status":=SMS."SMS Status"::Drafted;
                                SMS.SOURCE:=Receipt."No.";
                                Deadline:=CALCDATE('+5D',TODAY);
                                SMS.Description:='Dear '+"Tenant Name"+'.Invoice for the month of '+PayPeriods.Name+' of KES '+FORMAT("Total Amount")+
                                'has been generated.Kindly pay before '+FORMAT(Deadline)+'.Your account is'+"Unit No.";
                                SMS.INSERT;
                                */
                                //end
                                //Update Unit Card Billing
                                FnUpdateUnitCardBillingLines(Rec."Unit No.", Rec."No.");
                                //End Unit Card Billing Lines

                                //Post
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", JTemplate);
                                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                                end;
                                Rec.Posted := true;
                                Rec."Posted By" := UserId;
                                Rec."Posting Date" := Today;
                            end;
                        end;

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

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action("Update Water Bill")
                {
                    ApplicationArea = Basic;
                    Image = UpdateUnitCost;
                    Promoted = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to update water bill?', true, false) = true then begin
                            WaterBill.Reset;
                            WaterBill.SetRange(WaterBill.Unit, Rec."Unit No.");
                            WaterBill.SetRange(WaterBill.Posted, true);
                            if WaterBill.FindLast then begin
                                Receipt.Reset;
                                Receipt.SetRange(Receipt."No.", Rec."No.");
                                if Receipt.FindFirst then begin
                                    ReceiptLines.Reset;
                                    ReceiptLines.SetRange(ReceiptLines."Document No", Receipt."No.");
                                    ReceiptLines.SetRange(ReceiptLines."Transaction Type", 'WATER');
                                    if ReceiptLines.Find('+') then begin
                                        ReceiptLines.Amount := WaterBill."Amount Charged";
                                        ReceiptLines.Modify;
                                    end;
                                end;
                            end else begin
                                Error('Bill the unit for water first.');
                            end;
                        end;
                    end;
                }
            }
        }
    }

    var
        Receipt: Record "Unit Billing";
        ReceiptLines: Record "Unit Receipting Line";
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
        Amt: Decimal;
        Deadline: Date;
        Ientry: Integer;
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

