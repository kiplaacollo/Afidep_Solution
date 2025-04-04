Table 170010 "Receipts Header"
{
    // DrillDownPageID = UnknownPage51525072;
    // LookupPageID = UnknownPage51525072;

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                GLSetup.Get;
                if "No." <> xRec."No." then begin
                    NoSeriesMgt.TestManual(GLSetup."Receipt Nos");
                end;
            end;
        }
        field(2; Date; Date)
        {
        }
        field(3; "Pay Mode"; Option)
        {
            OptionCaption = ',MPESA,CASH';
            OptionMembers = ,MPESA,CASH;
        }
        field(4; "Cheque No"; Code[20])
        {
        }
        field(5; "Cheque Date"; Date)
        {
        }
        field(6; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Lines".Amount where("Receipt No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Amount(LCY)"; Decimal)
        {
        }
        field(8; "Bank Code"; Code[50])
        {
            TableRelation = "Bank Account";
        }
        field(9; "Received From"; Text[250])
        {
        }
        field(10; "On Behalf Of"; Text[250])
        {
            NotBlank = true;
        }
        field(11; Cashier; Code[50])
        {
            Editable = false;
        }
        field(12; Posted; Boolean)
        {
            Editable = false;
        }
        field(13; "Posted Date"; Date)
        {
            Editable = false;
        }
        field(14; "Posted Time"; Time)
        {
            Editable = false;
        }
        field(15; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(16; "No. Series"; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(17; "Currency Code"; Code[50])
        {
            TableRelation = Currency.Code;
        }
        field(18; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(19; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(20; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Pending Prepayment,Released,Closed,Rejected';
            OptionMembers = Open,"Pending Approval","Pending Prepayment",Released,Closed,Rejected;
        }
        field(21; Amount; Decimal)
        {
        }
        field(22; Banked; Boolean)
        {
        }
        field(23; "Procurement Method"; Option)
        {
            OptionCaption = ' ,Direct,RFQ,RFP,Tender,Low Value,Specially Permitted,EOI';
            OptionMembers = " ",Direct,RFQ,RFP,Tender,"Low Value","Specially Permitted",EOI;
        }
        field(24; "Procurement Request"; Code[30])
        {

            trigger OnValidate()
            begin
                //IF (Procurement Method=CONST(Direct)) "Procurement Request1" WHERE (Process Type=CONST(Direct)) ELSE IF (Procurement Method=CONST(RFP)) "Procurement Request1" WHERE (Process Type=CONST(RFP)) ELSE IF (Procurement Method=CONST(RFQ)) "Procurement Re
            end;
        }
        field(25; "Global Dimension 3 Code"; Code[50])
        {
            CaptionClass = '1,1,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(26; "Record From SMS"; Boolean)
        {
        }
        field(27; "Customer Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Service Provider,Schemes,Staff,Vendors';
            OptionMembers = ,"Service Provider",Schemes,Staff,Vendors;
        }
        field(28; "Received From No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Customer.Get("Received From No") then begin
                    "Received From" := Customer.Name;
                end;
            end;
        }
        field(29; Designation; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Officer,Asst Manager,Manager,Director,CEO';
            OptionMembers = " ",Officer,"Asst Manager",Manager,Director,CEO;
        }
        field(30; "Surrender Attached"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Payment Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Billing and Payments Periods"."Starting Date";
        }
    }

    keys
    {
        key(Key1; "No.")
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
            // CashMmtSetup.Get;
            // CashMmtSetup.TestField(CashMmtSetup."Receipt Nos");
            // NoSeriesMgt.InitSeries(CashMmtSetup."Receipt Nos", xRec."No. Series", 0D, "No.", "No. Series");
            PayablesSetup.Get;
            PayablesSetup.TestField(PayablesSetup."Receipt Vouchers Form");
            NoSeriesMgt.InitSeries(PayablesSetup."Receipt Vouchers Form", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        GLSetup.Get;
        Cashier := UserId;
        /*IF USet.GET(Cashier) THEN BEGIN
          Emp.RESET;
          Emp.SETRANGE(Emp."User ID",Cashier);
          IF Emp.FIND('-') THEN BEGIN
            "Global Dimension 1 Code":=Emp."Global Dimension 1 Code";
            "Global Dimension 2 Code":=Emp."Global Dimension 2 Code";
            Designation:=USet.Designation;
          END;
        END;*/

    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GLSetup: Record "Sales & Receivables Setup";
        CashMmtSetup: Record "Sales & Receivables Setup";
        PayablesSetup: Record "Purchases & Payables Setup";
        ReceiptLines: Record "Receipt Lines";
        Customer: Record Customer;
        Emp: Record Employee;
        USet: Record "User Setup";

    procedure ReqLinesExist(): Boolean
    begin
        ReceiptLines.Reset;
        ReceiptLines.SetRange("Receipt No.", "No.");
        exit(ReceiptLines.FindFirst);
    end;
}

