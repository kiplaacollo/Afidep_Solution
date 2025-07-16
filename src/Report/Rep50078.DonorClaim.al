Report 50078 "Donor Claim"
{
    RDLCLayout = 'Layouts/DonorClaim.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Project Allocation"; "Payroll Project Allocation")
        {
            RequestFilterFields = "Project Code", "Employee No";




            column(Employee_Name; "Employee Name")
            {
                Caption = 'Employee Name';
            }
            column(Period; Period)
            {

            }
            column(Employee_No; "Employee No") { }
            column(Project_Code; "Project Code")
            {
                Caption = 'Project Code';
            }
            column(Project_Name; "Project Name") { }
            column(Hours; Hours)
            {
                Caption = 'Hours Worked';
            }
            column(PercentageWorked; CalcPercentage(Hours))
            {
                Caption = 'Percentage Worked';
            }
            column(CompanyInformation_Pic; CompanyInfo.Picture) { }
            column(CompanyInformation_address; CompanyInfo.Address) { }
            column(CompanyInformation_Phone; CompanyInfo."Phone No.") { }
            column(CompanyInformation_Name; CompanyInfo.Name) { }
            column(CompanyInformation_Address2; CompanyInfo."Address 2") { }
            column(CompanyInformation_homepage; CompanyInfo."Home Page") { }
            column(CompanyInformation_Email; CompanyInfo."E-Mail") { }

            dataitem("Proposal Team"; "Proposal Team")
            {
                DataItemLink = "Proposal No." = field("Project Code"), "Employee No." = field("Employee No");
                //  DataItemTableView = SORTING("Project Code", "Employee No") WHERE(Hours = FILTER(> 0));
                column(Proposal_No_; "Proposal No.")
                {
                }
                column(Employee_No_; "Employee No.")
                {
                }

                column(Name; Name)
                {
                    Caption = 'Employee Name';
                }
                // column(Actual_Amount; "Actual Amount")
                // {
                //     Caption = 'Actual Amount';
                // }
                // column(Budgeted_Amount; "Budgeted Amount")
                // {
                //     Caption = 'Budgeted Amount';
                // }
                column(Total_Actual_Amount; TotalActualAmount)
                {
                    // Caption = 'Total Actual Amount (Adjusted)';
                }
                column(Total_Budgeted_Amount; CalcBudgetAmount)
                {
                    // Caption = 'Total Budgeted Amount (Adjusted)';
                }

                column(Actual_Amount; GetAdjustedAmount("Actual Amount", StartDateFilter, EndDateFilter))
                {
                    Caption = 'Actual Amount (Adjusted)';
                }
                column(Budgeted_Amount; GetAdjustedAmount(CalcBudgetAmount(), StartDateFilter, EndDateFilter))
                {
                    Caption = 'Budgeted Amount (Adjusted)';
                }
                column(Daily_Rate; "Daily Rate") { }
                column(Allocation__; "Allocation %") { }
                column(CName; CompanyInfo.Name)
                {
                    Caption = 'Company Name';
                }
                column(CAddress; CompanyInfo.Address)
                {
                    Caption = 'Company Address';
                }
                // Connect to G/L Entry
                // dataitem("G/L Entry"; "G/L Entry")
                // {
                //     DataItemTableView = SORTING("Posting Date") WHERE("Debit Amount" = FILTER(<> 0));
                //     DataItemLink = "Global Dimension 2 Code" = field("Proposal No.");

                //     column(Employee_No_GL; EmployeeNo)
                //     {
                //         Caption = 'Employee No.';
                //     }
                //     column(Project_Code_GL; "Global Dimension 2 Code")
                //     {
                //         Caption = 'Project Code';
                //     }
                //     column(Total_Amount; GetTotalAmount(EmployeeNo, "Global Dimension 2 Code"))
                //     {
                //         Caption = 'Total Amount';
                //     }
                //     column(Debit_Amount; "Debit Amount") { }
                //     column(Description; Description) { }
                //     column(Posting_Date; "Posting Date") { }
                //     trigger OnPreDataItem()
                //     begin
                //         // Apply the date filter
                //         if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then
                //             SetFilter("Posting Date", '%1..%2', StartDateFilter, EndDateFilter);


                //     end;

                //     trigger OnAfterGetRecord()
                //     var
                //         EmployeePrefix: Text[3];
                //     begin
                //         EmployeePrefix := CopyStr(Description, 1, 3); // Extract the first 3 characters

                //         if EmployeePrefix = 'EMP' then
                //             EmployeeNo := CopyStr(Description, 1, 6); // Extract the first 6 characters
                //                                                       // else
                //                                                       //     EmployeeNo := ''; // Ignore if it doesn’t start with "EMP"
                //     end;
                // }

                // dataitem("Payroll Project Allocation"; "Payroll Project Allocation")
                // {
                //     DataItemLink = "Project Code" = field("Proposal No."), "Employee No" = field("Employee No.");
                //     DataItemTableView = SORTING("Project Code", "Employee No") WHERE(Hours = FILTER(> 0));

                //     column(Employee_Name; "Employee Name")
                //     {
                //         Caption = 'Employee Name';
                //     }
                //     column(Project_Code; "Project Code")
                //     {
                //         Caption = 'Project Code';
                //     }
                //     column(Hours; Hours)
                //     {
                //         Caption = 'Hours Worked';
                //     }
                //     column(PercentageWorked; CalcPercentage(Hours))
                //     {
                //         Caption = 'Percentage Worked';
                //     }
                // }
            }
            trigger OnPreDataItem()
            begin
                // Apply the date filter
                if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then
                    SetFilter(Period, '%1..%2', StartDateFilter, EndDateFilter);

                // Calculate number of months
                NumMonths := CalcNumMonths(StartDateFilter, EndDateFilter);

                // Compute total amounts BEFORE the report runs
                TotalActualAmount := GetTotalActualAmount();
                TotalBudgetedAmount := GetTotalBudgetedAmount();

                // Message('Total Actual: %1, Total Budgeted: %2, NumMonths: %3',
                //         TotalActualAmount, TotalBudgetedAmount, NumMonths);

                if EmployeeNo <> '' then
                    SetRange("Payroll Project Allocation"."Employee No", EmployeeNo);




            end;

            trigger OnAfterGetRecord()
            begin
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."No.", "Employee No");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", Period);
                // PeriodTrans.SetFilter(PeriodTrans."Transaction Name", '<>%1&<>%2&<>%3&<>%4', 'Education Allowance', 'Education Allowance deduction', 'Excess Pension', 'Salary Arrears Excess Pension'); // Corrected syntax
                if PeriodTrans.Find('-') then begin
                    repeat
                    until PeriodTrans.next = 0;

                end;
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(StartDateFilter; StartDateFilter)
                    {
                        ApplicationArea = All;
                    }
                    field(EndDateFilter; EndDateFilter)
                    {
                        ApplicationArea = All;
                    }
                    field(EmployeeNo; EmployeeNo)
                    {
                        Caption = 'Employee No.';
                        ApplicationArea = All;
                        TableRelation = "HR Employees"."No."; // Assuming you’re using HREmployee table
                    }

                    // Caption = 'Options';
                    // field(ProjectFilter; FilterField)
                    // {
                    //     Caption = 'Project Filter';
                    //     ApplicationArea = All;
                    // }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // Optionally pre-set filters or values
        end;
    }

    trigger OnPreReport()
    var
        StartMonth, EndMonth, StartYear, EndYear : Integer;
    begin
        CI.Get();
        CI.CalcFields(CI.Picture);

        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);

        // Extract the month and year
        StartMonth := Date2DMY(StartDateFilter, 2);
        EndMonth := Date2DMY(EndDateFilter, 2);
        StartYear := Date2DMY(StartDateFilter, 3);
        EndYear := Date2DMY(EndDateFilter, 3);

        // Calculate total number of months
        if StartYear = EndYear then
            NumMonths := EndMonth - StartMonth + 1
        else
            NumMonths := (12 - StartMonth + 1) + ((EndYear - StartYear - 1) * 12) + EndMonth;


    end;




    var
        CompanyInfo: Record "Company Information";
        CI: Record "Company Information";
        FilterField: Code[20]; // This is used to set the project filter
        StartDateFilter: Date;
        EndDateFilter: Date;
        NumMonths: Integer;
        EmployeeNo: Code[20];
        TotalActualAmount: Decimal;
        TotalBudgetedAmount: Decimal;
        PeriodTrans: Record "Payroll Monthly Trans_AU";
        SelectedPeriod: Date;

    local procedure CalcPercentage(HoursWorked: Decimal): Decimal
    var
        TotalPossibleHours: Decimal;
    begin
        // Assuming 8 hours/day and 18.3333 days = 100%
        TotalPossibleHours := 8 * 18.3333;
        if TotalPossibleHours > 0 then
            exit((HoursWorked / TotalPossibleHours) * 100)
        else
            exit(0);
    end;

    local procedure ExtractEmployeeNo(Description: Text): Code[6]
    begin
        exit(CopyStr(Description, 1, 6)); // Extracts first 6 characters
    end;

    local procedure GetTotalAmount(EmployeeNo: Code[6]; ProjectCode: Code[20]): Decimal
    var
        GLEntry: Record "G/L Entry";
        TotalAmount: Decimal;
    begin
        TotalAmount := 0;

        // Filter by Employee No (Extracted from Description)
        GLEntry.SetFilter(Description, '%1*', EmployeeNo);

        // Filter by Project Code if provided
        GLEntry.SetRange("Global Dimension 2 Code", 'CB0039'); // Assuming Project Code is stored in Global Dimension 1

        // Filter Amount > 0
        GLEntry.SetFilter("Debit Amount", '<>0');

        if GLEntry.FindSet() then
            repeat
                TotalAmount += GLEntry."Debit Amount";
            until GLEntry.Next() = 0;

        exit(TotalAmount);
    end;

    local procedure GetAdjustedAmount(Amount: Decimal; StartDate: Date; EndDate: Date): Decimal
    var
        StartMonth, EndMonth, StartYear, EndYear : Integer;
        NumMonths: Integer;
    begin
        // Extract the month and year
        StartMonth := Date2DMY(StartDate, 2);
        EndMonth := Date2DMY(EndDate, 2);
        StartYear := Date2DMY(StartDate, 3);
        EndYear := Date2DMY(EndDate, 3);

        // Ensure the calculation spans multiple years correctly
        if StartYear = EndYear then
            NumMonths := EndMonth - StartMonth + 1
        else
            NumMonths := (12 - StartMonth + 1) + ((EndYear - StartYear - 1) * 12) + EndMonth;

        exit(Amount * NumMonths);
    end;

    local procedure GetTotalActualAmount(): Decimal
    var
        ProposalTeamRec: Record "Proposal Team"; // Ensure this matches your table
        Total: Decimal;
    begin
        Total := 0;

        // Apply filters if necessary (e.g., project code, employee no, etc.)
        ProposalTeamRec.SetRange("Proposal No.", "Proposal Team"."Proposal No."); // Adjust as needed
        ProposalTeamRec.SetRange("Employee No.", "Proposal Team"."Employee No."); // Adjust as needed

        if ProposalTeamRec.FindSet() then
            repeat
                Total += ProposalTeamRec."Actual Amount"; // Sum all values
                Message('Total: %1', Total);
            until ProposalTeamRec.Next() = 0;

        exit(Total * NumMonths); // Multiply by the number of months
    end;


    local procedure GetTotalBudgetedAmount(): Decimal
    var
        ProposalTeamRec: Record "Proposal Team";
        Total: Decimal;
    begin
        Total := 0;

        ProposalTeamRec.SetRange("Proposal No.", "Proposal Team"."Proposal No."); // Adjust as needed
        ProposalTeamRec.SetRange("Employee No.", "Proposal Team"."Employee No."); // Adjust as needed

        if ProposalTeamRec.FindSet() then
            repeat
                Total += ProposalTeamRec."Budgeted Amount"; // Sum all values
            until ProposalTeamRec.Next() = 0;

        exit(Total * NumMonths);
    end;

    local procedure CalcNumMonths(StartDate: Date; EndDate: Date): Integer
    var
        StartYear, StartMonth, EndYear, EndMonth : Integer;
    begin
        StartYear := Date2DMY(StartDate, 3);
        StartMonth := Date2DMY(StartDate, 2);
        EndYear := Date2DMY(EndDate, 3);
        EndMonth := Date2DMY(EndDate, 2);

        exit((EndYear - StartYear) * 12 + (EndMonth - StartMonth) + 1);
    end;


    procedure CalcBudgetAmount(): Decimal
    begin
        exit(("Proposal Team"."Allocation %" / 100) * "Proposal Team"."Daily Rate" * (220 / 12));
    end;





}
