Page 80013 "Payroll Deductions Card_AU"
{
    PageType = Card;
    SourceTable = "Payroll Transaction Code_AU";
    SourceTableView = where("Transaction Type"=const(Deduction));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction Code";Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Name";Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Type";Rec."Balance Type")
                {
                    ApplicationArea = Basic;
                }
                field(Frequency;Rec.Frequency)
                {
                    ApplicationArea = Basic;
                }
                field(Taxable;Rec.Taxable)
                {
                    ApplicationArea = Basic;
                }
                field("Is Cash";Rec."Is Cash")
                {
                    ApplicationArea = Basic;
                }
                field("Is Formulae";Rec."Is Formulae")
                {
                    ApplicationArea = Basic;
                }
                field(Formulae;Rec.Formulae)
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account";Rec."G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account Name";Rec."G/L Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(SubLedger;Rec.SubLedger)
                {
                    ApplicationArea = Basic;
                }
                field("Customer Posting Group";Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Percent of Basic";Rec."Percent of Basic")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Loan Details")
            {
                field("Deduct Premium";Rec."Deduct Premium")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate";Rec."Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Method";Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field("IsCo-Op/LnRep";Rec."IsCo-Op/LnRep")
                {
                    ApplicationArea = Basic;
                }
                field("Deduct Mortgage";Rec."Deduct Mortgage")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Other Setup")
            {
                field("Special Transaction";Rec."Special Transaction")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Preference";Rec."Amount Preference")
                {
                    ApplicationArea = Basic;
                }
                field("Fringe Benefit";Rec."Fringe Benefit")
                {
                    ApplicationArea = Basic;
                }
                field(IsHouseAllowance;Rec.IsHouseAllowance)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Deduction";Rec."Employer Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Include Employer Deduction";Rec."Include Employer Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Formulae for Employer";Rec."Formulae for Employer")
                {
                    ApplicationArea = Basic;
                }
                field("Co-Op Parameters";Rec."Co-Op Parameters")
                {
                    ApplicationArea = Basic;
                }
                field(Welfare;Rec.Welfare)
                {
                    ApplicationArea = Basic;
                }
                field("Is Pension";Rec."Is Pension")
                {
                    ApplicationArea = Basic;
                }
                field("Is Insurance";Rec."Is Insurance")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bank Details")
            {
                field("Payable Bank Ac";Rec."Payable Bank Ac")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name";Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code";Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Name";Rec."Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account Number";Rec."Account Number")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
           Rec."Transaction Type":=Rec."transaction type"::Deduction;
    end;
}

