Table 170017 "Billing and Payments Periods"
{

    fields
    {
        field(1;"Starting Date";Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
                Year:=Date2dmy("Starting Date",3);
                Name := Format("Starting Date",0,'<Month Text>')+' '+Format(Year);//+FORMAT(Type);
            end;
        }
        field(2;Name;Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"New Fiscal Year";Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Date Locked",false);
            end;
        }
        field(4;Closed;Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(5;"Date Locked";Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(6;Year;Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Starting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

