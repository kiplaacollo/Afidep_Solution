Page 50018 "Appraisal Card Supervisor"
{
    PageType = Card;
    SourceTable = "HR Appraisal Header";
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            group(General)
            {
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
                }
                field("Total Behavioral Score"; Rec."Total Behavioral Score")
                {
                    ApplicationArea = Basic;
                }
                field("Appraised Score"; Rec."Appraised Score")
                {
                    ApplicationArea = Basic;
                }
                field("Appraised Narration"; Rec."Appraised Narration")
                {
                    ApplicationArea = Basic;
                }
                field("Score Grading"; Rec."Score Grading")
                {
                    ApplicationArea = Basic;
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
            }

        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup1120054022)
            {
                action("Send Back For Correction")
                {
                    ApplicationArea = Basic;
                    Image = SendConfirmation;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to send to supervisor?', true, false) = true then begin
                            Rec."Appraisal Status" := Rec."appraisal status"::Supervisor;
                            Rec.Modify;
                        end;
                    end;
                }
                action("Appraise Staff")
                {
                    ApplicationArea = Basic;
                    Image = SendConfirmation;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to appraise this staff?', true, false) = true then begin
                            Rec.CalcFields(Rec."Total Targets", Rec."Total Target Score", Rec."Total Behavioral Score");
                            Rec."Appraised Score" := ROUND((Rec."Total Target Score" / Rec."Total Targets" * 80), 0.05, '>');
                            Rec."Appraised Score" := Rec."Appraised Score" + Rec."Total Behavioral Score";

                            if Rec."Appraised Score" < 60 then begin
                                Rec."Score Grading" := 'D';
                                Rec."Appraised Narration" := 'Poor performance-Institute corrective action.';
                            end else
                                if (Rec."Appraised Score" > 59) and (Rec."Appraised Score" < 80) then begin
                                    Rec."Score Grading" := 'C';
                                    Rec."Appraised Narration" := 'Fair performance.';
                                end else
                                    if (Rec."Appraised Score" > 79) and (Rec."Appraised Score" < 95) then begin
                                        Rec."Score Grading" := 'B';
                                        Rec."Appraised Narration" := 'Good performance.';
                                    end else
                                        if (Rec."Appraised Score" > 94) and (Rec."Appraised Score" < 101) then begin
                                            Rec."Score Grading" := 'B+';
                                            Rec."Appraised Narration" := 'Very Good Performance.';
                                        end else
                                            if (Rec."Appraised Score" > 100) then begin
                                                Rec."Score Grading" := 'A';
                                                Rec."Appraised Narration" := 'Excellent Performance ';
                                            end;
                            Rec.Appraised := true;
                            Rec."Appraised By" := UserId;
                            Rec.Modify();
                        end;
                    end;
                }
            }
        }
    }
}

