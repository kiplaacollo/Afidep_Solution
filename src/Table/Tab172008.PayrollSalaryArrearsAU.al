Table 172008 "Payroll Salary Arrears_AU"
{

    fields
    {
        field(10;"Employee Code";Code[20])
        {
            TableRelation = "Payroll Employee_AU";
        }
        field(11;"Transaction Code";Code[20])
        {
        }
        field(12;"Start Date";Date)
        {
            Description = 'From when';
        }
        field(13;"End Date";Date)
        {
            Description = 'Upto when';
        }
        field(14;"Salary Arrears";Decimal)
        {
        }
        field(15;"Salary Arrears(LCY)";Decimal)
        {
        }
        field(16;"PAYE Arrears";Decimal)
        {
        }
        field(17;"PAYE Arrears(LCY)";Decimal)
        {
        }
        field(18;"Period Month";Integer)
        {
        }
        field(19;"Period Year";Integer)
        {
        }
        field(20;"Current Basic";Decimal)
        {
        }
        field(21;"Current Basic(LCY)";Decimal)
        {
        }
        field(22;"Payroll Period";Date)
        {
            TableRelation = "Payroll Calender_AU"."Date Opened";
        }
        field(23;Number;Integer)
        {
            AutoIncrement = true;
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1;"Employee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

