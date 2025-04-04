Page 50068 "Posted Claim Authorization"
{
    Caption = 'Posted Claim Authorization';
    CardPageID = "Travel Claim";
    Editable = true;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type"=const(Quote),
                            Status=filter(Released),
                            MP=filter(true),
                            Archived=const(false),
                            Completed=const(true));

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
                field(Status;Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Purpose;Rec.Purpose)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Description";Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Destination';
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Shortcut Dimension 2 Code";Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No";Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name";Rec."Employee Name")
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
                      Rec.SetRange("No.",Rec."No.");
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

    end;

    var
        DimMgt: Codeunit DimensionManagement;
        DocPrint: Codeunit "Document-Print";
        HREmp: Record "HR Employees";


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

