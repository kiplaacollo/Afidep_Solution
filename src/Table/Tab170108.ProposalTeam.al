table 170108 "Proposal Team"
{
    DrillDownPageID = 17295;
    LookupPageID = 17295;

    fields
    {
        field(1; "Proposal No."; Code[50])
        {
        }
        field(2; "Employee No."; Code[50])
        {
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                IF EmployeeRec.GET("Employee No.") THEN BEGIN
                    Name := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
                    "Job Title" := EmployeeRec."Job Title";
                    Email := EmployeeRec."Company E-Mail";
                END;
            end;
        }
        field(3; Name; Text[100])
        {
        }
        field(4; "Job Title"; Text[100])
        {
        }
        field(5; Email; Text[100])
        {
        }
        field(6; "Allocation %"; Decimal)
        {
        }
        field(7; "Daily Rate"; Decimal)
        {
        }
        field(8; "Budgeted Amount"; Decimal)
        {
        }
        field(9; "Actual Amount"; Decimal)
        {
        }


    }

    keys
    {
        key(Key1; "Proposal No.", "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // EmployeeProjectAssignment.RESET;
        // EmployeeProjectAssignment.SETRANGE("Project Code","Proposal No.");
        //EmployeeProjectAssignment.SETRANGE("Employee No","Employee No.");
        //  IF NOT EmployeeProjectAssignment.FINDFIRST THEN BEGIN
        //  EmployeeProjectAssignment.INIT;
        //  EmployeeProjectAssignment.Date:=TODAY;
        // EmployeeProjectAssignment.VALIDATE("Project Code","Proposal No.");
        // EmployeeProjectAssignment.VALIDATE("Employee No","Employee No.");
        // EmployeeProjectAssignment.Status:=EmployeeProjectAssignment.Status::Active;
        //  EmployeeProjectAssignment.INSERT;
    END;
    // end;

    var
        EmployeeRec: Record "HR Employees";
    // EmployeeProjectAssignment: Record "170070";
}

