Table 170111 "HR Applicant Hobbies"
{

    fields
    {
        field(1; "Job Application No"; Code[20])
        {
            TableRelation = "HR Job Applications"."Application No";
        }
        field(2; Hobby; Text[200])
        {
        }
        field(3; "Line No"; Integer)
        {

        }
    }

    keys
    {
        key(Key1; "Job Application No", Hobby)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

