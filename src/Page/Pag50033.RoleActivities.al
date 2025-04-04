Page 50033 "Role Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Activities Cue";

    layout
    {
        area(content)
        {
            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                // field("Requests to Approve";Rec."Requests to Approve")
                // {
                //     ApplicationArea = Suite;
                //     DrillDownPageID = "Requests to Approve";
                //     ToolTip = 'Specifies the number of approval requests that require your approval.';
                // }
            }
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
            cuegroup("Incoming Documents")
            {
                Caption = 'Incoming Documents';
                field("My Incoming Documents"; Rec."My Incoming Documents")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies incoming documents that are assigned to you.';
                }
                field("Awaiting Verfication"; Rec."Inc. Doc. Awaiting Verfication")
                {
                    ApplicationArea = Suite;
                    DrillDown = true;
                    ToolTip = 'Specifies incoming documents in OCR processing that require you to log on to the OCR service website to manually verify the OCR values before the documents can be received.';
                    Visible = ShowAwaitingIncomingDoc;

                    trigger OnDrillDown()
                    var
                        OCRServiceSetup: Record "OCR Service Setup";
                    begin
                        if OCRServiceSetup.Get then
                            if OCRServiceSetup.Enabled then
                                Hyperlink(OCRServiceSetup."Sign-in URL");
                    end;
                }
            }
            cuegroup("Data Integration")
            {
                Caption = 'Data Integration';
                Visible = ShowDataIntegrationCues;
                field("CDS Integration Errors"; Rec."CDS Integration Errors")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Integration Errors';
                    DrillDownPageID = "Integration Synch. Error List";
                    ToolTip = 'Specifies the number of errors related to data integration.';
                    Visible = ShowIntegrationErrorsCue;
                }
                field("Coupled Data Synch Errors"; Rec."Coupled Data Synch Errors")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Coupled Data Synchronization Errors';
                    DrillDownPageID = "CRM Skipped Records";
                    ToolTip = 'Specifies the number of errors that occurred in the latest synchronization of coupled data between Business Central and Dynamics 365 for Sales.';
                    Visible = ShowD365SIntegrationCues;
                }
            }
            cuegroup("My User Tasks")
            {
                Caption = 'My User Tasks';
                field("UserTaskManagement.GetMyPendingUserTasksCount"; UserTaskManagement.GetMyPendingUserTasksCount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending User Tasks';
                    Image = Checklist;
                    ToolTip = 'Specifies the number of pending tasks that are assigned to you or to a group that you are a member of.';

                    trigger OnDrillDown()
                    var
                        UserTaskList: Page "User Task List";
                    begin
                        UserTaskList.SetPageToShowMyPendingUserTasks;
                        UserTaskList.Run;
                    end;
                }
            }
            cuegroup("Product Videos")
            {
                Caption = 'Product Videos';
                Visible = ShowProductVideosActivities;

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
                    //CueSetup.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
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
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
            Commit;
            NewRecord := true;
        end;



        PrepareOnLoadDialog;

        ShowAwaitingIncomingDoc := OCRServiceMgt.OcrServiceIsEnable;
        ShowIntercompanyActivities := false;
        ShowDocumentsPendingDocExchService := false;
        ShowProductVideosActivities := ClientTypeManagement.GetCurrentClientType <> Clienttype::Phone;
        //ShowIntelligentCloud := not PermissionManager.SoftwareAsAService;
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
        CueSetup: Codeunit 1907;
        O365GettingStartedMgt: Codeunit "O365 Getting Started Mgt.";
        ClientTypeManagement: Codeunit 4030;
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

    end;

    local procedure StartWhatIsNewTour(hasTourCompleted: Boolean)
    var
        O365UserTours: Record "User Tours";
        TourID: Integer;
    begin
        TourID := O365GettingStartedMgt.GetWhatIsNewTourID;

        if O365UserTours.AlreadyCompleted(TourID) then
            exit;

    

        if WhatIsNewTourVisible then begin
            O365UserTours.MarkAsCompleted(TourID);
            WhatIsNewTourVisible := false;
        end;
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
    
        exit(true);
    end;



    // trigger UserTours::ShowTourWizard(hasTourCompleted: Boolean)
    // var
    //     NetPromoterScoreMgt: Codeunit UnknownCodeunit1432;
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

