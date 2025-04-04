Page 17327 "Individual Perfomance Score"
{
    PageType = ListPart;
    SourceTable = "HR Appraisal Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {



                field("Key Output Areas"; Rec."Key Output Areas")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                    Enabled = EditField;
                }
                field("Key Performance Indicators"; Rec."Key Performance Indicators")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                    Enabled = EditField;
                }
                field("Perfomance Goals and Targets"; Rec."Perfomance Goals and Targets")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                    Enabled = EditField;
                }
                field("Self Rating"; Rec."Self Rating")
                {
                    ApplicationArea = Basic;
                    Visible = EvaluationVisibility;
                }
                field("Supervisor Rating"; Rec."Supervisor Rating")
                {
                    ApplicationArea = Basic;
                    Visible = EvaluationVisibility;
                }
                field("Employee Comments"; Rec."Employee Comments")
                {
                    ApplicationArea = Basic;
                    Visible = EvaluationVisibility;
                    MultiLine = true;
                }
                field("Supervisor Comments"; Rec."Supervisor Comments")
                {
                    ApplicationArea = Basic;
                    Visible = EvaluationVisibility;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
    }
    var
        AppraisalHeader: Record "HR Appraisal Header";
        VisibilityStatus: Boolean;

        EvaluationVisibility: Boolean;
        EditField: Boolean;
        AppraisalH: Record "HR Appraisal Header";

    trigger OnAfterGetRecord()
    begin
        VisibilityStatus := false;
        AppraisalHeader.Reset();
        AppraisalHeader.SetRange("No.", Rec."Appraisal No");
        if AppraisalHeader.FindSet() then begin
            if AppraisalHeader."Appraisal Status" = AppraisalHeader."Appraisal Status"::Supervisor then begin
                VisibilityStatus := true
            end else
                VisibilityStatus := false;
        end;
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
        if (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"End Year Evaluation") or (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Supervisor Evaluation") or
           (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Appraisal Completed") then begin
            EditField := false;
        end else
            if (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Setting") then begin
                EditField := true;
            end;
    end;
}

