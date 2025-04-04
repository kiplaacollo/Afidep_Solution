Page 80118 "Payment Voucher List(Approved)"
{
    Caption = 'Payment Voucher List Approved';
    CardPageID = 80101;
    Editable = true;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = sorting("Document Type", "No.")
                      order(descending)
                      where(/*PV = const(true),*/ Status = filter(Released), Posted = filter(false), "AU Form Type" = filter('Payment Voucher'));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }

                field("AU Form Type"; Rec."AU Form Type") { ApplicationArea = all; }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date';
                }
                field("Payee Naration"; Rec."Payee Naration")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payee';
                    //Visible = false;
                }
                field("Paying Account Name"; Rec."Paying Account Name")
                {
                    ApplicationArea = basic;

                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Invoice No"; Rec."Invoice No") { ApplicationArea = BASIC; }
                field("Imprest No"; Rec."Imprest No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; Rec.Amount) { ApplicationArea = all; }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount") { ApplicationArea = all; }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
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

            action("&Print")
            {
                ApplicationArea = Basic;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if LinesCommitted then
                        Error('All Lines should be committed');
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(80054, true, true, Rec);
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

            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec."Assigned User ID" := UserId;

    end;

    trigger OnOpenPage()
    begin

    end;

    var
        DimMgt: Codeunit DimensionManagement;
        DocPrint: Codeunit "Document-Print";
        HREmp: Record "HR Employees";


    procedure LinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin


    end;
}

