Table 170504 "Procurement Plan"
{

    fields
    {
        field(1;"Project Code";Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where ("Dimension Code"=const('PROJECT'));
        }
        field(2;"Activity Title";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Beneficiary Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Budget Line";Code[100])
        {
            // DataClassification = ToBeClassified;
            // TableRelation = "Dimension Value".Code where ("Dimension Code"=const('BUDGET LINES'),
            //                                               "Project Code"=field("Project Code"));

            trigger OnValidate()
            begin
                DimensionValue.Reset;
                DimensionValue.SetRange(Code,"Budget Line");
                if DimensionValue.FindFirst then
                  "Activity Title":=DimensionValue.Name;
            end;
        }
        field(5;"No of Units";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Unit Cost";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Budget":="No of Units"*"Unit Cost";
            end;
        }
        field(7;"Total Budget";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Donor Name";Code[1000])
        {
            DataClassification = ToBeClassified;
            TableRelation = Donors;
        }
        field(9;Sector;Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Expected Start Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Expected End Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12;Location;Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Locations;
        }
        field(13;"Type of Procurement";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Direct Procurement,Request for Quotation,Open Tender,Single sourcing,Selective Tendering';
            OptionMembers = ,"Direct Procurement","Request for Quotation","Open Tender","Single Sourcing","Selective Tendering";
        }
        field(14;Scenario;Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,A,B,C,D,E;
        }
        field(15;"Project Focal Person";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16;Unit;Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Project Code","Activity Title")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DimensionValue: Record "Dimension Value";
}

