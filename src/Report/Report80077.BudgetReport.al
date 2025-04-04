report 80077 "BudgetReport"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/BudgetReport.rdlc';


    dataset
    {

        dataitem("Dimension Value"; "Dimension Value")
        {
            RequestFilterFields = "Project Code";//, "Date Filter";
            column(CompanyInformation_Pic; CompanyInformation.Picture) { }
            column(CompanyInformation_address; CompanyInformation.Address) { }
            column(CompanyInformation_Phone; CompanyInformation."Phone No.") { }
            column(CompanyInformation_name; CompanyInformation.Name) { }
            column(CompanyInformation_Address2; CompanyInformation."Address 2") { }
            column(CompanyInformation_homepage; CompanyInformation."Home Page") { }
            column(CompanyInformation_Email; CompanyInformation."E-Mail") { }
            column(Dimension_Code; "Dimension Code")
            {
            }
            column(Code; Code)
            {

            }
            column(Name; Name) { }
            column(Project_Code; "Project Code")
            {

            }
            column(Budget_Amount; "Budget Amount") { }
            column(Actual_Spent; "Actual Spent") { }
            column(Variance; "Budget Amount" - "Actual Spent") { }
            column(RemainingAmount; BudgetPercent) { }
            column(Utilisation; UtilisationPercent) { }
            // dataitem("G/L Entry"; "G/L Entry")
            // {
            //     DataItemLink = "Global Dimension 1 Code" = field("Project Code");
            //     RequestFilterFields = "Posting Date";
            //     column(PostingDate_GLEntry; Format("Posting Date"))
            //     {
            //     }
            // }

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
                //  HREmployees.Get();
                // HREmployees.CalcFields(Signature);
            end;

            trigger OnAfterGetRecord()
            begin

                NameIndent := 0;
                // FormatLine;


                if "Currency Code" = '' then begin

                    if "Budget Amount" > 0 then begin
                        BudgetPercent := (("Budget Amount" - "Actual Spent") / "Budget Amount") * 100
                    end else begin
                        BudgetPercent := 0;


                    end;
                    if "Budget Amount" > 0 then begin
                        UtilisationPercent := 100 - BudgetPercent;
                    end else begin
                        UtilisationPercent := 0;
                    end;
                end else begin
                    "Actual Spent" := 0;
                end;



            end;




        }
        //      trigger onop

    }
    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            // var

            begin
                if DimensionValue.GetFilter("Dimension Code") <> '' then
                    DimensionCode := DimensionValue.GetRangeMin("Dimension Code");
                if DimensionCode <> '' then begin
                    DimensionValue.FilterGroup(2);
                    DimensionValue.SetRange("Dimension Code", DimensionCode);
                    DimensionValue.FilterGroup(0);
                end;
            end;
        end;
    }

    var

        Emphasize: Boolean;

        NameIndent: Integer;
        BudgetPercent: Decimal;
        UtilisationPercent: Decimal;
        "BudgetPercent(OtherCurrency)": Decimal;
        DimensionValue: Record "Dimension Value";
        DimensionCode: Code[20];
        CompanyInformation: Record "Company Information";

    // local procedure FormatLine()
    // begin
    //     Emphasize := Rec."Dimension Value Type" <> Rec."dimension value type"::Standard;
    //     NameIndent := Rec.Indentation;
    // end;
}