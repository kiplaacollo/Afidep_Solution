Page 80000 "Payroll Posting Group_AU"
{
    PageType = List;
    SourceTable = "Payroll Posting Groups_AU";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Code"; Rec."Posting Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Salary Account"; Rec."Salary Account")
                {
                    ApplicationArea = Basic;
                }
                field("Income Tax Account"; Rec."Income Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field("SSF Employer Account"; Rec."SSF Employer Account")
                {
                    ApplicationArea = Basic;
                }
                field("SSF Employee Account"; Rec."SSF Employee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Net Salary Payable"; Rec."Net Salary Payable")
                {
                    ApplicationArea = Basic;
                }
                field("Net Salary Payable-Contract"; Rec."Net Salary Payable-Contract")
                {
                    ApplicationArea = Basic;
                }
                field("Operating Overtime"; Rec."Operating Overtime")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Relief"; Rec."Tax Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Provident Fund Acc."; Rec."Employee Provident Fund Acc.")
                {
                    ApplicationArea = Basic;
                }
                field("Pay Period Filter"; Rec."Pay Period Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Pension Employer Acc"; Rec."Pension Employer Acc")
                {
                    ApplicationArea = Basic;
                }
                field("Pension Employee Acc"; Rec."Pension Employee Acc")
                {
                    ApplicationArea = Basic;
                }
                field("Earnings and deductions"; Rec."Earnings and deductions")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Benevolent"; Rec."Staff Benevolent")
                {
                    ApplicationArea = Basic;
                }
                field(SalaryExpenseAC; Rec.SalaryExpenseAC)
                {
                    ApplicationArea = Basic;
                }
                field("Directors Fee GL"; Rec."Directors Fee GL")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Gratuity"; Rec."Staff Gratuity")
                {
                    ApplicationArea = Basic;
                }
                field("NHIF Employee Account"; Rec."NHIF Employee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = Basic;
                }
                field("Upload to Payroll"; Rec."Upload to Payroll")
                {
                    ApplicationArea = Basic;
                }
                field("PAYE Benefit A/C"; Rec."PAYE Benefit A/C")
                {
                    ApplicationArea = Basic;
                }
                field("Premium Account"; Rec."Premium Account")
                {
                    ApplicationArea = basic;
                }
                field("Housing Employee"; Rec."Housing Employee")
                {
                    ApplicationArea = all;
                }
                field("Housing Employer"; Rec."Housing Employer")
                {
                    ApplicationArea = all;
                }
                field("SHIF Employee"; Rec."SHIF Employee")
                {
                    ApplicationArea = all;
                }
                field("SHIF Employer"; Rec."SHIF Employer")
                {
                    ApplicationArea = all;
                }
                field("Life Insurance Employee Acc"; Rec."Life Insurance Employee Acc")
                {
                    ApplicationArea = All;
                }
                field("Life Insurance Employer Acc"; Rec."Life Insurance Employer Acc")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

