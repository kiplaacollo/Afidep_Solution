Page 80001 "Payroll General Setup_AU"
{
    PageType = Card;
    SourceTable = "Payroll General Setup_AU";

    layout
    {
        area(content)
        {
            group(Relief)
            {
                field("Tax Relief"; Rec."Tax Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Relief"; Rec."Insurance Relief")
                {
                    ApplicationArea = Basic;
                }
                field("NHIF %"; Rec."NHIF %")
                {

                }
                field("Zakayo Leavy"; Rec."Zakayo Leavy")
                {
                    Caption = 'Housing Leavy';
                }
                field("Max Relief"; Rec."Max Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Mortgage Relief"; Rec."Mortgage Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Use Another Tax Bracket"; Rec."Use Another Tax Bracket")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Bracket %"; Rec."Tax Bracket %")
                {
                    ApplicationArea = Basic;
                }
            }
            group(NHIF)
            {
                field("NHIF Based on"; Rec."NHIF Based on")
                {
                    ApplicationArea = Basic;
                }
            }
            group(NSSF)
            {
                field("NSSF Employee"; Rec."NSSF Employee")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF Employer Factor"; Rec."NSSF Employer Factor")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF Based on"; Rec."NSSF Based on")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Pension)
            {
                field("Max Pension Contribution"; Rec."Max Pension Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Tax On Excess Pension"; Rec."Tax On Excess Pension")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Staff Loan")
            {
                field("Loan Market Rate"; Rec."Loan Market Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Corporate Rate"; Rec."Loan Corporate Rate")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Mortgage)
            {
            }
            group("Owner Occupier Interest")
            {
                field("OOI Deduction"; Rec."OOI Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("OOI December"; Rec."OOI December")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Number Series")
            {
                field("Payrol Numbers"; Rec."Payrol Numbers")
                {
                    ApplicationArea = Basic;
                }

            }
        }
    }

    actions
    {
    }
}

