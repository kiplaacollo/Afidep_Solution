tableextension 50109 "DimensionValueExtension" extends "Dimension Value"
{
    fields
    {
        field(8009; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROJECTS'));

            trigger OnValidate()
            begin
                DimensionValue.Reset;
                DimensionValue.SetRange("Project Code", "Project Code");
                DimensionValue.SetRange("Dimension Code", 'PROJECTS');
                if DimensionValue.FindFirst then
                    "Currency Code" := DimensionValue."Currency Code";
            end;
        }
        field(8003; "Budget Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(8004; "Actual Spent"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("Global Dimension 2 Code" = field("Project Code"), "G/L Account No." = filter('1890..7560'), "Shortcut Dimension 3 Code" = field(code), "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;

            trigger OnLookup()
            begin
                // UserSetup.Get(UserId);
                // if UserSetup."View Payroll" = false then
                //     Error('You do not have permision');
            end;
        }
        field(8005; "G/L Account"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            trigger OnValidate()
            var
                GLAccount: Record "G/L Account";
            begin
                "G/L Account Name" := '';
                GLAccount.Reset();
                GLAccount.SetRange("No.", "G/L Account");
                if GLAccount.Find('-') then begin
                    "G/L Account Name" := GLAccount.Name;
                    //"Date Filter" := GLAccount."Date Filter";
                end;
            end;
        }
        field(8006; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
        }
        field(8007; "Budget Amount(Other Currency)"; Decimal)
        {
            Caption = 'Budget Amount(Donor Currency)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(8008; "Actual Spent (Other Currency)"; Decimal)
        {
            CalcFormula = sum("G/L Entry"."Additional-Currency Amount" where("Global Dimension 2 Code" = field(Code),

                                                                              "Global Dimension 1 Code" = field("Project Code")));
            Caption = 'Actual Spent (Donor Currency)';
            FieldClass = FlowField;

            trigger OnLookup()
            begin
                // UserSetup.Get(UserId);
                // if UserSetup."View Payroll" = false then
                //     Error('You do not have permision');
            end;
        }
        field(172000; "G/L Account Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(172001; "Branch Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCH'));
        }
        field(172002; "Activity Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DELIVERABLE/ACTIVITY'));
        }
        field(172003; "Department Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }
        field(172004; "Donor Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DONOR'));
        }
        field(172005; "Thematic Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('THEMATIC'));
        }
        field(172006; "Outcome Code"; Code[100])
        {

            Caption = 'Expenditure category';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('EXPCATEGORIES'));
        }


        field(172007; Description; Text[250])
        {

        }
        field(172008; "Approver ID"; Code[30])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(172009; "BudgetLine Disabled"; Boolean)
        {

        }
        field(172010; "Date Filter"; date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
            TableRelation = "G/L Entry";
            trigger OnValidate()
            var
                GLEntry: Record "G/L Entry";
            begin
                "Date Filter" := 0D;
                GLEntry.Reset();
                GLEntry.SetRange("G/L Account No.", "G/L Account");
                if GLEntry.Find('-') then begin
                    "Date Filter" := GLEntry."Posting Date";
                end;

            end;
        }
        field(172011; Closed; Boolean)
        {

        }

    }










    var
        Text000: label '%1\You cannot delete it.';
        Text002: label '(CONFLICT)';
        Text003: label '%1 can not be (CONFLICT). This name is used internally by the system.';
        Text004: label '%1\You cannot change the type.';
        Text005: label 'This dimension value has been used in posted or budget entries.';
        DimSetEntry: Record "Dimension Set Entry";
        DimValueComb: Record "Dimension Value Combination";
        DefaultDim: Record "Default Dimension";
        SelectedDim: Record "Selected Dimension";
        AnalysisSelectedDim: Record "Analysis Selected Dimension";
        CostAccSetup: Record "Cost Accounting Setup";
        CostAccMgt: Codeunit "Cost Account Mgt";
        Text006: label 'You cannot change the value of %1.';
        DimensionValue: Record "Dimension Value";
        UserSetup: Record "User Setup";











}

