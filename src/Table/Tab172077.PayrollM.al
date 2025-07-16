table 172077 "Payroll M"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[45])
        {
            DataClassification = ToBeClassified;

        }

        field(2; "Payroll Period."; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Payroll Date"; Date)
        {
            DataClassification = ToBeClassified;

        }

        field(4; "User ID"; Code[200])
        {
            DataClassification = ToBeClassified;

        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Cancelled,Closed;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Cancelled,Closed';



        }
        field(6; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(7; Processed; Boolean)
        {
            DataClassification = ToBeClassified;

        }

        field(8; "Sender Signature"; Blob)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Approver Signature"; Blob)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PayrolSetup: Record "Payroll General Setup_AU";
        Payroll: Record "Payroll CalenderMalawi";

    trigger OnInsert()
    begin
        IF "Document No" = '' THEN BEGIN
            PayrolSetup.GET;
            PayrolSetup.TESTFIELD(PayrolSetup."Payrol Numbers");
            NoSeriesMgt.InitSeries(PayrolSetup."Payrol Numbers", xRec."No. Series", 0D, "Document No", "No. Series");
        END;
        "User ID" := USERID;
        "Payroll Date" := TODAY;

        IF Payroll.FINDLAST THEN
            "Payroll Period." := Payroll."Date Opened";

    end;

    trigger OnModify()
    begin
        IF Status = Status::Approved then begin
            NotifyFinancePerson();
        end;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;


    local procedure NotifyFinancePerson()
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailBody: Text;
        EmailSubject: Text;
        Recipients: Text;
        Country: Code[30];
    begin
        // Ensure the document is approved
        if Status <> Status::Approved then
            exit;

        // Set the country (can also use "Shortcut Dimension 1 Code" if available)
        Country := 'MALAWI'; // Replace with dynamic country if needed

        // Set recipient list as a semicolon-separated string
        case Country of
            'KENYA':
                Recipients := 'edward.njenga@afidep.org;john.kuyeli@afidep.org;wicklife.okinda@afidep.org';
            'MALAWI':
                Recipients := 'hector.mvula@afidep.org;john.kuyeli@afidep.org;wicklife.okinda@afidep.org';
            else
                exit;
        end;

        // Compose email content
        EmailSubject := 'Payroll Approved';
        EmailBody := StrSubstNo(
            'The payroll with document number %1 for country %2 has been fully approved.<br><br>Please proceed accordingly.',
            "Document No", Country
        );

        // Create and send email
        EmailMessage.Create(Recipients, EmailSubject, EmailBody, true);
        Email.Send(EmailMessage);
    end;


}