table 12 P10
{
    Caption = 'P10';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee No"; Code[30])
        {
            Caption = 'Employee No';
        }
        field(2; "Basic Salary"; Decimal)
        {
            Caption = 'Basic Salary';
        }
        field(3; "House Allowance"; Decimal)
        {
            Caption = 'House Allowance';
        }
        field(4; "Transport Alloawance"; Decimal)
        {
            Caption = 'Transport Alloawance';
        }
        field(5; "Leave Allowance"; Decimal)
        {
            Caption = 'Leave Allowance';
        }
        field(6; "Other Allowance"; Decimal)
        {
            Caption = 'Other Allowance';
        }
        field(7; "Pension Cotribution"; Decimal)
        {
            Caption = 'Pension Cotribution';
        }
        field(8; PAYE; Decimal)
        {
            Caption = 'PAYE';
        }
        field(9; NSSF; Decimal)
        {
            Caption = 'NSSF';
        }
        field(10; "payroll Preriod"; Date)
        {
            Caption = 'payroll Preriod';
            TableRelation = "Payroll Calender_AU"."Date Opened";
        }
        field(11; "Payroll Year"; Integer)
        {
            Caption = 'Payroll Year';
        }
        field(12; "Payroll Month"; Integer)
        {
            Caption = 'Payroll Month';
        }
        field(13; "Transaction Code"; Code[20])
        {
            Caption = 'Transaction Code';
        }
        field(14; "Transaction Name"; Text[50])
        {
            Caption = 'Transaction Name';
        }
        field(15; "Transaction key"; Code[20])
        {
            Caption = 'Transaction key';
        }
        field(16; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
        field(17; OverTimeAllowance; Decimal)
        {
            Caption = 'OverTimeAllowance';
        }
        field(18; "Insurance Relief"; Decimal)
        {
            Caption = 'Insurance Relief';
        }
        field(19; "Personal Relief"; Decimal)
        {
            Caption = 'Personal Relief';
        }
    }
    keys
    {
        key(PK; "Employee No")
        {
            Clustered = true;
        }
    }
}
