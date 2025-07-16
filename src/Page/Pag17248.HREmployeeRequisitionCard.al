//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17248 "HR Employee Requisition Card"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Job';
    SourceTable = "HR Employee Requisitions";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(Requestor; Rec.Requestor)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    //Editable = "Job IDEditable";
                    Importance = Promoted;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Reason For Request"; Rec."Reason For Request")
                {
                    ApplicationArea = Basic;
                    //Editable = "Reason For RequestEditable";
                }
                field("Type of Contract Required"; Rec."Type of Contract Required")
                {
                    ApplicationArea = Basic;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;
                    //Editable = PriorityEditable;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Required Positions"; Rec."Required Positions")
                {
                    ApplicationArea = Basic;
                    // Editable = "Required PositionsEditable";
                    Importance = Promoted;
                }
                field(Advertise; Rec.Advertise)
                {
                    ApplicationArea = Basic;
                }
                field("Date Advertised"; Rec."Date Advertised")
                {
                    ApplicationArea = Basic;
                    //Editable = "Closing DateEditable";
                    Importance = Promoted;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Closing Date';
                    //Editable = "Closing DateEditable";
                    Importance = Promoted;
                }
                field("Reporting Date"; Rec."Reporting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Proposed Date of candidate reporting';
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Duty Station';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    //Editable = "Responsibility CenterEditable";
                    Importance = Promoted;
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = Basic;
                    //Editable = "Requisition TypeEditable";
                    Importance = Promoted;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                }
                field("Monthly Salary"; Rec."Monthly Salary")
                {

                }

            }
            group("Profession")
            {
                caption = 'Education & Profession';
                field("Field of Study"; Rec."Field of Study") { ApplicationArea = all; }
                field("Education Level"; Rec."Education Level") { ApplicationArea = all; }
                field("Education Type"; Rec."Education Type") { ApplicationArea = all; }
                field("Proficiency Level"; Rec."Proficiency Level") { ApplicationArea = all; }
                field("Professional Course"; Rec."Professional Course") { ApplicationArea = all; }
                field("Professional Membership"; Rec."Professional Membership") { ApplicationArea = all; }
                field("Minimum years of experience"; Rec."Minimum years of experience") { ApplicationArea = all; }
                field("Maximum years of experience"; Rec."Maximum years of experience") { ApplicationArea = all; }
            }


            group("Additional Information")
            {
                Caption = 'Additional Information';
                field("Any Additional Information"; Rec."Any Additional Information")
                {
                    ApplicationArea = Basic;
                    //Editable = AnyAdditionalInformationEditab;
                }
                field("Reason for Request(Other)"; Rec."Reason for Request(Other)")
                {
                    ApplicationArea = Basic;
                    //Editable = ReasonforRequestOtherEditable;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000000; "HR Employee Req. Factbox")
            {
                SubPageLink = "Job ID" = field("Job ID");
            }
            systempart(Control1102755020; Outlook)
            {
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("General")
            {
                Caption = 'General';
                action(Advertised)
                {
                    ApplicationArea = Basic;
                    Caption = 'Advertise';
                    Image = Salutation;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Recipient: list of [Text];
                    begin
                        if Rec.Status <> Rec.Status::Approved then Error('The job position should first be approved');

                        if Rec."Requisition Type" = Rec."Requisition Type"::Internal then begin
                            Rec.TestField("Requisition Type", Rec."requisition type"::Internal);
                            HREmp.Reset;
                            HREmp.SetRange(HREmp."No.");
                            HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                            repeat
                                HREmp.TestField(HREmp."Company E-Mail");
                                Recipient.Add(HREmp."Company E-Mail");
                                EmailMessage.Create(Recipient, 'Job Advertisement',
                                   'A vacancy with the job description' + rEC."Job Description" + 'is open for applications', true);
                                Email.Send(EmailMessage);
                            until HREmp.Next = 0;

                        end;

                        if (Rec."Requisition Type" = Rec."Requisition Type"::External) OR (Rec."Requisition Type" = Rec."Requisition Type"::Both) then begin
                            Rec.Advertise := true;
                        end;


                        // if HREmp.Find('-') then

                        //     //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                        //     HREmailParameters.Reset;
                        // HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."associate with"::"HR Jobs");
                        // if HREmailParameters.Find('-') then begin
                        //     repeat
                        //         HREmp.TestField(HREmp."Company E-Mail");
                        //         Recipient.Add(HREmp."Company E-Mail");
                        //         EmailMessage.Create(Recipient,
                        //         HREmailParameters.Subject, 'Dear' + ' ' + HREmp."First Name" + ' ' +
                        //         HREmailParameters.Body + ' ' + Rec."Job Description" + ' ' + HREmailParameters."Body 2" + ' ' + Format(Rec."Closing Date") + '. ' +
                        //         HREmailParameters."Body 3", true);
                        //         Email.send(EmailMessage)
                        //     until HREmp.Next = 0;

                        //     Message('All Employees have been notified about this vacancy');
                        // end;
                        Rec.Advertise := true;
                        rec.Status := rec.Status::Advertised;
                        Rec.Modify();
                    end;
                }
                action("Mark as Closed/Open")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark as Closed/Open';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Rec.Closed then begin
                            if not Confirm('Are you sure you want to Re-Open this Document', false) then exit;
                            Rec.Closed := false;
                            Rec.Modify;
                            Message('Employee Requisition %1 has been Re-Opened', Rec."Requisition No.");

                        end else begin
                            if not Confirm('Are you sure you want to close this Document', false) then exit;
                            Rec.Closed := true;
                            Rec.Modify;
                            Message('Employee Requisition %1 has been marked as Closed', Rec."Requisition No.");
                        end;
                    end;
                }
                action("&Print")
                {
                    ApplicationArea = Basic;
                    Caption = '&Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmpReq.Reset;
                        HREmpReq.SetRange(HREmpReq."Requisition No.", Rec."Requisition No.");
                        if HREmpReq.Find('-') then
                            Report.run(80040, true, true, HREmpReq);
                    end;
                }
                action("&Send Mail to HR to add vacant position")
                {
                    ApplicationArea = Basic;
                    Caption = '&Send Mail to HR to add vacant position';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = false;

                    trigger OnAction()
                    begin
                        objEmp.Reset;
                        objEmp.SetRange(objEmp."Global Dimension 2 Code", Rec."Global Dimension 2 Code");
                        objEmp.SetRange(objEmp.HR, true);
                        if objEmp.Find('-') then begin
                            if objEmp."Company E-Mail" = '' then Error('THe HR doesnt have an email Account');
                            //**********************send mail**********************************
                            objEmp.TestField(objEmp."Company E-Mail");
                            // Recipient.Add(HREmp."Company E-Mail");
                            EmailMessage.Create(objEmp."Company E-Mail", 'Job Advertisement',
                               'Job with the job description' + Rec."Job Description" + 'is open. Kindly add to open vaccancies', true);
                            Email.Send(EmailMessage);
                            Message('EMail Sent');
                        end else begin
                            Message('There is no employee marked as HR in that department');
                        end;
                    end;
                }
                action("Re-Open")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    //Visible = false;

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Varient: Variant;
                    begin
                        Varient := Rec;
                        if Confirm('Send Document for Approval?', true) = false then exit;
                        if workflowIntergration.CheckApprovalsWorkflowEnabled(Varient) then
                            workflowIntergration.OnSendDocForApproval(Varient);
                        Message('Approved!');
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    //Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                        if Confirm('Cancel Document?', true) = false then exit;
                        Rec.Status := Rec.Status::New;
                        Rec.Modify(true);
                        Message('Cancelled!');
                    end;
                }
            }
            group(Job)
            {
                Caption = 'Job';
                action(Requirements)
                {
                    ApplicationArea = Basic;
                    Caption = 'Requirements';
                    Image = JobListSetup;
                    Promoted = true;
                    PromotedCategory = Category4;
                }
                action(Responsibilities)
                {
                    ApplicationArea = Basic;
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // RunObject = Page UnknownPage55648;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;

        HRLookupValues.SetRange(HRLookupValues.Code, Rec."Type of Contract Required");
        if HRLookupValues.Find('-') then
            ContractDesc := HRLookupValues.Description;
    end;

    trigger OnInit()
    begin
        TypeofContractRequiredEditable := true;
        AnyAdditionalInformationEditab := true;
        "Required PositionsEditable" := true;
        "Requisition TypeEditable" := true;
        "Closing DateEditable" := true;
        PriorityEditable := true;
        ReasonforRequestOtherEditable := true;
        "Reason For RequestEditable" := true;
        "Responsibility CenterEditable" := true;
        "Job IDEditable" := true;
        "Requisition DateEditable" := true;
        "Requisition No.Editable" := true;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL;
        ApprovalEntries: Page "Approval Entries";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        HREmpReq: Record "HR Employee Requisitions";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        workflowIntergration: Codeunit "Custom Approvals Codeunit";

        //SMTP: Codeunit "SMTP Mail";
        HRSetup: Record "HR Setup";
        CTEXTURL: Text[30];
        HREmp: Record "HR Employees";
        // HREmailParameters: Record "HR E-Mail Parameters";
        ContractDesc: Text[30];
        HRLookupValues: Record "HR Job Qualifications";
        [InDataSet]
        "Requisition No.Editable": Boolean;
        [InDataSet]
        "Requisition DateEditable": Boolean;
        [InDataSet]
        "Job IDEditable": Boolean;
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Reason For RequestEditable": Boolean;
        [InDataSet]
        ReasonforRequestOtherEditable: Boolean;
        [InDataSet]
        PriorityEditable: Boolean;
        [InDataSet]
        "Closing DateEditable": Boolean;
        [InDataSet]
        "Requisition TypeEditable": Boolean;
        [InDataSet]
        "Required PositionsEditable": Boolean;
        [InDataSet]
        AnyAdditionalInformationEditab: Boolean;
        [InDataSet]
        TypeofContractRequiredEditable: Boolean;
        DimValue: Record "Dimension Value";
        objEmp: Record "HR Employees";


    procedure TESTFIELDS()
    begin
        Rec.TestField("Job ID");
        Rec.TestField("Closing Date");
        Rec.TestField("Type of Contract Required");
        Rec.TestField("Requisition Type");
        Rec.TestField("Required Positions");
        if Rec."Reason For Request" = Rec."reason for request"::Other then
            Rec.TestField("Reason for Request(Other)");
    end;


    procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::New then begin
            "Requisition No.Editable" := true;
            "Requisition DateEditable" := true;
            "Job IDEditable" := true;
            "Responsibility CenterEditable" := true;
            "Reason For RequestEditable" := true;
            ReasonforRequestOtherEditable := true;
            PriorityEditable := true;
            "Closing DateEditable" := false;
            "Requisition TypeEditable" := true;
            "Required PositionsEditable" := true;
            "Required PositionsEditable" := true;
            AnyAdditionalInformationEditab := true;
            TypeofContractRequiredEditable := true;
        end else begin
            "Requisition No.Editable" := false;
            "Requisition DateEditable" := false;
            "Job IDEditable" := false;
            "Responsibility CenterEditable" := false;
            "Reason For RequestEditable" := false;
            ReasonforRequestOtherEditable := false;
            PriorityEditable := false;
            "Closing DateEditable" := true;
            "Requisition TypeEditable" := false;
            "Required PositionsEditable" := false;
            "Required PositionsEditable" := false;
            AnyAdditionalInformationEditab := false;

            TypeofContractRequiredEditable := false;
        end;
    end;
}




