Table 170016 "Mass Unit Billing"
{

    fields
    {
        field(1;"No.";Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                PurchSetup.Get;
                NoSeriesMgt.TestManual(PurchSetup."Unit Receipt Numbers");
                "No. Series" := '';
                end;
            end;
        }
        field(2;"Transaction Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3;"Posting Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6;Balance;Decimal)
        {
            Editable = false;
        }
        field(7;"Currency Code";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                  Validate("Responsibility Center");
            end;
        }
        field(8;"Currency Factor";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1),
                                                          "Dimension Value Type"=const(Standard));
        }
        field(10;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2),
                                                          "Dimension Value Type"=const(Standard));
        }
        field(11;"Shortcut Dimension 3 Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Shortcut Dimension 4 Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Shortcut Dimension 5 Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Shortcut Dimension 6 Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Shortcut Dimension 7 Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16;"Shortcut Dimension 8 Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17;"Responsibility Center";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
        }
        field(22;"User ID";Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23;Status;Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Canceled,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Canceled,Rejected;
        }
        field(24;Description;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25;"Received From";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(26;"On Behalf of";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27;"No. Series";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(28;Posted;Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29;"Date Posted";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30;"Time Posted";Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31;"Posted By";Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32;"Cheque No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(33;"Date Created";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34;"Time Created";Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35;"Receipt Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Bank,Cash';
            OptionMembers = Bank,Cash;
        }
        field(38;Property;Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Property Details".No;

            trigger OnValidate()
            var
                Customers: Record Customer;
                MassBillingLines: Record "Mass Billing Lines";
                LineNo: Integer;
                UnitLines: Record "Unit Billing Lines";
            begin
                PropertyDetails.Reset;
                PropertyDetails.SetRange(PropertyDetails.No,Property);
                if PropertyDetails.FindFirst then begin
                "Property Name":=PropertyDetails."Property Name";


                if MassBillingLines.FindLast then
                LineNo:=MassBillingLines.EntryNo+1
                else
                LineNo:=1;

                Customers.Reset;
                Customers.SetRange(Customers.Property22,PropertyDetails.No);
                Customers.SetRange(Customers."Unit Status3",Customers."unit status3"::Occupied);
                if Customers.Find('-') then begin
                repeat
                UnitLines.Reset;
                UnitLines.SetRange(UnitLines."Unit Code",Customers."No.");
                if UnitLines.FindFirst then begin
                repeat
                LineNo:=LineNo+1;
                //MESSAGE('No%1',LineNo);
                MassBillingLines.Init;
                MassBillingLines.EntryNo:=LineNo;
                MassBillingLines."Unit Code":=UnitLines."Unit Code";
                MassBillingLines.Description:=UnitLines.Description;
                MassBillingLines.Ammenity:=UnitLines.Ammenity;
                MassBillingLines.Rate:=UnitLines.Rate;
                MassBillingLines."Document No":="No.";
                MassBillingLines.Insert;
                until UnitLines.Next=0;
                end;
                until Customers.Next=0;
                end;
                end;
            end;
        }
        field(39;"Property Name";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(40;"Billing Period";Date)
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
        fieldgroup(DropDown;"No.","Transaction Date","Posting Date",Property,"Property Name")
        {
        }
    }

    trigger OnDelete()
    begin
        Error(errrdeletiontxt);
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
        PurchSetup.Get;
        PurchSetup.TestField("Unit Receipt Numbers");
        NoSeriesMgt.InitSeries(PurchSetup."Unit Receipt Numbers",xRec."No. Series",0D,"No.","No. Series");
        end;
        "User ID":=UserId;
        "Transaction Date":=Today;
        "Date Created":=Today;
        "Time Created":=Time;

        Periods.Reset;
        Periods.SetRange(Periods.Closed,false);
        if Periods.FindFirst then begin
        "Billing Period":=Periods."Starting Date";
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BankAccount: Record "Bank Account";
        Units: Record Customer;
        PropertyDetails: Record "Property Details";
        PurchSetup: Record "Purchases & Payables Setup";
        Leases: Record Lease;
        errrdeletiontxt: label 'You are not allowed to delete this  record.';
        Periods: Record "Billing and Payments Periods";
}

