Page 80007 "Payroll Employee Card_AU"
{
    DeleteAllowed = false;
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
                field(Photo; Rec.Photo)
                {
                    ApplicationArea = Basic;
                }
                field("Joining Date"; Rec."Joining Date")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;

                    Caption = 'Employee Currency Code';

                }
                field("Currency Factor"; Rec."Currency Factor") { ApplicationArea = all; }
                field("Global Dimension 1"; Rec."Global Dimension 1")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        Taxvisible := false;
                        if Rec."Global Dimension 1" = 'KENYA' THEN begin
                            Taxvisible := true
                        end ELSE begin
                            Taxvisible := false;
                        end;

                    end;
                }
                field("Global Dimension 2"; Rec."Global Dimension 2")
                {
                    ApplicationArea = Basic;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Caption = 'Department Code';
                    ApplicationArea = Basic;
                    NotBlank = true;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = Basic;
                }
                field("ID No/Passport No"; Rec."ID No/Passport No")
                {
                    ApplicationArea = Basic;
                }
                field("PIN No"; Rec."PIN No")
                {
                    ApplicationArea = Basic;
                }

            }
            group("Pay Details")
            {
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = Basic;

                }
                field("Basic Pay(LCY)"; Rec."Basic Pay(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Non Taxable"; Rec."Non Taxable")
                {
                    ApplicationArea = Basic;
                }
                field("Non Taxable(LCY)"; Rec."Non Taxable(LCY)")
                {
                    ApplicationArea = Basic;
                }
                group(Tax)
                {
                    Visible = Taxvisible;
                    field("Pays PAYE"; Rec."Pays PAYE")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Pays PAYE';

                    }
                    field("Pays NHIF"; Rec."Pays NHIF")
                    {
                        ApplicationArea = basic;

                    }
                    field("Pays NSSF"; Rec."Pays NSSF")
                    {
                        ApplicationArea = all;

                    }
                    field("NHIF No"; Rec."NHIF No") { }
                    field("NSSF No"; Rec."NSSF No") { }
                    field(Secondary; Rec.Secondary) { }
                }

                field("Suspend Pay"; Rec."Suspend Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Suspend Date"; Rec."Suspend Date")
                {
                    ApplicationArea = Basic;
                }
                field("Suspend Reason"; Rec."Suspend Reason")
                {
                    ApplicationArea = Basic;
                }
                field("Hourly Rate"; Rec."Hourly Rate")
                {
                    ApplicationArea = Basic;
                }
                field(Gratuity; Rec.Gratuity)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Gratuity Percentage"; Rec."Gratuity Percentage")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Gratuity Provision"; Rec."Gratuity Provision")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Gratuity Provision(LCY)"; Rec."Gratuity Provision(LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Days Absent"; Rec."Days Absent")
                {
                    ApplicationArea = Basic;
                }
                field("Paid per Hour"; Rec."Paid per Hour")
                {
                    ApplicationArea = Basic;
                }
                field("Do not prorate Again"; Rec."Do not prorate Again")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Relief"; Rec."Insurance Relief")
                {
                    ApplicationArea = Basic;

                }
                field("Include Insurance deduction"; Rec."Include Insurance deduction")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Mortgage Relief"; Rec."Mortgage Relief")
                {
                    ApplicationArea = Basic;

                }
                field("Personal Relief AMount"; Rec."Personal Relief AMount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Pension %-Employee"; Rec."Pension %-Employee")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        //if PayrollEmployee.Get("No.") then
                        // Paytrans.Reset();
                        // Paytrans.SetRange(Paytrans."No.", Rec."No.");
                        // if Paytrans.Find('-') then
                        //     Paytrans.Amount := (Rec."Pension %-Employee" / 100 * Rec."Basic Pay");
                        // Paytrans."Amount(LCY)" := (Rec."Pension %-Employee" / 100 * Rec."Basic Pay(LCY)");
                        // Paytrans.Modify;
                    end;

                }
                field("Pension %-Employer"; Rec."Pension %-Employer")
                {
                    ApplicationArea = Basic;

                }
                field(Premium; Rec.Premium)
                {

                }
                field("Premium %"; Rec."Premium %")
                {

                }
                field("Pension Administrative Fee"; Rec."Pension Administrative Fee")
                {

                }
                field("Group Life Assuarance"; Rec."Group Life Assuarance")
                {

                }
                field("VAT Administrative Fee"; Rec."VAT Administrative Fee")
                {

                }
                field("Maximum Premium"; Rec."Maximum Premium")
                {

                    Visible = false;
                }
            }
            group("Bank Details")
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Code"; Rec."Account Code")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Other Details")
            {
                field("Payslip Message"; Rec."Payslip Message")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Process Kenyan Payroll")
            {
                ApplicationArea = Basic;
                Caption = 'Process Kenyan Payroll';
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Enabled = PayrollVisible;
                trigger OnAction()
                var

                begin
                    PayrollCalender.Reset;
                    PayrollCalender.SetRange(PayrollCalender.Closed, false);
                    if PayrollCalender.FindFirst then begin
                        "Payroll Period" := PayrollCalender."Date Opened";
                    end;
                    if "Payroll Period" = 0D then
                        Error('No Open Payroll Period');
                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp.Status, PayrollEmp.Status::Active);
                    PayrollEmp.SETRANGE(PayrollEmp.Branch, 'MALAWI');
                    PayrollEmp.SetRange(PayrollEmp."Suspend Pay", false);
                    if PayrollEmp.FindSet then begin
                        PayrollEmp."Pays PAYE" := false;
                        PayrollEmp."Pays NHIF" := false;
                        PayrollEmp."Pays NSSF" := false;
                        PayrollEmp.Modify(true);
                    end;
                    RemoveTrans(PayrollEmp."No.", "Payroll Period");

                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp.Status, PayrollEmp.Status::Active);
                    PayrollEmp.SetRange(PayrollEmp."Suspend Pay", false);
                    PayrollEmp.SetRange("Global Dimension 1", 'KENYA');
                    if PayrollEmp.FindSet then begin
                        ProgressWindow.Open('Processing Salary for Employee No. #1#######');
                        repeat

                            if PayrollEmp."Global Dimension 1" = 'KENYA' THEN begin
                                PayrollEmp."Currency Factor" := PayrollCalender."Currency Code";
                                PayrollEmp.Modify(true);
                                Earnings.Reset();
                                Earnings.SetRange("Payroll Period", "Payroll Period");
                                if Earnings.Find('-') then begin
                                    repeat

                                        Earnings.Validate("Amount(LCY)");
                                        Earnings.Modify(true);
                                    until Earnings.Next() = 0;
                                end;
                            end;


                            // PayrollEmp.Reset;
                            // PayrollEmp.SetRange(PayrollEmp.Status, PayrollEmp.Status::Active);
                            // PayrollEmp.SETRANGE(PayrollEmp.Branch, 'KENYA');
                            // PayrollEmp.SetRange(PayrollEmp."Suspend Pay", false);
                            // PayrollEmp.SetRange(PayrollEmp.Secondary, true);
                            // if PayrollEmp.FindSet then begin
                            //     //  PayrollEmp."Pays PAYE" := false;
                            //     PayrollEmp."Pays NHIF" := false;
                            //     PayrollEmp."Pays NSSF" := false;
                            //     PayrollEmp.Modify(true);
                            // end;



                            // if PayrollEmp."Currency Code" = 'KES' then begin
                            //     // Message('curencey %1-%2', PayrollEmp."Currency Factor", Rec."Currency Factor");
                            //     PayrollEmp.Validate("Basic Pay");
                            // end
                            // else begin

                            PayrollEmp.Validate("Basic Pay(LCY)");

                            //end;
                            PayrollEmp.Modify(true);

                            PayrollEmp.TestField(PayrollEmp."Joining Date");

                            RemoveTrans(PayrollEmp."No.", "Payroll Period");
                            //End Remove Transactions
                            if (PayrollEmp."Joining Date" <> 0D) and (PayrollEmp.Status = PayrollEmp.Status::Active) then begin
                                //Message('%1-%2', PayrollEmp."Joining Date", PayrollEmp."Posting Group", PayrollEmp."Basic Pay");
                                PayrollManager.ProcessPayroll(PayrollEmp."No.", "Payroll Period", PayrollEmp."Posting Group", PayrollEmp."Basic Pay", PayrollEmp."Basic Pay(LCY)",
                                                              PayrollEmp."Currency Code", PayrollEmp."Currency Factor", PayrollEmp."Joining Date", PayrollEmp."Date of Leaving",
                                                              false, PayrollEmp."Global Dimension 1", PayrollEmp."Global Dimension 2", '', PayrollEmp."Pays PAYE", PayrollEmp."Pays NHIF",
                                                              PayrollEmp."Pays NSSF", PayrollEmp.GetsPayeRelief, PayrollEmp.GetsPayeBenefit, PayrollEmp.Secondary, PayrollEmp.PayeBenefitPercent);
                                ProgressWindow.Update(1, PayrollEmp."No." + ':' + PayrollEmp."Full Name");
                            end;
                        until PayrollEmp.Next = 0;
                    end;



                    ProgressWindow.Close;
                    Message('Payroll processing completed successfully.');
                end;
            }
            action("Process Malawi Payroll")
            {
                ApplicationArea = Basic;
                Caption = 'Process Malawi Payroll';
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Enabled = PayrollVisible;
                trigger OnAction()
                var

                begin
                    PayrollCalender1.Reset;
                    PayrollCalender1.SetRange(PayrollCalender1.Closed, false);
                    if PayrollCalender1.FindFirst then begin
                        "Payroll Period" := PayrollCalender1."Date Opened";
                    end;
                    if "Payroll Period" = 0D then
                        Error('No Open Payroll Period');

                    RemoveTrans1(PayrollEmp."No.", "Payroll Period");
                    PayrollEmp.Reset;
                    // PayrollEmp.SetRange(PayrollEmp.Status, PayrollEmp.Status::Active);
                    PayrollEmp.SETRANGE(PayrollEmp.Branch, 'MALAWI');
                    PayrollEmp.SetRange(PayrollEmp."Suspend Pay", false);
                    if PayrollEmp.FindSet then begin
                        PayrollEmp."Pays PAYE" := false;
                        PayrollEmp."Pays NHIF" := false;
                        PayrollEmp."Pays NSSF" := false;
                        PayrollEmp.Modify(true);
                    end;


                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp.Status, PayrollEmp.Status::Active);
                    PayrollEmp.SetRange(PayrollEmp."Suspend Pay", false);
                    PayrollEmp.SetRange("Global Dimension 1", 'MALAWI');
                    if PayrollEmp.FindSet then begin
                        ProgressWindow.Open('Processing Salary for Employee No. #1#######');
                        repeat

                            if PayrollEmp."Global Dimension 1" = 'MALAWI' THEN begin
                                PayrollEmp."Currency Factor" := PayrollCalender1."Malawi Currency Code";
                                PayrollEmp.Modify(true);
                                Earnings1.Reset();
                                Earnings1.SetRange("Payroll Period", "Payroll Period");
                                if Earnings1.Find('-') then begin
                                    repeat

                                        Earnings1.Validate("Amount(LCY)");
                                        Earnings1.Modify(true);
                                    until Earnings1.Next() = 0;
                                end;
                            end;


                            PayrollEmp.Validate("Basic Pay(LCY)");

                            //end;
                            PayrollEmp.Modify(true);

                            PayrollEmp.TestField(PayrollEmp."Joining Date");

                            RemoveTrans1(PayrollEmp."No.", "Payroll Period");
                            //End Remove Transactions
                            if ((PayrollEmp."Joining Date" <> 0D) and (PayrollEmp.Status = PayrollEmp.Status::Active)) then begin
                                //Message('%1-%2', PayrollEmp."Joining Date", PayrollEmp."Posting Group", PayrollEmp."Basic Pay");
                                PayrollManagerM.ProcessPayroll(PayrollEmp."No.", "Payroll Period", PayrollEmp."Posting Group", PayrollEmp."Basic Pay", PayrollEmp."Basic Pay(LCY)",
                                                              PayrollEmp."Currency Code", PayrollEmp."Currency Factor", PayrollEmp."Joining Date", PayrollEmp."Date of Leaving",
                                                              false, PayrollEmp."Global Dimension 1", PayrollEmp."Global Dimension 2", '', PayrollEmp."Pays PAYE", PayrollEmp."Pays NHIF",
                                                              PayrollEmp."Pays NSSF", PayrollEmp.GetsPayeRelief, PayrollEmp.GetsPayeBenefit, PayrollEmp.Secondary, PayrollEmp.PayeBenefitPercent,
                                                              PayrollEmp."Pension %-Employer", PayrollEmp."Pension Administrative Fee", PayrollEmp."VAT Administrative Fee", PayrollEmp."Group Life Assuarance");
                                ProgressWindow.Update(1, PayrollEmp."No." + ':' + PayrollEmp."Full Name");
                            end;
                        until PayrollEmp.Next = 0;
                    end;

                    ProgressWindow.Close;
                    Message('Payroll processing completed successfully.');
                end;
            }
            action("Process Current Employee")
            {
                ApplicationArea = Basic;
                Image = Allocations;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField("Posting Group");
                    Rec.TestField("Joining Date");
                    Rec.TestField("Basic Pay");
                    /*TESTFIELD("PIN No");
                    TESTFIELD("NHIF No");
                    TESTFIELD("NSSF No");*/

                    PayrollCalender.Reset;
                    PayrollCalender.SetRange(PayrollCalender.Closed, false);
                    if PayrollCalender.FindFirst then begin
                        "Payroll Period" := PayrollCalender."Date Opened";
                    end;
                    if "Payroll Period" = 0D then
                        Error('No Open Payroll Period');

                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp.Status, PayrollEmp.Status::Active);
                    PayrollEmp.SetRange(PayrollEmp."Suspend Pay", false);
                    PayrollEmp.SetRange("Global Dimension 1", 'KENYA');
                    if PayrollEmp.FindSet then begin
                        // ProgressWindow.Open('Processing Salary for Employee No. #1#######');
                        //First Remove Any transactions for this Month
                        RemoveTrans(PayrollEmp."No.", "Payroll Period");
                        //End Remove Transactions
                        if PayrollEmp."Joining Date" <> 0D then begin
                            PayrollManager.ProcessPayroll(PayrollEmp."No.", "Payroll Period", PayrollEmp."Posting Group", PayrollEmp."Basic Pay", PayrollEmp."Basic Pay(LCY)",
                                                          PayrollEmp."Currency Code", PayrollEmp."Currency Factor", PayrollEmp."Joining Date", PayrollEmp."Date of Leaving",
                                                          false, PayrollEmp."Global Dimension 1", PayrollEmp."Global Dimension 2", '', PayrollEmp."Pays PAYE", PayrollEmp."Pays NHIF",
                                                          PayrollEmp."Pays NSSF", PayrollEmp.GetsPayeRelief, PayrollEmp.GetsPayeBenefit, PayrollEmp.Secondary, PayrollEmp.PayeBenefitPercent);
                            ProgressWindow.Update(1, PayrollEmp."No." + ':' + PayrollEmp."Full Name");
                        end;
                    end;
                    //ProgressWindow.Close;
                    Message('Payroll processing completed successfully.');

                end;
            }

            action("Employee Earnings Kenya")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Payroll Employee Earnings_AU";
                RunPageLink = "No." = field("No.");
            }
            action("Employee Earnings Malawi")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Payroll Employee EarningsM";
                RunPageLink = "No." = field("No.");
                trigger OnAction()
                begin
                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp."No.", Rec."No.");
                    PayrollEmp.SetRange("Global Dimension 1", 'KENYA');
                    if PayrollEmp.FindFirst then begin
                        PayrollVisible := false;
                    end;
                end;
                // end;
            }
            action("Employee Deductions Kenya")
            {
                ApplicationArea = Basic;
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Payroll Employee Ded_AU";
                RunPageLink = "No." = field("No.");
            }
            action("Employee Deductions Malawi")
            {
                ApplicationArea = Basic;
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Payroll Employee DedM";
                RunPageLink = "No." = field("No.");
            }
            action("Employee Assignments")
            {
                ApplicationArea = Basic;
                Image = Apply;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = Page "Payroll Employee Assignp_AU";
                RunPageLink = "No." = field("No.");
            }
            action("Employee Cummulatives")
            {
                ApplicationArea = Basic;
                Image = History;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = Page "Payroll Emp. Cummulati_AU";
                RunPageLink = "No." = field("No.");
            }
            action("View PaySlip 2")
            {
                ApplicationArea = Basic;
                Caption = 'Kenyan PaySlip';
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    if UserSetup.Get(UserId) then
                        if UserSetup."View Malawi Payroll" = false then Error('you have no permission to view this payslip');
                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp."No.", Rec."No.");
                    if PayrollEmp.FindFirst then begin

                        Report.Run(50013, true, false, PayrollEmp)

                    end;
                end;
            }
            action("View PaySlip")
            {
                ApplicationArea = Basic;
                Caption = 'Kenya Payslip';
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp."No.", Rec."No.");
                    if PayrollEmp.FindFirst then begin
                        Report.Run(50099, true, false, PayrollEmp);
                    end;
                end;
            }
            action("View PaySlip 12")
            {
                ApplicationArea = Basic;
                Caption = 'Malawi PaySlip';
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    if UserSetup.Get(UserId) then
                        if UserSetup."View Malawi Payroll" = false then Error('you have no permission to view this payslip');
                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp."No.", Rec."No.");
                    if PayrollEmp.FindFirst then begin
                        Report.Run(50050, true, false, PayrollEmp)
                    end;
                end;
            }
            action(Activate)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Active;
                    Rec.Modify;
                end;
            }
            action("In-Activate")
            {
                ApplicationArea = Basic;
                Caption = 'In-Activate';

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Inactive;
                    Rec.Modify;
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        // Banch := '';
        // MalawiProcessVisible := false;
        // PayrollVisible := false;
        // HrEmployees.Reset();
        // HrEmployees.SetRange("Employee UserID", UserId);
        // if HrEmployees.Find('-') then begin
        //     Banch := HrEmployees."Global Dimension 1 Code";
        // end;
        // if Banch = 'MALAWI' then begin
        //     Rec.Reset();
        //     Rec.SetRange("Global Dimension 1", Banch);
        //     if Rec.Find('-') then begin
        //         MalawiProcessVisible := true;
        //     end;
        // end;
        // if Banch = 'KENYA' then begin

        //     Rec.Reset();
        //     Rec.SetRange("Global Dimension 1", Banch);
        //     if Rec.Find('-') then begin
        //         PayrollVisible := true;
        //     end;
        // end

    end;

    trigger OnInit()
    begin
        if UserSetup.Get(UserId) then begin
            if not ((UserSetup."View Payroll") OR (UserSetup."View Malawi Payroll")) then
                Error(PemissionDenied);
        end else begin
            Error(UserNotFound, UserId);
        end;
    end;

    var
        PayrollEmp: Record "Payroll Employee_AU";
        ProgressWindow: Dialog;
        PayrollVisible: Boolean;
        MalawiProcessVisible: Boolean;
        HrEmployees: Record "HR Employees";
        kenyadeductionvisible: Boolean;
        malawideductionsvisible: Boolean;
        Banch: Code[200];
        Earnings: Record "Payroll Employee Trans_AU";
        Earnings1: Record "Payroll Employee Trans_Malawi";
        Paytrans: Record "Payroll Employee Trans_AU";

        PayrollManager: Codeunit "Payroll Management_AU";
        PayrollManagerM: Codeunit "Payroll Management_Malawi";
        "Payroll Period": Date;
        PayrollCalender: Record "Payroll Calender_AU";
        PayrollMonthlyTrans: Record "Payroll Monthly Trans_AU";
        payrollCalender1: Record "Payroll CalenderMalawi";
        payrollMonthlyTrans1: Record "Payroll Monthly Trans_Malawi";
        PayrollEmployeeDed: Record "Payroll Employee Deductions_AU";
        PayrollEmployerDed: Record "Payroll Employer Deductions_AU";
        UserSetup: Record "User Setup";
        Taxvisible: Boolean;
        UserNotFound: label 'User Setup %1 not found.';
        PemissionDenied: label 'User Account is not Setup for Payroll Use. Contact System Administrator.';

    trigger OnAfterGetRecord()
    begin
        Taxvisible := false;
        if Rec."Global Dimension 1" = 'KENYA' THEN begin
            Taxvisible := true
        end ELSE begin
            Taxvisible := false;
        end;

    end;

    local procedure RemoveTrans(EmpNo: Code[20]; PayrollPeriod: Date)
    begin
        //Remove Monthly Transactions
        PayrollMonthlyTrans.Reset;
        PayrollMonthlyTrans.SetRange(PayrollMonthlyTrans."No.", EmpNo);
        PayrollMonthlyTrans.SetRange(PayrollMonthlyTrans."Period Month", Date2dmy(PayrollPeriod, 2));
        PayrollMonthlyTrans.SetRange(PayrollMonthlyTrans."Period Year", Date2dmy(PayrollPeriod, 3));
        if PayrollMonthlyTrans.FindSet then
            PayrollMonthlyTrans.DeleteAll;

        //Remove Employee Deductions
        //Remove Employer Deductions
    end;

    local procedure RemoveTrans1(EmpNo: Code[20]; PayrollPeriod: Date)
    begin
        //Remove Monthly Transactions
        PayrollMonthlyTrans1.Reset;
        PayrollMonthlyTrans1.SetRange(PayrollMonthlyTrans1."No.", EmpNo);
        PayrollMonthlyTrans1.SetRange(PayrollMonthlyTrans1."Period Month", Date2dmy(PayrollPeriod, 2));
        PayrollMonthlyTrans1.SetRange(PayrollMonthlyTrans1."Period Year", Date2dmy(PayrollPeriod, 3));
        if PayrollMonthlyTrans1.FindSet then
            PayrollMonthlyTrans1.DeleteAll;

        //Remove Employee Deductions
        //Remove Employer Deductions
    end;

    procedure UpdateCurrencyFactor()
    var
        UpdateCurrencyExchangeRates: Codeunit "Update Currency Exchange Rates";
        Updated: Boolean;
        CurrencyDate: Date;
        CurrExchRate: Record "Currency Exchange Rate";
    begin

        if Updated then
            exit;

        if Rec."Currency Code" <> '' then begin
            CurrencyDate := WorkDate;

            if UpdateCurrencyExchangeRates.ExchangeRatesForCurrencyExist(CurrencyDate, Rec."Currency Code") then begin
                Rec."Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, Rec."Currency Code");

                UpdateCurrencyExchangeRates.ShowMissingExchangeRatesNotification(Rec."Currency Code");
            end else begin
                Rec."Currency Factor" := 0;

            end;

        end;

    end;

}

