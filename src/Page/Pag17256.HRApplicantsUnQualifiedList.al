//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17256 "HR Applicants UnQualified List"
{
    CardPageID = "HR Applicants UnQualified Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Job Applications";
    SourceTableView = where("Qualification Status" = filter(UnQualified), Qualified = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = Basic;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                }
                field("Job Applied for Description"; Rec."Job Applied for Description")
                {
                    ApplicationArea = Basic;
                }
                field("Regret Notice Sent"; Rec."Regret Notice Sent")
                {
                    ApplicationArea = Basic;
                }
                field("Interview Type"; Rec."Interview Type")
                {
                    ApplicationArea = Basic;
                }
                field("Job Applied For"; Rec."Job Applied For")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicant)
            {
                Caption = 'Applicant';
                action("Send Regret Alert")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Regret Alert';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        recipients: list of [Text];
                    begin

                        //IF CONFIRM('Send this Requisition for Approval?',TRUE)=FALSE THEN EXIT;
                        if not Confirm(Text002, false) then exit;

                        Rec.TestField(Qualified, true);
                        HRJobApplications.SetRange(HRJobApplications."Application No", Rec."Application No");
                        CurrPage.SetSelectionFilter(HRJobApplications);
                        // if HRJobApplications.Find('-') then
                        //     //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                        //     HREmailParameters.Reset;
                        // HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."associate with"::"Regret Notification");
                        // if HREmailParameters.Find('-') then begin
                        //     repeat
                        //         recipients.Add(HRJobApplications."E-Mail");
                        //         HRJobApplications.TestField(HRJobApplications."E-Mail");

                        //     // SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", recipients,
                        //     // HREmailParameters.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' + HREmailParameters.Body + ' ' + HRJobApplications."Job Applied for Description" + ' ' + 'applied on' + ' ' + Format("Date Applied") + ' ' + HREmailParameters."Body 2", true);
                        //     // //HREmailParameters."Body 2"+' '+ FORMAT("Date Applied")+'. '+
                        //     // // HREmailParameters.Body,TRUE);
                        //     // SMTP.Send();
                        //     until HRJobApplications.Next = 0;

                        //     Message('All Unqualified  candidates have been sent regret alerts');
                        // end;
                    end;
                }
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = Card;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "HR Job Applications Card";
                    RunPageLink = "Application No" = field("Application No");
                }
                action(Qualifications)
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "HR Applicant Qualifications";
                    RunPageLink = "Application No" = field("Application No");
                }
                action(Referees)
                {
                    ApplicationArea = Basic;
                    Caption = 'Referees';
                    Image = ContactReference;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "HR Applicant Referees";
                    RunPageLink = "Job Application No" = field("Application No");
                }
                action(Hobbies)
                {
                    ApplicationArea = Basic;
                    Caption = 'Hobbies';
                    Image = Holiday;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "HR Applicant Hobbies";
                    RunPageLink = "Job Application No" = field("Application No");
                }
            }
            group(Print)
            {
                Caption = 'Print';
                action("&Print")
                {
                    ApplicationArea = Basic;
                    Caption = '&Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    begin
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", Rec."Application No");
                        if HRJobApplications.Find('-') then
                            Report.Run(53925, true, true, HRJobApplications);
                    end;
                }
            }
        }
    }

    var
        Text001: label 'Are you sure you want to Upload Applicants Details to the Employee Card?';
        Text002: label 'Are you sure you want to Send this Interview invitation?';
        HRJobApplications: Record "HR Job Applications";
        //  SMTP: Codeunit "SMTP Mail";
        CTEXTURL: Text[30];
       // HREmailParameters: Record "HR E-Mail Parameters";
}




