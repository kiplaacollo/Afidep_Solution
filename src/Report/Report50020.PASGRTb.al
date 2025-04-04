report 50020 PASGRTb
{
   // UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/PASGRTb.rdlc';


    dataset
    {
        dataitem("G/L Account";"G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }

            /*column(PeriodText; PeriodText)
            {
            }
            column(G_L_Account_TABLECAPTION_____GLFilter; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }*/
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Account__No_Caption; FieldCaption("No."))
            {
            }

            column(PADSTR__G_L_AccountIndentation_2_G_L_Account_NameCaptionLbl;PADSTR__G_L_AccountIndentation_2_G_L_Account_NameCaptionLbl)
            {

            }
            column(G_L_Account___Net_Change_CaptionLbl;G_L_Account___Net_Change_CaptionLbl)
            {

            }
            column(G_L_Account__Net_Change_Control22CaptionLbl;G_L_Account__Net_Change_Control22CaptionLbl)
            {

            }
            //column(G_L_Account__Balance_at_Date_Caption; G_L_Account__Balance_at_Date_CaptionLbl)
            ///{
           // }
           column(G_L_Account__Balance_at_Date_Control24CaptionLbl;G_L_Account__Balance_at_Date_Control24CaptionLbl)
           {

           }
            column(G_L_Account___Balance_at_Date_CaptionLbl;G_L_Account___Balance_at_Date_CaptionLbl)
            {

            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(G_L_Account__No_; GLAccount."No.")
                {
                }
                column(PADSTR__G_L_AccountIndentation_2_G_L_Account_Name; PadStr('', GLAccount.Indentation * 2) + GLAccount.Name)
                {
                }
                column(G_L_Account__Net_Change; GLAccount."Net Change")
                {
                }
                column(G_L_Account__Net_Change_Control22; -GLAccount."Net Change")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account__Balance_at_Date; GLAccount."Balance at Date")
                {
                }
                column(G_L_Account__Balance_at_Date_Control24; -GLAccount."Balance at Date")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account__Account_Type; Format(GLAccount."Account Type", 0, 2))
                {
                }
                column(No__of_Blank_Lines; GLAccount."No. of Blank Lines")
                {
                }
                dataitem(BlankLineRepeater; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(BlankLineNo; BlankLineNo)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if BlankLineNo = 0 then
                            CurrReport.Break();

                        BlankLineNo -= 1;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    BlankLineNo := GLAccount."No. of Blank Lines" + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Net Change", "Balance at Date");

                if ChangeGroupNo then begin
                    PageGroupNo += 1;
                    ChangeGroupNo := false;
                end;

                ChangeGroupNo := "New Page";
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 0;
                ChangeGroupNo := false;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        GLAccount.SecurityFiltering(SecurityFilter::Filtered);
        GLFilter := GLAccount.GetFilters();
        PeriodText := GLAccount.GetFilter("Date Filter");
    end;

    var
        Text000: Label 'Period: %1';
        PeriodText: Text[30];
        GLAccount: Record "G/L Account";
        Trial_BalanceCaptionLbl: Label 'Trial Balance';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Net_ChangeCaptionLbl: Label 'Net Change';
        BalanceCaptionLbl: Label 'Balance';
        PADSTR__G_L_AccountIndentation_2_G_L_Account_NameCaptionLbl: Label 'Name';
        G_L_Account___Net_Change_CaptionLbl: Label 'Debit';
        G_L_Account__Net_Change_Control22CaptionLbl: Label 'Credit';
        G_L_Account___Balance_at_Date_CaptionLbl: Label 'Debit';
        G_L_Account__Balance_at_Date_Control24CaptionLbl: Label 'Credit';
        PageGroupNo: Integer;
        ChangeGroupNo: Boolean;
        BlankLineNo: Integer;

    protected var
        GLFilter: Text;
}