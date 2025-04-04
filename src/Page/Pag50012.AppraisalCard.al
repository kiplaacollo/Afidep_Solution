Page 50012 "Appraisal Card"
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
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Status"; Rec."Appraisal Status")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Supervisor User ID"; Rec."Supervisor User ID")
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
                field("Supervisor No."; Rec."Supervisor No.")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = Basic;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;

                }
                field("Total Target Score"; Rec."Total Target Score")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                }
                field("Total Behavioral Score"; Rec."Total Behavioral Score")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                }
                field("Appraised Score"; Rec."Appraised Score")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                }
                field("Appraised Narration"; Rec."Appraised Narration")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                }
                field("Score Grading"; Rec."Score Grading")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                }
                field(Appraised; Rec.Appraised)
                {
                    ApplicationArea = Basic;

                }
                field("Appraised By"; Rec."Appraised By")
                {
                    ApplicationArea = Basic;

                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = Basic;

                }
            }
            part(KPI; "Appraisal Lines Targets")
            {
                SubPageLink = "Header No" = field("No.");
                //Visible = false;
            }
            part("Individual objectives"; "Departmental Objectives")
            {
                SubPageLink = "Appraisal No" = field("No."), "Employee No" = field("Employee No."), "Key Performance Areas" = filter(<> '');
                Editable = editableFa;

            }
            part("Job Specific objectives"; "Individual Perfomance Score")
            {
                SubPageLink = "Appraisal No" = field("No."), "Employee No" = field("Employee No."), "Perfomance Goals and Targets" = filter(<> '');
                Editable = editableFa;

            }
            part("Training Needs"; "Training Appraisee")
            {
                SubPageLink = "Appraisal No" = field("No."), "Employee No" = field("Employee No."), "Course Name" = filter(<> '');
                Editable = editableFa;

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

