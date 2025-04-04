//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 170040 "Funds Transfer Line"
{

    fields
    {
        field(10; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(11; "Document No"; Code[20])
        {
        }
        field(12; "Document Type"; Code[20])
        {
        }
        field(13; Date; Date)
        {
        }
        field(14; "Posting Date"; Date)
        {
        }
        field(15; "Pay Mode"; Option)
        {
            OptionCaption = ' ,Cash,Cheque,Transfer';
            OptionMembers = " ",Cash,Cheque,Transfer;
        }
        field(16; "Receiving Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin

                BankAcc.Reset;
                BankAcc.SetRange(BankAcc."No.", "Receiving Bank Account");
                if BankAcc.FindFirst then begin
                    "Bank Name" := BankAcc.Name;
                    "Currency Code" := BankAcc."Currency Code";
                end;
                Validate("Currency Code");
            end;
        }
        field(17; "Bank Name"; Text[50])
        {
            Editable = false;
        }
        field(18; "Bank Balance"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Receiving Bank Account")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Bank Balance(LCY)"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)" where("Bank Account No." = field("Receiving Bank Account")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Bank Account No."; Code[20])
        {
        }
        field(21; "Currency Code"; Code[20])
        {
            trigger
              OnValidate()
            begin
                //  "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
            end;
        }
        field(22; "Currency Factor"; Decimal)
        {
            trigger OnValidate()
            begin
                "Amount to Receive (LCY)" := "Amount to Receive" / "Currency Factor";
            end;
        }
        field(23; "Amount to Receive"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Amount to Receive (LCY)" := "Amount to Receive"
                else
                    //     "Amount to Receive (LCY)" := Round(
                    // CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Amount to Receive", "Currency Factor"));
                    "Amount to Receive (LCY)" := Round("Amount to Receive" * "Currency Factor");
                Validate("Amount to Receive (LCY)");

                if "Amount to Receive" < 0 then
                    Error('You cannot request Negative Amount');

            end;
        }
        field(24; "Amount to Receive (LCY)"; Decimal)
        {
            Editable = false;
            trigger OnValidate()
            begin
                FTransferHeader.Reset();
                FTransferHeader.SetRange("No.", "Document No");
                if FTransferHeader.FindFirst() then begin

                    FTransferHeader.CalcFields("Total Line Amount");
                    FTransferHeader.CalcFields("Total Line Amount(LCY)");
                    FTransferHeader.Modify(true);

                end;
            end;

        }
        field(25; "External Doc No."; Code[20])
        {
        }
        field(37; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(38; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(39; "Shortcut Dimension 3 Code"; Code[20])
        {
        }
        field(40; "Shortcut Dimension 4 Code"; Code[20])
        {
        }
        field(41; "Shortcut Dimension 5 Code"; Code[20])
        {
        }
        field(42; "Shortcut Dimension 6 Code"; Code[20])
        {
        }
        field(43; "Shortcut Dimension 7 Code"; Code[20])
        {
        }
        field(44; "Shortcut Dimension 8 Code"; Code[20])
        {
        }
        field(45; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Cancelled,Posted';
            OptionMembers = New,"Pending Approval",Approved,Cancelled,Posted;
        }
        field(46; Posted; Boolean)
        {
        }
        field(47; "Posted By"; Code[20])
        {
        }
        field(48; "Date Posted"; Date)
        {
        }
        field(49; "Time Posted"; Time)
        {
        }
        field(50; Reversed; Boolean)
        {
        }
        field(51; "Reversed By"; Code[30])
        {
        }
        field(52; "Reversal Date"; Date)
        {
        }
        field(53; "Reversal Time"; Time)
        {
        }
        field(54; "Exchange Rate"; Decimal)
        {
        }

    }

    keys
    {
        key(Key1; "Line No", "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        BankAcc: Record "Bank Account";
        FTransferHeader: Record "Funds Transfer Header";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
}




