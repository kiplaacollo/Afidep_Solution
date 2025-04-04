page 80143 "Staff Dashboard Cue"
{
    Caption = 'Infomation Analysis';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Staff Cue";

    layout
    {
        area(content)
        {
#if not CLEAN18
            cuegroup("Intelligent Cloud")
            {
                Caption = 'Intelligent Cloud';
                Visible = false;
                ObsoleteTag = '18.0';
                ObsoleteReason = 'Intelligent Cloud Insights is discontinued.';
                ObsoleteState = Pending;

                actions
                {
                    action("Learn More")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Learn More';
                        Image = TileInfo;
                        RunPageMode = View;
                        ToolTip = ' Learn more about the Intelligent Cloud and how it can help your business.';
                        Visible = false;
                        ObsoleteTag = '18.0';
                        ObsoleteReason = 'Intelligent Cloud Insights is discontinued.';
                        ObsoleteState = Pending;

                        trigger OnAction()
                        var
                            IntelligentCloudManagement: Codeunit "Intelligent Cloud Management";
                        begin
                            HyperLink(IntelligentCloudManagement.GetIntelligentCloudLearnMoreUrl);
                        end;
                    }
                    action("Intelligent Cloud Insights")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Intelligent Cloud Insights';
                        Image = TileCloud;
                        RunPageMode = View;
                        ToolTip = 'View your Intelligent Cloud insights.';
                        Visible = false;
                        ObsoleteTag = '18.0';
                        ObsoleteReason = 'Intelligent Cloud Insights is discontinued.';
                        ObsoleteState = Pending;

                        trigger OnAction()
                        var
                            IntelligentCloudManagement: Codeunit "Intelligent Cloud Management";
                        begin
                            HyperLink(IntelligentCloudManagement.GetIntelligentCloudInsightsUrl);
                        end;
                    }
                }
            }
            cuegroup(PaymentVoucher)
            {
                Caption = 'Payment Vouchers Form';
                field("Payment Voucher New - All"; Rec."Payment Voucher New - All")
                {

                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Payment Voucher List";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Payment Voucher Pending Ap"; Rec."Payment Voucher Pending Ap")
                {
                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Payment Voucher List(Pending)";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Payment Voucher Approved - All"; Rec."Payment Voucher Approved - All")
                {
                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Payment Voucher List(Approved)";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Payment Voucher Posted - All"; Rec."Payment Voucher Posted - All")
                {
                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Payment Voucher List(Posted)";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }


            }
            cuegroup(ImprestRequisition)
            {
                Caption = 'Imprest Requisition Form';
                field("Travel Requsition Form New - All"; Rec."Imprest Requisition New")
                {
                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "New Travel Authorization";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Travel Requsition Form Pending Approval - All"; Rec."Imprest Requisition Pending Approval")
                {

                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Pending Travel Authorization";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Travel Requsition Form Approved - All"; Rec."Imprest Requisition Approved")
                {
                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Approved Travel Authorization";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }


            }
            cuegroup(PurchaseRequisition)
            {
                Caption = 'Purchase Requisition';
                field("Purchase Request New - All"; Rec."Purchase Request New - All")
                {
                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Task Order";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Purchase Request Pending Approval - All"; Rec."Purchase Request Pending Approval - All")
                {

                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Pending Purchase Requisition";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Purchase Request Approved - All"; Rec."Purchase Request Approved - All")
                {
                    ApplicationArea = Manufacturing;
                    // DrillDownPageID = "Approved Purchase Requisition";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
            }
            cuegroup(LocalPurchaseOrders)
            {
                Caption = 'Local Purchase Orders';
                field("LPOs"; Rec."Purchase Orders")
                {
                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Purchase Order List";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
            }
            cuegroup("LeaveManagement")
            {
                Caption = 'Leave Application Management';
                field("Leave Application New"; Rec."Leave Application New")
                {
                    ApplicationArea = basic;
                    DrillDownPageID = "HR Leave Applications List";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Leave Application Pending Approval"; Rec."Leave Application Pending Approval")
                {
                    ApplicationArea = basic;
                    DrillDownPageID = "HR Leave Applications List";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Leave Application Approved"; Rec."Leave Application Approved")
                {
                    ApplicationArea = basic;
                    DrillDownPageID = "HR Leave Applications List";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Leave Application Posted"; Rec."Leave Application Posted")
                {
                    ApplicationArea = basic;
                    DrillDownPageID = "HR Leave Applications List";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Leave Application Rejected"; Rec."Leave Application Rejected")
                {
                    ApplicationArea = basic;
                    DrillDownPageID = "HR Leave Applications List";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }


            }
#endif

            cuegroup("Travel/Expenditure Voucher")
            {
                Caption = 'Travel/Expenditure Voucher';
                Visible = false;
                field("Travel/Expenditure New"; Rec."Travel/Expenditure New ")
                {
                    ApplicationArea = basic;
                    DrillDownPageID = "New Travel Accounting";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Travel/Expenditure Pending Approval - All"; Rec."Travel/Expenditure Pending Approval")
                {
                    ApplicationArea = basic;
                    DrillDownPageID = "Pending Travel Accounting";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Travel/Expenditure Approved - All"; Rec."Travel/Expenditure Approved")
                {
                    ApplicationArea = basic;
                    DrillDownPageID = "Approved Travel Accounting";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Travel/Expenditure Vouchers Posted - All"; Rec."Travel/Expenditure Vouchers Posted")
                {
                    ApplicationArea = basic;
                    DrillDownPageID = "Posted Travel Accounting";
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }


            }


            /*cuegroup(CashRequisitionForm)
            {
                Caption = 'Cash Requisition Form';
                field("Request Form New - All"; Rec."Request Form New - All")
                {
                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Request List";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Request Form Pending Approval - All"; Rec."Request Form Pending Approval - All")
                {

                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Request List Pending";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Request Form Approved - All"; Rec."Request Form Approved - All")
                {
                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Request List Approved";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }


            }*/
            /*cuegroup(PurchaseQuotes)
            {
                Caption = 'Purchase Quotes';
                field("Purchase Quote Awarded - All";Rec."Purchase Quote Awarded - All")
                {
                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "PQ Awarded List ";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Purchase Quote NOT Awarded - All";Rec."Purchase Quote NOT Awarded - All")
                {

                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "PQ NOT Awarded List ";
                    ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
              


            }*/
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        Rec.SetRange("User ID Filter", UserId());

        ShowIntelligentCloud := not EnvironmentInfo.IsSaaS();
    end;

    var
        CuesAndKpis: Codeunit "Cues And KPIs";
        EnvironmentInfo: Codeunit "Environment Information";
        ShowIntelligentCloud: Boolean;
}

