Table 170002 "Lease"
{
    LookupPageID = "Posted Lease List";

    fields
    {
        field(1;No;Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                  PurchSetup.Get;
                  NoSeriesMgt.TestManual(PurchSetup."Property Numbers");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Property Name";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3;Unit;Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where ("Customer Type2"=filter(Unit),
                                                  Property22=field(Property));

            trigger OnValidate()
            begin
                Units.Reset;
                Units.SetRange(Units."No.",Unit);
                if Units.FindFirst then begin
                "Unit Name":=Units.Name;
                "Account Number":=Units."Account No2.";
                end;
            end;
        }
        field(4;"Account Number";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5;"Starts From";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Next Automated Invoice";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Renew Lease Every";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Duration Types"."Duration Code";

            trigger OnValidate()
            begin
                if LeaseDurations.Get("Renew Lease Every") then begin
                "Lease End Date":=CalcDate(LeaseDurations.Duration,"Starts From");
                end;
            end;
        }
        field(8;"Managed By";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Organisation,Owner';
            OptionMembers = ,Organisation,Owner;
        }
        field(9;"Lease Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Rental,Sale';
            OptionMembers = ,Rental,Sale;
        }
        field(10;"Water Consumption(Units)";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Tenant Monthly Rent";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Tenant Rent Deposit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"No. Series";Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14;Tenant;Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Tenants."No.";

            trigger OnValidate()
            begin
                Tenants.Reset;
                Tenants.SetRange(Tenants."No.",Tenant);
                if Tenants.FindFirst then begin
                "Tenant Name":=Tenants."Full Names";
                end;
            end;
        }
        field(15;"Tenant Name";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16;"Unit Name";Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17;Property;Code[20])
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
        field(18;Active;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19;"Lease Duration Type";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Duration Types"."Duration Code";

            trigger OnValidate()
            begin
                if LeaseDurations.Get("Lease Duration Type") then begin
                "Lease End Date":=CalcDate(LeaseDurations.Duration,"Starts From");
                end;
            end;
        }
        field(20;"Lease End Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21;"Lease Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22;"User ID";Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23;Posted;Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24;"Posted Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25;"Posted By";Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26;"Lease Status";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Active,Inactive';
            OptionMembers = ,Active,Inactive;
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
        fieldgroup(DropDown;No,Property,"Property Name",Unit,"Unit Name",Tenant,"Tenant Name","Starts From","Lease End Date")
        {
        }
        fieldgroup(Brick;No,Property,"Property Name",Unit,"Unit Name",Tenant,"Tenant Name","Starts From","Lease End Date")
        {
        }
    }

    trigger OnDelete()
    begin
        Error(errrdeletiontxt);
    end;

    trigger OnInsert()
    begin
        if No = '' then begin
          PurchSetup.Get;
          PurchSetup.TestField("Lease Numbers");
          NoSeriesMgt.InitSeries(PurchSetup."Lease Numbers",xRec."No. Series",0D,No,"No. Series");
        end;
        "User ID":=UserId;
        "Lease Date":=Today;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchSetup: Record "Purchases & Payables Setup";
        Properties: Record "Property Details";
        LeaseDurations: Record "Duration Types";
        Tenants: Record Tenants;
        Units: Record Customer;
        errrdeletiontxt: label 'You are not allowed to delete this  record.';
}

