Table 170178 "Tender Committee"
{

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Member Name"; Text[100])
        {
        }
        field(3; "ID No."; Text[50])
        {
        }
        field(4; "Staff  No."; Code[50])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                if HREmployees.Get("Staff  No.") then begin
                    "Member Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                    "ID No." := HREmployees."ID Number";
                    Position := HREmployees."Job Title";
                    "Tel No." := HREmployees."Cell Phone Number";
                    "Email Address" := HREmployees."Company E-Mail";
                end;
            end;
        }
        field(5; Position; Text[50])
        {
        }
        field(6; "Tel No."; Text[50])
        {
        }
        field(7; "Email Address"; Text[100])
        {
        }
        field(8; "Tender No"; Code[200])
        {
            TableRelation = "Tender Notice"."Tender No";
        }
        field(9; Type; Option)
        {
            OptionCaption = ',Evaluation,Inspection,Opening';
            OptionMembers = ,Evaluation,Inspection,Opening;
        }
        field(10; Signature; Blob)
        {

        }
    }

    keys
    {
        key(Key1; No, "Tender No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmployees: Record "HR Employees";
}

