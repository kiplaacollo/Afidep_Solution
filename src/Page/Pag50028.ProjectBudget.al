Page 50028 "Project Budget"
{
    Caption = 'Dimension Values';
    DataCaptionFields = "Dimension Code";
    DelayedInsert = true;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = ALL;
    SourceTable = "Dimension Value";
    // SourceTableView = sorting("Dimension Value ID")
    //                   order(ascending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;

                field(Code; Rec.Code)
                {
                    ApplicationArea = Dimensions;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ToolTip = 'Specifies the code for the dimension value.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Dimensions;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ToolTip = 'Specifies a descriptive name for the dimension value.';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = Dimensions;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ToolTip = 'Specifies a descriptive name for the dimension value.';
                }
                field("Dimension Value Type"; Rec."Dimension Value Type")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the purpose of the dimension value.';
                }
                field(Totaling; Rec.Totaling)
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies an account interval or a list of account numbers. The entries of the account will be totaled to give a total balance. How entries are totaled depends on the value in the Account Type field.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimVal: Record "Dimension Value";
                        DimValList: Page "Dimension Value List";
                    begin
                        DimVal := Rec;
                        DimVal.SetRange("Dimension Code", Rec."Dimension Code");
                        DimValList.SetTableview(DimVal);
                        DimValList.LookupMode := true;
                        if DimValList.RunModal = Action::LookupOK then begin
                            DimValList.GetRecord(DimVal);
                            Text := DimVal.Code;
                            exit(true);
                        end;
                        exit(false);
                    end;
                }

                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = Basic;
                }

                field("Outcome Code"; Rec."Outcome Code") { }
                field("Thematic Code"; Rec."Thematic Code") { }

                field("Budget Amount"; Rec."Budget Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Actual Spent"; Rec."Actual Spent")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Variance; Rec."Budget Amount" - Rec."Actual Spent")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("% Remaining"; BudgetPercent)
                {
                    ApplicationArea = Basic;
                }
                field("% Utilisation"; UtilisationPercent)
                {
                    ApplicationArea = Basic;
                }
                field("Budget Amount(Other Currency)"; Rec."Budget Amount(Other Currency)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Actual Spent (Other Currency)"; Rec."Actual Spent (Other Currency)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Variance(Donor Currency)"; Rec."Budget Amount(Other Currency)" - Rec."Actual Spent (Other Currency)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("% (Donor Currency)"; "BudgetPercent(OtherCurrency)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Donor Code"; Rec."Donor Code") { }

                field("Branch Code"; Rec."Branch Code") { }
                field("Department Code"; Rec."Department Code") { }
                field("Activity Code"; Rec."Activity Code") { }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            action("Burn Rate Report")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report 80077;
            }//
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Indent Dimension Values")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Indent Dimension Values';
                    Image = Indent;
                    RunObject = Codeunit "Dimension Value-Indent";
                    RunPageOnRec = true;
                    ToolTip = 'Indent dimension values between a Begin-Total and the matching End-Total one level to make the list easier to read.';
                }
                action("Upload Budget")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Upload Budget';
                    Image = Indent;
                    RunPageOnRec = true;

                    trigger OnAction()
                    begin
                        Xmlport.Run(50000, false);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        NameIndent := 0;
        FormatLine;


        if Rec."Currency Code" = '' then begin

            if Rec."Budget Amount" > 0 then begin
                BudgetPercent := ((Rec."Budget Amount" - Rec."Actual Spent") / Rec."Budget Amount") * 100
            end else begin
                BudgetPercent := 0;


            end;
            if Rec."Budget Amount" > 0 then begin
                UtilisationPercent := 100 - BudgetPercent;
            end else begin
                UtilisationPercent := 0;
            end;
        end else begin
            Rec."Actual Spent" := 0;
        end;

        if Rec."Currency Code" <> '' then begin
            if (Rec."Budget Amount(Other Currency)" - Rec."Actual Spent (Other Currency)") <> 0 then begin
                "BudgetPercent(OtherCurrency)" := ((Rec."Budget Amount(Other Currency)" - Rec."Actual Spent (Other Currency)") / Rec."Budget Amount(Other Currency)") * 100
            end else begin
                "BudgetPercent(OtherCurrency)" := 0;
            end
        end else begin
            Rec."Actual Spent (Other Currency)" := 0;
        end;


    end;

    trigger OnOpenPage()
    var
        DimensionCode: Code[20];
    begin
        if Rec.GetFilter(Rec."Dimension Code") <> '' then
            DimensionCode := Rec.GetRangeMin(Rec."Dimension Code");
        if DimensionCode <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange(Rec."Dimension Code", DimensionCode);
            Rec.FilterGroup(0);
        end;
    end;

    var

        Emphasize: Boolean;

        NameIndent: Integer;
        BudgetPercent: Decimal;
        UtilisationPercent: Decimal;
        "BudgetPercent(OtherCurrency)": Decimal;
        DimensionValue: Record "Dimension Value";

    local procedure FormatLine()
    begin
        Emphasize := Rec."Dimension Value Type" <> Rec."dimension value type"::Standard;
        NameIndent := Rec.Indentation;
    end;
}

