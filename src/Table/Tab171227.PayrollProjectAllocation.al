Table 171227 "Payroll Project Allocation"
{

    fields
    {
        field(1; Period; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Calender_AU"."Date Opened";
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


            // trigger OnValidate()
            // begin
            //     if DimensionValue.Get("Project Code") then
            //         "Project Name" := DimensionValue.Name;
            //     // Award.Reset;
            //     // Award.SetRange(Award."No.","Project Code");
            //     // if Award.find('-') then
            //     // "Project Name" := Award.Name;
            // end;
            trigger OnValidate()
            begin
                DimensionValue.Reset;
                DimensionValue.SetRange(DimensionValue.Code, "Project Code");
                // DimensionValue.SetRange("Dimension Code", 'PROJECTS');
                if DimensionValue.Find('-') then begin
                    "Project Name" := DimensionValue.Name;
                 //   Error('Project name : %1', "Project Name");
                end;
            end;
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
        field(9; "Project Name"; Text[200])
        {
            // DataClassification = ToBeClassified;
            // TableRelation = "Dimension Value".Name where("Dimension Code" = const('PROJECTS'));
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
        DimensionValue: Record "Dimension Value";
        Award: Record Award;
}

