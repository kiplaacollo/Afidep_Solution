page 80144 "Imp. Acc Dashboard Cue"
{
    Caption = 'Imprest Infomation Analysis';
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
                Visible = true;
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
            cuegroup(ImprestAccounting)
            {
                Caption = 'Approved Imprest Accounting';
                field("Imprest Accounting Approved"; Rec."Imprest Accounting Approved K")
                {
                    Caption = 'Imprest Accounting Kenya';
                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Approved Travel Accounting";
                    trigger OnDrillDown()
                    var
                        ImprestRec: Record "Purchase Header";
                    begin
                        ImprestRec.Reset();
                        ImprestRec.SetRange(ImprestRec."Shortcut Dimension 1 Code", 'Kenya');
                        Page.Run(Page::"Approved Travel Accounting", ImprestRec);
                    end;
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Imprest Accounting Approved M"; Rec."Imprest Accounting Approved M")
                {
                    Caption = 'Imprest Accounting Malawi';
                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Approved Travel Accounting";
                    trigger OnDrillDown()
                    var
                        ImprestRec: Record "Purchase Header";
                    begin
                        ImprestRec.Reset();
                        ImprestRec.SetRange(ImprestRec."Shortcut Dimension 1 Code", 'MALAWI');
                        Page.Run(Page::"Approved Travel Accounting", ImprestRec);
                    end;
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }


                field("Travel Requsition Form Approved - All"; Rec."Imprest Request Approved K")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Approved Imprest Request Kenya';
                    DrillDownPageID = "Approved Travel Authorization";
                    trigger OnDrillDown()
                    var
                        ImprestRec: Record "Purchase Header";
                    begin
                        ImprestRec.Reset();
                        ImprestRec.SetRange(ImprestRec."Shortcut Dimension 1 Code", 'KENYA');
                        Page.Run(Page::"Approved Travel Authorization", ImprestRec);
                    end;
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Travel Requsition Form Approved - M"; Rec."Imprest Request Approved M")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Approved Imprest Request Malawi';
                    DrillDownPageID = "Approved Travel Authorization";
                    trigger OnDrillDown()
                    var
                        ImprestRec: Record "Purchase Header";
                    begin
                        ImprestRec.Reset();
                        ImprestRec.SetRange(ImprestRec."Shortcut Dimension 1 Code", 'MALAWI');
                        Page.Run(Page::"Approved Travel Authorization", ImprestRec);
                    end;
                    //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                }



            }
            cuegroup(ImprestRequisition)
            {
                Caption = 'Imprest Requisition Form';
                Visible = false;
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
                // field("Travel Requsition Form Approved - All"; Rec."Imprest Request Approved K")
                // {
                //     ApplicationArea = Manufacturing;
                //     Caption = 'Imprest Request Kenya';
                //     DrillDownPageID = "Approved Travel Authorization";
                //     trigger OnDrillDown()
                //     var
                //         ImprestRec: Record "Purchase Header";
                //     begin
                //         ImprestRec.Reset();
                //         ImprestRec.SetRange(ImprestRec."Shortcut Dimension 1 Code", 'KENYA');
                //         Page.Run(Page::"Approved Travel Authorization", ImprestRec);
                //     end;
                //     //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                // }
                // field("Travel Requsition Form Approved - M"; Rec."Imprest Request Approved M")
                // {
                //     ApplicationArea = Manufacturing;
                //     Caption = 'Imprest Request Malawi';
                //     DrillDownPageID = "Approved Travel Authorization";
                //     trigger OnDrillDown()
                //     var
                //         ImprestRec: Record "Purchase Header";
                //     begin
                //         ImprestRec.Reset();
                //         ImprestRec.SetRange(ImprestRec."Shortcut Dimension 1 Code", 'MALAWI');
                //         Page.Run(Page::"Approved Travel Authorization", ImprestRec);
                //     end;
                //     //ToolTip = 'Specifies the number of simulated production orders that are displayed in the Manufacturing Cue on the Role Center. The documents are filtered by today''s date.';
                // }


            }

#endif


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

