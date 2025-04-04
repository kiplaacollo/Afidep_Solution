Page 170061 "Mass Billing Card"
{
    PageType = Card;
    SourceTable = "Mass Unit Billing";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(Property;Rec.Property)
                {
                    ApplicationArea = Basic;
                }
                field("Property Name";Rec."Property Name")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Balance;Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("User ID";Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created";Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Time Created";Rec."Time Created")
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
                    PromotedCategory = Process;
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
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        UnitBills: Record "Unit Billing Lines";
                        PayPeriods: Record "Billing and Payments Periods";
                    begin
                        if Confirm('Are you sure you want to post this receipt?',true,false)=true then begin
                        //IF SMS.FINDLAST THEN
                        //Ientry:=SMS."Entry No"+1
                        //ELSE
                        //Ientry:=1;
                        //MESSAGE('Entry%1',Ientry);
                        Receipt.Reset;
                        Receipt.SetRange(Receipt."No.",Rec."No.");
                        if Receipt.FindFirst then begin
                        PurchaseSetup.Get();
                        JTemplate:=PurchaseSetup."Unit Receipt Template";
                        JBatch:=PurchaseSetup."Unit Receipting Batch";
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",JTemplate);
                        GenJournalLine.SetRange("Journal Batch Name",JBatch);
                        if GenJournalLine.FindSet then begin
                        GenJournalLine.DeleteAll;
                        end;
                        PayPeriods.Reset;
                        PayPeriods.SetRange(PayPeriods.Closed,false);
                        if PayPeriods.FindLast then
                        LineNo:=1000;
                        PropertyDet.Reset;PropertyDet.SetRange(PropertyDet.No,Rec.Property); if PropertyDet.FindFirst
                        then begin
                        LandlordNo:=PropertyDet."Property Owner";
                        Units.Reset;
                        Units.SetRange(Units.Property22,PropertyDet.No);
                        Units.SetRange(Units."Unit Status3",Units."unit status3"::Occupied);
                        if Units.Find('-') then begin
                        repeat
                          Amt:=0;
                        UnitBills.Reset;
                        UnitBills.SetRange(UnitBills."Unit Code",Units."No.");
                        UnitBills.SetFilter(UnitBills.Ammenity,'<>%1','WATER');
                        if UnitBills.FindFirst then begin
                        repeat
                        PurchaseSetup.Get();
                        JTemplate:=PurchaseSetup."Unit Receipt Template";
                        JBatch:=PurchaseSetup."Unit Receipting Batch";
                        PurchaseSetup.TestField("Payments Control Account");
                        
                        LineNo:=LineNo+10000;
                        AUFactory.FnInsertJournalLines(JTemplate,JBatch,Receipt."No.",Units.Tenant22,Accounttype::Vendor,LandlordNo,Units."Account No2.",Today
                        ,Units."Account No2."+' '+Units."Tenant Full Name 33",Rec."Global Dimension 1 Code",Rec."Global Dimension 2 Code",-UnitBills.Rate,LineNo,Accounttype::"G/L Account",PurchaseSetup."Payments Control Account",PayPeriods."Starting Date",UnitBills.Ammenity
                        ,Rec.Property);
                        
                        
                        LineNo:=LineNo+100000;
                        AUFactory.FnInsertJournalLines(JTemplate,JBatch,Receipt."No.",Units.Tenant22,Accounttype::Customer,Units."No.",Units."Account No2.",
                        Today,Units."Account No2."+' '+Units."Tenant Full Name 33",Rec."Global Dimension 1 Code",Rec."Global Dimension 2 Code",UnitBills.Rate,LineNo,Accounttype::"G/L Account",PurchaseSetup."Payments Control Account",PayPeriods."Starting Date",UnitBills.Ammenity
                        ,Rec.Property);
                        
                        Amt:=Amt+UnitBills.Rate;
                        //Update Unit Card Billing
                        //FnUpdateUnitCardBillingLines("Unit No.","No.");
                        //End Unit Card Billing Lines
                        
                        until UnitBills.Next=0;
                        end;
                        //send sms
                        /*Tenant.RESET;
                        Tenant.SETRANGE(Tenant."No.",Units.Tenant);
                        IF Tenant.FINDFIRST THEN BEGIN
                        SMS.INIT;
                        SMS."Entry No":=Ientry;
                        SMS."Date Entered":=TODAY;
                        SMS."Time Entered":=TIME;
                        SMS."Recipient Name":=Units."Tenant Full Name";
                        SMS."Recipient Phone No":=Tenant."Tenants Phone Number";
                        SMS."SMS Status":=SMS."SMS Status"::Drafted;
                        SMS.SOURCE:=Receipt."No.";
                        Deadline:=CALCDATE('+5D',TODAY);
                        SMS.Description:='Dear '+Units."Tenant Full Name"+'.Invoice for the month of '+PayPeriods.Name+' of KES '+FORMAT(Amt)+
                        ' has been generated.Kindly pay before '+FORMAT(Deadline)+'.Your account is '+Units."Account No.";
                        SMS.INSERT;
                        Ientry:=Ientry+1;
                        END;*/
                        until Units.Next=0;
                        
                        end;
                        end;
                        end;
                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",JTemplate);
                        GenJournalLine.SetRange("Journal Batch Name",JBatch);
                        if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJournalLine);
                        end;
                        Rec.Posted:=true;
                        Rec."Posted By":=UserId;
                        Rec."Posting Date":=Today;
                        end;

                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Process;

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
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField(Status,Rec.Status::Open);
                        VarVariant:=Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                          CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

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
        Amt: Decimal;
        Deadline: Date;
        Ientry: Integer;
        Tenant: Record Tenants;

    local procedure FnUpdateUnitCardBillingLines(UnitCode: Code[20];DocumentNo: Code[20])
    var
        UnitReceipting: Record "Unit Billing";
        UnitLines: Record "Unit Receipting Line";
        UnitBillingLines: Record "Unit Billing Lines";
        UnitLine: Integer;
    begin
        UnitBillingLines.Reset;
        UnitBillingLines.SetRange(UnitBillingLines."Unit Code",UnitCode);;
        if UnitBillingLines.FindSet then begin
        UnitBillingLines.Delete;
        end;


        UnitReceipting.Reset;
        UnitReceipting.SetRange(UnitReceipting."No.",DocumentNo);
        UnitReceipting.SetRange(UnitReceipting."No.",UnitCode);
        if UnitReceipting.FindFirst then
        begin
        if UnitBillingLines.FindLast then
        UnitLine:=UnitBillingLines.EntryNo
        else
        UnitLine:=0;

        UnitLines.Reset;
        UnitLines.SetRange(UnitLines."Document No",UnitReceipting."No.");
        if UnitLines.FindFirst then
        begin
        repeat
        UnitLine:=UnitLine+1;
        UnitBillingLines.Init;
        UnitBillingLines.EntryNo:=UnitLine;
        UnitBillingLines.Ammenity:=UnitLines."Transaction Type";
        UnitBillingLines.Description:=UnitLines.Description;
        UnitBillingLines."Unit Code":=UnitCode;
        UnitBillingLines.Rate:=UnitLines.Amount;
        UnitBillingLines.Insert;

        until UnitLines.Next=0;
        end;
        end;
    end;
}

