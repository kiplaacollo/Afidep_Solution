//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 80030 "HR Jobs Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Job,Approvals';
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Position Reporting to"; Rec."Position Reporting to")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                }
                field("Main Objective"; Rec."Main Objective")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor/Manager"; Rec."Supervisor/Manager")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = Basic;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Requisitions"; Rec."Employee Requisitions")
                {
                    ApplicationArea = Basic;
                }
                field("Key Position"; Rec."Key Position")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Is Supervisor"; Rec."Is Supervisor")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
            part(KeyJobResponsibilities; "Key Job Responsibilities")
            {
                SubPageLink = Code = field("Job ID");
                ApplicationArea = All;
            }
            part(Academics; "Company Job Education")
            {
                Caption = 'Academic Qualifications';
                SubPageLink = "Job Id" = field("Job ID"), "Education Level" = filter(<> Professional);
                ApplicationArea = All;
            }
            part(Experience; "Company Job Experience")
            {
                Caption = 'Experience Qualifications';
                SubPageLink = "Job Id" = field("Job ID");
                ApplicationArea = All;
            }
            part(ProfessionalCourse; "Company Job Prof course")
            {
                SubPageLink = "Job Id" = field("Job ID");
                ApplicationArea = All;
            }
            part(ProfessionalMembership; "Company Job Prof Membership")
            {
                SubPageLink = "Job Id" = field("Job ID");
                ApplicationArea = All;
            }
            part(JobAttachments; "Job Attachments")
            {
                SubPageLink = "Job Id" = field("Job ID");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = field("Job ID");
            }
            systempart(Control1102755006; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Job)
            {
                action("Raise Requisition")
                {
                    ApplicationArea = Basic;
                    Caption = 'Raise Requisition';
                    Image = Job;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Employee Requisition Card";
                    RunPageLink = "Job ID" = field("Job ID");
                }
                action("Job Qualifications")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Qualifications';
                    Image = Card;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines";
                    RunPageLink = "Job Id" = field("Job ID");
                }
                action(Responsibilities)
                {
                    ApplicationArea = Basic;
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Responsiblities Lines";
                    RunPageLink = "Job ID" = field("Job ID");
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
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        varient: Variant;
                    begin
                        varient := Rec;
                        IF workflowIntergration.CheckApprovalsWorkflowEnabled(varient) THEN
                            workflowIntergration.OnSendDocForApproval(varient);
                        // Rec.Status := Rec.Status::Approved;
                        // Rec.Modify;
                        // Message('Job Approved!')
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                        Message('Approval Cancelled!')
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;

        Rec.Validate("Vacant Positions");
    end;

    var
        HREmployees: Record "HR Employees";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        workflowIntergration: Codeunit "Custom Approvals Codeunit";

    local procedure UpdateControls()
    begin
        if Rec.Status = Rec.Status::New then begin
            CurrPage.Editable := true;
        end else begin
            CurrPage.Editable := false;
        end;
    end;


    procedure RecordLinkCheck(job: Record "HR Jobss") RecordLnkExist: Boolean
    var
        objRecordLnk: Record "Record Link";
        TableCaption: RecordID;
        objRecord_Link: RecordRef;
    begin
        objRecord_Link.GetTable(job);
        TableCaption := objRecord_Link.RecordId;
        objRecordLnk.Reset;
        objRecordLnk.SetRange(objRecordLnk."Record ID", TableCaption);
        if objRecordLnk.Find('-') then exit(true) else exit(false);
    end;
}




