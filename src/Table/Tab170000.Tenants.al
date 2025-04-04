Table 170000 "Tenants"
{
    Caption = 'Tenants';
    LookupPageID = "Tenants List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    PurchSetup.Get;
                    NoSeriesMgt.TestManual(PurchSetup."Tenant Numbers");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Full Names"; Text[100])
        {
            Caption = 'Full Names';

            trigger OnValidate()
            begin
                Unitss.Reset;
                Unitss.SetRange(Unitss.Tenant22, "No.");
                if Unitss.FindFirst then begin
                    Unitss."Tenant Full Name 33" := "Full Names";
                    Unitss.Modify;
                end;


                Lease.Reset;
                Lease.SetRange(Lease.Tenant, "No.");
                if Lease.FindFirst then begin
                    repeat
                        Lease."Tenant Name" := "Full Names";
                        Lease.Modify;
                    until Lease.Next = 0;
                end;
            end;
        }
        field(3; "Identification Document"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Kenyan ID,Passport';
            OptionMembers = ,"Kenyan ID",Passport;
        }
        field(4; "Identification Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Tenants Phone Number"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Unitss.Reset;
                Unitss.SetRange(Unitss.Tenant22, "No.");
                if Unitss.FindFirst then begin
                    Unitss."Phone No." := "Tenants Phone Number";
                    Unitss.Modify;
                end;
            end;
        }
        field(6; "Terms Of Tenancy"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Unit ID4"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where("Customer Type2" = filter(Unit));

            trigger OnValidate()
            begin
                Units.Reset;
                Units.SetRange(Units."No.", "Unit ID4");
                if Units.FindFirst then begin
                    Unit := Units.Name;
                end;

                Lease.Reset;
                Lease.SetRange(Lease.Unit, "Unit ID4");
                Lease.SetRange(Lease.Active, true);
                "Lease Number" := Lease.No;
                "Account Number" := Lease."Account Number";
                if Lease.FindFirst then begin

                end;
                "Account Number" := "Property ID" + "Unit ID4";
            end;
        }
        field(8; "Property ID"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Property Details".No;

            trigger OnValidate()
            begin
                Properties.Reset;
                Properties.SetRange(Properties.No, "Property ID");
                if Properties.FindFirst then begin
                    "Property Name" := Properties."Property Name";
                end;
                "Account Number" := "Property ID" + "Unit ID4";
            end;
        }
        field(9; "Property Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Rent Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Unit; Text[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Next Of Kin Full  Names"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Next Of KIn Phone Number"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Lease Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Lease.No where(Posted = const(true));
        }
        field(16; "Account Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Full Names", "Unit ID4", "Property Name")
        {
        }
        fieldgroup(Brick; "No.", "Full Names", "Unit ID4", "Property Name")
        {
        }
    }

    trigger OnDelete()
    var
        Task: Record "To-do";
        SegLine: Record "Segment Line";
        ContIndustGrp: Record "Contact Industry Group";
        ContactWebSource: Record "Contact Web Source";
        ContJobResp: Record "Contact Job Responsibility";
        ContMailingGrp: Record "Contact Mailing Group";
        ContProfileAnswer: Record "Contact Profile Answer";
        RMCommentLine: Record "Rlshp. Mgt. Comment Line";
        ContAltAddr: Record "Contact Alt. Address";
        ContAltAddrDateRange: Record "Contact Alt. Addr. Date Range";
        InteractLogEntry: Record "Interaction Log Entry";
        Opp: Record Opportunity;
        Cont: Record Contact;
        ContBusRel: Record "Contact Business Relation";
        IntrastatSetup: Record "Intrastat Setup";
        CampaignTargetGrMgt: Codeunit "Campaign Target Group Mgt";
        VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
    begin
        Error(errrdeletiontxt);
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            PurchSetup.Get;
            PurchSetup.TestField("Tenant Numbers");
            NoSeriesMgt.InitSeries(PurchSetup."Tenant Numbers", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        CannotDeleteWithOpenTasksErr: label 'You cannot delete contact %1 because there are one or more tasks open.', Comment = '%1 = Contact No.';
        Text001: label 'You cannot delete the %2 record of the %1 because the contact is assigned one or more unlogged segments.';
        Text002: label 'You cannot delete the %2 record of the %1 because one or more opportunities are in not started or progress.';
        Text003: label '%1 cannot be changed because one or more interaction log entries are linked to the contact.';
        CannotChangeWithOpenTasksErr: label '%1 cannot be changed because one or more tasks are linked to the contact.', Comment = '%1 = Contact No.';
        Text006: label '%1 cannot be changed because one or more opportunities are linked to the contact.';
        Text007: label '%1 cannot be changed because there are one or more related people linked to the contact.';
        RelatedRecordIsCreatedMsg: label 'The %1 record has been created.', Comment = 'The Customer record has been created.';
        Text010: label 'The %2 record of the %1 is not linked with any other table.';
        RMSetup: Record "Marketing Setup";
        Salesperson: Record "Salesperson/Purchaser";
        PostCode: Record "Post Code";
        DuplMgt: Codeunit DuplicateManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UpdateCustVendBank: Codeunit "CustVendBank-Update";
        CampaignMgt: Codeunit "Campaign Target Group Mgt";
        ContChanged: Boolean;
        SkipDefaults: Boolean;
        Text012: label 'You cannot change %1 because one or more unlogged segments are assigned to the contact.';
        Text019: label 'The %2 record of the %1 already has the %3 with %4 %5.';
        CreateCustomerFromContactQst: label 'Do you want to create a contact as a customer using a customer template?';
        Text021: label 'You have to set up formal and informal salutation formulas in %1  language for the %2 contact.';
        Text022: label 'The creation of the customer has been aborted.';
        Text033: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        SelectContactErr: label 'You must select an existing contact.';
        AlreadyExistErr: label '%1 %2 already has a %3 with %4 %5.', Comment = '%1=Contact table caption;%2=Contact number;%3=Contact Business Relation table caption;%4=Contact Business Relation Link to Table value;%5=Contact Business Relation number';
        HideValidationDialog: Boolean;
        PrivacyBlockedPostErr: label 'You cannot post this type of document because contact %1 is blocked due to privacy.', Comment = '%1=contact no.';
        PrivacyBlockedCreateErr: label 'You cannot create this type of document because contact %1 is blocked due to privacy.', Comment = '%1=contact no.';
        PrivacyBlockedGenericErr: label 'You cannot use contact %1 because they are marked as blocked due to privacy.', Comment = '%1=contact no.';
        ParentalConsentReceivedErr: label 'Privacy Blocked cannot be cleared until Parental Consent Received is set to true for minor contact %1.', Comment = '%1=contact no.';
        ProfileForMinorErr: label 'You cannot use profiles for contacts marked as Minor.';
        PurchSetup: Record "Purchases & Payables Setup";
        Units: Record Customer;
        Properties: Record "Property Details";
        errrdeletiontxt: label 'You are not allowed to delete this  record.';
        Lease: Record Lease;
        Unitss: Record Customer;
}

