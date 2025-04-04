codeunit 50009 "Notification Codeunit"
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
        ReleaverName: Text[250];
        HREmployees: Record "HR Employees";
        EmailLogs: Record EmailLogs;
        EntryNo: Integer;
        EmailSend: codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailBody: Text;
        emailAccount: Text[250];
        ReleaverEmail: Text[250];

    procedure SendEmailNotification()
    var
        myInt: Integer;

    begin



        ApprovalNotificationsetup.RESET;
        ApprovalNotificationsetup.SETRANGE(ApprovalNotificationsetup."Email Sent", FALSE);
        ApprovalNotificationsetup.SetRange(ApprovalNotificationsetup."Document No", ApprovalNotificationsetup."Document No");
        // ApprovalNotificationsetup.SetRange(ApprovalNotificationsetup.Status, ApprovalNotificationsetup.Status::Open);
        ApprovalNotificationsetup.SETRANGE(ApprovalNotificationsetup."Notification Type", ApprovalNotificationsetup."Notification Type"::"Send Approval");
        IF ApprovalNotificationsetup.FindFirst() THEN BEGIN
            REPEAT
                EmployeeName := '';
                emailAccount := '';
                HREmployees.RESET;
                HREmployees.SETRANGE(HREmployees."Employee UserID", ApprovalNotificationsetup."Approver ID");
                IF HREmployees.FIND('-') THEN BEGIN
                    EmployeeName := HREmployees."First Name" + ' ' + HREmployees."Last Name";
                    emailAccount := HREmployees."Company E-Mail";
                END;
                if emailAccount <> '' then begin
                    EmailBody := 'Dear ' + ApprovalNotificationsetup."Approver ID" + ', an approval Request for Document number ' + ApprovalNotificationsetup."Document No" + ' is waiting for your attention.Kindly ' +
                                     '<a href="https://bc.afidep.org:8090/">click here</a> to approve.';
                    EmailMessage.Create(emailAccount, 'Approval Request', EmailBody, true);
                    EmailSend.Send(EmailMessage, enum::"Email Scenario"::Default);
                    EmailNotification(ApprovalNotificationsetup."Sender ID", EmailBody, EmployeeName);
                END;
                EntryNo := 0;

                ApprovalNotificationsetup."Email Sent" := TRUE;
                ApprovalNotificationsetup.MODIFY;

            UNTIL ApprovalNotificationsetup.NEXT = 0;
        END;

    end;

    procedure EmailApprovalNotification()
    var
        myInt: Integer;
        HRLeaveApplication: Record "HR Leave Application";
    begin


        ApprovalNotificationsetup.RESET;
        ApprovalNotificationsetup.SETRANGE(ApprovalNotificationsetup."Email Sent", FALSE);
        ApprovalNotificationsetup.SETRANGE(ApprovalNotificationsetup."Notification Type", ApprovalNotificationsetup."Notification Type"::"Approve Document");
        IF ApprovalNotificationsetup.FINDSET THEN BEGIN
            REPEAT
                EmployeeName := '';
                emailAccount := '';
                ReleaverName := '';
                ReleaverEmail := '';
                HREmployees.RESET;
                HREmployees.SETRANGE(HREmployees."No.", ApprovalNotificationsetup."Employee Code");
                IF HREmployees.FIND('-') THEN BEGIN
                    EmployeeName := HREmployees."First Name" + ' ' + HREmployees."Last Name";
                    emailAccount := HREmployees."Company E-Mail";
                END;
                if emailAccount <> '' then begin
                    EmailBody := 'Hello, an approval Request for Document number ' + ApprovalNotificationsetup."Document No" + ' has been approved by ' + ApprovalNotificationsetup."Approver ID";
                    EmailMessage.Create(emailAccount, 'Approval Request', EmailBody);
                    EmailSend.Send(EmailMessage, enum::"Email Scenario"::Default);
                    EmailNotification(ApprovalNotificationsetup."Approver ID", EmailBody, EmployeeName);

                END;


                // HREmployees.Get();
                // HREmployees.SETRANGE(HREmployees."No.", ApprovalNotificationsetup."Employee Code");
                // IF HREmployees.FIND('-') THEN BEGIN
                HRLeaveApplication.RESET;
                HRLeaveApplication.SETRANGE(HRLeaveApplication."Employee No", ApprovalNotificationsetup."Employee Code");
                IF HRLeaveApplication.FIND('-') THEN BEGIN
                    ReleaverName := HRLeaveApplication."Reliever Name";
                    //  ReleaverEmail := HRLeaveApplication."Reliever Email";
                END;
                //end;
                if ReleaverEmail <> '' then begin
                    EmailBody := 'Hello, Kindly Note that an approval Request for Document number ' + ApprovalNotificationsetup."Document No" + '(' + EmployeeName + ')' + ' has been approved by' + ApprovalNotificationsetup."Approver ID" + 'and you are the releaver';
                    EmailMessage.Create(emailAccount, 'Approval Request', EmailBody);
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
                    EmailMessage.Create(emailAccount, 'Rejection ', EmailBody);
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