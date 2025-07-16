pageextension 50120 "Purch. Invoice Subform Ext" extends "Purchase Invoice"
{
    layout
    {
        modify("Posting Description")
        {
            Visible = true;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ShowMandatory = true;

        }
        addafter(Status)
        {
            field("Currency Code."; Rec."Currency Code")
            {
                ApplicationArea = Basic;
            }
            field("Currency Factor"; Rec."Currency Factor")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        modify("Re&lease")
        {
            Visible = false; // Hide the action
        }
        modify(Post)
        {
            Visible = true; // Hide the action
        }

        // Hide the original "Post" action
        // modify(Post)
        // {
        //    // Visible = false;
        // }

        // Add a new action: "Custom Post"
        addlast(Release)
        {
            action(CustomPost)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Custom Post';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Post the document after status validation.';
                Visible = false;

                trigger OnAction()
                var
                    PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                begin
                    // Check if the status is either Released or Approved
                    if (Rec.Status <> Rec.Status::Released) then
                        Rec.Status := Rec.Status::Released;
                    // Error('The document must be either Released or Approved to be posted.');

                    VerifyTotal(); // Verifies the total purchase lines

                    if Confirm('Are you sure you want to post the Receipt') then begin
                        //TESTFIELD(Status,Status::Released);

                        GenJnlLine.Reset;
                        GenJnlLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJnlLine.SetRange("Journal Batch Name", 'PURCINV');
                        if GenJnlLine.Find then begin
                            GenJnlLine.DeleteAll;
                        end;
                        GenJournalBatch.Reset;
                        GenJournalBatch.SetRange(GenJournalBatch."Journal Template Name", 'GENERAL');
                        GenJournalBatch.SetRange(GenJournalBatch.Name, 'PURCINV');
                        if GenJournalBatch.Find('-') = false then begin
                            GenJournalBatch.Init;
                            GenJournalBatch."Journal Template Name" := 'GENERAL';
                            GenJournalBatch.Name := 'PURCINV';
                            GenJournalBatch.Insert(true);
                        end;

                        LineNo := LineNo + 1000;
                        GenJnlLine.Reset;
                        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'GENERAL');
                        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PURCINV');
                        if GenJnlLine.Find('-') then begin
                            GenJnlLine.DeleteAll;
                        end;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := 'GENERAL';
                        GenJnlLine."Journal Batch Name" := 'PURCINV';

                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := 'GJNL';
                        GenJnlLine."Posting Date" := Rec."Posting Date";
                        //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                        GenJnlLine."Document No." := Rec."No.";
                        GenJnlLine."External Document No." := Rec."No.";
                        GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
                        GenJnlLine."Account No." := Rec."Paying Account No";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine.Description := Rec."Posting Description";
                        //'Paymentvoucher: '+"Account No"+' '+"Imprest No";
                        GenJnlLine.Amount := Rec.Amount;
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Currency Code" := Rec."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine."Currency Factor" := Rec."Currency Factor";
                        // GenJnlLine.Validate("Currency Factor");
                        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");

                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;


                        PurchLine6.Reset;
                        PurchLine6.SetRange(PurchLine6."Document No.", Rec."No.");
                        //PurchLine6.SETFILTER("Amount Spent",'<>%1',0);
                        if PurchLine6.FindSet then begin
                            repeat
                                LineNo2 := LineNo2 + 2000;
                                GenJnlLine.Init;
                                GenJnlLine."Journal Template Name" := 'GENERAL';
                                GenJnlLine."Journal Batch Name" := 'PURCINV';

                                GenJnlLine."Line No." := LineNo2;
                                GenJnlLine."Source Code" := 'GJNL';
                                GenJnlLine."Posting Date" := Rec."Posting Date";
                                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                                GenJnlLine."Document No." := Rec."No.";
                                GenJnlLine."External Document No." := Rec."No.";
                                IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::"G/L Account" THEN
                                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                GenJnlLine."Account No." := PurchLine6."Account No New";
                                IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::Supplier THEN
                                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                                IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::Customer THEN BEGIN
                                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                                    //   GenJnlLine."Account No." := PurchLine6."Imprest Account No";
                                END;
                                //GenJnlLine."Account No." := PurchLine6."Account No New";

                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine.Description := PurchLine6."Description 2";
                                GenJnlLine.Payee := Rec."Payee Naration";

                                GenJnlLine.Amount := -(PurchLine6.Amount);

                                GenJnlLine.Validate(Amount);

                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.Validate("Currency Code");
                                GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                // GenJnlLine.Validate("Currency Factor");

                                GenJnlLine."Shortcut Dimension 1 Code" := PurchLine6."Shortcut Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := PurchLine6."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                GenJnlLine.ValidateShortcutDimCode(5, Rec."Shortcut Dimension 5 Code");
                                GenJnlLine.ValidateShortcutDimCode(6, PurchLine6."ShortcutDimCode[6]");
                                GenJnlLine.ValidateShortcutDimCode(7, PurchLine6."ShortcutDimCode[7]");
                                GenJnlLine.ValidateShortcutDimCode(8, PurchLine6."ShortcutDimCode[8]");
                                if GenJnlLine.Amount <> 0 then
                                    GenJnlLine.Insert;
                            until PurchLine6.Next = 0;
                        end;
                        //MESSAGE('HOME %1|%2',GenJnlLine."Journal Batch Name",GenJnlLine."Journal Template Name");
                        //EXIT;
                        GenJnlLine.Reset;
                        GenJnlLine."Journal Template Name" := 'GENERAL';
                        GenJnlLine."Journal Batch Name" := 'PURCINV';
                        if GenJnlLine.Find('-') then begin
                            //   Message('HOME');
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnlLine);
                            Rec.Completed := true;
                            Rec.Posted := true;
                            Rec.Modify(true);

                            CurrPage.Close();
                            CurrPage.Update();
                        end;
                        PurchaseHeader2.Reset;
                        PurchaseHeader2.SetRange("No.", Rec."Linked Document");
                        if PurchaseHeader2.Findset then begin
                            repeat
                                PurchaseHeader2.Completed := true;
                                PurchaseHeader2.Posted := true;
                                PurchaseHeader2.Modify;
                            until PurchaseHeader2.Next = 0;
                        end;
                        Message('Purchase Invoice Successfully');
                    end;



                    // Proceed with posting using the Purch.-Post (Yes/No) codeunit
                    // PurchPostYesNo.Run(Rec); // Executes the posting logic for the purchase document
                end;
            }
            action(PostNew)
            {
                ApplicationArea = Basic;
                Caption = 'Post';
                Visible = false;
                Ellipsis = true;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    GetBatch: Record 232;
                    PurchSetup: Record "Purchases & Payables Setup";
                    NoSeriesMgt: Codeunit "NoSeriesManagement";
                    InvoiceNoSeriesCode: Code[20];
                    NewInvoiceNo: Code[20];
                begin
                    Rec.TestField("Posting Date");
                    Rec.CalcFields("Amount Including VAT");
                    //TESTFIELD(Rec.Status,Rec.Status::Open);
                    if (Rec.Status <> Rec.Status::Released) then
                        Error('The document has not been Approved');

                    if (Rec.Posted = true) then
                        Error('The document has already been Posted');

                    if Confirm('Are you sure you want to post the Receipt') then begin
                        //TESTFIELD(Status,Status::Released);
                        PurchSetup.Get();
                        InvoiceNoSeriesCode := PurchSetup."Posted Invoice Nos."; // Get the No. Series code for Purchase Invoices

                        if InvoiceNoSeriesCode = '' then
                            Error('No. Series for Purchase Invoices is not set up in Purchases & Payables Setup.');

                        NewInvoiceNo := NoSeriesMgt.GetNextNo(InvoiceNoSeriesCode, WorkDate(), true); // Generate new number

                        // Now use NewInvoiceNo as your Document No.

                        GenJnlLine.Reset;
                        GenJnlLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJnlLine.SetRange("Journal Batch Name", 'PURCINV');
                        if GenJnlLine.Find then begin
                            GenJnlLine.DeleteAll;
                        end;
                        GenJournalBatch.Reset;
                        GenJournalBatch.SetRange(GenJournalBatch."Journal Template Name", 'GENERAL');
                        GenJournalBatch.SetRange(GenJournalBatch.Name, 'PURCINV');
                        if GenJournalBatch.Find('-') = false then begin
                            GenJournalBatch.Init;
                            GenJournalBatch."Journal Template Name" := 'GENERAL';
                            GenJournalBatch.Name := 'PURCINV';
                            GenJournalBatch.Insert(true);
                        end;

                        PurchLine6.Reset;
                        PurchLine6.SetRange(PurchLine6."Document No.", Rec."No.");
                        if PurchLine6.Find('-') then
                            repeat
                                Rec.Amount += PurchLine6.Amount;
                            until PurchLine6.Next = 0;

                        LineNo := LineNo + 1000;
                        GenJnlLine.Reset;
                        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'GENERAL');
                        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PURCINV');
                        if GenJnlLine.Find('-') then begin
                            GenJnlLine.DeleteAll;
                        end;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := 'GENERAL';
                        GenJnlLine."Journal Batch Name" := 'PURCINV';

                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := 'GJNL';
                        GenJnlLine."Posting Date" := Rec."Posting Date";
                        //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                        GenJnlLine."Document No." := NewInvoiceNo;
                        GenJnlLine."External Document No." := NewInvoiceNo;
                        GenJnlLine."Account Type" := GenJnlLine."account type"::Vendor;
                        GenJnlLine."Account No." := Rec."Buy-from Vendor No.";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine.Description := Rec."Posting Description";
                        //'Paymentvoucher: '+"Account No"+' '+"Imprest No";
                        GenJnlLine.Amount := -1 * Rec."Amount Including VAT";
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Currency Code" := Rec."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine."Currency Factor" := Rec."Currency Factor";
                        // GenJnlLine.Validate("Currency Factor");
                        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");

                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;


                        PurchLine6.Reset;
                        PurchLine6.SetRange(PurchLine6."Document No.", Rec."No.");
                        //PurchLine6.SETFILTER("Amount Spent",'<>%1',0);
                        if PurchLine6.FindSet then begin
                            repeat
                                LineNo2 := LineNo2 + 2000;
                                GenJnlLine.Init;
                                GenJnlLine."Journal Template Name" := 'GENERAL';
                                GenJnlLine."Journal Batch Name" := 'PURCINV';

                                GenJnlLine."Line No." := LineNo2;
                                GenJnlLine."Source Code" := 'GJNL';
                                GenJnlLine."Posting Date" := Rec."Posting Date";
                                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                                GenJnlLine."Document No." := NewInvoiceNo;
                                GenJnlLine."External Document No." := NewInvoiceNo;
                                // IF PurchLine6."Claim Type" = PurchLine6."Claim Type"::"G/L Account" THEN
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                GenJnlLine."Account No." := PurchLine6."No.";

                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine.Description := PurchLine6."Description 2";
                                GenJnlLine.Payee := Rec."Payee Naration";
                                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::Purchase;

                                GenJnlLine.Amount := (PurchLine6."Amount Including VAT");

                                GenJnlLine.Validate(Amount);

                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.Validate("Currency Code");
                                GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                // GenJnlLine.Validate("Currency Factor");

                                GenJnlLine."Shortcut Dimension 1 Code" := PurchLine6."Shortcut Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := PurchLine6."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                GenJnlLine.ValidateShortcutDimCode(5, Rec."Shortcut Dimension 5 Code");
                                GenJnlLine.ValidateShortcutDimCode(6, PurchLine6."ShortcutDimCode[6]");
                                GenJnlLine.ValidateShortcutDimCode(7, PurchLine6."ShortcutDimCode[7]");
                                GenJnlLine.ValidateShortcutDimCode(8, PurchLine6."ShortcutDimCode[8]");
                                if GenJnlLine.Amount <> 0 then
                                    GenJnlLine.Insert;
                            until PurchLine6.Next = 0;
                        end;
                        // MESSAGE('HOME %1|%2', GenJnlLine."Journal Batch Name", GenJnlLine."Journal Template Name");
                        // EXIT;
                        GenJnlLine.Reset;
                        GenJnlLine."Journal Template Name" := 'GENERAL';
                        GenJnlLine."Journal Batch Name" := 'PURCINV';
                        if GenJnlLine.Find('-') then begin
                            //   Message('HOME');
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnlLine);

                        end;


                        Rec.Completed := true;
                        Rec.Posted := true;
                        Rec.Modify(true);

                        CurrPage.Close();
                        CurrPage.Update();

                        PurchaseHeader2.Reset;
                        PurchaseHeader2.SetRange("No.", Rec."Linked Document");
                        if PurchaseHeader2.Findset then begin
                            repeat
                                PurchaseHeader2.Completed := true;
                                PurchaseHeader2.Posted := true;
                                PurchaseHeader2.Modify;
                            until PurchaseHeader2.Next = 0;
                        end;
                        Message('Purchase Invoice Successfully');
                    end;


                end;
            }

        }
        addafter(CancelApprovalRequest)
        {
            action("Send A&pproval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
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

                    varrvariant := Rec;

                    if CustomApprovalsCodeunit.CheckApprovalsWorkflowEnabled(varrvariant) then
                        CustomApprovalsCodeunit.OnSendDocForApproval(varrvariant);

                end;
            }
            action(UnpostRec)
            {
                ApplicationArea = Basic, Suite;

                Caption = 'Unpost Record';
                Image = UpdateDescription;
                Promoted = true;
                Visible = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                ToolTip = 'Mark Record as not posted and Not completed.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    COA: Record "G/L Account";
                begin
                    if Rec.Posted = true then
                        Rec.Posted := false;
                    if Rec.Completed = true then
                        Rec.Completed := false;
                    Rec.Modify();

                end;
            }
            action(MarkpostRec)
            {
                ApplicationArea = Basic, Suite;

                Caption = 'Mark As Posted';
                Image = UpdateDescription;
                Promoted = true;
                Visible = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                ToolTip = 'Mark Record as posted and completed.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    COA: Record "G/L Account";
                begin
                    if Rec.Posted = false then
                        Rec.Posted := true;
                    if Rec.Completed = false then
                        Rec.Completed := true;
                    Rec.Modify();

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


        }
    }
    var
        ApprovalEntry: Record "Approval Entry";
        CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
        varrvariant: Variant;
        GenJnlLine: Record "Gen. Journal Line";
        Amt: Decimal;
        PurchaseHeader2: Record "Purchase Header";
        GenJnlLine2: Record "Gen. Journal Line";
        RFQ: Record "Purchase Line";
        LineNo: Integer;
        PurchLine6: Record "Purchase Line";
        UserSetup: Record "User Setup";
        LineNo2: Decimal;
        GenJournalBatch: Record "Gen. Journal Batch";
}


pageextension 50137 "Purch. Invoice Subform Ext1" extends "Purch. Invoice Subform"
{
    layout
    {
        modify("Description 2")
        {
            Visible = true;
        }
    }
}
