Page 50120 "SalesInvoice List"
{
    Caption = 'Sales Invoice List';
    CardPageID = 80101;
    Editable = true;
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = sorting("Document Type", "No.")
                      order(descending)
                      where(/*pv = const(true),*/ Status = filter(Open));// "Document Type" = filter('Payment Voucher'));

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

                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {

                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic;
                    // Caption = 'Payee';
                    //Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = basic;

                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic;
                    //  Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    // Visible = false;
                }
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
                    Report.Run(80028, true, true, Rec);
                    //Reset;
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            group(Release)
            {
                Caption = 'Approve';
                Image = ReleaseDoc;
                separator(Action1102601013)
                {
                }
                action("Re&lease")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //  ReleasePurchDoc.PerformManualRelease(Rec);
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
                        //  ReleasePurchDoc.PerformManualReopen(Rec);
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

