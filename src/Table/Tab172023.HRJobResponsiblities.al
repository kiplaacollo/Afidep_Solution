Table 172023 "HR Job Responsiblities"
{
    // DrillDownPageID = UnknownPage55564;
    // LookupPageID = UnknownPage55564;

    fields
    {
        field(2;"Job ID";Code[100])
        {
            TableRelation = "HR Jobss"."Job ID";
        }
        field(3;"Responsibility Description";Text[250])
        {
        }
        field(4;Remarks;Text[150])
        {
        }
        field(5;"Responsibility Code";Code[20])
        {

            trigger OnValidate()
            begin
                /*HRAppEvalArea.RESET;
                HRAppEvalArea.SETRANGE(HRAppEvalArea."Assign To","Responsibility Code");
                IF HRAppEvalArea.FIND('-') THEN
                BEGIN
                    "Responsibility Description":=HRAppEvalArea.Code;
                END;*/

            end;
        }
    }

    keys
    {
        key(Key1;"Job ID","Responsibility Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

