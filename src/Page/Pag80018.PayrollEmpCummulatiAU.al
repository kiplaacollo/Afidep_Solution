Page 80018 "Payroll Emp. Cummulati_AU"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Payroll Employee_AU";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic;
                }
                field(Firstname; Rec.Firstname)
                {
                    ApplicationArea = Basic;
                }
                field(Lastname; Rec.Lastname)
                {
                    ApplicationArea = Basic;
                }
            }
            group(Cummulatives)
            {
                field("Cummulative Basic Pay"; Rec."Cummulative Basic Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Gross Pay"; Rec."Cummulative Gross Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Allowances"; Rec."Cummulative Allowances")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Deductions"; Rec."Cummulative Deductions")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Net Pay"; Rec."Cummulative Net Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative PAYE"; Rec."Cummulative PAYE")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative NSSF"; Rec."Cummulative NSSF")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Pension"; Rec."Cummulative Pension")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative HELB"; Rec."Cummulative HELB")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative NHIF"; Rec."Cummulative NHIF")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Employer Pension"; Rec."Cummulative Employer Pension")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative TopUp"; Rec."Cummulative TopUp")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Basic Pay(LCY)"; Rec."Cummulative Basic Pay(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Gross Pay(LCY)"; Rec."Cummulative Gross Pay(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Allowances(LCY)"; Rec."Cummulative Allowances(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Deductions(LCY)"; Rec."Cummulative Deductions(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Net Pay(LCY)"; Rec."Cummulative Net Pay(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative PAYE(LCY)"; Rec."Cummulative PAYE(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative NSSF(LCY)"; Rec."Cummulative NSSF(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Pension(LCY)"; Rec."Cummulative Pension(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative HELB(LCY)"; Rec."Cummulative HELB(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative NHIF(LCY)"; Rec."Cummulative NHIF(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm Employer Pension(LCY)"; Rec."Cumm Employer Pension(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative TopUp(LCY)"; Rec."Cummulative TopUp(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Gratuity"; Rec."Cummulative Gratuity")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Gratuity(LCY)"; Rec."Cummulative Gratuity(LCY)")
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

