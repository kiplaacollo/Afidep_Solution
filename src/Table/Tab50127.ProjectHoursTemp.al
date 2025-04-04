table 50001 "Project Hours Temp"
{
    DataClassification = ToBeClassified;
    // Temporary = true;

    fields
    {
        field(1; "Timesheet No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Staff No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Project Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Total Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Date, "Staff No", "Project Code")
        {
            Clustered = true;
        }
    }
}
