Table 172010 "Payroll Employer Deductions_AU"
{

    fields
    {
        field(10;"Employee Code";Code[2000])
        {
        }
        field(11;"Transaction Code";Code[2000])
        {
        }
        field(12;Amount;Decimal)
        {
        }
        field(13;"Period Month";Integer)
        {
        }
        field(14;"Period Year";Integer)
        {
        }
        field(15;"Payroll Period";Date)
        {
            TableRelation = "Payroll Calender_AU"."Date Opened";
        }
        field(16;"Payroll Code";Code[2000])
        {
        }
        field(17;"Amount(LCY)";Decimal)
        {
        }
        field(18;Group;Integer)
        {
        }
        field(19;SubGroup;Integer)
        {
        }
        field(20;"Transaction Type";Code[2000])
        {
        }
        field(21;Description;Text[200])
        {
        }
        field(22;Balance;Decimal)
        {
        }
        field(23;"Balance(LCY)";Decimal)
        {
        }
        field(24;"Membership No";Code[20])
        {
        }
        field(25;"Reference No";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Employee Code","Transaction Code","Period Month","Period Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

