codeunit 50003 "Approval Notification"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnAfterDelegateApprovalRequest, '', false, false)]
    procedure Delegate(ApprovalEntry: Record "Approval Entry")
    var
        ApprovalSetup: Record "User Setup";
    begin
        ApprovalNotificationsetup.RESET;
        IF ApprovalNotificationsetup.FINDLAST THEN BEGIN
            EntryNo := ApprovalNotificationsetup."Entry No" + 1
        END ELSE
            EntryNo := EntryNo + 1;

        ApprovalNotificationsetup.INIT;
        ApprovalNotificationsetup."Entry No" := EntryNo;
        ApprovalNotificationsetup."Document No" := ApprovalEntry."Document No.";
        ApprovalSetup.Reset();
        ApprovalSetup.SetRange(ApprovalSetup."User ID", ApprovalEntry."Approver ID");
        if ApprovalSetup.FindFirst() then begin
            ApprovalNotificationsetup."Approver ID" := ApprovalSetup.Substitute;
        end;

        ApprovalNotificationsetup."Sender ID" := ApprovalEntry."Sender ID";
        ApprovalNotificationsetup."Employee Code" := ApprovalEntry."Employee Code";
        ApprovalNotificationSetup.Status := ApprovalEntry.Status;
        ApprovalNotificationsetup."Notification Type" := ApprovalNotificationsetup."Notification Type"::"Send Approval";
        ApprovalNotificationsetup.INSERT(TRUE);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", OnBeforeModifyEvent, '', false, false)]
    local procedure modify(var Rec: Record "Approval Entry")
    var
        PurchaseHeader: Record "Purchase Header";
        HRLeaveApplication: Record "HR Leave Application";

    begin
        ApprovalNotificationsetup.Reset();
        ApprovalNotificationsetup.SetRange("Document No", Rec."Document No.");
        if ApprovalNotificationSetup.Find('-') then begin
            ApprovalNotificationSetup.Status := Rec.Status;
            ApprovalNotificationsetup.Modify();
        end;
    end;





    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure SendNotificationEmail(var Rec: Record "Approval Entry")
    var
        PurchaseHeader: Record "Purchase Header";
        HRLeaveApplication: Record "HR Leave Application";
    begin
        PurchaseHeader.RESET;
        PurchaseHeader.SETRANGE(PurchaseHeader."No.", Rec."Document No.");
        IF PurchaseHeader.FIND('-') THEN BEGIN
            Rec."Employee Code" := PurchaseHeader."Employee No";
            Rec.Memo := PurchaseHeader."Payee Naration";
            Rec."Payment Voucher No" := PurchaseHeader."Bank No Series";
            Rec."Paying Bank Name" := PurchaseHeader."Paying Account Name";
            Rec."Paying Bank Number" := PurchaseHeader."Paying Account No";
            Rec."Employee Name" := PurchaseHeader."Employee Name";
            Rec."CashBook Narration" := PurchaseHeader."CashBook Naration";
            rec."Mission Narration" := PurchaseHeader."Mission Naration";
            rec."Document Types" := format(PurchaseHeader."AU Form Type");
            Rec.Modify(true);
            EmployeeName := '';
            emailAccount := '';
            HREmployee.Reset();
            HREmployee.SetRange(HREmployee."Employee UserID", Rec."Approver ID");
            if HREmployee.FindFirst() then begin
                EmployeeName := HREmployee."First Name" + ' ' + HREmployee."Last Name";
                emailAccount := HREmployee."Company E-Mail";
            end;


            //change trigger 
            // if emailAccount <> '' then begin
            //     EmailBody := 'Hello, an approval Request for Document number No ' + PurchaseHeader."No." + PurchaseHeader."Payee Naration" + format(PurchaseHeader.Amount) + ' is waiting your Attention.';
            //     EmailMessage.Create(emailAccount, 'Approval Request', EmailBody);
            //     EmailSend.Send(EmailMessage, enum::"Email Scenario"::Default);
            //     EmailNotification(Rec."Approver ID", EmailBody, EmployeeName);
            // end;
        END;

        //populate approval notification
        ApprovalNotificationsetup.RESET;
        IF ApprovalNotificationsetup.FINDLAST THEN BEGIN
            EntryNo := ApprovalNotificationsetup."Entry No" + 1
        END ELSE
            EntryNo := EntryNo + 1;
        ApprovalNotificationsetup.INIT;
        ApprovalNotificationsetup."Entry No" := EntryNo;
        ApprovalNotificationsetup."Document No" := Rec."Document No.";
        ApprovalNotificationsetup."Approver ID" := Rec."Approver ID";
        ApprovalNotificationsetup."Sender ID" := Rec."Sender ID";
        ApprovalNotificationsetup."Employee Code" := Rec."Employee Code";
        ApprovalNotificationSetup.Status := Rec.Status;
        ApprovalNotificationsetup."Notification Type" := ApprovalNotificationsetup."Notification Type"::"Send Approval";
        ApprovalNotificationsetup.INSERT(TRUE);
        HRLeaveApplication.RESET;
        HRLeaveApplication.SETRANGE(HRLeaveApplication."Application Code", Rec."Document No.");
        IF HRLeaveApplication.FIND('-') THEN BEGIN
            Rec."Document Types" := 'Leave Application';
            Rec."Employee Code" := HRLeaveApplication."Employee No";
            Rec."Employee Name" := HRLeaveApplication."Employee Name";
            Rec."Days Applied" := HRLeaveApplication."Days Applied";
            Rec."Leave Types" := HRLeaveApplication."Leave Type";
            Rec."Pending Task" := HRLeaveApplication."Pending Tasks";
            Rec.Modify(true);
            EmployeeName := '';
            emailAccount := '';

            ApprovalNotificationsetup.RESET;
            IF ApprovalNotificationsetup.FINDLAST THEN BEGIN
                EntryNo := ApprovalNotificationsetup."Entry No" + 1
            END ELSE
                EntryNo := EntryNo + 1;
            ApprovalNotificationsetup.INIT;
            ApprovalNotificationsetup."Entry No" := EntryNo;
            ApprovalNotificationsetup."Document No" := Rec."Document No.";
            ApprovalNotificationsetup."Approver ID" := Rec."Approver ID";
            ApprovalNotificationsetup."Sender ID" := Rec."Sender ID";
            ApprovalNotificationsetup."Employee Code" := Rec."Employee Code";
            ApprovalNotificationsetup."Notification Type" := ApprovalNotificationsetup."Notification Type"::"Send Approval";
            //  ApprovalNotificationsetup.INSERT(TRUE);
            HREmployee.Reset();
            HREmployee.SetRange(HREmployee."Employee UserID", Rec."Approver ID");
            if HREmployee.FindFirst() then begin
                //Message('email %1-inside%2', Rec."Approver ID", HREmployee."Employee UserID");
                EmployeeName := HREmployee."First Name" + ' ' + HREmployee."Last Name";
                emailAccount := HREmployee."Company E-Mail";
            end;
            /*
                        if emailAccount <> '' then begin
                            EmailBody := 'Hello, an approval Request for Document No ' + HRLeaveApplication."Application Code" + ' is waiting for your attention.';
                            EmailMessage.Create(emailAccount, 'Approval Request', EmailBody);
                            EmailSend.Send(EmailMessage, enum::"Email Scenario"::Default);
                            EmailNotification(Rec."Approver ID", EmailBody, EmployeeName);
                        end;*/
        END;
        //Message('%1', Rec."Employee Code");
        LastDocumentNo := '';
        Rec.Reset();
        Rec.SetFilter(Rec.Status, '%1', Rec.Status::Created);
        if Rec.FindLast then begin
            LastDocumentNo := Rec."Document No.";
        end;

        // Rec.Reset();
        // Rec.SetCurrentKey("Document No.");
        // Rec.SetRange(Rec."Document No.", LastDocumentNo);
        // Rec.SetFilter(Rec.Status, '%1', Rec.Status::Open);
        // if Rec.FindSet() then begin
        //     repeat

        //     until Rec.Next() = 0;
        // end;

    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    // local procedure OnApproveApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    // var
    //     LastDocumentNo2: Code[250];
    // begin
    //     LastDocumentNo := '';
    //     ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1', ApprovalEntry.Status::Approved);
    //     if ApprovalEntry.Find('-') then begin
    //         LastDocumentNo := ApprovalEntry."Document No.";
    //     end;
    //     LastDocumentNo2 := '';
    //     ApprovalEntry.Reset();
    //     ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1', ApprovalEntry.Status::Created);
    //     if ApprovalEntry.FindLast then begin
    //         LastDocumentNo2 := ApprovalEntry."Document No.";
    //     end;
    //     //populate Approval Entry
    //     ApprovalEntry.Get(ApprovalEntry."Entry No.");
    //     ApprovalNotificationsetup.RESET;
    //     IF ApprovalNotificationsetup.FINDLAST THEN BEGIN
    //         EntryNo := ApprovalNotificationsetup."Entry No" + 1
    //     END ELSE
    //         EntryNo := EntryNo + 1;
    //     ApprovalNotificationsetup.INIT;
    //     ApprovalNotificationsetup."Entry No" := EntryNo;
    //     ApprovalNotificationsetup."Document No" := ApprovalEntry."Document No.";
    //     ApprovalNotificationsetup."Approver ID" := ApprovalEntry."Approver ID";
    //     ApprovalNotificationsetup."Sender ID" := ApprovalEntry."Sender ID";
    //     ApprovalNotificationsetup."Employee Code" := ApprovalEntry."Employee Code";
    //     ApprovalNotificationsetup."Notification Type" := ApprovalNotificationsetup."Notification Type"::"Approve Document";
    //     ApprovalNotificationsetup.INSERT(TRUE);

    //     ApprovalEntry.Reset();
    //     ApprovalEntry.SetCurrentKey("Document No.");
    //     ApprovalEntry.SetRange(ApprovalEntry."Document No.", LastDocumentNo2);
    //     ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1', ApprovalEntry.Status::Open);
    //     if ApprovalEntry.FindSet() then begin
    //         repeat
    //             EmployeeName := '';
    //             emailAccount := '';
    //             HREmployee.Reset();
    //             HREmployee.SetRange(HREmployee."Employee UserID", ApprovalEntry."Approver ID");
    //             if HREmployee.FindFirst() then begin
    //                 EmployeeName := HREmployee."First Name" + ' ' + HREmployee."Last Name";
    //                 emailAccount := HREmployee."Company E-Mail";

    //                 /*
    //                                     if emailAccount <> '' then begin
    //                                         EmailBody := 'Hello, an approval Request for Document number ' + LastDocumentNo + ' is waiting for your attention.';
    //                                         EmailMessage.Create(emailAccount, 'Approval Request', EmailBody);
    //                                         EmailSend.Send(EmailMessage, enum::"Email Scenario"::Default);
    //                                         EmailNotification(ApprovalEntry."Approver ID", EmailBody, EmployeeName);
    //                                     end;*/
    //             end;
    //         until ApprovalEntry.Next() = 0;
    //     end;


    //     ApprovalEntry.Reset();
    //     ApprovalEntry.SetCurrentKey("Document No.");
    //     ApprovalEntry.SetRange(ApprovalEntry."Document No.", LastDocumentNo);
    //     ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1', ApprovalEntry.Status::Approved);
    //     if ApprovalEntry.FindSet() then begin
    //         repeat
    //             EmployeeName := '';
    //             emailAccount := '';
    //             HREmployee.Reset();
    //             HREmployee.SetRange(HREmployee."Employee UserID", ApprovalEntry."Sender ID");
    //             if HREmployee.FindFirst() then begin
    //                 EmployeeName := HREmployee."First Name" + ' ' + HREmployee."Last Name";
    //                 emailAccount := HREmployee."Company E-Mail";
    //                 /*
    //                                     if emailAccount <> '' then begin
    //                                         EmailBody := 'Hello, your Document number ' + ApprovalEntry."Document No." + ' has been approved by ' + ApprovalEntry."Approver ID";
    //                                         EmailMessage.Create(emailAccount, 'Approval Email', EmailBody);
    //                                         EmailSend.Send(EmailMessage, enum::"Email Scenario"::Default);
    //                                         EmailNotification(ApprovalEntry."Sender ID", EmailBody, EmployeeName);
    //                                     end;*/
    //                 //end;
    //             end;
    //         until ApprovalEntry.Next() = 0;
    //     end;

    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    begin


        LastDocumentNo := '';
        ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1', ApprovalEntry.Status::Rejected);
        if ApprovalEntry.Find('-') then begin
            LastDocumentNo := ApprovalEntry."Document No.";
        end;
        ApprovalNotificationsetup.RESET;
        IF ApprovalNotificationsetup.FINDLAST THEN BEGIN
            EntryNo := ApprovalNotificationsetup."Entry No" + 1
        END ELSE
            EntryNo := EntryNo + 1;
        ApprovalNotificationsetup.INIT;
        ApprovalNotificationsetup."Entry No" := EntryNo;
        ApprovalNotificationsetup."Document No" := ApprovalEntry."Document No.";
        ApprovalNotificationsetup."Approver ID" := ApprovalEntry."Approver ID";
        ApprovalNotificationsetup."Sender ID" := ApprovalEntry."Sender ID";
        ApprovalNotificationsetup."Employee Code" := ApprovalEntry."Employee Code";
        ApprovalNotificationsetup."Notification Type" := ApprovalNotificationsetup."Notification Type"::"Reject Document";
        ApprovalNotificationsetup.INSERT(TRUE);
        ApprovalEntry.Reset();
        ApprovalEntry.SetCurrentKey("Document No.");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", LastDocumentNo);
        ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1', ApprovalEntry.Status::Rejected);
        if ApprovalEntry.FindSet() then begin
            repeat

                EmployeeName := '';
                emailAccount := '';
                HREmployee.Reset();
                HREmployee.SetRange(HREmployee."Employee UserID", ApprovalEntry."Sender ID");
                if HREmployee.FindFirst() then begin
                    EmployeeName := HREmployee."First Name" + ' ' + HREmployee."Last Name";
                    emailAccount := HREmployee."Company E-Mail";
                    /*
                                        if emailAccount <> '' then begin
                                            EmailBody := 'Hello, your Document number ' + ApprovalEntry."Document No." + ' has been rejected by ' + ApprovalEntry."Approver ID";
                                            EmailMessage.Create(emailAccount, 'Rejection Email', EmailBody);
                                            // EmailMessage.AppendToBody(EmployeeName);
                                            EmailSend.Send(EmailMessage, enum::"Email Scenario"::Default);
                                            EmailNotification(ApprovalEntry."Sender ID", EmailBody, EmployeeName);
                                        end;*/
                    // end;
                end;
            until ApprovalEntry.Next() = 0;
        end;
    end;

    var
        ApprovalNotificationSetup: Record "Approval Notification Setup";
        LastDocumentNo: Code[150];
        HREmployee: Record "HR Employees";
        users: Record User;
        EntryNo: Integer;

        emailAccount: Text[250];

        EmployeeName: Text[2048];
        WorkflowManagement: Codeunit "Workflow Management";
        WFHandler: Codeunit "Workflow Event Handling";
        EmailSend: codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailBody: Text;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]

    procedure AddEventsToLib()
    begin

        WFHandler.AddEventToLibrary(RunWorkflowOnSendPurchaseOrderForApprovalCode(),
                                    Database::"Purchase header", 'Approval of a Travel request is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelPurchaseOrderApprovalRequestCode(),
                                    Database::"Purchase header", 'An Approval request for a Travel request is Canceled.', 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]

    procedure AddEventsPredecessor(EventFunctionName: Code[128])
    begin
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPurchaseOrderForApprovalCode());
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPurchaseOrderForApprovalCode());
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPurchaseOrderForApprovalCode());
    end;

    procedure RunWorkflowOnSendPurchaseOrderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPurchaseOrderForApproval'));
    end;


    procedure RunWorkflowOnCancelPurchaseOrderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPurchaseOrderApprovalRequest'));
    end;

    //[EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendPurchaseOrderForApproval', '', false, false)]

    procedure RunWorkflowOnSendPurchaseOrderForApproval(var PurchaseOrder: Record "Purchase header")
    begin

        WorkflowManagement.HandleEvent(RunWorkflowOnSendPurchaseOrderForApprovalCode, PurchaseOrder);
    end;

    //[EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPurchaseOrderApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPurchaseOrderApprovalRequest(var PurchaseOrder: Record "Purchase header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPurchaseOrderApprovalRequestCode, PurchaseOrder);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        PurechaseOrder: Record "Purchase header";
    begin

        RecRef.GetTable(Variant);
        case RecRef.Number of
            //Payment Header
            Database::"Purchase header":
                begin
                    RecRef.SetTable(PurechaseOrder);
                    PurechaseOrder.Validate(Status, PurechaseOrder.Status::"Pending Approval");
                    //PurechaseOrder.Modify(true);
                    IsHandled := true;
                    // Message('home %1-%2', IsHandled, PurechaseOrder.Status);
                end;
        end;

    end;

    procedure EmailNotification(var userid: Code[100]; var EmailBody: Text[2048]; var EmployeeName: Text[2048])
    var
        EmailLogs: Record EmailLogs;
    begin
        EmailLogs.INIT;
        EmailLogs."User Id" := userid;
        EmailLogs."Time Sent" := TIME;
        EmailLogs."Date Sent" := TODAY;
        EmailLogs."Employee Name" := EmployeeName;
        EmailLogs.Message := EmailBody + ' ' + EmployeeName;
        EmailLogs.INSERT(TRUE);

    end;

}