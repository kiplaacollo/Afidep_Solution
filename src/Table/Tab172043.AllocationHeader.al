Table 172043 "Allocation Header"
{
    DrillDownPageID = "Line Allocations";
    LookupPageID = "Line Allocations";

    fields
    {
        field(1;"Allocation No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Description;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Total Amount";Decimal)
        {
            CalcFormula = sum("Allocation Line2".Amount where ("Allocation No"=field("Allocation No")));
            FieldClass = FlowField;
        }
        field(4;Blocked;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Posting Description";Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Allocation No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

