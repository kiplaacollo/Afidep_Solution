Page 50100 "New Appraisal Card"
{
    PageType = Card;
    SourceTable = "HR Appraisal Header";
    PromotedActionCategories = 'New,Process,Report,Send To Supervisor,Supervisor Approval';

    layout
    {
        area(content)
        {
            group(General)
            {
                //
                Enabled = editableFa;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor User ID"; Rec."Supervisor User ID")
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor Name';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("Date of First Appointment"; Rec."Date of First Appointment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Joined';
                }
                field("Evaluation Period Start Date"; Rec."Evaluation Period Start Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reviewed Period From: ';
                }
                field("Evaluation Period End Date"; Rec."Evaluation Period End Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reviewed Period To: ';
                }
                field("Goal Setting (31 Jan)"; Rec."Goal Setting (31 Jan)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Completed Goal Setting';
                }
                field("Mid Term Review (31 Jul)"; Rec."Mid Term Review (31 Jul)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Completed Mid Term Review';
                }
                field("Annual Review (31 Dec)"; Rec."Annual Review (31 Dec)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Completed Annual Review';
                }
            }
            part(WorkLoad; ProjectWorkLoad)
            {
                SubPageLink = "Header No" = field("No.");
                //Visible = false;
            }
            part(KPI; "Appraisal Lines Targets")
            {
                SubPageLink = "Header No" = field("No.");
                Caption = 'For each project/functional area, please list down below, the objectives to be achieved by the end of the performance review period (i.e. After 12 months, with a review at 6 months) ';
                //Visible = false;
            }
            part("Resources Required"; "Required Resources")
            {
                SubPageLink = "Header No" = field("No.");
            }
            part(Confirmation; Confirmation)
            {
                SubPageLink = "Header No" = field("No.");
            }
            part("Mid-Term Review "; "Appraisal Assessment")
            {
                SubPageLink = "Appraisal No" = field("No."), "Employee No" = field("Employee No.");
                Editable = editableFa;
                //Visible = false;

            }
            part("Annual Review"; "Annual Review")
            {
                SubPageLink = "Header No" = field("No.");
                //Caption = 'For each project/functional area, please list down below, the objectives to be achieved by the end of the performance review period (i.e. After 12 months, with a review at 6 months) ';
                //Visible = false;
            }
            part("Job Specific objectives"; "Individual Perfomance Score")
            {
                SubPageLink = "Appraisal No" = field("No."), "Employee No" = field("Employee No."), "Perfomance Goals and Targets" = filter(<> '');
                Editable = editableFa;
                Visible = false;

            }

            part("Key Competencies"; "Key Competencies ")
            {
                SubPageLink = "Appraisal No" = field("No.");
            }
            part("Personal Development"; "Personal Development")
            {
                SubPageLink = "Appraisal No." = field("No.");
            }

            part("Training Needs"; "Training Appraisee")
            {
                SubPageLink = "Appraisal No" = field("No."), "Employee No" = field("Employee No."), "Course Name" = filter(<> '');
                Editable = editableFa;
                Caption = 'Personal Development';
                Visible = false;

            }
            part("OVerall Comments"; "Overall Comments")
            {
                SubPageLink = "Appraisal No" = field("No."), "Employee No" = field("Employee No.");
                Editable = editableFa;
                //Visible = false;

            }

        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup1120054007)
            {
                action("Send To Supervisor(Target Approval)")
                {
                    ApplicationArea = Basic;
                    Image = SendConfirmation;
                    Enabled = AppraiseeEnabled;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Rec."User ID" <> UserId then Error('You can only act on your appraisal form %1', Rec."User ID");
                        if Confirm('Are you sure you want to send to supervisor?') = true then begin
                            Rec."Appraisal Status" := Rec."Appraisal Status"::Supervisor;
                            Rec."Appraisal Stage" := Rec."Appraisal Stage"::"Target Approval";
                            Rec."Date sent Aprroval" := Today;
                            Rec.Modify();
                            Message('Tragets send for approval');
                        end;
                    end;
                }
                action("Approve Targets")
                {
                    ApplicationArea = Basic;
                    Image = SendConfirmation;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category5;
                    Enabled = SupervisorEnabled;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Approve the targets?') = false then exit;
                        Rec.Status := Rec.Status::Approved;
                        Rec."Appraisal Stage" := Rec."Appraisal Stage"::"End Year Evaluation";
                        Rec.Modify();
                        Message('Targets approved successfully');

                    end;
                }
                action("Return To Appraisee")
                {
                    ApplicationArea = Basic;
                    Image = SendConfirmation;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category5;
                    Enabled = SupervisorEnabled;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Appraisal Stage", Rec."Appraisal Stage"::"Target Approval");
                        if Confirm('Are you sure you want to return to appraisee?') = false then exit;
                        Rec."Appraisal Stage" := Rec."Appraisal Stage"::"Target Setting";
                        rec."Appraisal Status" := rec."Appraisal Status"::Appraisee;
                        Rec.MODIFY;
                        MESSAGE('Appraisal returned to appraisee')

                    end;
                }
                /*"Appraisal Period";*/
                action("Send To Supervisor(Evaluation)")
                {
                    ApplicationArea = Basic;
                    Image = SendConfirmation;
                    Enabled = SendForevaluation;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Rec."User ID" <> UserId then Error('You can only act on your appraisal form %1', Rec."User ID");
                        if Confirm('Are you sure you want to send to supervisor?') = true then begin

                            Rec."Appraisal Stage" := Rec."Appraisal Stage"::"Supervisor Evaluation";
                            Rec.Modify();
                            Message('Goals assessment send for Evaluation');
                        end;
                    end;
                }
                action("Approve Goals")
                {
                    ApplicationArea = Basic;
                    Image = SendConfirmation;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category5;
                    Enabled = SupervisorEvaluation;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Approve the Goals?') = false then exit;
                        Rec.Status := Rec.Status::Closed;
                        Rec.Appraised := true;
                        Rec."Appraised By" := UserId;
                        Rec."Appraisal Stage" := Rec."Appraisal Stage"::"Appraisal Completed";
                        Rec.Modify();
                        Message('Appraisal process has been successfuly completed');

                    end;
                }
                action("Print Form")
                {
                    ApplicationArea = Basic;
                    Image = SendConfirmation;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Report;


                    trigger OnAction()
                    begin
                        AppraisalHeader.Reset();
                        AppraisalHeader.SetRange("No.", Rec."No.");
                        if AppraisalHeader.Find('-') then begin
                            Report.Run(Report::"Appraisal Form", true, false, AppraisalHeader);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        AppraiseeEnabled := false;
        SupervisorEnabled := false;
        editableFa := false;
        SupervisorEvaluation := false;
        SendForevaluation := false;
        EnableField := false;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Setting" then begin
            AppraiseeEnabled := true;
            SupervisorEnabled := false;
            SendForevaluation := false;
            SupervisorEvaluation := false;
        end;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Approval" then begin
            SupervisorEnabled := true;
            AppraiseeEnabled := false;
            SendForevaluation := false;
            SupervisorEvaluation := false;

        end;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"End Year Evaluation" then begin
            SupervisorEnabled := false;
            AppraiseeEnabled := false;
            SendForevaluation := true;
            SupervisorEvaluation := false;

        end;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Supervisor Evaluation" then begin
            SupervisorEnabled := false;
            AppraiseeEnabled := false;
            SendForevaluation := false;
            SupervisorEvaluation := true;

        end;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Setting" then begin
            EnableField := true;
        end else begin
            EnableField := false;
        end;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Appraisal Completed" then begin
            editableFa := false;
        end else begin
            editableFa := true;
        end;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        AppraisalHeader.Reset();
        AppraisalHeader.SetRange("User ID", UserId);
        AppraisalHeader.SetRange("Appraisal Stage", AppraisalHeader."Appraisal Stage"::"Target Setting");
        if AppraisalHeader.FindSet() then begin
            if AppraisalHeader.Count > 1 then begin
                Error('You have another target setting that is open kindly use that %1', AppraisalHeader."No.");
            end;

        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Records are not allowed to be deleted. create another record instead!!!');
    end;

    trigger OnOpenPage()
    begin
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Setting" then begin
            EnableField := true;
        end else begin
            EnableField := false;
        end;
        if Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Appraisal Completed" then begin
            editableFa := false;
        end else begin
            editableFa := true;
        end;
        // Message('%1-%2-%3', Rec."Appraisal Stage", EnableField, editableFa);

    end;


    var
        SendForevaluation: Boolean;
        SupervisorEnabled: Boolean;
        AppraiseeEnabled: Boolean;
        SupervisorEvaluation: Boolean;
        editableFa: Boolean;
        EnableField: Boolean;
        AppraisalHeader: Record "HR Appraisal Header";
}

