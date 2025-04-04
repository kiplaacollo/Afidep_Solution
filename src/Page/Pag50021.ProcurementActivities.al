Page 50021 "Procurement Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Activities Cue";
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            cuegroup(Welcome)
            {
                Caption = 'Welcome';
                Visible = TileGettingStartedVisible;

                actions
                {
                    action(GettingStartedTile)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Return to Getting Started';
                        Image = TileVideo;
                        ToolTip = 'Learn how to get started with Dynamics 365.';

                        trigger OnAction()
                        begin
                            O365GettingStartedMgt.LaunchWizard(true, false);
                        end;
                    }
                }
            }
            cuegroup("Ongoing Purchases")
            {
                Caption = 'Ongoing Purchases';
                field("Purchase Orders"; Rec."Purchase Orders")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Purchase Order List";
                    ToolTip = 'Specifies purchases orders that are not posted or only partially posted.';
                }
                field("Ongoing Purchase Invoices"; Rec."Ongoing Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Purchase Invoices";
                    ToolTip = 'Specifies purchases invoices that are not posted or only partially posted.';
                }
                field("Purch. Invoices Due Next Week"; Rec."Purch. Invoices Due Next Week")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of payments to vendors that are due next week.';
                }
            }
            // cuegroup(Approvals)
            // {
            //     Caption = 'Approvals';
            //     field()
            //     {
            //         ApplicationArea = Suite;
            //         DrillDownPageID = "Requests to Approve";
            //         ToolTip = 'Specifies the number of approval requests that require your approval.';
            //     }
            // }
            cuegroup(Camera)
            {
                Caption = 'Camera';
                Visible = HasCamera;

                actions
                {
                    action(CreateIncomingDocumentFromCamera)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Create Incoming Doc. from Camera';
                        Image = TileCamera;
                        ToolTip = 'Create an incoming document by taking a photo of the document with your mobile device camera. The photo will be attached to the new document.';

                    
                    }
                }
            }
            cuegroup("Data Integration")
            {
                Caption = 'Data Integration';
                Visible = ShowDataIntegrationCues;
                field("CDS Integration Errors"; rec."CDS Integration Errors")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Integration Errors';
                    DrillDownPageID = "Integration Synch. Error List";
                    ToolTip = 'Specifies the number of errors related to data integration.';
                    Visible = ShowIntegrationErrorsCue;
                }
                field("Coupled Data Synch Errors"; rec."Coupled Data Synch Errors")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Coupled Data Synchronization Errors';
                    DrillDownPageID = "CRM Skipped Records";
                    ToolTip = 'Specifies the number of errors that occurred in the latest synchronization of coupled data between Business Central and Dynamics 365 for Sales.';
                    Visible = ShowD365SIntegrationCues;
                }
            }
            cuegroup(Control54)
            {
                CueGroupLayout = Wide;
                field("Overdue Purch. Invoice Amount"; rec."Overdue Purch. Invoice Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of your overdue payments to vendors.';

                    trigger OnDrillDown()
                    begin
                        ActivitiesMgt.DrillDownOverduePurchaseInvoiceAmount;
                    end;
                }
            }
            cuegroup("Product Videos")
            {
                Caption = 'Product Videos';
                Visible = false;

                actions
                {
                    action(Action43)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Product Videos';
                        Image = TileVideo;
                        // RunObject = Page UnknownPage1470;
                        ToolTip = 'Open a list of videos that showcase some of the product capabilities.';
                    }
                }
            }
            cuegroup("Get started")
            {
                Caption = 'Get started';
                Visible = ReplayGettingStartedVisible;

                actions
                {
                    action(ShowStartInMyCompany)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Try with my own data';
                        Image = TileSettings;
                        ToolTip = 'Set up My Company with the settings you choose. We''ll show you how, it''s easy.';
                        Visible = false;

                        trigger OnAction()
                        begin
                        
                        end;
                    }
                    action(ReplayGettingStarted)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Replay Getting Started';
                        Image = TileVideo;
                        ToolTip = 'Show the Getting Started guide again.';

                        trigger OnAction()
                        var
                            O365GettingStarted: Record "O365 Getting Started";
                        begin
                            if O365GettingStarted.Get(UserId, ClientTypeManagement.GetCurrentClientType) then begin
                                O365GettingStarted."Tour in Progress" := false;
                                O365GettingStarted."Current Page" := 1;
                                O365GettingStarted.Modify;
                                Commit;
                            end;

                            O365GettingStartedMgt.LaunchWizard(true, false);
                        end;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RefreshData)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Refresh Data';
                Image = Refresh;
                ToolTip = 'Refreshes the data needed to make complex calculations.';

                trigger OnAction()
                begin
                    Rec."Last Date/Time Modified" := 0DT;
                    Rec.Modify;

                    Codeunit.Run(Codeunit::"Activities Mgt.");
                    CurrPage.Update(false);
                end;
            }
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
                    CueSetup.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
    begin
     
    end;

    trigger OnAfterGetRecord()
    begin
        SetActivityGroupVisibility;
    end;

    trigger OnInit()
    begin
       
    end;

    trigger OnOpenPage()
    var
        CRMConnectionSetup: Record "CRM Connection Setup";
        IntegrationSynchJobErrors: Record "Integration Synch. Job Errors";
        OCRServiceMgt: Codeunit "OCR Service Mgt.";
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
        ConfPersonalizationMgt: Codeunit "Conf./Personalization Mgt.";
        NewRecord: Boolean;
    begin



        //rec.SetFilter(Rec.usr,UserId);


      

        ShowAwaitingIncomingDoc := OCRServiceMgt.OcrServiceIsEnable;
        ShowIntercompanyActivities := false;
        ShowDocumentsPendingDocExchService := false;
        ShowProductVideosActivities := ClientTypeManagement.GetCurrentClientType <> Clienttype::Phone;
        ///ShowIntelligentCloud := not PermissionManager.SoftwareAsAService;
        IntegrationSynchJobErrors.SetDataIntegrationUIElementsVisible(ShowDataIntegrationCues);
        ShowD365SIntegrationCues := CRMConnectionSetup.IsEnabled;
        ShowIntegrationErrorsCue := ShowDataIntegrationCues and (not ShowD365SIntegrationCues);
        RoleCenterNotificationMgt.ShowNotifications;
        ConfPersonalizationMgt.RaiseOnOpenRoleCenterEvent;

        if NewRecord then begin
            Codeunit.Run(Codeunit::"Activities Mgt.");
            exit;
        end;

        if ActivitiesMgt.IsCueDataStale then
            if not TaskScheduler.CanCreateTask then
                Codeunit.Run(Codeunit::"Activities Mgt.")
            else
                TaskScheduler.CreateTask(Codeunit::"Activities Mgt.", 0, true, COMPANYNAME, CurrentDatetime);
    end;

    var
        ActivitiesMgt: Codeunit "Activities Mgt.";
        CueSetup: Codeunit "Cues And KPIs";
        O365GettingStartedMgt: Codeunit "O365 Getting Started Mgt.";
        ClientTypeManagement: Codeunit "Client Type Management";
        PermissionManager: Codeunit "Permission Manager";
        UserTaskManagement: Codeunit "User Task Management";
  
        HasCamera: Boolean;
        ShowDocumentsPendingDocExchService: Boolean;
        ShowAwaitingIncomingDoc: Boolean;
        ShowIntercompanyActivities: Boolean;
        ShowProductVideosActivities: Boolean;
        ShowIntelligentCloud: Boolean;
        TileGettingStartedVisible: Boolean;
        ReplayGettingStartedVisible: Boolean;
        HideNpsDialog: Boolean;
        WhatIsNewTourVisible: Boolean;
        ShowD365SIntegrationCues: Boolean;
        ShowDataIntegrationCues: Boolean;
        ShowIntegrationErrorsCue: Boolean;

    local procedure SetActivityGroupVisibility()
    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";
        CompanyInformation: Record "Company Information";
    begin
        if DocExchServiceSetup.Get then
            ShowDocumentsPendingDocExchService := DocExchServiceSetup.Enabled;

        //if CompanyInformation.Get then
        //ShowIntercompanyActivities :=
        // (CompanyInformation."IC Partner Code" <> '') and (("IC Inbox Transactions" <> 0) or ("IC Outbox Transactions" <> 0));
    end;

    local procedure StartWhatIsNewTour(hasTourCompleted: Boolean)
    var
        O365UserTours: Record "User Tours";
        TourID: Integer;
    begin
        TourID := O365GettingStartedMgt.GetWhatIsNewTourID;

        if O365UserTours.AlreadyCompleted(TourID) then
            exit;

     

      
    end;

    local procedure PrepareOnLoadDialog()
    begin
        if PrepareUserTours then
            exit;
        PreparePageNotifier;
    end;

    local procedure PreparePageNotifier()
    begin
  
    end;

    local procedure PrepareUserTours(): Boolean
    var
    //NetPromoterScore: Record UnknownRecord1433;
    begin
     
      
    end;

 

    // trigger UserTours::ShowTourWizard(hasTourCompleted: Boolean)
    // var
    //     NetPromoterScoreMgt: Codeunit 1432;
    // begin
    //     if O365GettingStartedMgt.IsGettingStartedSupported then
    //       if O365GettingStartedMgt.LaunchWizard(false,hasTourCompleted) then
    //         exit;

    //     if (not hasTourCompleted) and (not HideNpsDialog) then
    //       if NetPromoterScoreMgt.ShowNpsDialog then begin
    //         HideNpsDialog := true;
    //         exit;
    //       end;

    //     StartWhatIsNewTour(hasTourCompleted);
    // end;


    // trigger Pagenotifier::PageReady()
    // var
    //     NetPromoterScoreMgt: Codeunit UnknownCodeunit1432;
    // begin
    //     if O365GettingStartedMgt.WizardShouldBeOpenedForDevices then begin
    //       Commit;
    //       Page.RunModal(Page::"O365 Getting Started Device");
    //       exit;
    //     end;

    //     if not HideNpsDialog then
    //       if NetPromoterScoreMgt.ShowNpsDialog then
    //         HideNpsDialog := true;
    // end;
}

