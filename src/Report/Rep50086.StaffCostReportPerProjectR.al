Report 50086 "Staff Cost Report P Range"
{
    RDLCLayout = 'Layouts/StaffCostRP.rdlc';
    DefaultLayout = RDLC;
    Caption = 'Staff Cost Report';

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
            column(StartDateFilter; StartDateFilter) { }
            column(EndDateFilter; EndDateFilter) { }
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
            column(Total_Hours; "Total Hours") { }
            column(PercentageWorked; CalcLOE(Hours))
            {
                Caption = 'Percentage Worked';
            }

            column(TotalActualAmount; TotalActualAmountN / WorkingDays) { }
            column(Actual_Amount; (CalcActualAmount(StartDateFilter, EndDateFilter)))
            {
                Caption = 'Actual Amount (Adjusted)';
            }
            column(AdjustedHours; AdjustedHours) { }
            column(WorkingDays; WorkingDays) { }
            column(ProjectPercent; ProjectPercent) { }
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

                column(Total_Budgeted_Amount; CalcBudgetAmount)
                {
                    // Caption = 'Total Budgeted Amount (Adjusted)';
                }

                // column(Actual_Amount; GetAdjustedAmount(CalcActualAmount(), StartDateFilter, EndDateFilter))
                // {
                //     Caption = 'Actual Amount (Adjusted)';
                // }
                column(Budgeted_Amount; (CalcBudgetAmount()))
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

            }
            trigger OnPreDataItem()
            begin
                // Apply the date filter
                if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then
                    SetFilter(Period, '%1..%2', StartDateFilter, EndDateFilter);

                // Calculate number of months
                NumMonths := CalcNumMonths(StartDateFilter, EndDateFilter);

                // Compute total amounts BEFORE the report runs


                // Message('Total Actual: %1, Total Budgeted: %2, NumMonths: %3',
                //         TotalActualAmount, TotalBudgetedAmount, NumMonths);

                if EmployeeNo <> '' then
                    SetRange("Payroll Project Allocation"."Employee No", EmployeeNo);



                // ProjectPercent := "Payroll Project Allocation".Hours / "Payroll Project Allocation"."Total Hours" * 100;

                TotalActualAmount := GetTotalActualAmount(EmployeeNo);
                TotalBudgetedAmount := GetTotalBudgetedAmount();


                objPeriod.Reset();
                objPeriod.SetRange(objPeriod."Date Opened", StartDateFilter, EndDateFilter);
                if objPeriod.Find('-') then begin
                    //  "Slip/Receipt No" := UpperCase(objPeriod."Period Name");
                    Currenc := Round(objPeriod."Currency Code", 0.01, '=');
                end;




            end;

            trigger OnAfterGetRecord()
            var
            begin
                // 🔵 RESET the total for the current record
                TotalActualAmountN := 0;
                EmployerPension := 0;
                SHIF := 0;
                NITA := 0;
                Nssf := 0;
                HL := 0;
                Grouplf := 0;
                AdmPension := 0;
                VATFee := 0;
                MedicalM := 0;
                EduM := 0;
                MedicalInsu := 0;
                LifeAss := 0;
                WibaIns := 0;
                TravelIns := 0;
                BasicPay := 0;
                Milage := 0;
                Responsibility := 0;


                // Apply percentage to get actual amount for the project

                PeriodTrans.Reset();
                if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then
                    PeriodTrans.SetRange("Payroll Period", StartDateFilter, EndDateFilter);

                PeriodTrans.SetRange("No.", "Payroll Project Allocation"."Employee No");

                if PeriodTrans.Find('-') then begin
                    repeat
                        case PeriodTrans."Transaction Code" of
                            'BPAY':
                                begin
                                    BasicPay += PeriodTrans."Amount(LCY)";
                                end;
                            'NSSF':
                                begin
                                    NSSF += PeriodTrans.Amount / Currenc;
                                    ;
                                end;
                            'HL':
                                begin
                                    HL += PeriodTrans.Amount / Currenc;
                                end;
                            'E002':
                                begin
                                    EduM += PeriodTrans."Amount(LCY)";
                                end;
                            'E006':
                                begin
                                    Milage += PeriodTrans."Amount(LCY)";
                                end;
                            'E001':
                                begin
                                    Responsibility += PeriodTrans."Amount(LCY)";
                                end;
                            'E012':
                                begin
                                    MedicalInsu += PeriodTrans."Amount(LCY)";
                                end;
                            'E013':
                                begin
                                    LifeAss += PeriodTrans."Amount(LCY)";
                                end;
                            'E014':
                                begin
                                    WibaIns += PeriodTrans."Amount(LCY)";
                                end;
                            'E015':
                                begin
                                    TravelIns += PeriodTrans."Amount(LCY)";
                                end;
                        // Pension from employee table if needed
                        end;
                    until PeriodTrans.Next() = 0;
                end;

                //if PeriodTrans."Transaction Code" = 'BPAY' then begin
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'BPAY');
                if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then
                    PeriodTrans.SetRange("Payroll Period", StartDateFilter, EndDateFilter);

                PeriodTrans.SetRange("No.", "Payroll Project Allocation"."Employee No");

                if PeriodTrans.Find('-') then begin
                    repeat
                        objEmp.Reset();
                        objEmp.SetRange(objEmp."No.", "Payroll Project Allocation"."Employee No");
                        // objEmp.SetFilter(objEmp."No.", '<>%1', 'EMP229');
                        if objEmp.Find('-') then begin

                            EmployerPension += objEmp."Pension %-Employer" / 100 * PeriodTrans."Amount(LCY)";
                            //  Message('Pension :%1', EmployerPension);
                        end;
                        SHIF += PeriodTrans."Amount(LCY)" * 2.75 / 100;


                        NITA += 50 / Currenc;
                    UNTIL PeriodTrans.Next = 0;
                end;
                // if PeriodTrans."Transaction Code" = 'NSSF' then begin



                // Message('Total: %1,Basic: %2,Pension: %3,Nssf: %4,HL: %5,Shif: %6,Nita: %7,Medical: %8,Life: %9,Wiba: %10,Travel: %11,Edu: %12', TotalActualAmountN, BasicPay, EmployerPension, Nssf, HL, SHIF, NITA, MedicalInsu, LifeAss, WibaIns, TravelIns, EduM);

                PeriodTransMW.Reset();
                PeriodTransMW.SetFilter(PeriodTransMW."Transaction Code", '%1', 'BPAY');
                if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then
                    PeriodTransMW.SetRange("Payroll Period", StartDateFilter, EndDateFilter);

                PeriodTransMW.SetRange("No.", "Payroll Project Allocation"."Employee No");

                if PeriodTransMW.Find('-') then begin
                    repeat
                        BasicPay += PeriodTransMW."Amount(LCY)";


                        if PeriodTransMW."Transaction Code" = 'BPAY' then begin
                            objEmp.Reset();
                            objEmp.SetRange(objEmp."No.", "Payroll Project Allocation"."Employee No");
                            // objEmp.SetFilter(objEmp."No.", '<>%1', 'EMP229');
                            if objEmp.Find('-') then begin

                                EmployerPension := objEmp."Pension %-Employer" / 100 * PeriodTransMW."Amount(LCY)";

                                Grouplf := objEmp."Group Life Assuarance" / 100 * PeriodTransMW."Amount(LCY)";
                                //  Message('Pension :%1', EmployerPension);
                                if (PeriodTransMW."Transaction Code" = 'BPAY') and (objEmp."Pension %-Employer" <> 0) then begin


                                    AdmPension := objEmp."Pension Administrative Fee" / 100 * PeriodTransMW."Amount(LCY)";
                                    //  Message('Pension :%1', EmployerPension);

                                    VATFee := objEmp."VAT Administrative Fee" / 100 * AdmPension;


                                end;

                            end;
                            //  TotalActualAmountN := TotalActualAmountN + EmployerPension + AdmPension + VATFee + Grouplf;
                        end;
                    until PeriodTransMW.Next() = 0;
                END;

                PeriodTransMW.Reset();
                PeriodTransMW.SetFilter(PeriodTransMW."Transaction Code", '%1', 'E012');
                if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then
                    PeriodTransMW.SetRange("Payroll Period", StartDateFilter, EndDateFilter);

                PeriodTransMW.SetRange("No.", "Payroll Project Allocation"."Employee No");

                if PeriodTransMW.Find('-') then begin
                    repeat
                        MedicalM += PeriodTransMW."Amount(LCY)";

                    until PeriodTransMW.Next() = 0;

                end;
                PeriodTransMW.Reset();
                PeriodTransMW.SetFilter(PeriodTransMW."Transaction Code", '%1', 'E001');
                if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then
                    PeriodTransMW.SetRange("Payroll Period", StartDateFilter, EndDateFilter);

                PeriodTransMW.SetRange("No.", "Payroll Project Allocation"."Employee No");

                if PeriodTransMW.Find('-') then begin
                    repeat
                        Responsibility += PeriodTransMW."Amount(LCY)";

                    until PeriodTransMW.Next() = 0;

                end;

                PeriodTransMW.Reset();
                PeriodTransMW.SetFilter(PeriodTransMW."Transaction Code", '%1', 'E002');
                if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then
                    PeriodTransMW.SetRange("Payroll Period", StartDateFilter, EndDateFilter);

                PeriodTransMW.SetRange("No.", "Payroll Project Allocation"."Employee No");

                if PeriodTransMW.Find('-') then begin
                    repeat
                        EduM += PeriodTransMW."Amount(LCY)";

                    until PeriodTransMW.Next() = 0;

                end;

                //  TotalActualAmountN := TotalActualAmountN + EmployerPension + + EduM;
                TotalActualAmountN := BasicPay + EmployerPension + Nssf + HL + SHIF + NITA + MedicalInsu + LifeAss + WibaIns + TravelIns + Responsibility + Milage + EduM + AdmPension + VATFee + Grouplf + MedicalM;
                //  Message('Total=%1, Basic=%2', TotalActualAmountN, BasicPay);
                // 🔵 Calculate Percentage and Cost
                // ProjectPercent := "Payroll Project Allocation".Hours / "Payroll Project Allocation"."Total Hours" * 100;
                // TotalActualAmountC := ("Payroll Project Allocation".Hours / "Payroll Project Allocation"."Total Hours" * TotalActualAmountN);
                // Initialize totals
                TotalProjectHours := 0;
                TotalEmployeeHours := 0;
                ProjectEndDate := DMY2Date(31, 3, 2025);

                PayrollAlloc.Reset();
                PayrollAlloc.SetRange("Employee No", "Payroll Project Allocation"."Employee No");
                PayrollAlloc.SetRange("Project Code", "Payroll Project Allocation"."Project Code");

                // Apply period filter (user selection)
                if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then begin
                    // For BMGF, restrict to March 2025
                    if ("Payroll Project Allocation"."Project Code" = 'CB0042') then begin
                        if StartDateFilter <= DMY2Date(31, 3, 2025) then begin
                            if EndDateFilter > DMY2Date(31, 3, 2025) then
                                PayrollAlloc.SetRange(Period, StartDateFilter, DMY2Date(31, 3, 2025))
                            else
                                PayrollAlloc.SetRange(Period, StartDateFilter, EndDateFilter);
                        end else
                            exit; // skip BMGF if entire filter is after March
                    end else begin
                        // Normal period filter for other projects
                        PayrollAlloc.SetRange(Period, StartDateFilter, EndDateFilter);
                    end;
                end;

                // Sum hours if filtered data exists
                if PayrollAlloc.FindSet() then begin
                    repeat
                        TotalProjectHours += PayrollAlloc.Hours;
                        TotalEmployeeHours += PayrollAlloc."Total Hours";
                    until PayrollAlloc.Next() = 0;
                end;


                // Prevent division by zero
                if TotalEmployeeHours <> 0 then
                    ProjectPercent := TotalProjectHours / TotalEmployeeHours
                else
                    ProjectPercent := 0;

                TotalActualAmountC := (ProjectPercent) * TotalActualAmountN;

                AdjustedHours := GetAdjustedHours("Employee No", Period, "Project Code", Hours);
                WorkingDays := GetWorkingDays(StartDateFilter, EndDateFilter);
                //  Amount := (AdjustedHours / 8) * (TotalCost / WorkingDays);


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
        TotalActualAmountC: Decimal;
        TotalActualAmountN: Decimal;
        AdmPension: Decimal;
        VATFee: Decimal;
        Grouplf: Decimal;
        TotalBudgetedAmount: Decimal;
        PeriodTrans: Record "Payroll Monthly Trans_AU";
        PeriodTransMW: Record "Payroll Monthly Trans_Malawi";
        SelectedPeriod: Date;
        ProjectPercent: Decimal;
        objEmp: Record "Payroll Employee_AU";
        EmployerPension: Decimal;
        SHIF: Decimal;
        NITA: Decimal;
        Nssf: Decimal;
        HL: Decimal;
        objPeriod: Record "Payroll Calender_AU";
        Currenc: Decimal;
        TotalProjectHours: Decimal;
        ProjectEndDate: Date;
        TotalEmployeeHours: Decimal;
        PayrollAlloc: Record "Payroll Project Allocation";
        MedicalInsu: Decimal;
        LifeAss: Decimal;
        TravelIns: Decimal;
        WibaIns: Decimal;
        MedicalM: Decimal;
        EduM: Decimal;
        BasicPay: Decimal;
        Milage: Decimal;
        Responsibility: Decimal;
        AdjustedHours: Decimal;
        WorkingDays: Integer;
    //StayD: Record "Stay Details";

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

    procedure GetAdjustedHours(EmpNo: Code[20]; Period: Date; ProjCode: Code[20]; LineHours: Decimal): Decimal
    var
        AllocRec: Record "Payroll Project Allocation";
        OtherHours: Decimal;
        AD003Hours: Decimal;
        RM001Hours: Decimal;
        RM2025Hours: Decimal;
        TotalCoreHours: Decimal;
        TotalEmployeeHours: Decimal;
        AdjustedHours: Decimal;
        TargetHours: Decimal;
        ExtraHours: Decimal;
    begin
        // Step 1: Sum hours
        AllocRec.Reset();
        AllocRec.SetRange("Employee No", EmpNo);
        AllocRec.SetRange(Period, Period);

        if AllocRec.FindSet() then
            repeat
                case AllocRec."Project Code" of
                    'AD03':
                        AD003Hours += AllocRec.Hours;
                    'RM001':
                        RM001Hours += AllocRec.Hours;
                    'RM2025':
                        RM2025Hours += AllocRec.Hours;
                    else
                        OtherHours += AllocRec.Hours;
                end;
            until AllocRec.Next() = 0;

        TotalCoreHours := AD003Hours + RM001Hours + RM2025Hours;
        TotalEmployeeHours := TotalCoreHours + OtherHours;
        TargetHours := WorkingDays * 8;

        // Step 2: Adjustment logic
        if TotalEmployeeHours <= TargetHours then
            exit(LineHours)
        else begin
            if OtherHours < TargetHours then begin
                ExtraHours := TargetHours - OtherHours;

                if (ProjCode in ['AD03', 'RM001', 'RM2025']) and (TotalCoreHours > 0) then
                    exit(ExtraHours * (LineHours / TotalCoreHours))
                else
                    exit(LineHours);
            end else begin
                if not (ProjCode in ['AD03', 'RM001', 'RM2025']) and (OtherHours > 0) then
                    exit(LineHours * (TargetHours / OtherHours))
                else
                    exit(0);
            end;
        end;
    end;


    procedure GetWorkingDays(StartDate: Date; EndDate: Date): Integer
    var
        CurrDate: Date;
        WorkingDays: Integer;
    begin
        CurrDate := StartDate;
        WorkingDays := 0;

        while CurrDate <= EndDate do begin
            if DATE2DWY(CurrDate, 1) in [1 .. 5] then
                WorkingDays += 1;
            CurrDate += 1;
        end;

        exit(WorkingDays);
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

    local procedure GetTotalActualAmount(EmployeeNo: Code[20]): Decimal
    var
        Total: Decimal;
    begin
        Total := 0;

        if EmployeeNo = '' then
            exit(0); // If no employee specified, exit early with 0

        // Process PeriodTrans
        PeriodTrans.Reset();
        PeriodTrans.SetRange("Posting Type", PeriodTrans."Posting Type"::Debit);
        PeriodTrans.SetRange("No.", EmployeeNo);
        if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then
            PeriodTrans.SetRange("Payroll Period", StartDateFilter, EndDateFilter);

        if PeriodTrans.FindSet() then
            repeat
                Total += PeriodTrans."Amount(LCY)";
            until PeriodTrans.Next() = 0;

        // Process PeriodTransMW
        PeriodTransMW.Reset();
        PeriodTransMW.SetRange("Posting Type", PeriodTransMW."Posting Type"::Debit);
        PeriodTransMW.SetRange("No.", EmployeeNo);
        if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then
            PeriodTransMW.SetRange("Payroll Period", StartDateFilter, EndDateFilter);

        if PeriodTransMW.FindSet() then
            repeat
                Total += PeriodTransMW."Amount(LCY)";
            until PeriodTransMW.Next() = 0;

        exit(Total);
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
    var
        ProjectCode: Code[20];
    begin
        ProjectCode := "Proposal Team"."Proposal No.";

        if ProjectCode = 'CB0039' then
            exit(("Proposal Team"."Allocation %" / 100) * "Proposal Team"."Daily Rate" * (220 / 12))
        else
            exit(("Payroll Project Allocation".Hours / 8) * "Proposal Team"."Daily Rate");
    end;

    procedure CalcActualAmount(StartDate: Date; EndDate: Date): Decimal
    var
        AllocRec: Record "Payroll Project Allocation";
        OtherHours: Decimal;
        AD003Hours: Decimal;
        RM001Hours: Decimal;
        RM2025Hours: Decimal;
        TotalCost: Decimal;
        ExtraHours: Decimal;
        TotalCoreHours: Decimal;
        LineHours: Decimal;
        ProjCode: Code[20];
        TotalEmployeeHours: Decimal;
        TargetHours: Decimal;
        CurrDate: Date;
        WorkingDays: Integer;
    begin
        TotalCost := TotalActualAmountN;
        LineHours := "Payroll Project Allocation".Hours;
        ProjCode := "Payroll Project Allocation"."Project Code";

        // Step 1: Sum hours by category for the employee and period
        AllocRec.Reset();
        AllocRec.SetRange("Employee No", "Payroll Project Allocation"."Employee No");
        AllocRec.SetRange(Period, StartDate, EndDate); // Assuming "Allocation Date" exists

        if AllocRec.FindSet() then
            repeat
                case AllocRec."Project Code" of
                    'AD03':
                        AD003Hours += AllocRec.Hours;
                    'RM001':
                        RM001Hours += AllocRec.Hours;
                    'RM2025':
                        RM2025Hours += AllocRec.Hours;
                    else
                        OtherHours += AllocRec.Hours;
                end;
            until AllocRec.Next() = 0;

        TotalCoreHours := AD003Hours + RM001Hours + RM2025Hours;
        TotalEmployeeHours := TotalCoreHours + OtherHours;

        // Step 2: Calculate working days between StartDate and EndDate
        CurrDate := StartDate;
        WorkingDays := 0;

        while CurrDate <= EndDate do begin
            if DATE2DWY(CurrDate, 1) in [1 .. 5] then
                WorkingDays += 1;
            CurrDate += 1;
        end;

        if WorkingDays = 0 then
            WorkingDays := 22; // Fallback

        TargetHours := WorkingDays * 8;

        // Step 3: Adjustment logic
        if TotalEmployeeHours <= TargetHours then
            AdjustedHours := LineHours
        else begin
            if (OtherHours < TargetHours) then begin
                ExtraHours := TargetHours - OtherHours;
                if (ProjCode in ['AD03', 'RM001', 'RM2025']) and (TotalCoreHours > 0) then
                    AdjustedHours := ExtraHours * (LineHours / TotalCoreHours)
                else
                    AdjustedHours := LineHours;
            end else begin
                if not (ProjCode in ['AD03', 'RM001', 'RM2025']) and (OtherHours > 0) then
                    AdjustedHours := LineHours * (TargetHours / OtherHours)
                else
                    AdjustedHours := 0;
            end;
        end;

        // Step 4: Calculate final amount
        exit((AdjustedHours / 8) * (TotalCost / WorkingDays));
    end;



    // procedure CalcActualAmount(): Decimal
    // var
    //     AllocRec: Record "Payroll Project Allocation";
    //     OtherHours: Decimal;
    //     AD003Hours: Decimal;
    //     RM001Hours: Decimal;
    //     RM2025Hours: Decimal;
    //     TotalCost: Decimal;
    //     ExtraHours: Decimal;
    //     TotalCoreHours: Decimal;
    //     AdjustedHours: Decimal;
    //     LineHours: Decimal;
    //     ProjCode: Code[20];
    //     TotalEmployeeHours: Decimal;
    //     TargetHours: Decimal;
    //     PeriodStart: Date;
    //     PeriodEnd: Date;
    //     CurrDate: Date;
    //     WorkingDays: Integer;
    // begin
    //     TotalCost := TotalActualAmountN;
    //     LineHours := "Payroll Project Allocation".Hours;
    //     ProjCode := "Payroll Project Allocation"."Project Code";

    //     // Step 1: Sum hours by category for the employee and period
    //     AllocRec.Reset();
    //     AllocRec.SetRange("Employee No", "Payroll Project Allocation"."Employee No");
    //     AllocRec.SetRange(Period, "Payroll Project Allocation".Period);

    //     if AllocRec.FindSet() then
    //         repeat
    //             case AllocRec."Project Code" of
    //                 'AD03':
    //                     AD003Hours += AllocRec.Hours;
    //                 'RM001':
    //                     RM001Hours += AllocRec.Hours;
    //                 'RM2025':
    //                     RM2025Hours += AllocRec.Hours;
    //                 else
    //                     OtherHours += AllocRec.Hours;
    //             end;
    //         until AllocRec.Next() = 0;

    //     TotalCoreHours := AD003Hours + RM001Hours + RM2025Hours;
    //     TotalEmployeeHours := TotalCoreHours + OtherHours;
    //     TargetHours := 176; // Fixed standard hours per month

    //     // Step 2: Adjust hours based on project type
    //     if TotalEmployeeHours <= TargetHours then begin
    //         AdjustedHours := LineHours;
    //     end else begin
    //         if (OtherHours < TargetHours) then begin
    //             ExtraHours := TargetHours - OtherHours;

    //             if (ProjCode in ['AD03', 'RM001', 'RM2025']) and (TotalCoreHours > 0) then
    //                 AdjustedHours := ExtraHours * (LineHours / TotalCoreHours)
    //             else
    //                 AdjustedHours := LineHours;
    //         end else begin
    //             if not (ProjCode in ['AD03', 'RM001', 'RM2025']) and (OtherHours > 0) then
    //                 AdjustedHours := LineHours * (TargetHours / OtherHours)
    //             else
    //                 AdjustedHours := 0;
    //         end;
    //     end;

    //     // Step 3: Calculate working days in the period (excluding weekends)
    //     PeriodStart := DMY2Date(1, Date2DMY("Payroll Project Allocation".Period, 2), Date2DMY("Payroll Project Allocation".Period, 3));
    //     PeriodEnd := CALCDATE('<CM>', PeriodStart) - 1;
    //     CurrDate := PeriodStart;
    //     WorkingDays := 0;

    //     while CurrDate <= PeriodEnd do begin
    //         if DATE2DWY(CurrDate, 1) in [1 .. 5] then
    //             WorkingDays += 1;
    //         CurrDate += 1;
    //     end;

    //     if WorkingDays = 0 then
    //         WorkingDays := 22; // Fallback in case of error

    //     // Step 4: Calculate and return amount using dynamic rate
    //     exit((AdjustedHours / 8) * (TotalCost / WorkingDays));
    // end;







    // procedure CalcActualAmount(): Decimal
    // var
    //     ProposalTeamRec: Record "Proposal Team";
    //     ProjectCode: Code[20];
    // begin
    //     // Attempt to find a matching Proposal Team entry for the current record
    //     if ProposalTeamRec.Get("Proposal Team"."Employee No.", "Proposal Team"."Proposal No.") then begin
    //         ProjectCode := ProposalTeamRec."Proposal No.";

    //         if ProjectCode = 'CB0039' then
    //             exit((ProposalTeamRec."Allocation %" / 100) * TotalActualAmountN / 22 * (220 / 12))
    //         else
    //             exit(("Payroll Project Allocation".Hours / 8) * (TotalActualAmountN / 22));
    //     end else begin
    //         // Not in Proposal Team – fallback to hours-based calculation
    //         exit(("Payroll Project Allocation".Hours / 8) * (TotalActualAmountN / 22));
    //     end;
    // end;

    // procedure CalcActualAmount(): Decimal
    // var
    //     ProjectCode: Code[20];
    // begin
    //     ProjectCode := "Proposal Team"."Proposal No.";

    //     if ProjectCode = 'CB0039' then
    //         exit(("Proposal Team"."Allocation %" / 100) * TotalActualAmountN / 22 * (220 / 12))
    //     else
    //         // Return value even if not in Proposal Team, as long as hours exist
    //         exit(("Payroll Project Allocation".Hours / 8) * (TotalActualAmountN / 22));
    //          end else begin
    //     // Not in Proposal Team – fallback to hours-based calculation
    //     exit(("Payroll Project Allocation".Hours / 8) * (TotalActualAmountN / 22));
    // end;
    // end;




    local procedure GetProposalActualAmount(ProjectCode: Code[20]; EmpNo: Code[20]): Decimal
    var
        PT: Record "Proposal Team";
    begin
        if PT.Get(ProjectCode, EmpNo) then
            exit(PT."Actual Amount");
        exit(0);
    end;

    local procedure CalcLOE(HoursWorked: Decimal): Decimal
    begin
        if HoursWorked = 0 then
            exit(0);

        // Use 176 as standard monthly hours (22 days * 8 hours)
        exit(Round((HoursWorked / 176) * 100, 0.1));
    end;


    procedure CalcProjectActualAmount(): Decimal
    var
        PeriodTransMW: Record "Payroll Monthly Trans_Malawi";
        TotalAmount: Decimal;
        PeriodTrans: Record "Payroll Monthly Trans_AU";
    begin
        TotalAmount := 0;

        PeriodTrans.Reset();
        PeriodTrans.SetRange("Posting Type", PeriodTrans."Posting Type"::Debit);
        if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then
            PeriodTrans.SetRange(PeriodTrans."Payroll Period", StartDateFilter, EndDateFilter);

        if EmployeeNo <> '' then
            PeriodTrans.SetRange(PeriodTrans."No.", EmployeeNo);

        if PeriodTrans.Find('-') then
            repeat
                TotalAmount += PeriodTrans.Amount;
            until PeriodTrans.Next() = 0;

        exit(TotalAmount);
    end;







}
