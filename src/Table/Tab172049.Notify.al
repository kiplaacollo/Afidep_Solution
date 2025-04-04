Table 172049 "Notify"
{

    fields
    {
        field(1;"code";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Employee Code";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                if HREmployees.Get("Employee Code") then begin
                  Email:=HREmployees."E-Mail";
                  Names:=HREmployees."First Name"+' '+HREmployees."Middle Name"+' '+HREmployees."Last Name";
                  end;
            end;
        }
        field(3;Email;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Names;Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"code","Employee Code")
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

