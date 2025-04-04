Table 170179 "Leave Planner"
{

    fields
    {
        field(1;"Employee No";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                if HREmployees.Get("Employee No") then
                  "Employee Name":=HREmployees.FullName;
            end;
        }
        field(2;"Employee Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Start Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"End Date";Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "No of Days":="End Date"-"Start Date";
            end;
        }
        field(5;"No of Days";Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Employee No","Employee Name")
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

