Table 170001 "Property Details"
{
    DrillDownPageID = "Property List";
    LookupPageID = "Property List";

    fields
    {
        field(1;No;Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF No <> xRec.No THEN BEGIN
                  PurchSetup.GET;
                  NoSeriesMgt.TestManual(PurchSetup."Property Numbers");
                  "No. Series" := '';
                END;*/

            end;
        }
        field(2;"Property Name";Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Property Location";Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Property Locations".Location;
        }
        field(4;"Property Type";Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Property Type".Code;
        }
        field(5;"Property Owner";Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." where ("Vendor Type2"=filter(Landlord));

            trigger OnValidate()
            begin
                Vendors.Reset;
                Vendors.SetRange(Vendors."No.","Property Owner");
                if Vendors.FindFirst then
                begin
                "Property Owner Name":=Vendors.Name;
                "Landlord Contact":=Vendors."Phone No.";
                end;
            end;
        }
        field(6;"Landlord Contact";Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7;"Property Description";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Number Of Units";Integer)
        {
            CalcFormula = count(Customer where (Property22=field(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9;Ammenities;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Service Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Premium,Standard';
            OptionMembers = ,Premium,Standard;
        }
        field(11;"No. Series";Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12;"Property Owner Name";Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13;"Property LR Number";Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Property Administrator";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Payment Deadline Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16;"Commission Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Fixed Commission,Percentage';
            OptionMembers = ,"Fixed Commission",Percentage;
        }
        field(17;Commission;Decimal)
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
        fieldgroup(DropDown;No,"Property Name","Property Owner Name")
        {
        }
    }

    trigger OnInsert()
    begin
        if No = '' then begin
          PurchSetup.Get;
          PurchSetup.TestField("Property Numbers");
          NoSeriesMgt.InitSeries(PurchSetup."Property Numbers",xRec."No. Series",0D,No,"No. Series");
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchSetup: Record "Purchases & Payables Setup";
        Vendors: Record Vendor;
}

