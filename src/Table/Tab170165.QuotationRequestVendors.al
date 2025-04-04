Table 170165 "Quotation Request Vendors"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
        }
        field(2; "Requisition Document No."; Code[20])
        {
        }
        field(3; "Vendor No."; Code[20])
        {
            TableRelation = Vendor where("Vendor Posting Group" = filter(<> 'DRIVERS'));

            trigger OnValidate()
            begin
                Vendor.Get("Vendor No.");
                "Vendor Name" := Vendor.Name;
                Email := Vendor."E-Mail";
            end;
        }
        field(4; "Vendor Name"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
            FieldClass = FlowField;
        }
        field(5; "Total Quoted Cost"; Decimal)
        {
        }
        field(6; Selected; Boolean)
        {
            trigger OnValidate()
            var
                RFQ: Record "Purchase Quote Header";
            begin
                RFQ.Reset;
                rfq.SetRange("No.", "Requisition Document No.");
                if RFQ.Find('-') then begin
                    RFQ.Amount := "Total Quoted Cost";
                    RFQ.Modify(true);
                    Commit();
                end;

            end;
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            var
                BankAcc: Record "Bank Account";
            begin


                "Currency Factor" :=
                  CurrExchRate.ExchangeRate(Today, "Currency Code");
            end;
        }
        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 2 : 9;

            trigger OnValidate()
            var
            //   RFQ: Record "Purchase Quote Header";
            begin
                //Navigator

                if "Currency Code" = '' then
                    "Total Quoted Cost" := Amount
                else
                    "Total Quoted Cost" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          Today, "Currency Code",
                          Amount, "Currency Factor"));
            end;
        }
        field(14; Quantity; Integer)
        {
        }
        field(15; "Unit Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                Amount := "Unit Cost" * Quantity;
                Validate(Amount);
            end;
        }
        field(16; "Currency Factor"; Decimal)
        {
        }
        field(17; Email; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Requisition Document No.", "Vendor No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CurrExchRate: Record "Currency Exchange Rate";
        Vendor: Record Vendor;
}

