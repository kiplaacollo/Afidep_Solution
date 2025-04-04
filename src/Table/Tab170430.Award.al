table 170430 Award
{
    // Serenic Navigator - (c)Copyright Serenic Software, Inc. 1999-2017.
    // By opening this object you acknowledge that this object includes confidential information
    // and intellectual property of Serenic Software, Inc., and that this work is protected by US
    // and international copyright laws and agreements.
    // ------------------------------------------------------------------------------------------

    Caption = 'Award';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = 20450;
    // LookupPageID = 30025;


    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin

            end;
        }
        field(2; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                IF ("Search Name" = UPPERCASE(xRec.Name)) OR ("Search Name" = '') THEN BEGIN
                    "Search Name" := Name;
                END;

                //  UpdateFundDimension;
            end;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(5; "Description 2"; Text[250])
        {
            Caption = 'Description 2';
        }
        field(6; "Award Dimension No."; Integer)
        {
            Caption = 'Award Dimension No.';
            Editable = false;
            // TableRelation = "G/L Dimension".No. WHERE (No.=FILTER(>0));
        }
        field(7; "Award Dimension Code"; Code[20])
        {
            Caption = 'Award Dimension Code';
            Editable = false;
            //TableRelation = IF (Award Dimension No.=FILTER(2..9)) Dimension;
        }
        field(8; "Award Dimension Value"; Code[20])
        {
            Caption = 'Award Dimension Value';



        }
        field(9; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = true;
            TableRelation = "No. Series";
        }
        field(10; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Proposal,Award,Subaward';
            OptionMembers = Proposal,Award,Subaward;
        }
        field(13; "Start Date"; Date)
        {
            Caption = 'Start Date';

            trigger OnValidate()
            begin
                /*IF ("Start Date" <> 0D) AND ("End Date" <> 0D) AND ("Start Date" > "End Date") THEN
                  ERROR(SNText016,FIELDCAPTION("Start Date"),FIELDCAPTION("End Date"));
                
                IF ("Document Type" <> "Document Type"::Proposal) AND (Phase <> Phase::Planning) THEN
                  ERROR(SNText018)*/

            end;
        }
        field(14; "End Date"; Date)
        {
            Caption = 'End Date';

            trigger OnValidate()
            begin
                /*IF ("End Date" <> 0D) AND ("Start Date" > "End Date") THEN
                  ERROR(SNText016,FIELDCAPTION("Start Date"),FIELDCAPTION("End Date"));
                
                IF ("Document Type" <> "Document Type"::Proposal) AND (Phase <> Phase::Planning) THEN
                  ERROR(SNText018)*/

            end;
        }
        field(17; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(19; Phase; Option)
        {
            Caption = 'Phase';
            OptionCaption = 'Active Pursuit,Submitted,Awaiting Feedback,Awarded,Not Awarded,Pre-Planning,No-GO';
            OptionMembers = Planning,Submitted,Negotiation,Awarded,"Not Awarded","Pre-Planning","No-GO";


        }
        field(21; "Indirect Cost Rate"; Decimal)
        {
            Caption = 'Indirect Cost Rate';
        }
        field(23; "AV Posting Group"; Code[10])
        {
            Caption = 'AV Posting Group';

        }
        field(24; Blocked; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Closed,All';
            OptionMembers = " ",Closed,All;

            trigger OnValidate()
            var
                DimBlocked: Boolean;
            begin
                IF Blocked = Blocked::All THEN BEGIN
                    DimBlocked := TRUE
                END ELSE BEGIN
                    DimBlocked := FALSE;
                END;


            end;
        }
        field(28; "Fiscal Year Start Date"; Date)
        {
            Caption = 'Fiscal Year Start Date';
        }
        field(31; "Allow Posting From"; Date)
        {

        }
        field(32; "Allow Posting To"; Date)
        {


        }
        field(35; "Next Revision No."; Integer)
        {
            Caption = 'Next Revision No.';
            Editable = false;
            InitValue = 0;
            MinValue = 0;
        }
        field(45; "Award Probability"; Decimal)
        {
            Caption = 'Award Probability';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50; "Restriction Checking"; Boolean)
        {
            Caption = 'Restriction Checking';


        }
        field(60; "Sponsoring Funder No."; Code[20])
        {

        }
        field(71; "Funder's Reference No."; Text[30])
        {
            Caption = 'Funder''s Reference No.';
        }
        field(72; "Reference No."; Text[30])
        {
            Caption = 'Reference No.';
        }
        field(73; "Budget Amount"; Text[30])
        {
            Caption = 'Reference No. 2';
        }
        field(74; "Publication Code"; Code[10])
        {
            Caption = 'Publication Code';

        }
        field(75; "Publication Page No."; Code[10])
        {
            Caption = 'Publication Page No.';
        }
        field(76; "Publication Date"; Date)
        {
            Caption = 'Publication Date';
        }
        field(80; "Process Clearance"; Option)
        {

            OptionMembers = " ",Pending,Approved,Denied,"N/A";

        }
        field(85; "Matching Required"; Boolean)
        {
            Caption = 'Matching Required';
        }
        field(87; "Allow Matching Excess"; Boolean)
        {
            Caption = 'Allow Matching Excess';
        }
        field(90; "Matching Award Rate Code"; Code[10])
        {

        }
        field(98; "Estimate Date"; Date)
        {
            Caption = 'Estimate Date';
            Editable = false;
        }
        field(99; "Awarded Date"; Date)
        {
            Caption = 'Awarded Date';
        }
        field(100; "Not Awarded Date"; Date)
        {
            Caption = 'Not Awarded Date';
        }
        field(101; "Submission Date"; Date)
        {
            Caption = 'Submission Date';
        }
        field(102; Type; Code[10])
        {
            Caption = 'Type of Partnership';
            // TableRelation = "Award Type";
        }
        field(103; Class; Code[10])
        {
            Caption = 'Class';
            //TableRelation = "Award Class";
        }
        field(110; "Inter-Company Name"; Text[30])
        {
            Caption = 'Inter-Company Name';
            TableRelation = Company;
        }
        field(115; "Source Company Name"; Text[30])
        {
            Caption = 'Source Company Name';
            Editable = false;
            TableRelation = Company;
        }
        field(400; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(410; "Date Created"; Date)
        {
            Caption = 'Date Created';
            Editable = false;
        }
        field(420; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(430; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(500; "Fund Class Code"; Code[10])
        {
            Caption = 'Fund Class Code';


            trigger OnValidate()
            var
                GLEntry: Record 17;
            begin

            end;
        }
        field(510; "Parent No."; Code[10])
        {
            Caption = 'Parent No.';
            TableRelation = Award;
        }
        field(640; "Proposal No."; Code[10])
        {
            Caption = 'Proposal No.';


            trigger OnValidate()
            begin
                IF "Proposal No." = '' THEN
                    EXIT;


            end;
        }
        field(770; "Originating Funder No."; Code[20])
        {
            Caption = 'Sponsor No.';


            trigger OnValidate()
            begin




            end;
        }
        field(785; "Line Item Flexibility %"; Decimal)
        {
            Caption = 'Line Item Flexibility %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(800; "Vendor No."; Code[20])
        {
            Caption = 'Subawardee No.';
            Editable = false;

        }
        field(850; "Monitoring Requirement"; Text[50])
        {
            Caption = 'Monitoring Requirement';
            Editable = false;
        }
        field(875; "Subaward Clearance Threshold"; Decimal)
        {
            Caption = 'Subaward Clearance Threshold (ACY)';
        }
        field(1041; "Allocation No."; Code[10])
        {
            Caption = 'Allocation No.';

        }
        field(1050; "Fund No."; Code[10])
        {

        }
        field(1051; "Global Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code';

        }
        field(1052; "Global Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';

        }
        field(1053; "Global Dimension 3 Code"; Code[10])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';

        }
        field(1054; "Global Dimension 4 Code"; Code[10])
        {
            CaptionClass = '1,2,4';
            Caption = 'Global Dimension 4 Code';

        }
        field(1055; "Global Dimension 5 Code"; Code[10])
        {

            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = const(5));
            CaptionClass = '1,2,5';
            Caption = 'Global Dimension 5 Code';

        }
        field(1056; "Global Dimension 6 Code"; Code[10])
        {
            CaptionClass = '1,2,6';
            Caption = 'Global Dimension 6 Code';

        }
        field(1057; "Global Dimension 7 Code"; Code[10])
        {
            CaptionClass = '1,2,7';
            Caption = 'Global Dimension 7 Code';


        }
        field(1058; "Global Dimension 8 Code"; Code[10])
        {
            CaptionClass = '1,2,8';
            Caption = 'Global Dimension 8 Code';



        }
        field(1059; "Dimension Speedkey Code"; Code[10])
        {
            Caption = 'Dimension Speedkey Code';




        }
        field(1099; "Internal Control No."; Code[50])
        {
            Caption = 'Internal Control No.';
            Editable = false;
        }
        field(1111; "CFDA Number"; Text[30])
        {
            Caption = 'CFDA Number';
        }
        field(1113; "Appropriation Number"; Text[30])
        {
            Caption = 'Appropriation Number';
        }
        field(1115; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;



        }
        field(1116; "Indirect Cost Recovery Code"; Code[10])
        {
            Caption = 'Indirect Cost Recovery Code';

        }
        field(1118; "Revenue Recognition Code"; Code[10])
        {
            Caption = 'Revenue Recognition Code';

        }
        field(1120; "Invoice Rule Code"; Code[10])
        {
            Caption = 'Invoice Rule Code';

        }
        field(8000; "Fund Filter"; Code[10])
        {
            Caption = 'Fund Filter';
            FieldClass = FlowFilter;

        }
        field(8001; "Global Dimension 1 Filter"; Code[10])
        {
            CaptionClass = '1,4,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(8002; "Global Dimension 2 Filter"; Code[10])
        {
            CaptionClass = '1,4,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(8003; "Global Dimension 3 Filter"; Code[10])
        {
            CaptionClass = '1,4,3';
            Caption = 'Global Dimension 3 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(8004; "Global Dimension 4 Filter"; Code[10])
        {
            CaptionClass = '1,4,4';
            Caption = 'Global Dimension 4 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(8005; "Global Dimension 5 Filter"; Code[10])
        {
            CaptionClass = '1,4,5';
            Caption = 'Global Dimension 5 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(8006; "Global Dimension 6 Filter"; Code[10])
        {
            CaptionClass = '1,4,6';
            Caption = 'Global Dimension 6 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(8007; "Global Dimension 7 Filter"; Code[10])
        {
            CaptionClass = '1,4,7';
            Caption = 'Global Dimension 7 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(8008; "Global Dimension 8 Filter"; Code[10])
        {
            CaptionClass = '1,4,8';
            Caption = 'Global Dimension 8 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
        field(8009; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(8010; "Transaction Type Filter"; Option)
        {
            Caption = 'Transaction Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Actual,Budget,Commitment,Encumbrance,Statistical,Provisional';
            OptionMembers = Actual,Budget,Commitment,Encumbrance,Statistical,Provisional;
        }
        field(8011; "Award Filter"; Code[10])
        {
            Caption = 'Award Filter';
            FieldClass = FlowFilter;
            TableRelation = Award;
        }
        field(8012; "Award Sponsor Filter"; Code[20])
        {
            Caption = 'Award Sponsor Filter';
            FieldClass = FlowFilter;
            // TableRelation = Funder;
        }
        field(8013; "Investigator Filter"; Code[20])
        {
            Caption = 'Investigator Filter';
            FieldClass = FlowFilter;
            //TableRelation = "AV Contact";
        }
        field(8014; "Type Filter"; Code[10])
        {
            Caption = 'Type Filter';
            FieldClass = FlowFilter;
            // TableRelation = "Award Type";
        }
        field(8015; "Class Filter"; Code[10])
        {
            Caption = 'Class Filter';
            FieldClass = FlowFilter;
            // TableRelation = "Award Contact";
        }
        field(8016; "G/L Account Filter"; Code[20])
        {
            Caption = 'G/L Account Filter';
            FieldClass = FlowFilter;
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
        }
        field(8017; "Budget Plan Filter"; Code[10])
        {
            Caption = 'Budget Plan Filter';
            FieldClass = FlowFilter;
            //TableRelation = "BV Plan";
        }
        field(8018; "Entry Type Filter"; Option)
        {
            Caption = 'Entry Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = ' ,Proposal,,Estimate,,Obligation,,Modification,,,,Subaward,,Indirect Cost,Revenue,Invoice,Disbursement,Receipt';
            OptionMembers = " ",Proposal,,Estimate,,Obligation,,Modification,,,,Subaward,,"Indirect Cost",Revenue,Invoice,Disbursement,Receipt;
        }
        field(8020; "To Inter-Company Name Filter"; Text[30])
        {
            Caption = 'To Inter-Company Name Filter';
            FieldClass = FlowFilter;
            TableRelation = Company;
        }
        field(9000; Comment; Boolean)
        {

            Caption = 'Comment';
            Editable = false;
            // FieldClass = FlowField;
        }
        field(9002; "Sponsoring Funder Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Sponsoring Funder No.")));
            //  CalcFormula = Lookup(Funder.Name WHERE (No.=FIELD(Sponsoring Funder No.)));
            Caption = 'Sponsoring Funder Name';
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(9004; "Originating Funder Name"; Text[50])
        {
            /// CalcFormula = Lookup(Funder.Name WHERE (No.=FIELD(Originating Funder No.)));
            Caption = 'Sponsor Name';
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(9006; "Vendor Name"; Text[50])
        {
            // CalcFormula = Lookup(Vendor.Name WHERE (No.=FIELD(Vendor No.)));
            Caption = 'Subawardee Name';
            Editable = false;
            // FieldClass = FlowField;
        }
        field(9010; Obligation; Decimal)
        {

            Caption = 'Obligation';
            Editable = false;
            //  FieldClass = FlowField;
        }
        field(9012; "Obligation (LCY)"; Decimal)
        {

            Caption = 'Obligation (LCY)';
            Editable = false;
            //  FieldClass = FlowField;
        }
        field(9014; "Obligation (RCY)"; Decimal)
        {

            //   FieldClass = FlowField;
        }
        field(9016; "Obligation (ACY)"; Decimal)
        {

            Editable = false;
            //   FieldClass = FlowField;
        }
        field(9018; "Obligation (SCY)"; Decimal)
        {

            Editable = false;
            //   FieldClass = FlowField;
        }
        field(9020; Estimate; Decimal)
        {

            Editable = false;
            //  FieldClass = FlowField;
        }
        field(9022; "Estimate (LCY)"; Decimal)
        {

            Editable = false;
            //  FieldClass = FlowField;
        }
        field(9024; "Estimate (RCY)"; Decimal)
        {

            //  FieldClass = FlowField;
        }
        field(9026; "Estimate (ACY)"; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9028; "Estimate (SCY)"; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9030; "Subaward (LCY)"; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9032; "Subaward (RCY)"; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9034; "Subaward (ACY)"; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9036; "Subaward (SCY)"; Decimal)
        {

            Editable = false;
            //    FieldClass = FlowField;
        }
        field(9040; "Expenses (LCY)"; Decimal)
        {

            Editable = false;
            //  FieldClass = FlowField;
        }
        field(9044; "Expenses (ACY)"; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9046; "Expenses (SCY)"; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9050; Matching; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9052; "Matching (LCY)"; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9054; "Matching (RCY)"; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9056; "Matching (ACY)"; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9060; "Matching Fund Sources"; Integer)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9062; "Matching GIK Sources"; Integer)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9064; "No. of Awards Matched"; Integer)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9070; "Internal Modifications"; Integer)
        {

            //FieldClass = FlowField;
        }
        field(9072; "External Modifications"; Integer)
        {

            //FieldClass = FlowField;
        }
        field(9074; Modifications; Integer)
        {

            //    FieldClass = FlowField;
        }
        field(9080; "Dtld. Ledger Amount (LCY)"; Decimal)
        {

            Editable = false;
            //  FieldClass = FlowField;
        }
        field(9082; "Dtld. Ledger Amount (RCY)"; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9084; "Dtld. Ledger Amount (ACY)"; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9086; "Dtld. Ledger Amount (SCY)"; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9090; Actual; Decimal)
        {

            Caption = 'Actual';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(9091; Budget; Decimal)
        {
            Caption = 'Budget';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(9092; Commitments; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9093; Encumbrances; Decimal)
        {

        }
        field(9094; Statistical; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9095; Provisional; Decimal)
        {

            Editable = false;
            //FieldClass = FlowField;
        }
        field(9100; "Total Proposal (LCY)"; Decimal)
        {

            //FieldClass = FlowField;
        }
        field(9102; "Total Proposal (RCY)"; Decimal)
        {

            //FieldClass = FlowField;
        }
        field(9104; "Total Proposal (ACY)"; Decimal)
        {

            //FieldClass = FlowField;
        }

        field(9207; "Country/Region Code"; Code[50])
        {
            // TableRelation = Country/Region;
        }
        field(9208; "Project Leader"; Text[50])
        {
            TableRelation = Employee;
        }
        field(9214; test; Code[10])
        {
        }
        field(9215; Unit; Code[100])
        {
            // TableRelation = Unit;
        }
        field(9216; "code"; Code[100])
        {
        }
        field(9217; "Notify End Date On"; Date)
        {
            Caption = 'End Date';

            trigger OnValidate()
            begin
                /*IF ("End Date" <> 0D) AND ("Start Date" > "End Date") THEN
                  ERROR(SNText016,FIELDCAPTION("Start Date"),FIELDCAPTION("End Date"));
                
                IF ("Document Type" <> "Document Type"::Proposal) AND (Phase <> Phase::Planning) THEN
                  ERROR(SNText018)*/

            end;
        }
        field(9218; "Total Budget"; Decimal)
        {
        }
        field(9219; "signature & synergy"; Code[10])
        {
            Caption = 'signature, synergy and other issues';
            //TableRelation = "Signature & Synergy Issues.";
        }
        field(9220; "Project Profile"; Text[250])
        {
        }
        field(9221; "partners budget"; Decimal)
        {
        }
        field(923; "Amount awarded"; Decimal)
        {
            AutoFormatType = 1;

            //CaptionClass = '22,Subaward Obligations,'+"Award No.";
            Caption = 'Amount awarded';
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(924; "Amount invoiced to donors"; Decimal)
        {
            AutoFormatType = 1;

            // CaptionClass = '22,Subaward Obligations,'+"Award No.";
            Caption = 'Amount invoiced to donors';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry"."Debit Amount" where("G/L Account No." = const('8400|9400'), "Global Dimension 2 Code" = field("No.")));
        }

        field(925; "Budgeted cost"; Decimal)
        {
            AutoFormatType = 1;

            // CaptionClass = '22,Subaward Obligations,'+"Award No.";
            Caption = 'Budgeted cost';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Dimension Value"."Budget Amount" where("Project Code" = field("No.")));
        }

        field(926; "Received amount"; Decimal)
        {
            AutoFormatType = 1;

            // CaptionClass = '22,Subaward Obligations,'+"Award No.";
            Caption = 'Received amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry"."Credit Amount" where("G/L Account No." = const('1010'), "Global Dimension 2 Code" = field("No.")));

        }

        field(927; "Total expenditure"; Decimal)
        {
            AutoFormatType = 1;

            // CaptionClass = '22,Subaward Obligations,'+"Award No.";
            Caption = 'Total expenditure';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount where("G/L Account No." = filter('1890..7560'), "Global Dimension 2 Code" = field("No.")));
        }

        field(928; "Remaining amount"; Decimal)
        {
            AutoFormatType = 1;

            // CaptionClass = '22,Subaward Obligations,'+"Award No.";
            Caption = 'Remaining amount';
            // Editable = false;
            //FieldClass = FlowField;
            // CalcFormula=sum(Field())
        }

        field(929; "% Utilization"; Decimal)
        {
            AutoFormatType = 1;

            // CaptionClass = '22,Subaward Obligations,'+"Award No.";
            Caption = '% Utilization';
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(930; Closed; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; "Sponsoring Funder No.")
        {
        }
        key(Key4; "Award Dimension Value")
        {
        }
        key(Key5; "Document Type")
        {
        }
        key(Key6; "Parent No.")
        {
        }
        key(Key7; "Currency Code")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
        }
        key(Key8; Name)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*IF Phase = Phase::Negotiation THEN
          ERROR(SNText007,FORMAT(Phase));
        IF AVManagement.DetermineIfAwardExists("No.") THEN
          ERROR(SNText015);
        
        IF "Document Type" IN ["Document Type"::Award,"Document Type"::Subaward] THEN BEGIN
          AVLedgerEntry.RESET;
          AVLedgerEntry.SETCURRENTKEY("Award/Subaward No.");
          AVLedgerEntry.SETRANGE("Award/Subaward No.", "No.");
          IF "Document Type" = "Document Type"::Award THEN BEGIN
            AVLedgerEntry.SETFILTER("Entry Type",'<>%1',AVLedgerEntry."Entry Type"::Estimate);
          END;
          IF AVLedgerEntry.FINDFIRST THEN BEGIN
            ERROR(SNText013);
          END;
        END;
        
        IF "Document Type" = "Document Type"::Award THEN BEGIN
          DtldAVLedgerEntry.SETCURRENTKEY("Award/Subaward No.");
          DtldAVLedgerEntry.SETRANGE("Award/Subaward No.", "No.");
          DtldAVLedgerEntry.SETFILTER("To IC Partner Code", '<>%1', '');
          IF DtldAVLedgerEntry.FINDFIRST THEN
            ERROR(SNText022);
        END;
        
        CALCFIELDS(Modifications);
        IF Modifications <> 0 THEN
          ERROR(SNText019);
        
        GLEntry.SETCURRENTKEY("Award/Subaward No.");
        GLEntry.SETRANGE("Award/Subaward No.","No.");
        IF GLEntry.FINDFIRST THEN
          ERROR(SNText006);
        
        AVCommentLine.SETRANGE("Table Name",AVCommentLine."Table Name"::Award);
        AVCommentLine.SETRANGE("No.","No.");
        AVCommentLine.DELETEALL;
        
        AwardActivityLog.SETRANGE("Award No.","No.");
        AwardActivityLog.DELETEALL;
        
        AwardInvestigator.SETRANGE("Award No.","No.");
        AwardInvestigator.DELETEALL;
        
        ProposalLine.SETRANGE("Document No.","No.");
        ProposalLine.DELETEALL;
        
        ProposalLineDetail.SETRANGE("Document Type", "Document Type");
        ProposalLineDetail.SETRANGE("Document No.","No.");
        ProposalLineDetail.DELETEALL;
        
        AwardProtocol.SETRANGE("Award No.","No.");
        AwardProtocol.DELETEALL;
        
        AwardModificationHeader.SETRANGE("Award/Subaward No.","No.");
        AwardModificationHeader.DELETEALL;
        
        AwardModificationLine.SETRANGE("Award/Subaward No.","No.");
        AwardModificationLine.DELETEALL;
        
        AwardRate.RESET;
        AwardRate.SETRANGE("Award No.", "No.");
        AwardRate.DELETEALL;
        
        Milestone.RESET;
        Milestone.SETRANGE("Award No.", "No.");
        Milestone.DELETEALL(TRUE);
        
        AwardMatching.RESET;
        AwardMatching.SETRANGE("Award No.", "No.");
        AwardMatching.DELETEALL(TRUE);
        
        Certification.RESET;
        Certification.SETRANGE("No.", "No.");
        Certification.DELETEALL;
        
        DimMgt.DeleteDefaultDim(DATABASE::Award,"No.");
        GLTranManagement.DeleteLineDistributionBuffer("Internal Control No.");
        WorkflowManagement.DeleteCurrentApprovals("Internal Control No.");
        
        IF FileAttachment.READPERMISSION THEN BEGIN
          FileAttachment.DeleteDocuments(DATABASE::Award,"No.",'','');
        END;
        IF EFExtFieldEntry.READPERMISSION THEN BEGIN
          CASE "Document Type" OF
            "Document Type"::Proposal:
              EFExtendedFieldsMgt.AllowedTableOnDeleteV2(DATABASE::Award, PAGE::"Proposal Card", "No.", '', '');
            "Document Type"::Award:
              BEGIN
                EFExtendedFieldsMgt.AllowedTableOnDeleteV2(DATABASE::Award, PAGE::"Award Card", "No.", '', '');
                EFExtendedFieldsMgt.AllowedTableOnDeleteV2(DATABASE::Award, PAGE::"AV Terms & Conditions Card", "No.", '', '');
              END;
            "Document Type"::Subaward:
              BEGIN
                EFExtendedFieldsMgt.AllowedTableOnDeleteV2(DATABASE::Award, PAGE::"Subaward Card", "No.", '', '');
                EFExtendedFieldsMgt.AllowedTableOnDeleteV2(DATABASE::Award, PAGE::"AV Terms & Conditions Card", "No.", '', '');
              END;
          END;
        END;*/

    end;

}
