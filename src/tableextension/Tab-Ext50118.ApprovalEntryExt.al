tableextension 50118 "ApprovalEntryExt" extends "Approval Entry"
{
    fields
    {
        field(172000; Comments; Text[2048])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("Approval Comment Line".Comment where("Record ID to Approve" = field("Record ID to Approve") ));
            DataClassification = ToBeClassified;

        }
        field(172001; Payee; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(172002; DocType; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(172003; "Employee Code"; Code[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(172004; "Payment Voucher No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(172005; "Paying Bank Name"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(172013; "Paying Bank Number"; Code[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(172006; Memo; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(172007; "CashBook Narration"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(172008; "Employee Name"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(172009; "Mission Narration"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(172010; "Purpose for Travel"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(172011; "fromDate"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Departure Date';
        }
        field(172012; "Travel Destination"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(172014; "Document Types"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(172015; "Pending Task"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(172016; "Leave Types"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(172017; "Days Applied"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(172018; "Project Code"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(172019; "Donor Code"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }



    }

    trigger OnModify()

    begin
        if Status = Status::Open then begin

            ApprovalNotificationsetup.Reset();
            ApprovalNotificationsetup.SetRange("Document No", "Document No.");
            ApprovalNotificationSetup.SetRange("Approver ID", "Approver ID");
            if ApprovalNotificationSetup.Find('-') then begin

                ApprovalNotificationSetup.Status := Rec.Status;
                ApprovalNotificationsetup.Modify();
                // Message('rr Status %1', ApprovalNotificationSetup.Status);
            end;
            //Error('ukweli status %1', Status);
        end;
        if Status <> Status::Open then begin
            //Message('Status %1', Status);
            ApprovalNotificationsetup.Reset();
            ApprovalNotificationsetup.SetRange("Document No", "Document No.");
            ApprovalNotificationSetup.SetRange("Approver ID", "Approver ID");
            if ApprovalNotificationSetup.Find('-') then begin
                ApprovalNotificationSetup.Status := Rec.Status;
                ApprovalNotificationsetup.Modify();
                //Message('rr Status %1', ApprovalNotificationSetup.Status);
            end;
            // if Status = Status::Approved then begin
            //     NotifySender("Sender ID");
            // end;
        end;

    end;

    var
        ApprovalNotificationSetup: Record "Approval Notification Setup";
        HREmp: Record "HR Employees";

    procedure NotifySender(EmployeeCode: Code[50])
    var
        EmailTextBuilder: TextBuilder;
        Salutation: Label 'Dear %1';
        EmailBody: Label ',<br><br>An approval for Document Number %2 has been approved by %3.<br><br>Thank you.';
        Regards: Label '<P>Kind Regards</p> <br>%4</br>';
        Subject: Label 'Document Approval';
        EmailTosend: Text;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        FormatedBody: Text;
        companyInformation: Record "Company Information";
    begin
        HREmp.Get(EmployeeCode);
        HREmp.TestField(HREmp."Company E-Mail");
        companyInformation.Get;
        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        EmailTextBuilder.Clear();
        EmailTextBuilder.Append(Salutation);
        EmailTextBuilder.Append(EmailBody);
        EmailTextBuilder.Append(Regards);

        EmailTosend := EmailTextBuilder.ToText();

        FormatedBody := StrSubstNo(EmailTosend, HREmp."First Name" + ' ' + HREmp."Last Name", Rec."Document No.", Rec."Approver ID", companyInformation.Name);

        EmailMessage.create(HREmp."Company E-Mail", Subject, FormatedBody, true);
        Email.Send(EmailMessage);

        MESSAGE('Leave applicant has been notified successfully');
    END;


}
tableextension 50140 "Company Infor" extends "Company Information"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Sharepoint Path"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Report Header"; Blob) { Subtype = Bitmap; }
        field(50002; "Report header Address"; Text[2048])
        {

        }
    }

    var
        myInt: Integer;
}