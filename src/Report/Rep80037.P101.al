report 80037 "P10"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/Payroll P10_Au.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Employee_AU"; "Payroll Employee_AU")
        {

            RequestFilterFields = "No.";
            column(No; "No.")
            {

            }
            column(JoiningDate_PayrollEmployeeAU; "Payroll Employee_AU"."Joining Date")
            {

            }
            column(Bank_Code; "Payroll Employee_AU"."Bank Code")
            {

            }
            column(BankCode_PayrollEmployeeAU; "Payroll Employee_AU"."Bank Code")
            {

            }
            column(Surname; Surname)
            {

            }
            column(Firstname; Firstname)
            {

            }
            column(Lastname; Lastname)
            {

            }
            column(Full_Name; "Payroll Employee_AU"."Full Name")
            {

            }
            column(CName; CompanyInfo.Name)
            {

            }
            column(CAddress; CompanyInfo.Address)
            {

            }
            column(CPic; CompanyInfo.Picture)
            {

            }
            column(PeriodName; PeriodName)
            {

            }
            column(PinNo2; PinNo)
            {

            }
            column(NSSF_No; "NSSF No")
            {

            }
            column(NHIF_No; "NHIF No")
            {

            }
            column(PinNo; "Payroll Employee_AU"."PIN No")
            {

            }
            column(BankAccNo; "Bank Account No")
            {

            }
            column(NoOfYearsServed; NoOfYearsServed)
            {

            }
            column(BankName; "Bank Name")
            {

            }
            column(BranchName; "Branch Name")
            {

            }
            dataitem(P10R; P10)
            {
                DataItemLink = "Employee No" = FIELD("No.");
                RequestFilterFields = "payroll Preriod";
                column(EmployeeNo_P10R; P10R."Employee No")
                {

                }
                column(BasicSalary_P10R; P10R."Basic Salary")
                {

                }
                column(HouseAllowance_P10R; P10R."House Allowance")
                {

                }
                column(TransportAlloawance_P10R; P10R."Transport Alloawance")
                {

                }
                column(LeaveAllowance_P10R; P10R."Leave Allowance")
                {

                }
                column(OtherAllowance_P10R; P10R."Other Allowance")
                {

                }
                column(PensionCotribution_P10R; P10R."Pension Cotribution")
                {

                }
                column(PAYE_P10R; P10R.PAYE)
                {

                }
                column(NSSF_P10R; P10R.NSSF)
                {

                }
                column(PayrollPreriod_P10R; P10R."payroll Preriod")
                {

                }
                column(PayrollYear_P10R; P10R."Payroll Month")
                {

                }
                column(PayrollMonth_P10R; P10R."Payroll Month")
                {

                }
                column(OverTimeAllowance_P10R; P10R.OverTimeAllowance)
                {

                }
                column(InsuranceRelief_P10R; P10R."Insurance Relief")
                {

                }
                column(PersonalRelief_P10R; P10R."Personal Relief")
                {

                }
                column(Text; Text)
                {

                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Text := 0;


                    //PopulateP10;
                    P10.RESET;
                    P10.SETRANGE(P10."Payroll Preriod", PayrollPeriod);
                    P10.SETRANGE(P10."Employee No", P10R."Employee No");
                    IF P10.FIND('-') THEN BEGIN
                        // UpdateP10.PopulateP10(P10."Employee No", P10."Payroll Preriod");

                    END;
                end;

                trigger OnPostDataItem()
                var

                begin



                end;

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                //  UpdateP10.UpdateP10("Payroll Employee_AU"."No.");
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                //  DeleteFunction();
            end;



        }


    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Period)
                {
                    field(PayrollPeriod; PayrollPeriod)
                    {
                        Caption = 'Payroll Period';
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
    end;




    var
        CompanyInfo: Record "Company Information";
        PayrollCalender: Record "Payroll Calender_AU";
        "Payroll Period": Date;
        PeriodName: Text;
        PayrollEmp: Record "Payroll Employee_AU";
        UserSetup: Record "User Setup";
        periodfIlter: Date;
        NoOfYearsServed: Text;
        HREmployees: Record "HR Employees";
        PinNo: Code[10];
        PayrollMonthlyTrans_AU: Record "Payroll Monthly Trans_AU";
        NssfEmploer: Decimal;
        PensionEmployer: Decimal;
        PayrollEmployerDeductions_AU: Record "Payroll Employer Deductions_AU";
        PayrollEmployee_AU: Record "Payroll Employee_AU";
        P10: Record P10;
        P102: Record P10;
        Text: Decimal;
        UpdateP10: Codeunit "Upadate P10";
        PayrollPeriod: Date;

    // LOCAL procedure LeapYear(Year: Integer) LY: Boolean
    // begin
    //     // CenturyYear := Year MOD 100 = 0;
    //     // DivByFour := Year MOD 4 = 0;
    //     // IF ((NOT CenturyYear AND DivByFour) OR (Year MOD 400 = 0)) THEN
    //     //     LY := TRUE
    //     // ELSE
    //     //     LY := FALSE;
    // end;

    // LOCAL procedure DetermineDaysInMonth(Month: Integer; Year: Integer) DaysInMonth: Integer
    // begin
    //     CASE (Month) OF
    //         1:
    //             DaysInMonth := 31;
    //         2:
    //             BEGIN
    //                 IF (LeapYear(Year)) THEN
    //                     DaysInMonth := 29
    //                 ELSE
    //                     DaysInMonth := 28;
    //             END;
    //         3:
    //             DaysInMonth := 31;
    //         4:
    //             DaysInMonth := 30;
    //         5:
    //             DaysInMonth := 31;
    //         6:
    //             DaysInMonth := 30;
    //         7:
    //             DaysInMonth := 31;
    //         8:
    //             DaysInMonth := 31;
    //         9:
    //             DaysInMonth := 30;
    //         10:
    //             DaysInMonth := 31;
    //         11:
    //             DaysInMonth := 30;
    //         12:
    //             DaysInMonth := 31;
    //         ELSE
    //             MESSAGE('Not valid date. The month must be between 1 and 12');
    //     END;

    //     EXIT;
    // end;


    procedure DetermineAge(DateOfBirth: Date; DateOfJoin: Date) AgeString: Text[45]
    var
        dayB: Integer;
        monthB: Integer;
        yearB: Integer;
        dayJ: Integer;
        monthJ: Integer;
        yearJ: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        monthsToBirth: Integer;
        D: Date;
        DateCat: Integer;
    begin


        IF ((DateOfBirth <> 0D) AND (DateOfJoin <> 0D)) THEN BEGIN
            dayB := DATE2DMY(DateOfBirth, 1);
            monthB := DATE2DMY(DateOfBirth, 2);
            yearB := DATE2DMY(DateOfBirth, 3);
            dayJ := DATE2DMY(DateOfJoin, 1);
            monthJ := DATE2DMY(DateOfJoin, 2);
            yearJ := DATE2DMY(DateOfJoin, 3);
            Day := 0;
            Month := 0;
            Year := 0;
            DateCat := DateCategory(dayB, dayJ, monthB, monthJ, yearB, yearJ);
            CASE (DateCat) OF
                1:
                    BEGIN
                        Year := yearJ - yearB;
                        IF monthJ >= monthB THEN
                            Month := monthJ - monthB
                        ELSE BEGIN
                            Month := (monthJ + 12) - monthB;
                            Year := Year - 1;
                        END;

                        IF (dayJ >= dayB) THEN
                            Day := dayJ - dayB
                        ELSE
                            IF (dayJ < dayB) THEN BEGIN
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                Month := Month - 1;
                            END;

                        AgeString := '%1  Years, %2  Months and #3## Days';
                        AgeString := STRSUBSTNO(AgeString, Year, Month, Day);

                    END;

                2, 3, 7:
                    BEGIN
                        IF (monthJ <> monthB) THEN BEGIN
                            IF monthJ >= monthB THEN
                                Month := monthJ - monthB
                            //  ELSE ERROR('The wrong date category!');
                        END;

                        IF (dayJ <> dayB) THEN BEGIN
                            IF (dayJ >= dayB) THEN
                                Day := dayJ - dayB
                            ELSE
                                IF (dayJ < dayB) THEN BEGIN
                                    Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                    Month := Month - 1;
                                END;
                        END;

                        AgeString := '%1  Months %2 Days';
                        AgeString := STRSUBSTNO(AgeString, Month, Day);
                    END;
                4:
                    BEGIN
                        Year := yearJ - yearB;
                        AgeString := '#1## Years';
                        AgeString := STRSUBSTNO(AgeString, Year);
                    END;
                5:
                    BEGIN
                        IF (dayJ >= dayB) THEN
                            Day := dayJ - dayB
                        ELSE
                            IF (dayJ < dayB) THEN BEGIN
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                monthJ := monthJ - 1;
                                Month := (monthJ + 12) - monthB;
                                yearJ := yearJ - 1;
                            END;

                        Year := yearJ - yearB;
                        AgeString := '%1  Years, %2 Months and #3## Days';
                        AgeString := STRSUBSTNO(AgeString, Year, Month, Day);
                    END;
                6:
                    BEGIN
                        IF monthJ >= monthB THEN
                            Month := monthJ - monthB
                        ELSE BEGIN
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        END;
                        Year := yearJ - yearB;
                        AgeString := '%1  Years and #2## Months';
                        AgeString := STRSUBSTNO(AgeString, Year, Month);
                    END;
                ELSE
                    AgeString := '';
            END;
        END ELSE
            MESSAGE('For Date Calculation Enter All Applicable Dates!');
        EXIT;
    end;

    procedure DateCategory(BDay: Integer; EDay: Integer; BMonth: Integer; EMonth: Integer; BYear: Integer; EYear: Integer) Category: Integer
    var

    begin
        IF ((EYear > BYear) AND (EMonth <> BMonth) AND (EDay <> BDay)) THEN
            Category := 1
        ELSE
            IF ((EYear = BYear) AND (EMonth <> BMonth) AND (EDay = BDay)) THEN
                Category := 2
            ELSE
                IF ((EYear = BYear) AND (EMonth = BMonth) AND (EDay <> BDay)) THEN
                    Category := 3
                ELSE
                    IF ((EYear > BYear) AND (EMonth = BMonth) AND (EDay = BDay)) THEN
                        Category := 4
                    ELSE
                        IF ((EYear > BYear) AND (EMonth = BMonth) AND (EDay <> BDay)) THEN
                            Category := 5
                        ELSE
                            IF ((EYear > BYear) AND (EMonth <> BMonth) AND (EDay = BDay)) THEN
                                Category := 6
                            ELSE
                                IF ((EYear = BYear) AND (EMonth <> BMonth) AND (EDay <> BDay)) THEN
                                    Category := 7
                                ELSE
                                    IF ((EYear = BYear) AND (EMonth = BMonth) AND (EDay = BDay)) THEN
                                        Category := 3
                                    ELSE
                                        IF ((EYear < BYear)) THEN
                                            //ERROR(TEXTDATE1)
                                            //ELSE BEGIN
                                            Category := 0;
        //ERROR('The start date cannot be after the end date.');
        //END;
        EXIT;
    end;

    procedure DetermineDaysInMonth(Month: Integer; Year: Integer) DaysInMonth: Integer
    begin
        CASE (Month) OF
            1:
                DaysInMonth := 31;
            2:
                BEGIN
                    IF (LeapYear(Year)) THEN
                        DaysInMonth := 29
                    ELSE
                        DaysInMonth := 28;
                END;
            3:
                DaysInMonth := 31;
            4:
                DaysInMonth := 30;
            5:
                DaysInMonth := 31;
            6:
                DaysInMonth := 30;
            7:
                DaysInMonth := 31;
            8:
                DaysInMonth := 31;
            9:
                DaysInMonth := 30;
            10:
                DaysInMonth := 31;
            11:
                DaysInMonth := 30;
            12:
                DaysInMonth := 31;
            ELSE
                MESSAGE('Not valid date. The month must be between 1 and 12');
        END;


        EXIT;
    end;

    procedure LeapYear(Year: Integer) LY: Boolean
    var
        CenturyYear: Boolean;
        DivByFour: Boolean;
    begin
        CenturyYear := Year MOD 100 = 0;
        DivByFour := Year MOD 4 = 0;
        IF ((NOT CenturyYear AND DivByFour) OR (Year MOD 400 = 0)) THEN
            LY := TRUE
        ELSE
            LY := FALSE;
    end;

    LOCAL procedure DeleteFunction()
    begin
        P10.RESET;
        IF P10.FIND('-') THEN BEGIN
            P10.DELETEALL;
        END;
    end;

}