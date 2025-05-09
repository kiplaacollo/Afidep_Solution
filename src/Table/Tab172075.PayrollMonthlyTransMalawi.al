Table 172075 "Payroll Monthly Trans_Malawi"
{

    fields
    {
        field(10; "No."; Code[20])
        {
        }
        field(11; "Transaction Code"; Code[1000])
        {
        }
        field(12; "Transaction Name"; Text[1000])
        {
        }
        field(13; "Global Dimension 1"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(14; "Global Dimension 2"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(15; "Shortcut Dimension 3"; Code[20])
        {
        }
        field(16; "Shortcut Dimension 4"; Code[20])
        {
        }
        field(17; "Shortcut Dimension 5"; Code[20])
        {
        }
        field(18; "Shortcut Dimension 6"; Code[20])
        {
        }
        field(19; "Shortcut Dimension 7"; Code[20])
        {
        }
        field(20; "Shortcut Dimension 8"; Code[20])
        {
        }
        field(21; "Group Text"; Text[1000])
        {
        }
        field(22; Amount; Decimal)
        {
        }
        field(23; "Amount(LCY)"; Decimal)
        {
        }
        field(99; "Currency Factor"; Decimal)
        { }
        field(24; Balance; Decimal)
        {
        }
        field(25; "Balance(LCY)"; Decimal)
        {
        }
        field(26; Grouping; Integer)
        {
        }
        field(27; SubGrouping; Integer)
        {
        }
        field(28; "Period Month"; Integer)
        {
        }
        field(29; "Period Year"; Integer)
        {
        }
        field(30; "Payroll Period"; Date)
        {
            // TableRelation = "Payroll Calender_AU"."Date Opened";
            TableRelation = "Payroll CalenderMalawi"."Date Opened";
        }
        field(31; "Period Filter"; Date)
        {
        }
        field(32; "Reference No"; Code[20])
        {
        }
        field(33; Membership; Code[20])
        {
        }
        field(34; LumpSumItems; Boolean)
        {
        }
        field(35; TravelAllowance; Code[20])
        {
        }
        field(36; "Posting Type"; Option)
        {
            OptionCaption = ' ,Debit,Credit';
            OptionMembers = " ",Debit,Credit;
        }
        field(37; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,Investor';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        }
        field(38; "Account No"; Code[50])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner";
        }
        field(39; "Loan Number"; Code[20])
        {
        }
        field(40; "Co-Op parameters"; Option)
        {
            OptionCaption = 'None,Shares,Loan,Loan Interest,Emergency Loan,Emergency Loan Interest,School Fees Loan,School Fees Loan Interest,Welfare,Pension,NSSF,Overtime,WSS';
            OptionMembers = "None",Shares,Loan,"Loan Interest","Emergency Loan","Emergency Loan Interest","School Fees Loan","School Fees Loan Interest",Welfare,Pension,NSSF,Overtime,WSS;
        }
        field(41; "Company Deduction"; Boolean)
        {
        }
        field(42; "Employer Amount"; Decimal)
        {
        }
        field(43; "Employer Amount(LCY)"; Decimal)
        {
        }
        field(44; "Employer Balance"; Decimal)
        {
        }
        field(45; "Employer Balance(LCY)"; Decimal)
        {
        }
        field(46; "Payment Mode"; Option)
        {
            OptionCaption = ' ,Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,SACCO;
        }
        field(47; "Payroll Code"; Code[50])
        {
        }
        field(48; "No. of Units"; Decimal)
        {
        }
        field(49; Approver1Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50; Approver2Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51; Approver2Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(52; Approver3Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53; Approver3Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(54; Approver1Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(55; Approver2Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(56; Approver3Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(57; RequesterDate; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(58; Approver1Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Requester Signature"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(60; RequesterName; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51516000; "Total Statutories"; Decimal)
        {
            CalcFormula = sum("Payroll Monthly Trans_AU".Amount where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(51516001; "Contract Type"; Option)
        {
            CalcFormula = lookup("Payroll Employee_AU"."Contract Type" where("No." = field("No.")));
            Caption = 'Contract Status';
            FieldClass = FlowField;
            OptionCaption = 'Contract,Secondment,Casual,Temporary,Volunteer,Project Staff,Consultant-Contract,Consultant,Deployed,Board,Committee,Full Time';
            OptionMembers = Contract,Secondment,Casual,"Temporary",Volunteer,"Project Staff","Consultant-Contract",Consultant,Deployed,Board,Committee,"Full Time";
        }
    }

    keys
    {
        key(Key1; "No.", "Transaction Code", "Period Month", "Period Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

