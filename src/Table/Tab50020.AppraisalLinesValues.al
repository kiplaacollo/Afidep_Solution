Table 50020 "Appraisal Lines Values"
{

    fields
    {
        field(1;"Appraisal No.";Integer)
        {
            Editable = false;
            TableRelation = "HR Appraisal Header"."No.";
        }
        field(2;Values;Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Description;Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5;Score;Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
        }
        field(6;"Appraisee Comments";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Supervisor Score";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Agreed Score";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Appraisal Period";Code[60])
        {
            DataClassification = ToBeClassified;
            Description = 's';
        }
        field(10;"Target Score";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Supervisors Comments";Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(12;Department;Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Header No";Code[60])
        {
        }
    }

    keys
    {
        key(Key1;"Appraisal No.","Header No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if ValuesLines.FindLast then
        "Appraisal No.":=ValuesLines."Appraisal No."+1
        else
        "Appraisal No.":=1;
    end;

    var
        ValuesLines: Record "Appraisal Lines Values";
}

