Table 171229 "Stay Details"
{

    fields
    {
        field(1; Period; Date)
        {
            DataClassification = ToBeClassified;
            //   TableRelation = "Payroll Calender_AU"."Date Opened";
        }
        field(2; "Employee No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Employee_AU";

            trigger OnValidate()
            begin
                if HREmployees.Get("Employee No") then
                    "Employee Name" := HREmployees.Firstname + ' ' + HREmployees.Lastname;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Cost of Stay"; Decimal)
        {
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(Key1; Period, "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmployees: Record "Payroll Employee_AU";
}

