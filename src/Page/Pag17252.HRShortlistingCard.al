//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17252 "HR Shortlisting Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Shortlisting,Send Email Notification,Upload Employee';
    SourceTable = "HR Employee Requisitions";
    SourceTableView = where(Status = const(Approved),
                            Closed = const(false));

    layout
    {
        area(content)
        {
            group("Job Details")
            {
                Caption = 'Job Details';
                Editable = true;
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = Basic;
                    Editable = "Requisition DateEditable";
                    Enabled = false;
                    Importance = Promoted;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;
                    Editable = PriorityEditable;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Required Positions"; Rec."Required Positions")
                {
                    ApplicationArea = Basic;
                    Editable = "Required PositionsEditable";
                    Enabled = false;
                    Importance = Promoted;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
            part(Shortlisted; "HR Shortlisting Lines")
            {
                Editable = ShortlistedEditable;
                SubPageLink = "Employee Requisition No" = field("Requisition No.");
            }
        }
        area(factboxes)
        {
            part(Control1102755003; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = field("Job ID");
            }
            systempart(Control1102755001; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicants)
            {
                Caption = 'Applicants';
                action("&ShortList Applicants")
                {
                    ApplicationArea = Basic;
                    Caption = '&ShortList Applicants';
                    Image = SelectField;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    begin

                        Humanresoucemgt.ShortlistApplicants(Rec);

                        Message('%1', 'Shortlisting Competed Successfully.');
                    end;
                }
                action("&Notify Qualified")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Invitation Email';
                    Image = MailSetup;
                    Promoted = true;

                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin

                        Humanresoucemgt.MailQualifiedShortlistApplicants(Rec);
                        Message('Qualified Applicants notified Competed Successfully.');
                    end;
                }
                action("&Notify Un-Qualified")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Regret Email';
                    Image = MailSetup;
                    Promoted = true;

                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin

                        Humanresoucemgt.MailUnQualifiedShortlistApplicants(Rec);
                        Message('UnQualified Applicants notified Competed Successfully.');
                    end;
                }
                action("Upload To Employee")
                {
                    ApplicationArea = Basic;
                    Caption = 'Upload To Employee';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    begin

                        Humanresoucemgt.UploadApplicantToEmployeeList(Rec);

                    end;
                }
            }
        }

    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecords();
        ;
    end;

    trigger OnInit()
    begin
        "Required PositionsEditable" := true;
        PriorityEditable := true;
        ShortlistedEditable := true;
        "Requisition DateEditable" := true;
        "Job IDEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecords;
    end;

    var
        HRJobRequirements: Record "HR Job Requirements";
        //AppQualifications: Record UnknownRecord51516210;
        HRJobApplications: Record "HR Job Applications";
        Qualified: Boolean;
        StageScore: Decimal;
        HRShortlistedApplicants: Record "HR Shortlisted Applicants";
        MyCount: Integer;
        RecCount: Integer;

        Humanresoucemgt: Codeunit "Human resouce mgt";
        HREmpReq: Record "HR Employee Requisitions";
        [InDataSet]
        "Job IDEditable": Boolean;
        [InDataSet]
        "Requisition DateEditable": Boolean;
        [InDataSet]
        ShortlistedEditable: Boolean;
        [InDataSet]
        PriorityEditable: Boolean;
        [InDataSet]
        "Required PositionsEditable": Boolean;
        Text19057439: label 'Short Listed Candidates';


    procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::New then begin
            "Job IDEditable" := true;
            "Requisition DateEditable" := true;
            ShortlistedEditable := true;
            PriorityEditable := true;
            "Required PositionsEditable" := true;
        end else begin
            "Job IDEditable" := false;
            "Requisition DateEditable" := false;
            ShortlistedEditable := false;
            PriorityEditable := false;
            "Required PositionsEditable" := false;
        end;
    end;

    local procedure OnAfterGetCurrRecords()
    begin
        xRec := Rec;

        UpdateControls;
    end;
}




