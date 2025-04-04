report 50024 "Detailed GL Expenditure Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/test.rdlc';
    ApplicationArea = Basic, Suite;
    Caption = 'Detailed GL Expenditure Report';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    


    dataset
    {
       
                dataitem("G/L Entry"; "G/L Entry")
                {
                   
                   DataItemTableView = WHERE("G/L Account No."= filter('500-00'..'599-99'));
                    //RequestFilterFields=("Global Dimension 1 Code","Global Dimension 2 Code","Shortcut Dimension 3 Code","Shortcut Dimension 4 Code","Shortcut Dimension 5 Code","Shortcut Dimension 6 Code","Shortcut Dimension 7 Code","Shortcut Dimension 8 Code";
                    //DataItemTableView = SORTING("Posting Date");
                    
                     RequestFilterFields="Posting Date","Global Dimension 1 Code","G/L Account No.","Global Dimension 2 Code","Shortcut Dimension 3 Code","Shortcut Dimension 4 Code","Shortcut Dimension 5 Code","Shortcut Dimension 6 Code","Shortcut Dimension 7 Code","Shortcut Dimension 8 Code";
                   
                    column(VATAmount_GLEntry; "VAT Amount")
                    {
                        IncludeCaption = true;
                    }
                    
                    column(Global_Dimension_1_Code;"Global Dimension 1 Code")
                    {

                    }
                    column(Global_Dimension_2_Code;"Global Dimension 2 Code")
                    {

                    }
                    column(Shortcut_Dimension_3_Code;"Shortcut Dimension 3 Code")
                    {

                    }
                    column(Shortcut_Dimension_4_Code;"Shortcut Dimension 4 Code")
                    {

                    }
                    column(Shortcut_Dimension_5_Code;"Shortcut Dimension 5 Code")
                    {

                    }
                    column(Shortcut_Dimension_6_Code;"Shortcut Dimension 6 Code")
                    {

                    }
                    column(Shortcut_Dimension_7_Code;"Shortcut Dimension 7 Code")
                    {

                    }
                    column(Shortcut_Dimension_8_Code;"Shortcut Dimension 8 Code")
                    {

                    }
                    column(DebitAmount_GLEntry; "Debit Amount")
                    {
                    }
                    column(CreditAmount_GLEntry; "Credit Amount")
                    {
                    }
                    column(Add__Currency_Debit_Amount;"Add.-Currency Debit Amount")
                    {

                    }
                    column(Add__Currency_Credit_Amount;"Add.-Currency Credit Amount")
                    {

                    }
                    column(GetCurrencyCode;GetCurrencyCode)
                    {

                    }
                    column(Currency_Code;"Currency Code 3")
                    {

                    }
                    column(Currency_Factor;"Currency Factor3")
                    {
                        
                    }
            
                    column(G_L_Account_No_;"G/L Account No.")
                    {

                    }
                    column(G_L_Account_Name;"G/L Account Name")
                    {

                    }
                    column(PostingDate_GLEntry; Format("Posting Date"))
                    {
                    }
                    column(DocumentNo_GLEntry; "Document No.")
                    {
                    }
                    column(ExtDocNo_GLEntry; "External Document No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Description_GLEntry; Description)
                    {
                    }
                    
                    column(Reversed_GLEntry; Reversed)
                    {
                    }
                    column(Amount;Amount)
                    {

                    }
                    column(AmountLCY;AmountLCY){}
                    column(Payee;Payee2){}
                  

                    

                    
                    
                    

                   
            

            
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NewPageperGLAcc; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per G/L Acc.';
                        ToolTip = 'Specifies if each G/L account information is printed on a new page if you have chosen two or more G/L accounts to be included in the report.';
                    }
                    field(ExcludeGLAccsHaveBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Exclude G/L Accs. That Have a Balance Only';
                        MultiLine = true;
                        ToolTip = 'Specifies if you do not want the report to include entries for G/L accounts that have a balance but do not have a net change during the selected time period.';
                    }
                    field(InclClosingEntriesWithinPeriod; PrintClosingEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Closing Entries Within the Period';
                        MultiLine = true;
                        ToolTip = 'Specifies if you want the report to include closing entries. This is useful if the report covers an entire fiscal year. Closing entries are listed on a fictitious date between the last day of one fiscal year and the first day of the next one. They have a C before the date, such as C123194. If you do not select this field, no closing entries are shown.';
                    }
                    field(IncludeReversedEntries; PrintReversedEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Reversed Entries';
                        ToolTip = 'Specifies if you want to include reversed entries in the report.';
                    }
                    field(PrintCorrectionsOnly; PrintOnlyCorrections)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Corrections Only';
                        ToolTip = 'Specifies if you want the report to show only the entries that have been reversed and their matching correcting entries.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        PostingDateCaption = 'Posting Date';
        DocNoCaption = 'Document No.';
        DescCaption = 'Description';
        VATAmtCaption = 'VAT Amount';
        EntryNoCaption = 'Entry No.';
    }



    trigger OnPostReport()
    begin
        FinishDateTime := CurrentDateTime();
        LogReportTelemetry(StartDateTime, FinishDateTime, NumberOfGLEntryLines);
    end;

    var
        Text000: Label 'Period: %1';
        GLDateFilter: Text;
        GLFilter: Text;
        AmountLCY:Decimal;
        GLBalance: Decimal;
        StartBalance: Decimal;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        PrintClosingEntries: Boolean;
        PrintOnlyCorrections: Boolean;
        PrintReversedEntries: Boolean;
        PageGroupNo: Integer;
        ClosingEntry: Boolean;
        DetailTrialBalCaptionLbl: Label 'Detail Trial Balance';
        PageCaptionLbl: Label 'Page';
        BalanceCaptionLbl: Label 'This also includes general ledger accounts that only have a balance.';
        PeriodCaptionLbl: Label 'This report also includes closing entries within the period.';
        OnlyCorrectionsCaptionLbl: Label 'Only corrections are included.';
        NetChangeCaptionLbl: Label 'Net Change';
        GLEntryDebitAmtCaptionLbl: Label 'Debit';
        GLEntryCreditAmtCaptionLbl: Label 'Credit';
        GLBalCaptionLbl: Label 'Balance';
        TelemetryCategoryTxt: Label 'Report', Locked = true;
        DetailedTrialBalanceReportGeneratedTxt: Label 'Detail Trial Balance report generated.', Locked = true;

    protected var
        NumberOfGLEntryLines: Integer;
        StartDateTime: DateTime;
        FinishDateTime: DateTime;

    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean; NewExcludeBalanceOnly: Boolean; NewPrintClosingEntries: Boolean; NewPrintReversedEntries: Boolean; NewPrintOnlyCorrections: Boolean)
    begin
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly := NewExcludeBalanceOnly;
        PrintClosingEntries := NewPrintClosingEntries;
        PrintReversedEntries := NewPrintReversedEntries;
        PrintOnlyCorrections := NewPrintOnlyCorrections;
    end;

    local procedure LogReportTelemetry(StartDateTime: DateTime; FinishDateTime: DateTime; NumberOfLines: Integer)
    var
        Dimensions: Dictionary of [Text, Text];
        ReportDuration: BigInteger;
    begin
        ReportDuration := FinishDateTime - StartDateTime;
        Dimensions.Add('Category', TelemetryCategoryTxt);
        Dimensions.Add('ReportStartTime', Format(StartDateTime, 0, 9));
        Dimensions.Add('ReportFinishTime', Format(FinishDateTime, 0, 9));
        Dimensions.Add('ReportDuration', Format(ReportDuration));
        Dimensions.Add('NumberOfLines', Format(NumberOfLines));
        Session.LogMessage('0000FJL', DetailedTrialBalanceReportGeneratedTxt, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, Dimensions);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnPreDataItemGLEntry(var GLEntry: Record "G/L Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnPreReport(var GLAccount: Record "G/L Account")
    begin
    end;
}

