Codeunit 80014 "Upadate P10"
{

    trigger OnRun()
    begin

    end;

    var
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
        P10: Record "P10";
        P102: Record P10;

    procedure UpdateP10(No: Code[50])
    begin

        PayrollMonthlyTrans_AU.RESET;
        PayrollMonthlyTrans_AU.SETCURRENTKEY("No.");
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."No.", No);
        IF PayrollMonthlyTrans_AU.FINDSET THEN BEGIN
            REPEAT

                P10.RESET;
                P10.SETRANGE(P10."Employee No", PayrollMonthlyTrans_AU."No.");
                P10.SETRANGE(P10."Payroll Preriod", PayrollMonthlyTrans_AU."Payroll Period");
                IF NOT P10.FIND('-') THEN BEGIN
                    P10.INIT;
                    P10."Employee No" := PayrollMonthlyTrans_AU."No.";
                    P10."Payroll Preriod" := PayrollMonthlyTrans_AU."Payroll Period";
                    P10."Payroll Month" := PayrollMonthlyTrans_AU."Period Month";
                    P10."Payroll Year" := PayrollMonthlyTrans_AU."Period Year";

                    IF PayrollMonthlyTrans_AU."Transaction Code" = 'NSSF' THEN
                        P10.NSSF := PayrollMonthlyTrans_AU.Amount;


                    IF PayrollMonthlyTrans_AU."Transaction Code" = 'E003' THEN BEGIN
                        P10."House Allowance" := PayrollMonthlyTrans_AU.Amount;
                    END;
                    IF PayrollMonthlyTrans_AU."Transaction Code" = 'D009' THEN BEGIN
                        P10."Pension Cotribution" := PayrollMonthlyTrans_AU.Amount;
                    END;
                    IF PayrollMonthlyTrans_AU."Transaction Code" = 'PAYE' THEN BEGIN
                        P10.PAYE := PayrollMonthlyTrans_AU.Amount;
                    END;
                    P10.INSERT(TRUE);
                END;

            UNTIL PayrollMonthlyTrans_AU.NEXT = 0;
        END;
    end;

    Procedure PopulateP10(EmployeeNo: Code[20]; Period: Date)
    BEGIN
        PayrollMonthlyTrans_AU.RESET;
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."No.", EmployeeNo);
        PayrollMonthlyTrans_AU.SETFILTER(PayrollMonthlyTrans_AU."Transaction Code", '%1', 'BPAY');
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."Payroll Period", Period);
        IF PayrollMonthlyTrans_AU.FIND('-') THEN BEGIN
            REPEAT
                P10."Basic Salary" := PayrollMonthlyTrans_AU.Amount;
                P10.MODIFY(true);

            UNTIL PayrollMonthlyTrans_AU.NEXT = 0;
        END;
        PayrollMonthlyTrans_AU.RESET;
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."No.", EmployeeNo);
        PayrollMonthlyTrans_AU.SETFILTER(PayrollMonthlyTrans_AU."Transaction Code", '%1', 'PAYE');
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."Payroll Period", Period);
        IF PayrollMonthlyTrans_AU.FINDSET() THEN BEGIN
            REPEAT
                P10.PAYE := PayrollMonthlyTrans_AU.Amount;
                P10.MODIFY;
            UNTIL PayrollMonthlyTrans_AU.NEXT = 0;
        END;
        PayrollMonthlyTrans_AU.RESET;
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."No.", EmployeeNo);
        PayrollMonthlyTrans_AU.SETFILTER(PayrollMonthlyTrans_AU."Transaction Code", '%1', 'NSSF');
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."Payroll Period", Period);
        IF PayrollMonthlyTrans_AU.FINDSET() THEN BEGIN
            REPEAT
                P10.NSSF := PayrollMonthlyTrans_AU.Amount;
                P10.MODIFY;

            UNTIL PayrollMonthlyTrans_AU.NEXT = 0;
        END;

        PayrollMonthlyTrans_AU.RESET;
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."No.", EmployeeNo);
        PayrollMonthlyTrans_AU.SETFILTER(PayrollMonthlyTrans_AU."Transaction Code", '%1|%2|%3', 'PENSION', 'PENSION VC', 'BRITAM PEN');
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."Payroll Period", Period);
        IF PayrollMonthlyTrans_AU.FINDSET(TRUE, TRUE) THEN BEGIN
            //REPEAT
            PayrollMonthlyTrans_AU.CALCSUMS(Amount);
            P10."Pension Cotribution" := PayrollMonthlyTrans_AU.Amount;
            P10.MODIFY;

            //UNTIL PayrollMonthlyTrans_AU.NEXT = 0 ;
        END;

        PayrollMonthlyTrans_AU.RESET;
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."No.", EmployeeNo);
        PayrollMonthlyTrans_AU.SETFILTER(PayrollMonthlyTrans_AU."Transaction Code", '%1', 'HOUSE');
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."Payroll Period", Period);
        IF PayrollMonthlyTrans_AU.FINDSET() THEN BEGIN
            REPEAT
                P10."House Allowance" := PayrollMonthlyTrans_AU.Amount;
                P10.MODIFY;

            UNTIL PayrollMonthlyTrans_AU.NEXT = 0;
        END;

        PayrollMonthlyTrans_AU.RESET;
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."No.", EmployeeNo);
        PayrollMonthlyTrans_AU.SETFILTER(PayrollMonthlyTrans_AU."Transaction Code", '%1', 'COMMUTER');
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."Payroll Period", Period);
        IF PayrollMonthlyTrans_AU.FINDSET() THEN BEGIN
            REPEAT
                P10."Transport Alloawance" := PayrollMonthlyTrans_AU.Amount;
                P10.MODIFY;

            UNTIL PayrollMonthlyTrans_AU.NEXT = 0;
        END;

        PayrollMonthlyTrans_AU.RESET;
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."No.", EmployeeNo);
        PayrollMonthlyTrans_AU.SETFILTER(PayrollMonthlyTrans_AU."Transaction Code", '%1', 'INSRLF');
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."Payroll Period", Period);
        IF PayrollMonthlyTrans_AU.FINDSET(TRUE, TRUE) THEN BEGIN
            REPEAT
                P10."Insurance Relief" := PayrollMonthlyTrans_AU.Amount;
                P10.MODIFY;

            UNTIL PayrollMonthlyTrans_AU.NEXT = 0;
        END;
        PayrollMonthlyTrans_AU.RESET;
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."No.", EmployeeNo);
        PayrollMonthlyTrans_AU.SETFILTER(PayrollMonthlyTrans_AU."Transaction Code", '%1', 'E016');
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."Payroll Period", Period);
        IF PayrollMonthlyTrans_AU.FINDSET(TRUE, TRUE) THEN BEGIN
            REPEAT
                P10.OverTimeAllowance := PayrollMonthlyTrans_AU.Amount;
                P10.MODIFY;

            UNTIL PayrollMonthlyTrans_AU.NEXT = 0;
        END;

        PayrollMonthlyTrans_AU.RESET;
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."No.", EmployeeNo);
        PayrollMonthlyTrans_AU.SETFILTER(PayrollMonthlyTrans_AU."Transaction Code", '%1', 'PSNR');
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."Payroll Period", Period);
        IF PayrollMonthlyTrans_AU.FINDSET(TRUE, TRUE) THEN BEGIN
            REPEAT
                P10."Personal Relief" := PayrollMonthlyTrans_AU.Amount;
                P10.MODIFY;

            UNTIL PayrollMonthlyTrans_AU.NEXT = 0;
        END;

        PayrollMonthlyTrans_AU.RESET;
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."No.", EmployeeNo);
        PayrollMonthlyTrans_AU.SETFILTER(PayrollMonthlyTrans_AU."Transaction Code", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10', 'BENEFIT', 'ACTING', 'E005', 'E006', 'E007', 'E008', 'E009', 'E011', 'E012', 'E014');
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."Payroll Period", Period);
        IF PayrollMonthlyTrans_AU.FINDSET(TRUE) THEN BEGIN

            PayrollMonthlyTrans_AU.CALCSUMS(Amount);
            P10."Other Allowance" := 0;
            ;
            P10.MODIFY;


        END;
        PayrollMonthlyTrans_AU.RESET;
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."No.", EmployeeNo);
        PayrollMonthlyTrans_AU.SETFILTER(PayrollMonthlyTrans_AU."Transaction Code", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10', 'BENEFIT', 'ACTING', 'E005', 'E006', 'E007', 'E008', 'E009', 'E011', 'E012', 'E014');
        PayrollMonthlyTrans_AU.SETRANGE(PayrollMonthlyTrans_AU."Payroll Period", Period);
        IF PayrollMonthlyTrans_AU.FINDSET() THEN BEGIN
            // REPEAt
            PayrollMonthlyTrans_AU.CALCSUMS(Amount);
            P10."Other Allowance" := PayrollMonthlyTrans_AU.Amount;
            P10.MODIFY;

            // UNTIL PayrollMonthlyTrans_AU.NEXT = 0 ;
        END;
    end;
    //
}

