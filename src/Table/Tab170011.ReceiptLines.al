Table 170011 "Receipt Lines"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Receipt No."; Code[20])
        {
            TableRelation = "Receipts Header";
        }
        field(3; "Account Type"; Option)
        {
            Editable = false;
            InitValue = Customer;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(4; "Account No."; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("Bank Account")) "Bank Account";

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin

                case "Account Type" of
                    "account type"::"G/L Account":
                        begin
                            if GLAccount.Get("Account No.") then
                                "Account Name" := GLAccount.Name;
                        end;
                    "account type"::Customer:
                        begin
                            if Cust.Get("Account No.") then
                                "Account Name" := Cust.Name;
                        end;
                    "account type"::Vendor:
                        begin
                            if Vendor.Get("Account No.") then
                                "Account Name" := Vendor.Name;
                        end;
                end;
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Account No.");
                if Cust.FindFirst then begin
                    Property := Cust.Property22;
                end;
            end;
        }
        field(5; "Account Name"; Text[250])
        {
        }
        field(6; Description; Text[250])
        {
        }
        field(7; "VAT Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(8; "W/Tax Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(9; "VAT Amount"; Decimal)
        {
        }
        field(10; "W/Tax Amount"; Decimal)
        {
        }
        field(11; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                Validate("Applies to Doc. No");
                "Net Amount" := Amount;
            end;
        }
        field(12; "Net Amount"; Decimal)
        {
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(15; "Applies to Doc. No"; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            var
                GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
                PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
            begin
                /*"Applies to Doc. No":='';
                  Amt:=0;
                  NetAmount:=0;
                  //VATAmount:=0;
                 //"W/TAmount":=0;
                
                CASE "Account Type" OF
                "Account Type"::Customer:
                BEGIN
                 CustLedger.RESET;
                 CustLedger.SETCURRENTKEY(CustLedger."Customer No.",Open,"Document No.");
                 CustLedger.SETRANGE(CustLedger."Customer No.","Account No.");
                 CustLedger.SETRANGE(Open,TRUE);
                 CustLedger.CALCFIELDS("Remaining Amount");
                IF PAGE.RUNMODAL(0,CustLedger) = ACTION::LookupOK THEN BEGIN
                
                IF CustLedger."Applies-to ID"<>'' THEN BEGIN
                 CustLedger1.RESET;
                 CustLedger1.SETCURRENTKEY(CustLedger1."Customer No.",Open,"Applies-to ID");
                 CustLedger1.SETRANGE(CustLedger1."Customer No.","Account No.");
                 CustLedger1.SETRANGE(Open,TRUE);
                 CustLedger1.SETRANGE("Applies-to ID",CustLedger."Applies-to ID");
                 IF CustLedger1.FIND('-') THEN BEGIN
                   REPEAT
                     CustLedger1.CALCFIELDS("Remaining Amount");
                     Amt:=Amt+ABS(CustLedger1."Remaining Amount");
                   UNTIL CustLedger1.NEXT=0;
                  END;
                
                IF Amt<>Amt THEN
                 //ERROR('Amount is not equal to the amount applied on the application form');
                 IF Amount=0 THEN
                 Amount:=Amt;
                 VALIDATE(Amount);
                 "Applies to Doc. No":=CustLedger."Document No.";
                END ELSE BEGIN
                IF Amount<>ABS(CustLedger."Remaining Amount") THEN
                CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                 IF Amount=0 THEN
                Amount:=ABS(CustLedger."Remaining Amount");
                VALIDATE(Amount);
                "Applies to Doc. No":=CustLedger."Document No.";
                END;
                END;
                VALIDATE(Amount);
                END;
                
                "Account Type"::Vendor:
                BEGIN
                 VendLedger.RESET;
                 VendLedger.SETCURRENTKEY(VendLedger."Vendor No.",Open,"Document No.");
                 VendLedger.SETRANGE(VendLedger."Vendor No.","Account No.");
                 VendLedger.SETRANGE(Open,TRUE);
                 VendLedger.CALCFIELDS("Remaining Amount");
                IF PAGE.RUNMODAL(0,VendLedger) = ACTION::LookupOK THEN BEGIN
                
                IF VendLedger."Applies-to ID"<>'' THEN BEGIN
                 VendLedger1.RESET;
                 VendLedger1.SETCURRENTKEY(VendLedger1."Vendor No.",Open,"Applies-to ID");
                 VendLedger1.SETRANGE(VendLedger1."Vendor No.","Account No.");
                 VendLedger1.SETRANGE(Open,TRUE);
                 VendLedger1.SETRANGE(VendLedger1."Applies-to ID",VendLedger."Applies-to ID");
                 IF VendLedger1.FIND('-') THEN BEGIN
                   REPEAT
                     VendLedger1.CALCFIELDS(VendLedger1."Remaining Amount");
                
                     NetAmount:=NetAmount+ABS(VendLedger1."Remaining Amount");
                   UNTIL VendLedger1.NEXT=0;
                  END;
                
                IF NetAmount<>NetAmount THEN
                 //ERROR('Amount is not equal to the amount applied on the application form');
                  IF Amount=0 THEN
                 Amount:=NetAmount;
                
                 VALIDATE(Amount);
                 "Applies to Doc. No":=VendLedger."Document No.";
                END ELSE BEGIN
                IF Amount<>ABS(VendLedger."Remaining Amount") THEN
                VendLedger.CALCFIELDS(VendLedger."Remaining Amount");
                 IF Amount=0 THEN
                Amount:=ABS(VendLedger."Remaining Amount");
                VALIDATE(Amount);
                "Applies to Doc. No":=VendLedger."Document No.";
                END;
                END;
                Amount:=ABS(VendLedger."Remaining Amount");
                VALIDATE(Amount);
                END;
                END;
                */
                if (Rec."Account Type" <> Rec."account type"::Customer) and (Rec."Account Type" <> Rec."account type"::Vendor) then
                    Error('You cannot apply to %1', "Account Type");

                with Rec do begin
                    //Amount:=0;
                    //VALIDATE(Amount);
                    BilToCustNo := Rec."Account No.";
                    CustLedgEntry.SetCurrentkey("Customer No.", Open);
                    CustLedgEntry.SetRange("Customer No.", BilToCustNo);
                    CustLedgEntry.SetRange(Open, true);
                    if "Applies-to ID" = '' then
                        "Applies-to ID" := "Receipt No.";

                    //ApplyCustEntries.SetReceipts(Rec,CustLedgEntry,Rec.FIELDNO("Applies-to ID"));
                    ApplyCustEntries.SetRecord(CustLedgEntry);
                    ApplyCustEntries.SetTableview(CustLedgEntry);
                    ApplyCustEntries.LookupMode(true);
                    OK := ApplyCustEntries.RunModal = Action::LookupOK;
                    Clear(ApplyCustEntries);
                    if not OK then
                        exit;
                    CustLedgEntry.Reset;
                    CustLedgEntry.SetCurrentkey("Customer No.", Open);
                    CustLedgEntry.SetRange("Customer No.", BilToCustNo);
                    CustLedgEntry.SetRange(Open, true);
                    CustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                    if CustLedgEntry.Find('-') then begin
                        "Applies-to Doc. Type" := 0;
                        "Applies to Doc. No" := '';
                    end else
                        "Applies-to ID" := '';

                end;
                //Calculate Total Amount
                CustLedgEntry.Reset;
                CustLedgEntry.SetCurrentkey("Customer No.", Open, "Applies-to ID");
                CustLedgEntry.SetRange("Customer No.", BilToCustNo);
                CustLedgEntry.SetRange(Open, true);
                CustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                if CustLedgEntry.Find('-') then begin
                    CustLedgEntry.CalcSums(CustLedgEntry."Amount to Apply");
                    Amount := Abs(CustLedgEntry."Amount to Apply");
                    Validate(Amount);
                    "Applies to Doc. No" := CustLedgEntry."Document No.";
                end;

            end;

            trigger OnValidate()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                VendLedgEntry: Record "Vendor Ledger Entry";
                TempGenJnlLine: Record "Gen. Journal Line" temporary;
            begin

                case "Account Type" of
                    "account type"::Customer:
                        begin
                            CustLedger.Reset;
                            CustLedger.SetRange("Customer No.", "Account No.");
                            CustLedger.SetRange(Open, true);
                            CustLedger.SetRange("Document No.", "Applies to Doc. No");
                            if CustLedger.Find('-') then
                                "Applies-to Doc. Type" := CustLedger."Document Type";
                        end;
                    "account type"::Vendor:
                        begin
                            VendLedger.Reset;
                            VendLedger.SetRange("Vendor No.", "Account No.");
                            VendLedger.SetRange(Open, true);
                            VendLedger.SetRange("Document No.", "Applies to Doc. No");
                            if VendLedger.Find('-') then
                                "Applies-to Doc. Type" := VendLedger."Document Type";

                        end;
                end;
            end;
        }
        field(16; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(17; "Procurement Method"; Option)
        {
            OptionCaption = ' ,Direct,RFQ,RFP,Tender,Low Value,Specially Permitted,EOI';
            OptionMembers = " ",Direct,RFQ,RFP,Tender,"Low Value","Specially Permitted",EOI;
        }
        field(18; "Procurement Request"; Code[30])
        {
            // TableRelation = Table51525303;
        }
        field(19; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,1,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(20; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Receipt';
            OptionMembers = Receipt;
        }
        field(21; "Receipt Transaction Type"; Code[50])
        {

            trigger OnValidate()
            begin
                /*CashManagementSetup.GET;
                FundsTypes.RESET;
                FundsTypes.SETRANGE(FundsTypes.Code,"Receipt Transaction Type");
                IF FundsTypes.FINDFIRST THEN BEGIN
                 //"Default Grouping":=FundsTypes."Default Grouping";
                 "Account Type":=FundsTypes."Account Type";
                 "Account No.":=FundsTypes."G/L Account";
                 "Account Name":=FundsTypes.Description;
                 Description:=FundsTypes.Description;
                END;
                "Financial Year":=CashManagementSetup."Current Budget";
                MESSAGE(CashManagementSetup."Current Budget");
                MODIFY;*/

                /*RHeader.RESET;
                RHeader.SETRANGE(RHeader."No.","Document No");
                 IF RHeader.FINDFIRST THEN BEGIN
                     "Posting Date":=RHeader."Posting Date";
                     "Document Date":=RHeader.Date;
                     "Global Dimension 1 Code":=RHeader."Global Dimension 1 Code";
                     "Global Dimension 2 Code":=RHeader."Global Dimension 2 Code";
                     "Shortcut Dimension 3 Code":=RHeader."Shortcut Dimension 3 Code";
                     "Shortcut Dimension 4 Code":=RHeader."Shortcut Dimension 4 Code";
                     "Shortcut Dimension 5 Code":=RHeader."Shortcut Dimension 5 Code";
                     "Shortcut Dimension 6 Code":=RHeader."Shortcut Dimension 6 Code";
                     "Shortcut Dimension 7 Code":=RHeader."Shortcut Dimension 7 Code";
                     "Shortcut Dimension 8 Code":=RHeader."Shortcut Dimension 8 Code";
                     "Pay Mode":=RHeader."Pay Mode";
                     "Cheque No":=RHeader."Cheque No";
                     "Responsibility Center":=RHeader."Responsibility Center";
                     "Document Type":="Document Type"::Receipt;
                     "Bank Code":=RHeader."Bank Code";
                     VALIDATE("Bank Code");
                     "Currency Code":=RHeader."Currency Code";
                     VALIDATE("Currency Code");
                     "Currency Factor":=RHeader."Currency Factor";
                     VALIDATE("Currency Factor");
                 END;
                 VALIDATE("Account Type");
                 */

            end;
        }
        field(22; "Customer Transaction type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Financial Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Applies-to ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; Ammenity; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit Transaction Types"."Transaction Code";

            trigger OnValidate()
            var
                Trans: Record "Unit Transaction Types";
            begin
                Trans.Reset;
                Trans.SetRange(Trans."Transaction Code", Ammenity);
                if Trans.FindFirst then begin
                    Description := Trans."Transaction Description";
                end;
            end;
        }
        field(26; Property; Code[31])
        {
            TableRelation = "Property Details".No;
        }
    }

    keys
    {
        key(Key1; "Line No", "Receipt No.")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        GLAccount: Record "G/L Account";
        Cust: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        BankAccount: Record "Bank Account";
        CustLedger: Record "Cust. Ledger Entry";
        CustLedger1: Record "Cust. Ledger Entry";
        VendLedger: Record "Vendor Ledger Entry";
        VendLedger1: Record "Vendor Ledger Entry";
        Amt: Decimal;
        NetAmount: Decimal;
        CashManagementSetup: Record "Cash Management Setup";
        ApplyCustEntries: Page "Apply Customer Entries";
        CustLedgEntry: Record "Cust. Ledger Entry";
        BilToCustNo: Code[20];
        OK: Boolean;
        Trans: Record "Unit Transaction Types";
}

