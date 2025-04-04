Page 80003 "Payroll Employee Assig_AU"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Payroll Employee_AU";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Surname;Rec.Surname)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Firstname;Rec.Firstname)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Lastname;Rec.Lastname)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Pays PAYE";Rec."Pays PAYE")
                {
                    ApplicationArea = Basic;
                }
                field("Pays NSSF";Rec."Pays NSSF")
                {
                    ApplicationArea = Basic;
                }
                field("Pays NHIF";Rec."Pays NHIF")
                {
                    ApplicationArea = Basic;
                }
                field(Secondary;Rec.Secondary)
                {
                    ApplicationArea = Basic;
                }
            }
            group(Numbers)
            {
                field("National ID No";Rec."National ID No")
                {
                    ApplicationArea = Basic;
                }
                field("PIN No";Rec."PIN No")
                {
                    ApplicationArea = Basic;
                }
                field("NHIF No";Rec."NHIF No")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF No";Rec."NSSF No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("PAYE Relief and Benefit")
            {
                field(GetsPayeRelief;Rec.GetsPayeRelief)
                {
                    ApplicationArea = Basic;
                }
                field(GetsPayeBenefit;Rec.GetsPayeBenefit)
                {
                    ApplicationArea = Basic;
                }
                field(PayeBenefitPercent;Rec.PayeBenefitPercent)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Employee Company")
            {
                field(Company;Rec.Company)
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

