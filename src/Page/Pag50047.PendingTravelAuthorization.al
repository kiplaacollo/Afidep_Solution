Page 50047 "Pending Travel Authorization"
{
    Caption = 'Imprest Requisition Pending Approval';
    CardPageID = "Imprest Requisition";
    Editable = true;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = where("AU Form Type" = filter("Imprest Requisition"),
                            Status = filter("Pending Approval")
                          );


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }

                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(CustomerBalance; Rec.CustomerBalance)
                {
                    ApplicationArea = basic;
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
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code") { ApplicationArea = all; Visible = false; }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                field(Amount; Rec."Travel Total")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Total Imprest Amount';
                }


                field("Responsibility Center"; Rec."Responsibility Center") { ApplicationArea = all; Editable = false; Caption = 'Department'; }


                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Mission Naration"; Rec."Mission Naration") { ApplicationArea = basic; }


                field(fromDate; Rec.fromDate) { ApplicationArea = all; Caption = 'Activity start date'; }
                field("Payment Terms Code"; Rec."Payment Terms Code") { ApplicationArea = all; Caption = 'Period'; Visible = false; }

                field("Document Type"; Rec."Document Type") { ApplicationArea = all; Visible = false; }
                field("Due Date"; Rec."Due Date") { ApplicationArea = all; Caption = 'Activity End Date'; }

                field("User ID"; Rec."User ID") { ApplicationArea = basic; Enabled = false; }
                field("Paying Account No"; Rec."Paying Account No")
                {
                    Caption = 'Paying Account No(Finance)';
                    ApplicationArea = Basic;
                    Visible = false;
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
                    Visible = false;
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

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date';
                    ShowMandatory = true;
                }
                field(Posted; Rec.Posted) { ApplicationArea = all; Enabled = false; Visible = true; }
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
                action(Approvals)
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
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        PayablesSetup: Record "Purchases & Payables Setup";
        Pheader: Record "Purchase Header";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        PayablesSetup.Get();
        Rec."No." := NoSeriesManagement.GetNextNo(PayablesSetup."Imprest Nos.", Today, true);
        Rec."AU Form Type" := Rec."au form type"::"Imprest Requisition";
        Rec."Assigned User ID" := UserId;
        Rec."User ID" := UserId;
        Rec."Requested Receipt Date" := Today;
        Rec."Posting Description" := format(Rec."AU Form Type"::"Imprest Requisition");



        Message('%1', PayablesSetup."Imprest Nos.");


    end;

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

