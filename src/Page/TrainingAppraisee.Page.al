Page 17330 "Training Appraisee"
{
    PageType = ListPart;
    SourceTable = "HR Appraisal Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {


                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = Basic;
                    Enabled = EditField;
                }
                field("Lessons Learnt"; Rec."Lessons Learnt")
                {
                    ApplicationArea = Basic;
                    Visible = EvaluationVisibility;
                }
                field("Appraisee Remarks"; Rec."Appraisee Remarks")
                {
                    ApplicationArea = Basic;
                    Visible = EvaluationVisibility;
                }
                field("Supervisor Remarks"; Rec."Supervisor Remarks")
                {
                    ApplicationArea = Basic;
                    Visible = EvaluationVisibility;
                }
            }
        }
    }

    actions
    {
    }
    var
        EvaluationVisibility: Boolean;
        EditField: Boolean;
        AppraisalH: Record "HR Appraisal Header";

    trigger OnAfterGetRecord()
    begin
        UpdateVisibility();
        UpdateEdition();
    end;
      trigger OnOpenPage()
    begin
        UpdateEdition();
    end;
   

    procedure UpdateVisibility()
    var
        myInt: Integer;
    begin
        EvaluationVisibility := false;
        AppraisalH.Reset();
        AppraisalH.SetRange("No.", Rec."Appraisal No");
        if AppraisalH.FindSet() then begin
            if (AppraisalH."Appraisal Stage" = AppraisalH."Appraisal Stage"::"End Year Evaluation") or (AppraisalH."Appraisal Stage" = AppraisalH."Appraisal Stage"::"Appraisal Completed") or
            (AppraisalH."Appraisal Stage" = AppraisalH."Appraisal Stage"::"Supervisor Evaluation") then begin
                EvaluationVisibility := true;
            end else
                EvaluationVisibility := false;
        end;
    end;

    procedure UpdateEdition()
    var
        myInt: Integer;
    begin
        EditField := false;
        if (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"End Year Evaluation") or (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Supervisor Evaluation") or
            (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Appraisal Completed") then begin
            EditField := false;
        end else
            if (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Setting") then begin
                EditField := true;
            end;
    end;
}

