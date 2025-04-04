Table 50103 Assessment
{



    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Appraisal No"; Code[30])
        {
            TableRelation = "HR Appraisal Header"."No.";
        }
        field(3; "Appraisal Period"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code where(Type = filter("Appraisal Period"),
                                                           Closed = const(false));
        }
        field(4; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Employees";
        }


        field(5; "Employee’s self-assessment"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Appraiser’s assessment"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Appraisal Stage"; Option)
        {
            OptionMembers = "Target Setting","Target Approval","Mid Year Review","End Year Evaluation","Supervisor Evaluation","Appraisal Completed";
            FieldClass = FlowField;
            CalcFormula = lookup("HR Appraisal Header"."Appraisal Stage" where("No." = field("Appraisal No")));
            Editable = false;

        }
        field(8; "Employee Comments"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Line Manager Comments"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Line No", "Appraisal No", "Appraisal Period", "Employee No")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }


    var
        Employee: Record "HR Employees";
        HRAppraisalGoalSettingH: Record "HR Appraisal Header";
        AppraisalScores: Record "HR Appraisal Lines";
        mycurrStatus: Boolean;
        objHRSetup: Record "HR Setup";
        Vendor: Record Vendor;
        Customer: Record Customer;
        HRAPPHEADER: Record "HR Appraisal Header";
        HRAppraisalLines: Record "HR Appraisal Lines";
    // CoreV: Record "Delegation Header";
    // MainV: Record "Delegation Line";
    // Performance: Record "Perfomance Ratings";


    procedure maxRating() maxRating: Decimal
    begin
        maxRating := 0;
        objHRSetup.Reset;
        objHRSetup.SetRange(objHRSetup."Primary Key");
        if objHRSetup.Find('-') then
            maxRating := objHRSetup."Max Appraisal Rating";
    end;
}

