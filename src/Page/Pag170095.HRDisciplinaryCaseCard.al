Page 170095 "HR Disciplinary Case Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Case Stage,Show';
    SourceTable = "HR Disciplinary Cases NCA";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Dimension 1 Code"; Rec."Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension 2 Code"; Rec."Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Accused Employee"; Rec."Accused Employee")
                {
                    ApplicationArea = Basic;
                }
                field("Accused Employee Name"; Rec."Accused Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field("Manager/Supervisor"; Rec."Manager/Supervisor")
                {
                    ApplicationArea = Basic;
                }
                field("Manager/Supervisor Name"; Rec."Manager/Supervisor Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field("Type of Complaint"; Rec."Type of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Type of Complaint Description"; Rec."Type of Complaint Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field("Description of Complaint"; Rec."Description of Complaint")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Severity Of the Complain"; Rec."Severity Of the Complain")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Complaint was Reported"; Rec."Date of Complaint was Reported")
                {
                    ApplicationArea = Basic;
                }
                field("Violation Place"; Rec."Violation Place")
                {
                    ApplicationArea = Basic;
                }
                field("Violation Date"; Rec."Violation Date")
                {
                    ApplicationArea = Basic;
                }
                field("Violation Time"; Rec."Violation Time")
                {
                    ApplicationArea = Basic;
                }
                field("Manager/Supervisor Statament"; Rec."Manager/Supervisor Statament")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Employee Statement"; Rec."Employee Statement")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Accussed By"; Rec."Accussed By")
                {
                    ApplicationArea = Basic;
                }
                field(Reporter; Rec.Reporter)
                {
                    ApplicationArea = Basic;
                }
                field("Reporter Name"; Rec."Reporter Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field("Non Employee Reporter"; Rec."Non Employee Reporter")
                {
                    ApplicationArea = Basic;
                }
                field("Witness #1"; Rec."Witness #1")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Witness #1 Name"; Rec."Witness #1 Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Witness #2"; Rec."Witness #2")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Witness #2  Name"; Rec."Witness #2  Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Date To Discuss Case"; Rec."Date To Discuss Case")
                {
                    ApplicationArea = Basic;
                }
                field("Body Handling The Complaint"; Rec."Body Handling The Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Body Handling Name"; Rec."Body Handling Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mode of Lodging the Complaint"; Rec."Mode of Lodging the Complaint")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Policy Guidlines In Effect"; Rec."Policy Guidlines In Effect")
                {
                    ApplicationArea = Basic;
                }
                field("Policy Description"; Rec."Policy Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Recommended Action"; Rec."Recommended Action")
                {
                    ApplicationArea = Basic;
                    Editable = RecommendedActionEditable;
                }
                field("Recommended Action Description"; Rec."Recommended Action Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Disciplinary Stage Status"; Rec."Disciplinary Stage Status")
                {
                    ApplicationArea = Basic;
                    Caption = 'Disciplinary Stage';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Appealed; Rec.Appealed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("No. of Appeals"; Rec."No. of Appeals")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Action Information")
            {
                Caption = 'Action Information';
                field("Action Taken"; Rec."Action Taken")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Taken Action Description"; Rec."Taken Action Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Action Taken By Whom"; Rec."Action Taken By Whom")
                {
                    ApplicationArea = Basic;
                }
                field("Action Taken By When"; Rec."Action Taken By When")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Remarks"; Rec."Disciplinary Remarks")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    MultiLine = true;
                }
                field("Investigation Findings"; Rec.Comments)
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Review Findings"; Rec."Review Findings")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Action Duration Start Date"; Rec."Action Duration Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Action Duration End  Date"; Rec."Action Duration End  Date")
                {
                    ApplicationArea = Basic;
                }
                field("Interdict Employee"; Rec."Interdict Employee")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755038; "HR Disciplinary Cases Factbox")
            {
                Caption = 'HR Disciplinary Cases Factbox';
                SubPageLink = "Case Number" = field("Case Number");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Case Stage")
            {
                action("Under Investigation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Under Investigation';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Disciplinary Stage Status", Rec."disciplinary stage status"::Reported);

                        if Confirm('Are you sure you want to mark this case as "Under Investigation"?') then begin
                            Rec."Disciplinary Stage Status" := Rec."disciplinary stage status"::"Under Investigation";
                            Rec.Modify;
                            Message('Case Number %1 has been marked as under "Investigation"', Rec."Case Number");
                        end;
                    end;
                }
                action("In Progress")
                {
                    ApplicationArea = Basic;
                    Caption = 'In Progress';
                    Image = CarryOutActionMessage;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        Rec.TestField(Rec."Disciplinary Stage Status", Rec."disciplinary stage status"::"Under Investigation");


                        if Confirm('Are you sure you want to mark this case as "In Progress"?') then begin
                            Rec."Disciplinary Stage Status" := Rec."disciplinary stage status"::"In progress";
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "In Progress"', Rec."Case Number");
                        end;
                    end;
                }
                action(Close)
                {
                    ApplicationArea = Basic;
                    Caption = ' Close';
                    Image = Closed;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        if (Rec."Disciplinary Stage Status" <> Rec."disciplinary stage status"::"In progress") and (Rec."Disciplinary Stage Status" <> Rec."disciplinary stage status"::"Under review") then
                            Error('You can only close a case that is in progress or under review');

                        Rec.TestField(Status, Rec.Status::Approved);

                        if Confirm('Are you sure you want to mark this case as "Closed"?') then begin
                            Rec."Disciplinary Stage Status" := Rec."disciplinary stage status"::Closed;
                            Rec.Modify;
                            Message('Case Number %1 has been marked as "Closed"', Rec."Case Number");
                        end;
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        DiscCase.Reset;
                        DiscCase.SetRange(DiscCase."Case Number", Rec."Case Number");
                        // if DiscCase.Find('-') then
                        // Report.Run(Report::Report51525058,true,true,DiscCase);
                    end;
                }
            }
            group("Case Status")
            {
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF CONFIRM('Send this Disciplinary Case for Approval?',TRUE)=FALSE THEN EXIT;

                        //VarVariant := Rec;
                        //IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                        //  CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF CONFIRM('Cancel Disciplinary Case Approval Request?',TRUE)=FALSE THEN EXIT;

                        //VarVariant := Rec;
                        //CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
            }
        }
        area(navigation)
        {
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)
                end;
            }
        }
    }

    trigger OnInit()
    begin
        RecommendedActionEditable := true;
        ActionTakenEditable := true;
        DisciplinaryRemarksEditable := true;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        ApprovalsMgt: Codeunit "Approvals Mgmt.";
        VarVariant: Variant;
        "Document Type": Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Leave Journal","Medical Claims","Activity Approval","Disciplinary Approvals";
        RecommendedActionEditable: Boolean;
        ActionTakenEditable: Boolean;
        DisciplinaryRemarksEditable: Boolean;
        DiscCase: Record "HR Disciplinary Cases NCA";


    procedure UpdateControls()
    begin
        /*
        IF DiscCase.Status=DiscCase.Status::New THEN
        BEGIN
          RecommendedActionEditable:=FALSE;
          ActionTakenEditable:=FALSE;
          DisciplinaryRemarksEditable:=FALSE;
        END;
        
        IF DiscCase.Status=DiscCase.Status::Approved  THEN
        BEGIN
          CurrPage.EDITABLE:=FALSE;
        END;
        
        IF DiscCase.Status=DiscCase.Status::"Pending Approval"  THEN
        BEGIN
          CurrPage.EDITABLE:=FALSE;
        END;
        */

    end;
}

