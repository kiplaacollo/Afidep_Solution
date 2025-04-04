Table 171228 "Timesheets Allocation"
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
        field(4; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROJECTS'));
        }
        field(5; Allocation; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "BudgetLine Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BUDGET LINE'), "Project Code" = field("Project Code"));
        }
        field(7; "Total Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
           
        }
        field(8; Hours; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Period, "Project Code", "Employee No")
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

