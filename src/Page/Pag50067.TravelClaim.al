Page 50067 "Travel Claim"
{
    Caption = 'Travel Claim';
    Editable = true;
    PageType = Card;
    SourceTable = "Purchase Header";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Destination';
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec."Travel Total")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date';
                }
                field("Paying Account No"; Rec."Paying Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Account Name"; Rec."Paying Account Name")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control9; "Travel Details")
            {
                SubPageLink = "Document No." = field("No.");
            }
            part(Control10; "Accountin Accomodation Details")
            {
                Caption = 'Claim Accomodation Details';
                SubPageLink = "Document No." = field("No.");
            }
            part(Control11; "Accounting Meals Details")
            {
                Caption = 'Claim Meals Details';
                SubPageLink = "Document No." = field("No.");
            }
            part(Control12; "Accounting Other Details")
            {
                Caption = 'Claim Other Details';
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
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
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post';
                Ellipsis = true;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField(Completed, false);
                    if Confirm('Are you sure you want to post the claim') then begin
                        Rec.TestField(Status, Rec.Status::Released);

                        GenJnlLine2.Reset;
                        GenJnlLine2.SetRange("Journal Template Name", 'GENERAL');
                        GenJnlLine2.SetRange("Journal Batch Name", 'CLAIM');
                        if GenJnlLine2.Find then
                            GenJnlLine2.Delete;

                        /*GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name":='PAYMENTS';
                        GenJnlLine."Journal Batch Name":='SURRENDER';
                        GenJnlLine2.RESET;
                        GenJnlLine2.SETRANGE("Journal Template Name",'PAYMENTS');
                        GenJnlLine2.SETRANGE("Journal Batch Name",'SURRENDER');
                        IF GenJnlLine2.FINDLAST THEN
                        GenJnlLine."Line No.":=GenJnlLine2."Line No."+10000;
                        GenJnlLine."Source Code":='PAYMENTJNL';
                        GenJnlLine."Posting Date":=TODAY;
                        //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                        GenJnlLine."Document No.":="No.";
                        GenJnlLine."External Document No.":="Cheque No";
                        GenJnlLine."Account Type":=GenJnlLine."Account Type"::Customer;
                        GenJnlLine."Account No.":="Account No";
                        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                        GenJnlLine.Description:='Surrender: '+"Account No"+' '+"Imprest No";
                        Amt:=0;
                        PurchLine.RESET;
                        PurchLine.SETRANGE("Document No.","No.");
                        IF PurchLine.FINDSET THEN BEGIN
                          REPEAT
                            Amt:=Amt+PurchLine."Line Amount";
                            UNTIL PurchLine.NEXT=0;
                          END;
                        GenJnlLine.Amount:=-1*Amt;
                        GenJnlLine.VALIDATE(GenJnlLine.Amount);
                       // GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"Bank Account";
                       // GenJnlLine."Bal. Account No.":="Paying Account No";
                       // GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                        //Added for Currency Codes
                        GenJnlLine."Currency Code":="Currency Code";
                        GenJnlLine.VALIDATE("Currency Code");
                        GenJnlLine."Currency Factor":="Currency Factor";
                        GenJnlLine.VALIDATE("Currency Factor");
                        GenJnlLine."Shortcut Dimension 1 Code":="Shortcut Dimension 1 Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                    
                    
                        IF GenJnlLine.Amount<>0 THEN
                        GenJnlLine.INSERT;*/



                        PurchLine6.Reset;
                        PurchLine6.SetRange("Document No.", Rec."No.");
                        PurchLine6.SetFilter("Amount Spent", '<>%1', 0);
                        if PurchLine6.FindSet then begin
                            repeat
                                GenJnlLine.Init;
                                GenJnlLine."Journal Template Name" := 'GENERAL';
                                GenJnlLine."Journal Batch Name" := 'CLAIM';
                                GenJnlLine2.Reset;
                                GenJnlLine2.SetRange("Journal Template Name", 'GENERAL');
                                GenJnlLine2.SetRange("Journal Batch Name", 'CLAIM');
                                if GenJnlLine2.FindLast then
                                    GenJnlLine."Line No." := GenJnlLine2."Line No." + 10000;
                                GenJnlLine."Source Code" := 'GENJNL';
                                GenJnlLine."Posting Date" := Today;
                                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                                GenJnlLine."Document No." := Rec."No.";
                                GenJnlLine."External Document No." := Rec."Imprest No";
                                GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
                                GenJnlLine."Account No." := Rec."Paying Account No";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine.Description := Rec.Purpose + ' ' + PurchLine6."Description 2";
                                //'Surrender: '+"Account No"+' '+"Imprest No";
                                GenJnlLine.Amount := -1 * PurchLine6."Amount Spent";
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                                GenJnlLine."Bal. Account No." := PurchLine6."Expense Account";
                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                GenJnlLine."Bal. Gen. Posting Type" := GenJnlLine."bal. gen. posting type"::Sale;
                                //Added for Currency Codes
                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.Validate("Currency Code");
                                GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                GenJnlLine.Validate("Currency Factor");
                                GenJnlLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                GenJnlLine.ValidateShortcutDimCode(5, PurchLine6."ShortcutDimCode[5]");
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
                                GenJnlLine."Journal Batch Name" := 'CLAIM';
                                GenJnlLine2.Reset;
                                GenJnlLine2.SetRange("Journal Template Name", 'GENERAL');
                                GenJnlLine2.SetRange("Journal Batch Name", 'CLAIM');
                                if GenJnlLine2.FindLast then
                                    GenJnlLine."Line No." := GenJnlLine2."Line No." + 10000;
                                GenJnlLine."Source Code" := 'GENJNL';
                                GenJnlLine."Posting Date" := Today;
                                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                                GenJnlLine."Document No." := Rec."No.";
                                GenJnlLine."External Document No." := Rec."Imprest No";
                                GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
                                GenJnlLine."Account No." := Rec."Account No";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine.Description := 'Refund on ' + Rec.Purpose + ' ' + PurchLine6."Description 2";
                                //'Surrender: '+"Account No"+' '+"Imprest No";
                                GenJnlLine.Amount := -1 * PurchLine6."Cash Refund";
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"Bank Account";
                                GenJnlLine."Bal. Account No." := PurchLine6."Cash Refund  Account";
                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                //Added for Currency Codes
                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.Validate("Currency Code");
                                GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                GenJnlLine.Validate("Currency Factor");
                                GenJnlLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, PurchLine6."ShortcutDimCode[3]");
                                GenJnlLine.ValidateShortcutDimCode(4, PurchLine6."ShortcutDimCode[4]");
                                GenJnlLine.ValidateShortcutDimCode(5, PurchLine6."ShortcutDimCode[5]");
                                if GenJnlLine.Amount <> 0 then
                                    GenJnlLine.Insert;
                            until PurchLine6.Next = 0;
                        end;





                        GenJnlLine.Reset;
                        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'GENERAL');
                        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'CLAIM');
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnlLine);
                        Rec.Completed := true;

                        PurchaseHeader2.Reset;
                        PurchaseHeader2.SetRange("No.", Rec."Imprest No");
                        if PurchaseHeader2.FindFirst then begin
                            PurchaseHeader2.Completed := true;
                            PurchaseHeader2.Surrendered := true;
                            //PurchaseHeader2."Imprest No":="No.";
                            PurchaseHeader2.Modify;
                        end;

                        Rec.Modify;

                        GenJnlLine2.Reset;
                        GenJnlLine2.SetRange("Journal Template Name", 'GENERAL');
                        GenJnlLine2.SetRange("Journal Batch Name", 'CLAIM');
                        if GenJnlLine2.FindFirst then
                            GenJnlLine2.DeleteAll;

                        Message('Claim posted Successfully');
                    end;

                end;
            }
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                begin
                    //WorkflowsEntriesBuffer.RunWorkflowEntriesPage(Rec.RecordId, Database::"Purchase Header", Rec."Document Type", Rec."No.");
                end;
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
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if LinesCommitted then
                        Error('All Lines should be committed');
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(80053, true, true, Rec);
                    //Reset;
                    //DocPrint.PrintPurchHeader(Rec);
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
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec."Assigned User ID" := UserId;
    end;

    trigger OnOpenPage()
    begin
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

    end;

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
}

