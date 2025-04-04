codeunit 50004 "Approval Notification Push"
{
    trigger OnRun()
    begin
        SendEmailNotification();
        EmailApprovalNotification();
        EmailRejectionNotification();
    end;

    var
        myInt: Integer;
        ApprovalNotificationsetup: Record "Approval Notification Setup";
        EmployeeName: Text[200];
        HREmployees: Record "HR Employees";
        EmailLogs: Record EmailLogs;
        EntryNo: Integer;
        EmailSend: codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailBody: Text;
        emailAccount: Text[250];

    procedure SendEmailNotification()
    var
        myInt: Integer;

    begin



        ApprovalNotificationsetup.RESET;
        ApprovalNotificationsetup.SETRANGE(ApprovalNotificationsetup."Email Sent", true);
        ApprovalNotificationsetup.SETRANGE(ApprovalNotificationsetup."Notification Type", ApprovalNotificationsetup."Notification Type"::"Send Approval");
        // ApprovalNotificationsetup.SetRange(ApprovalNotificationsetup.Status, ApprovalNotificationsetup.Status::Open);
        IF ApprovalNotificationsetup.FindLast THEN BEGIN
            REPEAT
                EmployeeName := '';
                emailAccount := '';
                HREmployees.RESET;
                HREmployees.SETRANGE(HREmployees."Employee UserID", ApprovalNotificationsetup."Sender ID");
                IF HREmployees.FIND('-') THEN BEGIN
                    EmployeeName := HREmployees."First Name" + ' ' + HREmployees."Last Name";
                    emailAccount := HREmployees."Company E-Mail";
                END;
                if emailAccount <> '' then begin
                    EmailBody := 'Dear ' + ApprovalNotificationsetup."Sender ID" +
    ',<br><br>An approval for Document Number ' + ApprovalNotificationsetup."Document No" +
    ' has been approved by ' + ApprovalNotificationsetup."Approver ID" +
    '.<br><br>Thank you.';

                    // EmailBody := 'Dear ' + ApprovalNotificationsetup."Approver ID" + ', an approval Request for Document number ' + ApprovalNotificationsetup."Document No" + ' is waiting for your attention.Kindly ' +
                    //              '<a href="https://bc.afidep.org:8090/">click here</a> to approve.';//'Hello, an approval Request for Document number ' + ApprovalNotificationsetup."Document No" + ' is waiting for your attention.';
                    EmailMessage.Create(emailAccount, 'Approved Document', EmailBody, true);
                    //   EmailSend.Send(EmailMessage, enum::"Email Scenario"::Default);
                    //  EmailNotification(ApprovalNotificationsetup."Sender ID", EmailBody, EmployeeName);
                END;
                EntryNo := 0;

            // ApprovalNotificationsetup."Email Sent" := TRUE;
            // ApprovalNotificationsetup.MODIFY;

            UNTIL ApprovalNotificationsetup.NEXT = 0;
        END;

    end;

    procedure EmailApprovalNotification()
    var
        myInt: Integer;
    begin


        ApprovalNotificationsetup.RESET;
        ApprovalNotificationsetup.SETRANGE(ApprovalNotificationsetup."Email Sent", FALSE);
        ApprovalNotificationsetup.SetRange(ApprovalNotificationsetup.Status, ApprovalNotificationsetup.Status::Open);
        ApprovalNotificationsetup.SETRANGE(ApprovalNotificationsetup."Notification Type", ApprovalNotificationsetup."Notification Type"::"Send Approval");
        IF ApprovalNotificationsetup.FINDSET THEN BEGIN
            REPEAT
                EmployeeName := '';
                emailAccount := '';
                HREmployees.RESET;
                HREmployees.SETRANGE(HREmployees."Employee UserID", ApprovalNotificationsetup."Approver ID");
                IF HREmployees.FindSet THEN BEGIN
                    EmployeeName := HREmployees."First Name" + ' ' + HREmployees."Last Name";
                    emailAccount := HREmployees."Company E-Mail";
                END;
                if emailAccount <> '' then begin
                    EmailBody := 'Dear ' + ApprovalNotificationsetup."Approver ID" +
   ',<br><br>An approval request for Document Number ' + ApprovalNotificationsetup."Document No" +
   ' is waiting for your attention. Kindly ' +
   '<a href="https://bc.afidep.org:8090/" target="_blank">click here</a> to approve.<br><br>Thank you.';
                    // EmailBody := 'Dear ' + ApprovalNotificationsetup."Approver ID" + ', an approval Request for Document number ' + ApprovalNotificationsetup."Document No" + ' is waiting for your attention.Kindly ' +
                    //              '<a href="https://bc.afidep.org:8090/">click here</a> to approve.';//'Hello, an approval Request for Document number ' + ApprovalNotificationsetup."Document No" + ' has been approved by ' + ApprovalNotificationsetup."Approver ID";
                    EmailMessage.Create(emailAccount, 'Approval Request', EmailBody, true);
                    EmailSend.Send(EmailMessage, enum::"Email Scenario"::Default);
                    EmailNotification(ApprovalNotificationsetup."Approver ID", EmailBody, EmployeeName);

                END;
                EntryNo := 0;



                ApprovalNotificationsetup."Email Sent" := TRUE;
                ApprovalNotificationsetup.MODIFY;

            UNTIL ApprovalNotificationsetup.NEXT = 0;
        END;
    end;

    procedure EmailRejectionNotification()
    var
        myInt: Integer;
    begin
        ApprovalNotificationsetup.RESET;
        ApprovalNotificationsetup.SETRANGE(ApprovalNotificationsetup."Email Sent", FALSE);
        ApprovalNotificationsetup.SETRANGE(ApprovalNotificationsetup."Notification Type", ApprovalNotificationsetup."Notification Type"::"Reject Document");
        IF ApprovalNotificationsetup.FINDSET THEN BEGIN
            REPEAT
                EmployeeName := '';
                emailAccount := '';
                HREmployees.RESET;
                HREmployees.SETRANGE(HREmployees."No.", ApprovalNotificationsetup."Employee Code");
                IF HREmployees.FIND('-') THEN BEGIN
                    EmployeeName := HREmployees."First Name" + ' ' + HREmployees."Last Name";
                    emailAccount := HREmployees."Company E-Mail";
                END;

                if emailAccount <> '' then begin
                    EmailBody := 'Hello, an approval Request for Document number ' + ApprovalNotificationsetup."Document No" + ' has been rejected by ' + ApprovalNotificationsetup."Approver ID";
                    EmailMessage.Create(emailAccount, 'Rejection ', EmailBody, true);
                    EmailSend.Send(EmailMessage, enum::"Email Scenario"::Default);
                    EmailNotification(ApprovalNotificationsetup."Approver ID", EmailBody, EmployeeName);
                END;
                EntryNo := 0;



                ApprovalNotificationsetup."Email Sent" := TRUE;
                ApprovalNotificationsetup.MODIFY;

            UNTIL ApprovalNotificationsetup.NEXT = 0;
        END;
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