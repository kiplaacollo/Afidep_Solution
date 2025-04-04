Table 172004 "Payroll Employee P9_AU"
{

    fields
    {
        field(10;"Employee Code";Code[20])
        {
            TableRelation = "Payroll Employee_AU";
        }
        field(11;"Basic Pay";Decimal)
        {
        }
        field(12;Allowances;Decimal)
        {
        }
        field(13;Benefits;Decimal)
        {
        }
        field(14;"Value Of Quarters";Decimal)
        {
        }
        field(15;"Defined Contribution";Decimal)
        {
        }
        field(16;"Owner Occupier Interest";Decimal)
        {
        }
        field(17;"Gross Pay";Decimal)
        {
        }
        field(18;"Taxable Pay";Decimal)
        {
        }
        field(19;"Tax Charged";Decimal)
        {
        }
        field(20;"Insurance Relief";Decimal)
        {
        }
        field(21;"Tax Relief";Decimal)
        {
        }
        field(22;PAYE;Decimal)
        {
        }
        field(23;NSSF;Decimal)
        {
        }
        field(24;NHIF;Decimal)
        {
        }
        field(25;Deductions;Decimal)
        {
        }
        field(26;"Net Pay";Decimal)
        {
        }
        field(27;"Period Month";Integer)
        {
        }
        field(28;"Period Year";Integer)
        {
        }
        field(29;"Payroll Period";Date)
        {
            TableRelation = "Payroll Calender_AU"."Date Opened";
        }
        field(30;"Period Filter";Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Calender_AU"."Date Opened";
        }
        field(31;Pension;Decimal)
        {
        }
        field(32;HELB;Decimal)
        {
        }
        field(33;"Payroll Code";Code[20])
        {
        }
        field(34;"Line No";Integer)
        {
            AutoIncrement = true;
        }
        field(35;"Employee PIN";Code[20])
        {
        }
        field(36;"Contract Type";Option)
        {
            CalcFormula = lookup("Payroll Employee_AU"."Contract Type" where ("No."=field("Employee Code")));
            FieldClass = FlowField;
            OptionCaption = 'Contract,Secondment,Casual,Temporary,Volunteer,Project Staff,Consultant-Contract,Consultant,Deployed,Board,Committee,Full Time';
            OptionMembers = Contract,Secondment,Casual,"Temporary",Volunteer,"Project Staff","Consultant-Contract",Consultant,Deployed,Board,Committee,"Full Time";
        }
    }

    keys
    {
        key(Key1;"Employee Code","Period Month","Period Year","Payroll Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

