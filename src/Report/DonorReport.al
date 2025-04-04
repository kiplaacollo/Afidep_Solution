report 50000 DonorReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/DonorReport.rdl';
    dataset
    {

        dataitem("G/L Account"; "G/L Account")
        {
            //DataItemLink = "No." = field(code);
            DataItemTableView = where("Income/Balance" = filter('Income Statement'));
            RequestFilterFields = "No.";
            column(No_; "No.") { }
            column(Name; Name) { }
            column(CompanyInformation_Pic; CompanyInformation.Picture) { }
            column(CompanyInformation_address; CompanyInformation.Address) { }
            column(CompanyInformation_Phone; CompanyInformation."Phone No.") { }
            column(CompanyInformation_name; CompanyInformation.Name) { }
            column(CompanyInformation_Address2; CompanyInformation."Address 2") { }
            column(CompanyInformation_homepage; CompanyInformation."Home Page") { }
            column(CompanyInformation_Email; CompanyInformation."E-Mail") { }
            column(Empty; Empty) { }
            column(AmountDecimal; AmountDecimal) { }
            column(DimensionValue; DimensionValue) { }
            column(SumPeroject; SumPeroject) { }



            dataitem("G/L Budget Entry"; "G/L Budget Entry")
            {
                DataItemLink = "G/L Account No." = field("No.");
                DataItemTableView = where(Amount = filter(> 0));
                column(Amount; Amount) { }
                column(G_L_Account_No_1; "G/L Account No.") { }
                column(Global_Dimension_1_Code2; "Global Dimension 1 Code") { }
                //column(SumPeroject; SumPeroject) { }

                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "G/L Account No." = field("G/L Account No.");
                    //DataItemLink = "Global Dimension 1 Code" = field("Global Dimension 1 Code");

                    RequestFilterFields = "Global Dimension 1 Code", "Posting Date";
                    column(G_L_Account_No_; "G/L Account No.")
                    {

                    }
                    column(Global_Dimension_1_Code; "Global Dimension 1 Code") { }

                    column(GLAmount; Amount) { }



                    dataitem("Dimension Value"; "Dimension Value")
                    {

                        DataItemLink = code = field("Global Dimension 1 Code");
                        column(Dimension_Code; "Dimension Code")
                        {

                        }
                        column(DimValueCode; Code) { }
                        column(DimvalueName; Name) { }
                    }
                }
                trigger OnPreDataItem()
                begin
                    //SumPeroject := FnGetTotalBudget();
                end;

                trigger OnAfterGetRecord()
                begin
                    DimensionValue := 0;
                    DimensionCodeBuffer.Reset();
                    DimensionCodeBuffer.SetRange("Global Dimension 1 Code", "G/L Budget Entry"."Global Dimension 1 Code");
                    if DimensionCodeBuffer.Find('-') then begin
                        repeat
                            DimensionValue := DimensionValue + DimensionCodeBuffer.Amount;
                        until DimensionCodeBuffer.Next() = 0;
                    end;

                end;

            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
                SumPeroject := FnGetTotalBudget();
                Message('%1', SumPeroject);
            end;

            trigger OnAfterGetRecord()
            begin
                Empty := '';
                AmountDecimal := 0;

            end;


        }


    }







    var
        myInt: Integer;

        DimensionCodeBuffer: Record "G/L Budget Entry";
        DimensionValue: Decimal;
        CompanyInfo: Record "Company Information";
        CompanyInformation: Record "Company Information";
        Empty: Text[500];
        AmountDecimal: Decimal;
        SumPeroject: Decimal;

    procedure FnGetTotalBudget() Amount: Decimal;
    var
        myInt: Integer;
    begin
        DimensionCodeBuffer.Reset();
        if DimensionCodeBuffer.Find('-') then begin
            DimensionCodeBuffer.CalcSums(Amount);
            Amount := DimensionCodeBuffer.Amount;
        end;
        exit(Amount);
    end;
}