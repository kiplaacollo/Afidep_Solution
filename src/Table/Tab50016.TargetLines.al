Table 50016 "Target Lines"
{

    fields
    {
        field(1; No; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Key Value Drivers"; Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Key Value Drivers"."Key Value Driver";
        }
        field(3; "Key Performance Indicator"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Key Performance Indicators".Indicator where("Key Value Drivers" = field("Key Value Drivers"));
        }
        field(4; Target; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Staff No"; Code[20])
        {
            TableRelation = "HR Employees";
        }
        field(6; Weight; Decimal)
        {
        }
        field(7; "Target Score"; Text[200])
        {
        }
        field(8; "Target Header"; Code[20])
        {
        }
        field(9; Period; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; No, "Target Header", "Staff No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if TargetLines.FindLast then
            No := TargetLines.No + 1
        else
            No := 1;

        AppraisalPeriods.SetRange(AppraisalPeriods.Open, true);
        if AppraisalPeriods.FindFirst then begin
            Period := AppraisalPeriods.Code;
        end;
    end;

    var
        TargetLines: Record "Target Lines";
        AppraisalPeriods: Record "Appraisal Periods";
}

