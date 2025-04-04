Table 170013 "Water Billing"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                GLSetup.Get;
                if "No."<>xRec."No." then begin
                  NoSeriesMgt.TestManual(GLSetup."Water Billing Nos");
                  end;
            end;
        }
        field(2;"Billing Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3;Unit;Code[20])
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
                Tenant:=Units.Tenant22;
                "Tenant Name":=Units."Tenant Full Name 33";
                end;

                Validate(Property);
            end;
        }
        field(4;"Unit Name";Text[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5;Property;Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Property Details".No;

            trigger OnValidate()
            var
                Properties: Record "Property Details";
            begin
                Properties.Reset;
                Properties.SetRange(Properties.No,Property);
                if Properties.FindFirst then begin
                "Property Name":=Properties."Property Name";
                end;





                PropLines.Reset;
                PropLines.SetRange(PropLines."Property Code",Property);
                PropLines.SetRange(PropLines.Ammenity,'WATER');
                if PropLines.FindFirst then begin
                Rate:=PropLines.Rate;
                end;
            end;
        }
        field(6;"Property Name";Text[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7;Tenant;Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8;"Tenant Name";Text[120])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9;"Previous Meter Reading";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Current Meter Reading";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Previous Meter Reading");
                "Units Consumed":="Current Meter Reading"-"Previous Meter Reading";
                "Amount Charged":="Units Consumed"*Rate;
            end;
        }
        field(11;"Units Consumed";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12;Rate;Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13;"Amount Charged";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14;Posted;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15;"No. Series";Code[50])
        {
            TableRelation = "No. Series";
        }
        field(16;"Billing Period";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17;Landlord;Code[40])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
          CashMmtSetup.Get;
          CashMmtSetup.TestField(CashMmtSetup."Water Billing Nos");
          NoSeriesMgt.InitSeries(CashMmtSetup."Water Billing Nos",xRec."No. Series",0D,"No.","No. Series");
        end;

        BillingPeriod.Reset;
        BillingPeriod.SetRange(BillingPeriod.Closed,false);
        if BillingPeriod.FindFirst then begin
        "Billing Period":=BillingPeriod."Starting Date";
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GLSetup: Record "Sales & Receivables Setup";
        CashMmtSetup: Record "Sales & Receivables Setup";
        PropLines: Record "Property Billing Lines";
        BillingPeriod: Record "Billing and Payments Periods";
}

