Table 170021 "Units Mass Update"
{

    fields
    {
        field(1;No;Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2;Property;Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Property Details".No;

            trigger OnValidate()
            begin
                Properties.Reset;
                Properties.SetRange(Properties.No,Property);
                if Properties.FindFirst then begin
                "Property Name":=Properties."Property Name";
                end;
            end;
        }
        field(3;"Property Name";Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4;Date;Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5;Updated;Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6;"Updated Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7;"Updated By";Code[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8;"No. Series";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9;Ammenity;Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit Transaction Types"."Transaction Code";

            trigger OnValidate()
            begin
                TestField(Property);
                Amenities.Reset;
                Amenities.SetRange(Amenities."Property Code",Property);
                Amenities.SetRange(Amenities.Ammenity,Ammenity);
                if Amenities.FindFirst then begin
                Amount:=Amenities.Rate;
                end;
            end;
        }
        field(10;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
        PurchSetup.Get;
        PurchSetup.TestField("Unit Update Numbers");
        NoSeriesMgt.InitSeries(PurchSetup."Unit Update Numbers",xRec."No. Series",0D,No,"No. Series");
        end;
        Date:=Today;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        Properties: Record "Property Details";
        Tenants: Record Tenants;
        Amenities: Record "Property Billing Lines";
}

