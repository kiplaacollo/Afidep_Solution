
Report 80102 "Housing Levy Report_AU"
{
    RDLCLayout = './Layouts/Housing Levy Report_AU.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Employee_AU"; "Payroll Employee_AU")
        {
            DataItemTableView = where(Status = const(Active));

            column(No; "Payroll Employee_AU"."No.")
            {
            }
            column(Basic; "Payroll Employee_AU"."Basic Pay")
            {
            }
            column(Name; Name)
            {
            }
            column(Pic; CompanyInfo.Picture)
            {
            }
            column(Period; Period)
            {
            }
            column(Statutory; Statutory)
            {
            }
            column(EmployerPension; EmployerPension)
            {
            }
            column(EmployeePension; EmployeePension)
            {
            }
            column(TotalPension; TotalPension)
            {
            }
            column(BankName; BankName)
            {
            }
            column(BranchName; BranchName)
            {
            }
            column(AccountNo; AccountNo)
            {
            }
            column(BankCode; BankCode)
            {
            }
            column(BranchCode; BranchCode)
            {
            }
            column(CompanyName; CompanyInfo.Name) { }
            trigger OnPreDataItem();
            begin
                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
                TotEmployeePension := 0;
                TotEmployerPension := 0;
                UserSetup.Get(UserId);
                if UserSetup."View Payroll" = false then
                    Error('You do not have permissions to view the report');
            end;

            trigger OnAfterGetRecord();
            begin
                Name := "Payroll Employee_AU".Surname + ' ' + "Payroll Employee_AU".Firstname + ' ' + "Payroll Employee_AU".Lastname;
                EmployeePen := 0;
                EmployerPen := 0;
                PayrollEmployee.Reset();
                PayrollEmployee.SetRange("No.", "Payroll Employee_AU"."No.");
                if PayrollEmployee.Find('-') then begin
                    //  EmployeePen := PayrollEmployee."Pension %" / 100 * PayrollEmployee."Basic Pay";
                    //  EmployerPen := PayrollEmployee."Pension %-Employer" / 100 * PayrollEmployee."Basic Pay";
                end;
                EmployeePension := 0;
                EmployerPension := 0;
                TotEmployerPension := 0;
                TotEmployeePension := 0;
                PayrollMonthly.Reset;
                PayrollMonthly.SetRange(PayrollMonthly."No.", "Payroll Employee_AU"."No.");
                PayrollMonthly.SetRange(PayrollMonthly."Payroll Period", Period);
                PayrollMonthly.SetRange(PayrollMonthly."Transaction Code", 'HL');
                if PayrollMonthly.Find('-') then begin
                    EmployeePension := PayrollMonthly.Amount;
                    EmployerPension := PayrollMonthly.Amount;
                    TotEmployeePension := TotEmployeePension + EmployeePension;
                    TotEmployerPension := TotEmployerPension + EmployerPension;
                end;
                TotalPension := EmployeePension + EmployerPension;
                //Transaction Bank Details
                TransCodes.Reset;
                TransCodes.SetRange(TransCodes."Transaction Code", '2003');
                if TransCodes.Find('-') then begin
                    BankCode := TransCodes."Payable Bank Ac";
                    BankName := TransCodes."Bank Name";
                    BranchCode := TransCodes."Branch Code";
                    BranchName := TransCodes."Branch Name";
                    AccountNo := TransCodes."Account Number";
                end;
                //MESSAGE(FORMAT(TotalPension));
                /*EmployeePensionP:=0;
				EmployerPensionP:=0;
				PayrollMonthly.RESET;
				PayrollMonthly.SETRANGE(PayrollMonthly."No.","Payroll Employee"."No.");
				PayrollMonthly.SETRANGE(PayrollMonthly."Payroll Period",Period);
				PayrollMonthly.SETRANGE(PayrollMonthly."Transaction Code",'2003');
				IF PayrollMonthly.FIND('-') THEN BEGIN
				  REPEAT
					  EmployeePensionP:=PayrollMonthly.Amount;
					  EmployerPensionP:=(EmployeePensionP*2);
					TotalPension:=TotalPension+EmployeePensionP+EmployerPensionP;
				  UNTIL PayrollMonthly.NEXT=0;
				END;
				*/
                if EmployeePension = 0 then CurrReport.Skip;

            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field(Period; Period)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period';
                    TableRelation = "Payroll Calender_AU"."Date Opened";
                }
                // field(ForNavOpenDesigner;ReportForNavOpenDesigner)
                // {
                // 	ApplicationArea = Basic;
                // 	Caption = 'Design';
                // 	Visible = ReportForNavAllowDesign;
                // 		trigger OnValidate()
                // 		begin
                // 			ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
                // 			CurrReport.RequestOptionsPage.Close();
                // 		end;

                // }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            //ReportForNavOpenDesigner := false;
        end;
    }

    trigger OnInitReport()
    begin
        TotalPension := 0;
        //;ReportsForNavInit;

    end;

    trigger OnPostReport()
    begin
        //;ReportForNav.Post;
    end;

    trigger OnPreReport()
    begin
        //;ReportsForNavPre;
    end;

    var
        Period: Date;
        Statutory: Decimal;
        Deductions: Decimal;
        Benefits: Decimal;
        TDeductions: Decimal;
        Netpay: Decimal;
        TransCodes: Record "Payroll Transaction Code_AU";
        Name: Text;
        CompanyInfo: Record "Company Information";
        NSSF: Decimal;
        NHIF: Decimal;
        PAYE: Decimal;
        EmployeePension: Decimal;
        PayrollMonthly: Record "Payroll Monthly Trans_AU";
        EmployerPension: Decimal;
        TotEmployeePension: Decimal;
        TotEmployerPension: Decimal;
        TotalPension: Decimal;
        EmployeePensionP: Decimal;
        EmployerPensionP: Decimal;
        BankName: Text;
        BranchName: Text;
        AccountNo: Text;
        BankCode: Code[200];
        BranchCode: Code[200];
        UserSetup: Record "User Setup";
        PayrollEmployee: Record "Payroll Employee_AU";
        EmployeePen: Decimal;
        EmployerPen: Decimal;


}
