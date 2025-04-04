Page 80060 "Task Order"
{
    Caption = 'Purchase Requisitions';
    CardPageID = "Task Order Card";
    Editable = true;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = sorting("Document Type", "No.")
                      order(descending)where("Document Type" = const(Quote),"AU Form Type" = filter("Purchase Requisition")
                            ,Status=filter(Open));
    // SourceTableView = where("Document Type"=const(Quote),
                            
    //                         Status=filter(Open),
    //                         PR=filter(true),
    //                         Requisition=filter(true),
    //                         Service=const(false),
    //                         Archived=const(false));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Payee Naration";Rec."Payee Naration")
                {
                    ApplicationArea=basic;
                  //  Caption='Transaction Description';
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Expected Receipt Date";Rec."Expected Receipt Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Required';

                    trigger OnValidate()
                    begin
                        /*IF "Expected Receipt Date"<TODAY THEN
                          ERROR('Date cannot be in the past');*/

                    end;
                }
                
                field("Responsibility Center";Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Caption='Department';
                    Importance = Additional;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code";Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Visible=false;
                }
                field("Posting Description";Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Employee No";Rec."Employee No")
                {
                    ApplicationArea = Basic;
                    Visible=false;
                    
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Visible=false;
                    
                }
                field("Employee Name";Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Caption='Requested By';
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea=basic;
                    Caption='Total Amount';
                    Editable=false;
                }
                field("Order Address Code";Rec."Order Address Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Buy-from Vendor Name";Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Vendor Authorization No.";Rec."Vendor Authorization No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Buy-from Post Code";Rec."Buy-from Post Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Buy-from Country/Region Code";Rec."Buy-from Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Buy-from Contact";Rec."Buy-from Contact")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Pay-to Vendor No.";Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Pay-to Name";Rec."Pay-to Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Pay-to Post Code";Rec."Pay-to Post Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Pay-to Country/Region Code";Rec."Pay-to Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Pay-to Contact";Rec."Pay-to Contact")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Ship-to Code";Rec."Ship-to Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Ship-to Name";Rec."Ship-to Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Ship-to Post Code";Rec."Ship-to Post Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Ship-to Country/Region Code";Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Ship-to Contact";Rec."Ship-to Contact")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Posting Date";Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Currency Code";Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Campaign No.";Rec."Campaign No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(DocApprovalType;Rec.DocApprovalType2)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(PR;Rec.PR)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Requisition;Rec.Requisition)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Buy-from Vendor No.";Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
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
                        Page.RunModal(Page::"Purchase Statistics",Rec);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type"=field("Document Type"),
                                  "No."=field("No."),
                                  "Document Line No."=const(0);
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
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(Database::"Purchase Header",Rec."Document Type",Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
        area(processing)
        {
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
                      Rec.SetRange(Rec."No.",Rec."No.");
                      Report.Run(51516100,true,true,Rec);
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

        Rec."Assigned User ID":=UserId;
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
        Rec."Assigned User ID":=UserId;

    end;

    var
        DimMgt: Codeunit DimensionManagement;
        DocPrint: Codeunit "Document-Print";
        HREmp: Record "HR Employees";
        Customer: Record "Customer";


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

