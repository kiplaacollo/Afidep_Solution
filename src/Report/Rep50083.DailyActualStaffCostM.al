report 50083 "Daily Actual Staff Cost M"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Layouts/DailyStaffCostM.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Monthly Trans_Malawi"; "Payroll Monthly Trans_Malawi")
        {

            DataItemTableView = SORTING("No.");
            column(No_M; "No.") { }
            column(BasicPayM; BasicPayM) { }
            column(Grouplf; Grouplf) { }
            column(VATFee; VATFee) { }
            column(AdmPension; AdmPension) { }
            column(PensionM; PensionM) { }
            column(Medic; Medic) { }
            column(Edu; Edu) { }
            column(Responsibility; Responsibility) { }
            column(TotalM; TotalM) { }
            column(WorkingDays; WorkingDays) { }


            trigger OnAfterGetRecord()
            begin
                begin
                    BasicPayM := 0;
                    Grouplf := 0;
                    PensionM := 0;
                    VATFee := 0;
                    AdmPension := 0;
                    Medic := 0;
                    Edu := 0;
                    Responsibility := 0;
                    TotalM := 0;


                    // Filter payroll transactions by employee and date
                    PeriodTransMW.Reset();
                    PeriodTransMW.SetRange(PeriodTransMW."No.", "Payroll Monthly Trans_Malawi"."No."); // Replace with the actual field from your DataItem
                    PeriodTransMW.SetRange(PeriodTransMW."Payroll Period", PeriodFilter);

                    if PeriodTransMW.Find('-') then begin
                        repeat
                            case PeriodTransMW."Transaction Code" of
                                'BPAY':
                                    begin
                                        BasicPayM := PeriodTransMW."Amount(LCY)";
                                    end;
                                'E012':
                                    begin
                                        Medic := PeriodTransMW."Amount(LCY)";
                                    end;
                                'E002':
                                    begin
                                        Edu := PeriodTransMW."Amount(LCY)";
                                    end;
                                'E001':
                                    begin
                                        Responsibility := PeriodTransMW."Amount(LCY)";
                                    end;
                            // 'VAT-ADM-PENSION':
                            //     begin
                            //         VATFee := PeriodTransMW."Amount(LCY)";
                            //     end;
                            // 'GROUPLIFE':
                            //     begin
                            //         Grouplf := PeriodTransMW."Amount(LCY)";
                            //     end;
                            // 'ADM-PENSION':
                            //     begin
                            //         AdmPension := PeriodTransMW."Amount(LCY)";
                            //     end;
                            // Pension from employee table if needed
                            end;
                            if PeriodTransMW."Transaction Code" = 'BPAY' then begin
                                objEmp.Reset();
                                objEmp.SetRange(objEmp."No.", "No.");
                                // objEmp.SetFilter(objEmp."No.", '<>%1', 'EMP229');
                                if objEmp.Find('-') then begin

                                    PensionM := objEmp."Pension %-Employer" / 100 * PeriodTransMW."Amount(LCY)";

                                    Grouplf := objEmp."Group Life Assuarance" / 100 * PeriodTransMW."Amount(LCY)";
                                    //  Message('Pension :%1', EmployerPension);
                                    if (PeriodTransMW."Transaction Code" = 'BPAY') and (objEmp."Pension %-Employer" <> 0) then begin


                                        AdmPension := objEmp."Pension Administrative Fee" / 100 * PeriodTransMW."Amount(LCY)";
                                        //  Message('Pension :%1', EmployerPension);

                                        VATFee := objEmp."VAT Administrative Fee" / 100 * AdmPension;


                                    end;

                                end;
                            end;
                        until PeriodTransMW.Next() = 0;
                    end;

                    // Pension % from employee table (Employer's contribution)


                    TotalM := BasicPayM + PensionM + Grouplf + AdmPension + VATFee + Medic + Edu + Responsibility;

                    if BasicPayM <= 0 then
                        CurrReport.Skip;
                end;

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
        objEmp: Record "Payroll Employee_AU";
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
        AdmPension: Decimal;
        VATFee: Decimal;
        Grouplf: Decimal;
        PensionM: Decimal;
        BasicPayM: Decimal;
        TotalM: Decimal;
        Medic: Decimal;
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
