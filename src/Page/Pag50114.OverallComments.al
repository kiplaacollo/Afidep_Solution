Page 50114 "Overall Comments"
{
    PageType = ListPart;
    SourceTable = Assessment;


    layout
    {
        area(content)
        {
            // repeater(Group)
            // {


            field("Employee Comments"; Rec."Employee Comments")
            {
                ApplicationArea = Basic;
                MultiLine = true;
                // Enabled = EditField;
                Caption = 'Employee Comments';


            }
            // }
            // repeater(Group2)
            // {


            field("Appraiser’s assessment"; Rec."Appraiser’s assessment")
            {
                ApplicationArea = Basic;
                MultiLine = true;
                //  Enabled = EditField;
                Caption = 'Appraiser’s assessment';


            }
        }
        // }
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
            if (AppraisalH."Appraisal Stage" = AppraisalH."Appraisal Stage"::"End Year Evaluation") or (AppraisalH."Appraisal Stage" = AppraisalH."Appraisal Stage"::"Supervisor Evaluation") or
            (AppraisalH."Appraisal Stage" = AppraisalH."Appraisal Stage"::"Appraisal Completed") then begin
                EvaluationVisibility := false;
            end else
                EvaluationVisibility := true;
        end;
    end;

    procedure UpdateEdition()
    var

    begin
        EditField := false;

        if (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"End Year Evaluation") or (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Supervisor Evaluation") or
            (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Appraisal Completed") then begin
            EditField := false;
        end else
            if (Rec."Appraisal Stage" = Rec."Appraisal Stage"::"Target Setting") then begin
                EditField := true;
            end;
        //end;
    end;
}

