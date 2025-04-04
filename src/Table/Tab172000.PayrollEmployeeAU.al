Table 172000 "Payroll Employee_AU"
{

    fields
    {
        field(10; "No."; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin

                HREmployees.Reset;
                HREmployees.SetRange("No.", "No.");
                if HREmployees.FindFirst then begin
                    "Pays NHIF" := true;
                    "Pays NSSF" := true;
                    "Pays PAYE" := true;
                    Validate(Surname, HREmployees."Last Name");
                    Validate(Firstname, HREmployees."First Name");
                    Validate(Lastname, HREmployees."Middle Name");
                    "Joining Date" := HREmployees."Date Of Join";
                    "NHIF No" := HREmployees."NHIF No.";
                    "NSSF No" := HREmployees."NSSF No.";
                    "PIN No" := HREmployees."PIN No.";
                    "Bank Code" := HREmployees."Bank Code New";
                    "Bank Name" := HREmployees."Bank Name";
                    "Branch Code" := HREmployees."Branch Code New";
                    "Branch Name" := HREmployees."Branch Name";
                    "Bank Account No" := HREmployees."Bank Account Number";
                    "Global Dimension 1" := HREmployees."Global Dimension 1 Code";
                    "Global Dimension 2" := HREmployees."Global Dimension 2 Code";
                    "Posting Group" := HREmployees."Posting Group";
                    "ID No/Passport No" := HREmployees."ID Number";
                    "National ID No" := HREmployees."ID Number";
                end;
            end;
        }
        field(11; Surname; Text[30])
        {

            trigger OnValidate()
            begin
                "Full Name" := Surname + ' ' + Firstname + ' ' + Lastname;
            end;
        }
        field(12; Firstname; Text[30])
        {

            trigger OnValidate()
            begin
                "Full Name" := Surname + ' ' + Firstname + ' ' + Lastname;
            end;
        }
        field(13; Lastname; Text[30])
        {

            trigger OnValidate()
            begin
                "Full Name" := Surname + ' ' + Firstname + ' ' + Lastname;
            end;
        }
        field(14; "Joining Date"; Date)
        {
        }
        field(15; "Currency Code"; Code[20])
        {
            TableRelation = Currency.Code;
        }
        field(16; "Currency Factor"; Decimal)
        {
            DecimalPlaces = 5;
        }
        field(17; "Global Dimension 1"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(18; "Global Dimension 2"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(19; "Shortcut Dimension 3"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(20; "Shortcut Dimension 4"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(21; "Shortcut Dimension 5"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
        field(22; "Shortcut Dimension 6"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
        }
        field(23; "Shortcut Dimension 7"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
        }
        field(24; "Shortcut Dimension 8"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
        }
        field(25; "Basic Pay"; Decimal)
        {
            Editable = false;
            trigger OnValidate()
            begin
                // "Basic Pay(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Basic Pay", "Currency Factor"), 0.00001, '=');
                "Basic Pay(LCY)" := "Basic Pay" / "Currency Factor";
            end;
        }
        field(26; "Basic Pay(LCY)"; Decimal)
        {
            trigger OnValidate()
            begin

                //  "Basic Pay" := ROUND(CurrExchRate.ExchangeAmtLCYToFCY(Today, "Currency Code", "Basic Pay(LCY)", "Currency Factor"), 0.00001, '=');
                "Basic Pay" := "Basic Pay(LCY)" * "Currency Factor";
            end;
        }
        field(27; "Cummulative Basic Pay"; Decimal)
        {
            CalcFormula = sum("Payroll Monthly Trans_AU".Amount where("Transaction Code" = const('BPAY'),
                                                                       "Payroll Period" = field("Period Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Cummulative Gross Pay"; Decimal)
        {
            Editable = false;
        }
        field(29; "Cummulative Allowances"; Decimal)
        {
            CalcFormula = sum("Payroll Monthly Trans_AU".Amount where("Group Text" = const('ALLOWANCE'),
                                                                       "Payroll Period" = field("Period Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Cummulative Deductions"; Decimal)
        {
            CalcFormula = sum("Payroll Monthly Trans_AU".Amount where("Posting Type" = const(Credit),
                                                                       "Payroll Period" = field("Period Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Cummulative Net Pay"; Decimal)
        {
            CalcFormula = sum("Payroll Monthly Trans_AU".Amount where("Transaction Code" = const('NPAY'),
                                                                       "Payroll Period" = field("Period Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Cummulative PAYE"; Decimal)
        {
        }
        field(33; "Cummulative NSSF"; Decimal)
        {
        }
        field(34; "Cummulative Pension"; Decimal)
        {
        }
        field(35; "Cummulative HELB"; Decimal)
        {
        }
        field(36; "Cummulative NHIF"; Decimal)
        {
        }
        field(37; "Cummulative Employer Pension"; Decimal)
        {
        }
        field(38; "Cummulative TopUp"; Decimal)
        {
        }
        field(39; "Cummulative Basic Pay(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(40; "Cummulative Gross Pay(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(41; "Cummulative Allowances(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(42; "Cummulative Deductions(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(43; "Cummulative Net Pay(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(44; "Cummulative PAYE(LCY)"; Decimal)
        {
        }
        field(45; "Cummulative NSSF(LCY)"; Decimal)
        {
        }
        field(46; "Cummulative Pension(LCY)"; Decimal)
        {
        }
        field(47; "Cummulative HELB(LCY)"; Decimal)
        {
        }
        field(48; "Cummulative NHIF(LCY)"; Decimal)
        {
        }
        field(49; "Cumm Employer Pension(LCY)"; Decimal)
        {
        }
        field(50; "Cummulative TopUp(LCY)"; Decimal)
        {
        }
        field(51; "Non Taxable"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Non Taxable(LCY)" := "Non Taxable"
                else
                    "Non Taxable(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Non Taxable", "Currency Factor"));
            end;
        }
        field(52; "Non Taxable(LCY)"; Decimal)
        {
        }
        field(53; "Posting Group"; Code[20])
        {
            TableRelation = "Payroll Posting Groups_AU"."Posting Code";
        }
        field(54; "Payment Mode"; Option)
        {
            OptionCaption = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = "Bank Transfer",Cheque,Cash,SACCO;
        }
        field(55; "Pays PAYE"; Boolean)
        {
        }
        field(56; "Pays NSSF"; Boolean)
        {
        }
        field(57; "Pays NHIF"; Boolean)
        {
        }
        field(58; "Bank Code"; Code[20])
        {
            TableRelation = "Payroll Bank Codes_AU";

            trigger OnValidate()
            begin
                BankCodes.Reset;
                BankCodes.SetRange(BankCodes."Bank Code", "Bank Code");
                if BankCodes.FindFirst then begin
                    BankCodes.TestField(BankCodes."Bank Name");
                    "Bank Name" := BankCodes."Bank Name";
                end;
            end;
        }
        field(59; "Bank Name"; Text[100])
        {
            Editable = false;
        }
        field(60; "Branch Code"; Code[20])
        {
            TableRelation = "Payroll Bank Branches_AU"."Branch Code" where("Bank Code" = field("Bank Code"));

            trigger OnValidate()
            begin
                BankBranches.Reset;
                BankBranches.SetRange(BankBranches."Bank Code", "Bank Code");
                BankBranches.SetRange(BankBranches."Branch Code", "Branch Code");
                if BankBranches.FindFirst then begin
                    BankBranches.TestField(BankBranches."Branch Name");
                    "Branch Name" := BankBranches."Branch Name";
                end;
            end;
        }
        field(61; "Branch Name"; Text[100])
        {
            Editable = false;
        }
        field(62; "Bank Account No"; Code[50])
        {
        }
        field(63; "Suspend Pay"; Boolean)
        {
        }
        field(64; "Suspend Date"; Date)
        {
        }
        field(65; "Suspend Reason"; Text[100])
        {
            Enabled = false;
        }
        field(66; "Hourly Rate"; Decimal)
        {
        }
        field(67; Gratuity; Boolean)
        {
        }
        field(68; "Gratuity Percentage"; Decimal)
        {
        }
        field(69; "Gratuity Provision"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Gratuity Provision(LCY)" := "Gratuity Provision"
                else
                    "Gratuity Provision(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Gratuity Provision", "Currency Factor"));
            end;
        }
        field(70; "Gratuity Provision(LCY)"; Decimal)
        {
        }
        field(71; "Cummulative Gratuity"; Decimal)
        {
        }
        field(72; "Cummulative Gratuity(LCY)"; Decimal)
        {
        }
        field(73; "Days Absent"; Decimal)
        {
        }
        field(74; "Payslip Message"; Text[100])
        {
        }
        field(75; "Paid per Hour"; Boolean)
        {
        }
        field(76; "Full Name"; Text[90])
        {
        }
        field(77; Status; Option)
        {
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(78; "Date of Leaving"; Date)
        {
        }
        field(79; GetsPayeRelief; Boolean)
        {
        }
        field(80; GetsPayeBenefit; Boolean)
        {
        }
        field(81; Secondary; Boolean)
        {
        }
        field(82; PayeBenefitPercent; Decimal)
        {
        }
        field(83; "NSSF No"; Code[20])
        {
        }
        field(84; "NHIF No"; Code[20])
        {
        }
        field(85; "PIN No"; Code[20])
        {
        }
        field(86; Company; Text[30])
        {
        }
        field(87; "Current Month Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(88; "National ID No"; Code[20])
        {
        }
        field(89; Photo; Blob)
        {
            SubType = Bitmap;
        }
        field(90; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Calender_AU"."Date Opened";
        }
        field(91; "Join Date"; Date)
        {
        }
        field(92; "Contract Type"; Option)
        {
            Caption = 'Contract Type';
            OptionCaption = 'Contract,Secondment,Casual,Temporary,Volunteer,Project Staff,Consultant-Contract,Consultant,Deployed,Board,Committee,Full Time';
            OptionMembers = Contract,Secondment,Casual,"Temporary",Volunteer,"Project Staff","Consultant-Contract",Consultant,Deployed,Board,Committee,"Full Time";
        }
        field(93; "ID No/Passport No"; Code[50])
        {
        }
        field(94; "Account Code"; Code[100])
        {
        }
        field(95; "Do not prorate Again"; Boolean)
        {
        }
        field(96; "Include Insurance deduction"; Boolean)
        {
        }
        field(97; "Insurance Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(98; "Mortgage Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(99; "Pension %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(100; Location; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Pension %-Employer"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(103; "Cash Benefit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(104; "Personal Relief AMount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(105; "Pension %-Employee"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(106; Premium; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(107; "Premium %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(108; "Maximum Premium"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(109; Branch; Code[50])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(110; "Group Life Assuarance"; Decimal)
        {

        }
        field(111; "Pension Administrative Fee"; Decimal)
        {

        }
        field(112; "VAT Administrative Fee"; Decimal)
        {

        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CurrExchRate: Record "Currency Exchange Rate";
        BankCodes: Record "Payroll Bank Codes_AU";
        BankBranches: Record "Payroll Bank Branches_AU";
        HREmployees: Record "HR Employees";

    [IntegrationEvent(TRUE, false)]
    local procedure OnValidateAmountOnAfterAssignAmountLCY(var AmountLCY: Decimal)
    begin
    end;
}

