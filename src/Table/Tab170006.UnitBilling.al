Table 170006 "Unit Billing"
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
        field(4;"Bank Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."No.","Bank Code");
                if BankAccount.FindFirst then begin
                "Bank Name":=BankAccount.Name;
                end;
            end;
        }
        field(5;"Bank Name";Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
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
        field(18;"Amount Received";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19;"Amount Received(LCY)";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20;"Total Amount";Decimal)
        {
            CalcFormula = sum("Unit Receipting Line".Amount where ("Document No"=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21;"Total Amount(LCY)";Decimal)
        {
            CalcFormula = sum("Unit Receipting Line"."Amount(LCY)" where ("Document No"=field("No.")));
            Editable = false;
            FieldClass = FlowField;
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
        field(36;"Unit No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Units.Reset;
                Units.SetRange(Units."No.","Unit No.");
                if Units.FindFirst then begin
                "Unit Name":=Units.Name;
                end;
            end;
        }
        field(38;Property;Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Property Details".No;

            trigger OnValidate()
            begin
                 if "No."<>'' then begin
                PropertyDetails.Reset;
                PropertyDetails.SetRange(PropertyDetails.No,Property);
                if PropertyDetails.FindFirst then begin
                "Property Name":=PropertyDetails."Property Name";
                end;
                end;
            end;
        }
        field(39;"Property Name";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(40;"Unit Name";Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(41;Tenant;Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(42;"Tenant Name";Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(43;"Lease Number";Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = Lease.No where (Posted=filter(true));

            trigger OnValidate()
            var
                Units: Record Customer;
                BillingLines: Record "Property Billing Lines";
                EntryNo: Integer;
                PaymentEntries: Record "Unit Receipting Line";
            begin
                Leases.Reset;
                Leases.SetRange(Leases.No,"Lease Number");
                if Leases.FindFirst then begin
                Tenant:=Leases.Tenant;
                "Tenant Name":=Leases."Tenant Name";
                Property:=Leases.Property;
                "Property Name":=Leases."Property Name";
                "Unit No.":=Leases.Unit;
                "Unit Name":=Leases."Unit Name";
                end;

                Units.Reset;
                Units.SetRange(Units."No.","Unit No.");
                if Units.FindFirst then
                begin
                Units.CalcFields(Balance);
                Balance:=Units.Balance;
                end;

                if PaymentEntries.FindLast then
                EntryNo:=PaymentEntries."Line No"
                else
                EntryNo:=1;

                PaymentEntries.Reset;
                PaymentEntries.SetRange(PaymentEntries."Document No","No.");
                PaymentEntries.Delete;
                BillingLines.Reset;
                BillingLines.SetRange(BillingLines."Property Code",Property);
                if BillingLines.FindFirst then
                begin
                repeat
                EntryNo:=EntryNo+1;
                PaymentEntries.Init;
                PaymentEntries."Line No":=EntryNo;
                PaymentEntries."Account Code":="Unit No.";
                PaymentEntries."Account Name":="Unit Name";
                PaymentEntries."Transaction Type":=BillingLines.Ammenity;
                PaymentEntries."Document No":="No.";
                PaymentEntries.Amount:=BillingLines.Rate;
                PaymentEntries.Insert(true);
                until BillingLines.Next=0;
                end;
            end;
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
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BankAccount: Record "Bank Account";
        Units: Record Customer;
        PropertyDetails: Record "Property Details";
        PurchSetup: Record "Purchases & Payables Setup";
        Leases: Record Lease;
        errrdeletiontxt: label 'You are not allowed to delete this  record.';
}

