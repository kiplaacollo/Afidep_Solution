report 50082 "Daily Actual Staff Cost"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Layouts/DailyStaffCost.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Monthly Trans_AU"; "Payroll Monthly Trans_AU")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Payroll Period";
            column(No_; "No.") { }
            column(Payroll_Period; "Payroll Period") { }
            column(BasicPay; BasicPay) { }
            column(Pension; Pension) { }
            column(NITA; NITA) { }
            column(HL; HL) { }
            column(SHIF; SHIF) { }
            column(NSSF; NSSF) { }
            column(Edu; Edu) { }
            column(Milage; Milage) { }
            column(Responsibility; Responsibility) { }
            column(ExcessPens; ExcessPens) { }
            column(MedicalInsu; MedicalInsu) { }
            column(LifeAss; LifeAss) { }
            column(WibaIns; WibaIns) { }
            column(TravelIns; TravelIns) { }
            column(WorkingDays; WorkingDays) { }
            column(Total; Total) { }

            trigger OnPreDataItem()


            begin
                // PeriodFilter := "Payroll Monthly Trans_AU"."Payroll Period";
                objPeriod.Reset();
                objPeriod.SetRange(objPeriod."Date Opened", PeriodFilter);
                if objPeriod.Find('-') then begin
                    //  "Slip/Receipt No" := UpperCase(objPeriod."Period Name");
                    Currenc := Round(objPeriod."Currency Code", 0.01, '=');
                end;

            end;

            trigger OnAfterGetRecord()
            var

            begin
                BasicPay := 0;
                Allowances := 0;
                Pension := 0;
                NSSF := 0;
                NITA := 0;
                Total := 0;
                HL := 0;
                SHIF := 0;
                Edu := 0;
                Milage := 0;
                Responsibility := 0;
                MedicalInsu := 0;
                LifeAss := 0;
                TravelIns := 0;
                WibaIns := 0;

                // Filter payroll transactions by employee and date
                PeriodTrans.Reset();
                PeriodTrans.SetRange("No.", "No."); // Replace with the actual field from your DataItem
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", PeriodFilter);

                if PeriodTrans.Find('-') then begin
                    repeat
                        case PeriodTrans."Transaction Code" of
                            'BPAY':
                                begin
                                    BasicPay := PeriodTrans."Amount(LCY)";
                                end;
                            'ALLW':
                                begin
                                    Allowances := PeriodTrans."Amount(LCY)";
                                end;
                            'NSSF':
                                begin
                                    NSSF := PeriodTrans.Amount / Currenc;
                                    ;
                                end;
                            'HL':
                                begin
                                    HL := PeriodTrans.Amount / Currenc;
                                end;
                            'E002':
                                begin
                                    Edu := PeriodTrans."Amount(LCY)";
                                end;
                            'E006':
                                begin
                                    Milage := PeriodTrans."Amount(LCY)";
                                end;
                            'E001':
                                begin
                                    Responsibility := PeriodTrans."Amount(LCY)";
                                end;
                            'E012':
                                begin
                                    MedicalInsu := PeriodTrans."Amount(LCY)";
                                end;
                            'E013':
                                begin
                                    LifeAss := PeriodTrans."Amount(LCY)";
                                end;
                            'E014':
                                begin
                                    WibaIns := PeriodTrans."Amount(LCY)";
                                end;
                            'E015':
                                begin
                                    TravelIns := PeriodTrans."Amount(LCY)";
                                end;
                        // Pension from employee table if needed
                        end;
                    until PeriodTrans.Next() = 0;
                end;

                // Pension % from employee table (Employer's contribution)
                EmpRec.Reset();
                EmpRec.SetRange("No.", "No.");
                if EmpRec.FindFirst() then begin
                    Pension := (EmpRec."Pension %-Employer" / 100) * BasicPay;
                end;
                SHIF := BasicPay * 0.0275;

                NITA := 50 / Currenc;

                Total := BasicPay + Allowances + Pension + NSSF + NITA + HL + SHIF + Edu + Milage + Responsibility + MedicalInsu + TravelIns + LifeAss + WibaIns;

                if BasicPay <= 0 then
                    CurrReport.Skip;


                WorkingDays := GetWorkingDays(PeriodFilter);
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Filter")
                {
                    field(PeriodFilter; PeriodFilter)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions { }
    }



    trigger OnPreReport()
    begin
        // You could preprocess anything if needed

    end;

    var

        PeriodFilter: Date;
        objPeriod: Record "Payroll Calender_AU";
        Currenc: Decimal;
        PeriodTrans: Record "Payroll Monthly Trans_AU";
        EmpRec: Record "Payroll Employee_AU";
        BasicPay: Decimal;
        Allowances: Decimal;
        Pension: Decimal;
        NSSF: Decimal;
        NITA: Decimal;
        Total: Decimal;
        HL: Decimal;
        SHIF: Decimal;
        Edu: Decimal;
        Milage: Decimal;
        Responsibility: Decimal;
        ExcessPens: Decimal;
        PeriodTransMW: Record "Payroll Monthly Trans_Malawi";
        MedicalInsu: Decimal;
        LifeAss: Decimal;
        TravelIns: Decimal;
        WibaIns: Decimal;
        BasicPayM: Decimal;
        TotalM: Decimal;
        WorkingDays: Decimal;

    procedure GetWorkingDays(Period: Date): Integer
    var
        PeriodStart: Date;
        PeriodEnd: Date;
        CurrDate: Date;
        WorkingDays: Integer;
    begin
        PeriodStart := DMY2Date(1, Date2DMY(Period, 2), Date2DMY(Period, 3));
        PeriodEnd := CALCDATE('<CM>', PeriodStart);
        CurrDate := PeriodStart;

        while CurrDate <= PeriodEnd do begin
            if DATE2DWY(CurrDate, 1) in [1 .. 5] then
                WorkingDays += 1;
            CurrDate += 1;
        end;

        if WorkingDays = 0 then
            WorkingDays := 22;

        exit(WorkingDays);
    end;

}
