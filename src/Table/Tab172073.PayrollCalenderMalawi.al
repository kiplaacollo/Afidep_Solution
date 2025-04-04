Table 172073 "Payroll CalenderMalawi"
{

    fields
    {
        field(10; "Date Opened"; Date)
        {
        }
        field(11; "Date Closed"; Date)
        {
        }
        field(12; "Period Name"; Text[50])
        {
        }
        field(13; "Period Month"; Integer)
        {
        }
        field(14; "Period Year"; Integer)
        {
        }
        field(15; "Payroll Code"; Code[50])
        {
        }
        field(16; "Tax Paid"; Decimal)
        {
        }
        field(17; "Tax Paid(LCY)"; Decimal)
        {
        }
        field(18; "Basic Pay Paid"; Decimal)
        {
        }
        field(19; "Basic Pay Paid(LCY)"; Decimal)
        {
        }
        field(20; Closed; Boolean)
        {
        }
        field(21; "Payslip Message"; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                PayrollEmployee_AU.Reset;
                PayrollEmployee_AU.SetRange(Status, PayrollEmployee_AU.Status::Active);
                if PayrollEmployee_AU.FindSet then begin
                    repeat
                        PayrollEmployee_AU."Payslip Message" := "Payslip Message";
                        PayrollEmployee_AU.Modify;
                    until PayrollEmployee_AU.Next = 0;
                end;
            end;
        }
        field(22; "Currency Code"; Decimal)
        {
            DecimalPlaces = 5;
            DataClassification = ToBeClassified;
        }
        field(23; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(24; "Malawi Currency Code"; Decimal)
        {
            DecimalPlaces = 5;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Date Opened", "Branch Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PayrollEmployee_AU: Record "Payroll Employee_AU";
}

