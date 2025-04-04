Table 172055 "Project Implementation Plan"
{
    Caption = 'Project Implementation Plan';
    LookupPageID = "Project Work Plan";

    fields
    {
        field(1;"Dimension Code";Code[20])
        {
            Caption = 'Dimension Code';
            NotBlank = true;
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                UpdateMapToICDimensionCode;
            end;
        }
        field(2;"Code";Code[10])
        {
            Caption = 'Code';
            NotBlank = true;

            trigger OnValidate()
            begin
                if UpperCase(Code) = Text002 then
                  Error(Text003,
                    FieldCaption(Code));
            end;
        }
        field(3;Name;Text[250])
        {
            Caption = 'Name';
        }
        field(4;"Dimension Value Type";Option)
        {
            Caption = 'Dimension Value Type';
            OptionCaption = 'Standard,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Standard,Heading,Total,"Begin-Total","End-Total";

            trigger OnValidate()
            begin
                if ("Dimension Value Type" <> "dimension value type"::Standard) and
                   (xRec."Dimension Value Type" = xRec."dimension value type"::Standard)
                then
                  if CheckIfDimValueUsed then
                    Error(Text004,GetCheckDimErr);
                Totaling := '';
            end;
        }
        field(5;Totaling;Text[250])
        {
            Caption = 'Totaling';
            TableRelation = if ("Dimension Value Type"=const(Total)) "Dimension Value"."Dimension Code" where ("Dimension Code"=field("Dimension Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if not ("Dimension Value Type" in
                        ["dimension value type"::Total,"dimension value type"::"End-Total"]) and (Totaling <> '')
                then
                  FieldError("Dimension Value Type");
            end;
        }
        field(6;Blocked;Boolean)
        {
            Caption = 'Blocked';
        }
        field(7;"Consolidation Code";Code[20])
        {
            AccessByPermission = TableData "Business Unit"=R;
            Caption = 'Consolidation Code';
        }
        field(8;Indentation;Integer)
        {
            Caption = 'Indentation';
        }
        field(9;"Global Dimension No.";Integer)
        {
            Caption = 'Global Dimension No.';
        }
        field(10;"Map-to IC Dimension Code";Code[20])
        {
            Caption = 'Map-to IC Dimension Code';

            trigger OnValidate()
            begin
                if "Map-to IC Dimension Code" <> xRec."Map-to IC Dimension Code" then
                  Validate("Map-to IC Dimension Value Code",'');
            end;
        }
        field(11;"Map-to IC Dimension Value Code";Code[20])
        {
            Caption = 'Map-to IC Dimension Value Code';
            TableRelation = "IC Dimension Value".Code where ("Dimension Code"=field("Map-to IC Dimension Code"));
        }
        field(12;"Dimension Value ID";Integer)
        {
            Caption = 'Dimension Value ID';
            Editable = false;

            trigger OnValidate()
            begin
                Error(Text006,FieldCaption("Dimension Value ID"));
            end;
        }
        field(8000;Id;Guid)
        {
            Caption = 'Id';
        }
        field(8001;"Last Modified Date Time";DateTime)
        {
            Caption = 'Last Modified Date Time';
        }
        field(8002;"Project Code";Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where ("Dimension Code"=const('PROJECT'));
        }
        field(8003;"Budget Amount";Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3:3;
        }
        field(8004;"Actual Spent";Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where ("Global Dimension 2 Code"=field(Code)));
            FieldClass = FlowField;
        }
        field(8005;"G/L Account";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(8006;"Start Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8007;"End Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8008;Comments;Text[1000])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Dimension Code","Code","Project Code",Name)
        {
            Clustered = true;
        }
        key(Key2;"Code","Global Dimension No.")
        {
        }
        key(Key3;Name)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Code",Name)
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

    procedure CheckIfDimValueUsed(): Boolean
    begin
        DimSetEntry.SetCurrentkey("Dimension Value ID");
        DimSetEntry.SetRange("Dimension Value ID","Dimension Value ID");
        exit(not DimSetEntry.IsEmpty);
    end;

    local procedure GetCheckDimErr(): Text[250]
    begin
        exit(Text005);
    end;

    local procedure RenameBudgEntryDim()
    var
        GLBudget: Record "G/L Budget Name";
        GLBudgetEntry: Record "G/L Budget Entry";
        GLBudgetEntry2: Record "G/L Budget Entry";
        BudgDimNo: Integer;
    begin
        /*GLBudget.LOCKTABLE;
        IF GLBudget.FIND('-') THEN
          REPEAT
          UNTIL GLBudget.NEXT = 0;
        FOR BudgDimNo := 1 TO 4 DO BEGIN
          CASE TRUE OF
            BudgDimNo = 1:
              GLBudget.SETRANGE("Budget Dimension 1 Code","Dimension Code");
            BudgDimNo = 2:
              GLBudget.SETRANGE("Budget Dimension 2 Code","Dimension Code");
            BudgDimNo = 3:
              GLBudget.SETRANGE("Budget Dimension 3 Code","Dimension Code");
            BudgDimNo = 4:
              GLBudget.SETRANGE("Budget Dimension 4 Code","Dimension Code");
          END;
          IF GLBudget.FIND('-') THEN BEGIN
            GLBudgetEntry.SETCURRENTKEY("Budget Name","G/L Account No.","Business Unit Code","Global Dimension 1 Code");
            REPEAT
              GLBudgetEntry.SETRANGE("Budget Name",GLBudget.Name);
              CASE TRUE OF
                BudgDimNo = 1:
                  GLBudgetEntry.SETRANGE("Budget Dimension 1 Code",xRec.Code);
                BudgDimNo = 2:
                  GLBudgetEntry.SETRANGE("Budget Dimension 2 Code",xRec.Code);
                BudgDimNo = 3:
                  GLBudgetEntry.SETRANGE("Budget Dimension 3 Code",xRec.Code);
                BudgDimNo = 4:
                  GLBudgetEntry.SETRANGE("Budget Dimension 4 Code",xRec.Code);
              END;
              IF GLBudgetEntry.FIND('-') THEN
                REPEAT
                  GLBudgetEntry2 := GLBudgetEntry;
                  CASE TRUE OF
                    BudgDimNo = 1:
                      GLBudgetEntry2."Budget Dimension 1 Code" := Code;
                    BudgDimNo = 2:
                      GLBudgetEntry2."Budget Dimension 2 Code" := Code;
                    BudgDimNo = 3:
                      GLBudgetEntry2."Budget Dimension 3 Code" := Code;
                    BudgDimNo = 4:
                      GLBudgetEntry2."Budget Dimension 4 Code" := Code;
                  END;
                  GLBudgetEntry2.MODIFY;
                UNTIL GLBudgetEntry.NEXT = 0;
              GLBudgetEntry.RESET;
            UNTIL GLBudget.NEXT = 0;
          END;
          GLBudget.RESET;
        END;
        */

    end;

    local procedure RenameAnalysisViewEntryDim()
    var
        AnalysisView: Record "Analysis View";
        AnalysisViewEntry: Record "Analysis View Entry";
        AnalysisViewEntry2: Record "Analysis View Entry";
        AnalysisViewBudgEntry: Record "Analysis View Budget Entry";
        AnalysisViewBudgEntry2: Record "Analysis View Budget Entry";
        DimensionNo: Integer;
    begin
        /*AnalysisView.LOCKTABLE;
        IF AnalysisView.FIND('-') THEN
          REPEAT
          UNTIL AnalysisView.NEXT = 0;
        
        FOR DimensionNo := 1 TO 4 DO BEGIN
          CASE TRUE OF
            DimensionNo = 1:
              AnalysisView.SETRANGE("Dimension 1 Code","Dimension Code");
            DimensionNo = 2:
              AnalysisView.SETRANGE("Dimension 2 Code","Dimension Code");
            DimensionNo = 3:
              AnalysisView.SETRANGE("Dimension 3 Code","Dimension Code");
            DimensionNo = 4:
              AnalysisView.SETRANGE("Dimension 4 Code","Dimension Code");
          END;
          IF AnalysisView.FIND('-') THEN
            REPEAT
              AnalysisViewEntry.SETRANGE("Analysis View Code",AnalysisView.Code);
              AnalysisViewBudgEntry.SETRANGE("Analysis View Code",AnalysisView.Code);
              CASE TRUE OF
                DimensionNo = 1:
                  BEGIN
                    AnalysisViewEntry.SETRANGE("Dimension 1 Value Code",xRec.Code);
                    AnalysisViewBudgEntry.SETRANGE("Dimension 1 Value Code",xRec.Code);
                  END;
                DimensionNo = 2:
                  BEGIN
                    AnalysisViewEntry.SETRANGE("Dimension 2 Value Code",xRec.Code);
                    AnalysisViewBudgEntry.SETRANGE("Dimension 2 Value Code",xRec.Code);
                  END;
                DimensionNo = 3:
                  BEGIN
                    AnalysisViewEntry.SETRANGE("Dimension 3 Value Code",xRec.Code);
                    AnalysisViewBudgEntry.SETRANGE("Dimension 3 Value Code",xRec.Code);
                  END;
                DimensionNo = 4:
                  BEGIN
                    AnalysisViewEntry.SETRANGE("Dimension 4 Value Code",xRec.Code);
                    AnalysisViewBudgEntry.SETRANGE("Dimension 4 Value Code",xRec.Code);
                  END;
              END;
              IF AnalysisViewEntry.FIND('-') THEN
                REPEAT
                  AnalysisViewEntry2 := AnalysisViewEntry;
                  CASE TRUE OF
                    DimensionNo = 1:
                      AnalysisViewEntry2."Dimension 1 Value Code" := Code;
                    DimensionNo = 2:
                      AnalysisViewEntry2."Dimension 2 Value Code" := Code;
                    DimensionNo = 3:
                      AnalysisViewEntry2."Dimension 3 Value Code" := Code;
                    DimensionNo = 4:
                      AnalysisViewEntry2."Dimension 4 Value Code" := Code;
                  END;
                  AnalysisViewEntry.DELETE;
                  AnalysisViewEntry2.INSERT;
                UNTIL AnalysisViewEntry.NEXT = 0;
              AnalysisViewEntry.RESET;
              IF AnalysisViewBudgEntry.FIND('-') THEN
                REPEAT
                  AnalysisViewBudgEntry2 := AnalysisViewBudgEntry;
                  CASE TRUE OF
                    DimensionNo = 1:
                      AnalysisViewBudgEntry2."Dimension 1 Value Code" := Code;
                    DimensionNo = 2:
                      AnalysisViewBudgEntry2."Dimension 2 Value Code" := Code;
                    DimensionNo = 3:
                      AnalysisViewBudgEntry2."Dimension 3 Value Code" := Code;
                    DimensionNo = 4:
                      AnalysisViewBudgEntry2."Dimension 4 Value Code" := Code;
                  END;
                  AnalysisViewBudgEntry.DELETE;
                  AnalysisViewBudgEntry2.INSERT;
                UNTIL AnalysisViewBudgEntry.NEXT = 0;
              AnalysisViewBudgEntry.RESET;
            UNTIL AnalysisView.NEXT = 0;
          AnalysisView.RESET;
        END;
        */

    end;

    local procedure RenameItemBudgEntryDim()
    var
        ItemBudget: Record "Item Budget Name";
        ItemBudgetEntry: Record "Item Budget Entry";
        ItemBudgetEntry2: Record "Item Budget Entry";
        BudgDimNo: Integer;
    begin
        /*ItemBudget.LOCKTABLE;
        IF ItemBudget.FIND('-') THEN
          REPEAT
          UNTIL ItemBudget.NEXT = 0;
        
        FOR BudgDimNo := 1 TO 3 DO BEGIN
          CASE TRUE OF
            BudgDimNo = 1:
              ItemBudget.SETRANGE("Budget Dimension 1 Code","Dimension Code");
            BudgDimNo = 2:
              ItemBudget.SETRANGE("Budget Dimension 2 Code","Dimension Code");
            BudgDimNo = 3:
              ItemBudget.SETRANGE("Budget Dimension 3 Code","Dimension Code");
          END;
          IF ItemBudget.FIND('-') THEN BEGIN
            ItemBudgetEntry.SETCURRENTKEY(
              "Analysis Area","Budget Name","Item No.","Source Type","Source No.",Date,"Location Code","Global Dimension 1 Code");
            REPEAT
              ItemBudgetEntry.SETRANGE("Analysis Area",ItemBudget."Analysis Area");
              ItemBudgetEntry.SETRANGE("Budget Name",ItemBudget.Name);
              CASE TRUE OF
                BudgDimNo = 1:
                  ItemBudgetEntry.SETRANGE("Budget Dimension 1 Code",xRec.Code);
                BudgDimNo = 2:
                  ItemBudgetEntry.SETRANGE("Budget Dimension 2 Code",xRec.Code);
                BudgDimNo = 3:
                  ItemBudgetEntry.SETRANGE("Budget Dimension 3 Code",xRec.Code);
              END;
              IF ItemBudgetEntry.FIND('-') THEN
                REPEAT
                  ItemBudgetEntry2 := ItemBudgetEntry;
                  CASE TRUE OF
                    BudgDimNo = 1:
                      ItemBudgetEntry2."Budget Dimension 1 Code" := Code;
                    BudgDimNo = 2:
                      ItemBudgetEntry2."Budget Dimension 2 Code" := Code;
                    BudgDimNo = 3:
                      ItemBudgetEntry2."Budget Dimension 3 Code" := Code;
                  END;
                  ItemBudgetEntry2.MODIFY;
                UNTIL ItemBudgetEntry.NEXT = 0;
              ItemBudgetEntry.RESET;
            UNTIL ItemBudget.NEXT = 0;
          END;
          ItemBudget.RESET;
        END;
        */

    end;

    local procedure RenameItemAnalysisViewEntryDim()
    var
        ItemAnalysisView: Record "Item Analysis View";
        ItemAnalysisViewEntry: Record "Item Analysis View Entry";
        ItemAnalysisViewEntry2: Record "Item Analysis View Entry";
        ItemAnalysisViewBudgEntry: Record "Item Analysis View Budg. Entry";
        ItemAnalysisViewBudgEntry2: Record "Item Analysis View Budg. Entry";
        DimensionNo: Integer;
    begin
        /*ItemAnalysisView.LOCKTABLE;
        IF ItemAnalysisView.FIND('-') THEN
          REPEAT
          UNTIL ItemAnalysisView.NEXT = 0;
        
        FOR DimensionNo := 1 TO 3 DO BEGIN
          CASE TRUE OF
            DimensionNo = 1:
              ItemAnalysisView.SETRANGE("Dimension 1 Code","Dimension Code");
            DimensionNo = 2:
              ItemAnalysisView.SETRANGE("Dimension 2 Code","Dimension Code");
            DimensionNo = 3:
              ItemAnalysisView.SETRANGE("Dimension 3 Code","Dimension Code");
          END;
          IF ItemAnalysisView.FIND('-') THEN
            REPEAT
              ItemAnalysisViewEntry.SETRANGE("Analysis Area",ItemAnalysisView."Analysis Area");
              ItemAnalysisViewEntry.SETRANGE("Analysis View Code",ItemAnalysisView.Code);
              ItemAnalysisViewBudgEntry.SETRANGE("Analysis Area",ItemAnalysisView."Analysis Area");
              ItemAnalysisViewBudgEntry.SETRANGE("Analysis View Code",ItemAnalysisView.Code);
              CASE TRUE OF
                DimensionNo = 1:
                  BEGIN
                    ItemAnalysisViewEntry.SETRANGE("Dimension 1 Value Code",xRec.Code);
                    ItemAnalysisViewBudgEntry.SETRANGE("Dimension 1 Value Code",xRec.Code);
                  END;
                DimensionNo = 2:
                  BEGIN
                    ItemAnalysisViewEntry.SETRANGE("Dimension 2 Value Code",xRec.Code);
                    ItemAnalysisViewBudgEntry.SETRANGE("Dimension 2 Value Code",xRec.Code);
                  END;
                DimensionNo = 3:
                  BEGIN
                    ItemAnalysisViewEntry.SETRANGE("Dimension 3 Value Code",xRec.Code);
                    ItemAnalysisViewBudgEntry.SETRANGE("Dimension 3 Value Code",xRec.Code);
                  END;
              END;
              IF ItemAnalysisViewEntry.FIND('-') THEN
                REPEAT
                  ItemAnalysisViewEntry2 := ItemAnalysisViewEntry;
                  CASE TRUE OF
                    DimensionNo = 1:
                      ItemAnalysisViewEntry2."Dimension 1 Value Code" := Code;
                    DimensionNo = 2:
                      ItemAnalysisViewEntry2."Dimension 2 Value Code" := Code;
                    DimensionNo = 3:
                      ItemAnalysisViewEntry2."Dimension 3 Value Code" := Code;
                  END;
                  ItemAnalysisViewEntry.DELETE;
                  ItemAnalysisViewEntry2.INSERT;
                UNTIL ItemAnalysisViewEntry.NEXT = 0;
              ItemAnalysisViewEntry.RESET;
              IF ItemAnalysisViewBudgEntry.FIND('-') THEN
                REPEAT
                  ItemAnalysisViewBudgEntry2 := ItemAnalysisViewBudgEntry;
                  CASE TRUE OF
                    DimensionNo = 1:
                      ItemAnalysisViewBudgEntry2."Dimension 1 Value Code" := Code;
                    DimensionNo = 2:
                      ItemAnalysisViewBudgEntry2."Dimension 2 Value Code" := Code;
                    DimensionNo = 3:
                      ItemAnalysisViewBudgEntry2."Dimension 3 Value Code" := Code;
                  END;
                  ItemAnalysisViewBudgEntry.DELETE;
                  ItemAnalysisViewBudgEntry2.INSERT;
                UNTIL ItemAnalysisViewBudgEntry.NEXT = 0;
              ItemAnalysisViewBudgEntry.RESET;
            UNTIL ItemAnalysisView.NEXT = 0;
          ItemAnalysisView.RESET;
        END;
        */

    end;

    procedure LookUpDimFilter(Dim: Code[20];var Text: Text): Boolean
    var
        DimVal: Record "Dimension Value";
        DimValList: Page "Dimension Value List";
    begin
        if Dim = '' then
          exit(false);
        DimValList.LookupMode(true);
        DimVal.SetRange("Dimension Code",Dim);
        DimValList.SetTableview(DimVal);
        if DimValList.RunModal = Action::LookupOK then begin
          Text := DimValList.GetSelectionFilter;
          exit(true);
        end;
        exit(false)
    end;

    procedure LookupDimValue(DimCode: Code[20];var DimValueCode: Code[20])
    var
        DimValue: Record "Dimension Value";
        DimValuesList: Page "Dimension Values";
    begin
        DimValue.SetRange("Dimension Code",DimCode);
        DimValuesList.LookupMode := true;
        DimValuesList.SetTableview(DimValue);
        if DimValue.Get(DimCode,DimValueCode) then
          DimValuesList.SetRecord(DimValue);
        if DimValuesList.RunModal = Action::LookupOK then begin
          DimValuesList.GetRecord(DimValue);
          DimValueCode := DimValue.Code;
        end;
    end;

    local procedure GetGlobalDimensionNo(): Integer
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        GeneralLedgerSetup.Get;
        case "Dimension Code" of
          GeneralLedgerSetup."Global Dimension 1 Code":
            exit(1);
          GeneralLedgerSetup."Global Dimension 2 Code":
            exit(2);
          GeneralLedgerSetup."Shortcut Dimension 3 Code":
            exit(3);
          GeneralLedgerSetup."Shortcut Dimension 4 Code":
            exit(4);
          GeneralLedgerSetup."Shortcut Dimension 5 Code":
            exit(5);
          GeneralLedgerSetup."Shortcut Dimension 6 Code":
            exit(6);
          GeneralLedgerSetup."Shortcut Dimension 7 Code":
            exit(7);
          GeneralLedgerSetup."Shortcut Dimension 8 Code":
            exit(8);
          else
            exit(0);
        end;
    end;

    local procedure SetLastModifiedDateTime()
    begin
        "Last Modified Date Time" := CurrentDatetime;
    end;

    local procedure UpdateMapToICDimensionCode()
    var
        Dimension: Record Dimension;
    begin
        Dimension.Get("Dimension Code");
        Validate("Map-to IC Dimension Code",Dimension."Map-to IC Dimension Code");
    end;
}

