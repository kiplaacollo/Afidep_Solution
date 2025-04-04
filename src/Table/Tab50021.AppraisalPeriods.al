Table 50021 "Appraisal Periods"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Period Start Date"; Date)
        {
        }
        field(4; "Period End Date"; Date)
        {
        }
        field(5; Open; Boolean)
        {
            trigger OnValidate()
            begin
                if Open = true then
                    "Opened By" := UserId
                else
                    "Close By" := UserId;
            end;
        }
        field(6; "Close By"; Code[20])
        {
        }
        field(7; "Opened By"; Code[20])
        {
        }
        field(8; "Mid Year Review Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

