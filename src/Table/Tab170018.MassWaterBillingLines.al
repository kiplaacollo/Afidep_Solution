Table 170018 "Mass Water Billing Lines"
{

    fields
    {
        field(1;No;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;Unit;Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                Units: Record Customer;
            begin
                Units.Reset;
                Units.SetRange(Units."No.",Unit);
                if Units.FindFirst then
                begin
                "Unit Name":=Units.Name;
                Property:=Units.Property22;
                "Property Name":=Units."Property Name22";
                Tenant33:=Units.Tenant22;
                "Tenant Name":=Units."Tenant Full Name 33";
                end;

                Validate(Property);
            end;
        }
        field(3;"Unit Name";Text[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4;Tenant33;Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5;"Tenant Name";Text[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6;"Previous Meter Reading";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Current Meter Reading";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Previous Meter Reading");
                "Units Consumed":="Current Meter Reading"-"Previous Meter Reading";
                "Amount Charged":="Units Consumed"*Rate;
            end;
        }
        field(8;"Units Consumed";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9;Rate;Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10;"Amount Charged";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11;Property;Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12;"Property Name";Text[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13;"Document No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Billing Period";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Account No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;No,"Document No","Billing Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if MassLines.FindLast then
        No:=MassLines.No+1
        else
        No:=1;
    end;

    var
        Units: Record Customer;
        MassLines: Record "Mass Water Billing Lines";
}

