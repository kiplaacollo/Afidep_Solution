Table 170007 "Unit Receipting Line"
{

    fields
    {
        field(1;"Line No";Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2;"Document No";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3;"Document Type";Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt;
        }
        field(4;"Transaction Type";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit Transaction Types"."Transaction Code";

            trigger OnValidate()
            begin
                 FundsTypes.Reset;
                 FundsTypes.SetRange(FundsTypes."Transaction Code","Transaction Type");
                 if FundsTypes.FindFirst then begin
                  "Default Grouping":=FundsTypes."Default Grouping";
                  "Account Type":=FundsTypes."Account Type";
                  "Account Code":=FundsTypes."Account No";
                  Description:=FundsTypes."Transaction Description";
                 end;
                Validate("Account Type");
            end;
        }
        field(5;"Default Grouping";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6;"Account Type";Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            InitValue = Customer;
            OptionCaption = 'G/L Account,Unit,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(7;"Account Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type"=const("G/L Account")) "G/L Account" where ("Account Type"=const(Posting),
                                                                                          Blocked=const(false))
                                                                                          else if ("Account Type"=const(Customer)) Customer where ("Customer Type2"=filter(Unit))
                                                                                          else if ("Account Type"=const(Vendor)) Vendor
                                                                                          else if ("Account Type"=const("Bank Account")) "Bank Account"
                                                                                          else if ("Account Type"=const("Fixed Asset")) "Fixed Asset"
                                                                                          else if ("Account Type"=const("IC Partner")) "IC Partner"
                                                                                          else if ("Account Type"=const(Employee)) Employee;

            trigger OnValidate()
            begin
                Units.Reset;
                Units.SetRange(Units."No.","Account Code");
                if Units.FindFirst then begin
                "Account Name":=Units.Name;
                 "Unit Name":=Units.Name;
                end;
                "Unit No.":="Account Code";
            end;
        }
        field(8;"Account Name";Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9;Description;Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1),
                                                          "Dimension Value Type"=const(Standard));
        }
        field(11;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2),
                                                          "Dimension Value Type"=const(Standard));
        }
        field(12;"Shortcut Dimension 3 Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13;"Shortcut Dimension 4 Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14;"Shortcut Dimension 5 Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15;"Shortcut Dimension 6 Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16;"Shortcut Dimension 7 Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17;"Shortcut Dimension 8 Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18;"Responsibility Center";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19;"Pay Mode";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Cash,Cheque,Deposit Slip,EFT,Bankers Cheque,RTGS';
            OptionMembers = " ",Cash,Cheque,"Deposit Slip",EFT,"Bankers Cheque",RTGS;
        }
        field(20;"Currency Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21;"Currency Factor";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23;"Amount(LCY)";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24;"Cheque No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25;"Applies-To Doc No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26;"Applies-To ID";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27;"VAT Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(28;"VAT Percentage";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29;"VAT Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30;"VAT Amount(LCY)";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31;"W/TAX Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32;"W/TAX Percentage";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33;"W/TAX Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34;"W/TAX Amount(LCY)";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35;"Net Amount";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36;"Net Amount(LCY)";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(37;"Gen. Bus. Posting Group";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(38;"Gen. Prod. Posting Group";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39;"VAT Bus. Posting Group";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40;"VAT Prod. Posting Group";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(41;"User ID";Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(42;Status;Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = New,"Pending Approval",Approved,Rejected,Posted;
        }
        field(43;Posted;Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(44;"Date Posted";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(45;"Time Posted";Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(46;"Posted By";Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(47;"Date Created";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(48;"Time Created";Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(49;"Legal Fee Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50;"No. Series";Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(51;"Unit No.";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Units.Reset;
                Units.SetRange(Units."No.","Unit No.");
                if Units.FindFirst then begin
                "Unit Name":=Units."Unit ID4";
                end;
            end;
        }
        field(52;"Unit Name";Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(53;Tenant;Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                Tenants.Reset;
                Tenants.SetRange(Tenants."No.",Tenant);
                if Tenants.FindFirst then begin
                "Tenant Name":=Tenants."Full Names";
                end;
            end;
        }
        field(54;"Tenant Name";Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(55;Property;Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Property Details".No;
        }
        field(56;"Property Name";Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Line No","Document No",Tenant)
        {
            Clustered = true;
        }
      
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if TctLines.FindLast then
        "Line No":=TctLines."Line No"+1
        else
        "Line No":=1;
    end;

    var
        FundsTypes: Record "Unit Transaction Types";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchSetup: Record "Purchases & Payables Setup";
        Units: Record Customer;
        PropertyDetails: Record "Property Details";
        Tenants: Record Tenants;
        TctLines: Record "Unit Receipting Line";
}

