// dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
// {	
// 	assembly("ForNav.Reports.6.0.0.2068")
// 	{
// 		type(ForNav.Report_6_0_0_2068; ForNavReport80036_v6_0_0_2068){}   
// 	}
// } // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 80036 "Payment Voucher1"
{
    UseSystemPrinter = true;
    RDLCLayout = './Layouts/Payment Voucher1.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name";
            column(ReportForNavId_7024; 7024) { } // Autogenerated by ForNav - Do not delete
            column(Gen__Journal_Line__Posting_Date_; "Posting Date")
            {
            }
            column(Gen__Journal_Line__Document_Date_; "Document Date")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo__Address_2_; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo__Country_Region_Code_; CompanyInfo."Country/Region Code")
            {
            }
            column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo__E_Mail_; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo__Home_Page_; CompanyInfo."Home Page")
            {
            }
            column(Gen__Journal_Line__Document_No__; "Document No.")
            {
            }
            column(ReportTitle; ReportTitle)
            {
            }
            column(Gen__Journal_Line_Amount; Amount)
            {
            }
            column(Gen__Journal_Line_Description; Description)
            {
            }
            column(Gen__Journal_Line__Account_No__; "Account No.")
            {
            }
            column(Gen__Journal_Line__Account_Name_; AccName)
            {
            }
            column(Gen__Journal_Line__Applies_to_Doc__No__; "Applies-to Doc. No.")
            {
            }
            column(Gen__Journal_Line__External_Document_No__; "External Document No.")
            {
            }
            column(AMOUNT_IN_WORDS____AmtInWords_1_; 'AMOUNT IN WORDS: ' + AmtInWords[1])
            {
            }
            column(TotalAmt; TotAmt)
            {
            }
            column(P_Date; P_Date)
            {
            }
            column(FinUser; FinUser)
            {
            }
            column(Gen__Journal_Line__Posting_Date__Control1000000060; "Posting Date")
            {
            }
            column(VOUCHER_NO_Caption; VOUCHER_NO_CaptionLbl)
            {
            }
            column(VOUCHER_DATECaption; VOUCHER_DATECaptionLbl)
            {
            }
            column(CHEQUE_DATECaption; CHEQUE_DATECaptionLbl)
            {
            }
            column(Tel_Caption; Tel_CaptionLbl)
            {
            }
            column(Fax_Caption; Fax_CaptionLbl)
            {
            }
            column(Email_Caption; Email_CaptionLbl)
            {
            }
            column(Web_Caption; Web_CaptionLbl)
            {
            }
            column(Other_DetailsCaption; Other_DetailsCaptionLbl)
            {
            }
            column(Account_Details_DescriptionCaption; Account_Details_DescriptionCaptionLbl)
            {
            }
            column(Cheque_Reference_No_Caption; Cheque_Reference_No_CaptionLbl)
            {
            }
            column(KES_AmountCaption; KES_AmountCaptionLbl)
            {
            }
            column(Invoice_No_Caption; Invoice_No_CaptionLbl)
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(Signature_Caption_Control1000000012; Signature_Caption_Control1000000012Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000025; EmptyStringCaption_Control1000000025Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000028; EmptyStringCaption_Control1000000028Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000034; EmptyStringCaption_Control1000000034Lbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Date_Caption_Control1000000039; Date_Caption_Control1000000039Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000041; EmptyStringCaption_Control1000000041Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000045; EmptyStringCaption_Control1000000045Lbl)
            {
            }
            column(Signature_Caption_Control1000000046; Signature_Caption_Control1000000046Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000047; EmptyStringCaption_Control1000000047Lbl)
            {
            }
            column(Date_Caption_Control1000000048; Date_Caption_Control1000000048Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000049; EmptyStringCaption_Control1000000049Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000050; EmptyStringCaption_Control1000000050Lbl)
            {
            }
            column(Authorised_By_Executive_Director_Caption; Authorised_By_Executive_Director_CaptionLbl)
            {
            }
            column(Prepared_By_Finance_Officer__Caption; Prepared_By_Finance_Officer__CaptionLbl)
            {
            }
            column(Checked_By_Head_of_Finance__Caption; Checked_By_Head_of_Finance__CaptionLbl)
            {
            }
            column(Gen__Journal_Line_Journal_Template_Name; "Journal Template Name")
            {
            }
            column(Gen__Journal_Line_Journal_Batch_Name; "Journal Batch Name")
            {
            }
            column(Gen__Journal_Line_Line_No_; "Line No.")
            {
            }
            column(FundNo; "Gen. Journal Line"."Shortcut Dimension 1 Code")
            {
            }
            column(AccName; AccName)
            {
            }
            column(vendorname; "vendor name")
            {
            }
            trigger OnPreDataItem();
            begin
                LastFieldNo := FieldNo("Journal Template Name");
                CompanyInfo.Get;
            end;

            trigger OnAfterGetRecord();
            begin
                CompanyInfo.CalcFields(Picture);
                //GenJnlManagement.GetAccounts(BalAccName);
                "vendor name" := '';
                if Vendor.Get("Gen. Journal Line"."Account No.") then "vendor name" := Vendor.Name;
                if Cust.Get("Gen. Journal Line"."Account No.") then "vendor name" := Cust.Name;
                if GLAcc.Get("Gen. Journal Line"."Account No.") then "vendor name" := GLAcc.Name;
                if BankAcc.Get("Gen. Journal Line"."Account No.") then "vendor name" := BankAcc.Name;
                if (GenJnlLine."Account Type" <> LastGenJnlLine."Account Type") or
                   (GenJnlLine."Account No." <> LastGenJnlLine."Account No.")
                then begin
                    AccName := '';
                    if GenJnlLine."Account No." <> '' then
                        case GenJnlLine."Account Type" of
                            GenJnlLine."account type"::"G/L Account":
                                if GLAcc.Get(GenJnlLine."Account No.") then
                                    AccName := GLAcc.Name;
                            GenJnlLine."account type"::Customer:
                                if Cust.Get(GenJnlLine."Account No.") then
                                    AccName := Cust.Name;
                            GenJnlLine."account type"::Vendor:
                                if Vend.Get(GenJnlLine."Account No.") then
                                    AccName := Vend.Name;
                            GenJnlLine."account type"::"Bank Account":
                                if BankAcc.Get(GenJnlLine."Account No.") then
                                    AccName := BankAcc.Name;
                            GenJnlLine."account type"::"Fixed Asset":
                                if FA.Get(GenJnlLine."Account No.") then
                                    AccName := FA.Description;
                            GenJnlLine."account type"::"IC Partner":
                                if IC.Get(GenJnlLine."Account No.") then
                                    AccName := IC.Name;
                        end;
                end;
                if (GenJnlLine."Bal. Account Type" <> LastGenJnlLine."Bal. Account Type") or
                   (GenJnlLine."Bal. Account No." <> LastGenJnlLine."Bal. Account No.") then begin
                    BalAccName := '';
                    if GenJnlLine."Bal. Account No." <> '' then
                        case GenJnlLine."Bal. Account Type" of
                            GenJnlLine."bal. account type"::"G/L Account":
                                if GLAcc.Get(GenJnlLine."Bal. Account No.") then
                                    BalAccName := GLAcc.Name;
                            GenJnlLine."bal. account type"::Customer:
                                if Cust.Get(GenJnlLine."Bal. Account No.") then
                                    BalAccName := Cust.Name;
                            GenJnlLine."bal. account type"::Vendor:
                                if Vend.Get(GenJnlLine."Bal. Account No.") then
                                    BalAccName := Vend.Name;
                            GenJnlLine."bal. account type"::"Bank Account":
                                if BankAcc.Get(GenJnlLine."Bal. Account No.") then
                                    BalAccName := BankAcc.Name;
                            GenJnlLine."bal. account type"::"Fixed Asset":
                                if FA.Get(GenJnlLine."Bal. Account No.") then
                                    BalAccName := FA.Description;
                            GenJnlLine."bal. account type"::"IC Partner":
                                if IC.Get(GenJnlLine."Bal. Account No.") then
                                    BalAccName := IC.Name;
                        end;
                end;
                LastGenJnlLine := GenJnlLine;
                //2013 r2
                GenJnlLine2.CopyFilters("Gen. Journal Line");
                if GenJnlLine2.FindFirst then
                    repeat
                        TotAmt := GenJnlLine2.Amount + TotAmt;
                    until GenJnlLine2.Next = 0;
                CheckforMillion.InitTextVariable;
                CheckforMillion.FormatNoText(AmtInWords, Abs(TotAmt), '');
                //END;
                GLSetup.Get;
                CurrCode := GLSetup."LCY Code";
                if "Currency Code" = '' then
                    AmtInWords[1] := CurrCode + ' ' + AmtInWords[1]
                else
                    AmtInWords[1] := "Currency Code" + ' ' + AmtInWords[1];
                P_Date := GenJnlLine."Document Date";
                //FinUser:=GenJnlLine."Owner ID";
            end;

        }
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
                    // field(ForNavOpenDesigner;ReportForNavOpenDesigner)
                    // {
                    // 	ApplicationArea = Basic;
                    // 	Caption = 'Design';
                    // 	Visible = ReportForNavAllowDesign;
                    // 	trigger OnValidate()
                    // 	begin
                    // 		ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
                    // 		CurrReport.RequestOptionsPage.Close();
                    // 	end;

                    // }
                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            //ReportForNavOpenDesigner := false;
        end;
    }

    trigger OnInitReport()
    begin
        //;ReportsForNavInit;

    end;

    trigger OnPostReport()
    begin
        //;ReportForNav.Post;
    end;

    trigger OnPreReport()
    begin
        if WhichReport = Whichreport::"Payment Voucher" then
            ReportTitle := 'Payment Voucher'
        else
            if WhichReport = Whichreport::"Payment Remittance" then
                ReportTitle := 'Payment Remittance';
        TotAmt := 0;
        //;ReportsForNavPre;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: label 'Total for ';
        CompanyInfo: Record "Company Information";
        GenJnlManagement: Codeunit GenJnlManagement;
        BalAccName: Text[50];
        AccName: Text[50];
        LastGenJnlLine: Record "Gen. Journal Line";
        GenJnlLine: Record "Gen. Journal Line";
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        BankAcc: Record "Bank Account";
        FA: Record "Fixed Asset";
        IC: Record "IC Partner";
        BalAvailable: Decimal;
        GLEntry: Record "G/L Account";
        BudgetedAmt: Decimal;
        AmtInWords: array[2] of Text[160];
        CheckforMillion: Report "Check for Million";
        GLSetup: Record "General Ledger Setup";
        CurrCode: Code[10];
        TotalAmt: Decimal;
        genjnl: Record "Gen. Journal Line";
        TotAmt: Decimal;
        WhichReport: Option "Payment Voucher","Payment Remittance";
        PaymentVoucher: label 'Payent Voucher';
        PaymentRemittance: label 'Payment Remittance';
        ReportTitle: Text[100];
        VOUCHER_NO_CaptionLbl: label 'VOUCHER NO.';
        VOUCHER_DATECaptionLbl: label 'VOUCHER DATE';
        CHEQUE_DATECaptionLbl: label 'CHEQUE DATE';
        Tel_CaptionLbl: label 'Tel:';
        Fax_CaptionLbl: label 'Fax:';
        Email_CaptionLbl: label 'Email:';
        Web_CaptionLbl: label 'Web:';
        Other_DetailsCaptionLbl: label 'Other Details';
        Account_Details_DescriptionCaptionLbl: label 'Account Details/Description';
        Cheque_Reference_No_CaptionLbl: label 'Cheque/Reference No.';
        KES_AmountCaptionLbl: label 'KES Amount';
        Invoice_No_CaptionLbl: label 'Invoice No.';
        TOTALCaptionLbl: label 'TOTAL';
        EmptyStringCaptionLbl: label '__________________________';
        Signature_CaptionLbl: label 'Signature:';
        Signature_Caption_Control1000000012Lbl: label 'Signature:';
        EmptyStringCaption_Control1000000025Lbl: label '__________________________';
        EmptyStringCaption_Control1000000028Lbl: label '__________________________';
        EmptyStringCaption_Control1000000034Lbl: label '__________________________';
        Date_CaptionLbl: label 'Date:';
        Date_Caption_Control1000000039Lbl: label 'Date:';
        EmptyStringCaption_Control1000000041Lbl: label '__________________________';
        EmptyStringCaption_Control1000000045Lbl: label '__________________________';
        Signature_Caption_Control1000000046Lbl: label 'Signature:';
        EmptyStringCaption_Control1000000047Lbl: label '__________________________';
        Date_Caption_Control1000000048Lbl: label 'Date:';
        EmptyStringCaption_Control1000000049Lbl: label '__________________________';
        EmptyStringCaption_Control1000000050Lbl: label '__________________________';
        Authorised_By_Executive_Director_CaptionLbl: label 'Authorised By Executive Director:';
        Prepared_By_Finance_Officer__CaptionLbl: label 'Prepared By Finance Officer: ';
        Checked_By_Head_of_Finance__CaptionLbl: label 'Checked By Head of Finance: ';
        GenJnlLine2: Record "Gen. Journal Line";
        P_Date: Date;
        FinUser: Code[150];
        Vendor: Record Vendor;
        "vendor name": Text;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    // var 
    // 	[WithEvents]
    // 	ReportForNav : DotNet ForNavReport80036_v6_0_0_2068;
    // 	ReportForNavOpenDesigner : Boolean;
    // 	[InDataSet]
    // 	ReportForNavAllowDesign : Boolean;

    // local procedure ReportsForNavInit();
    // var
    // 	addInFileName : Text;
    // 	tempAddInFileName : Text;
    // 	path: DotNet Path;
    // 	ApplicationSystemConstants: Codeunit "Application System Constants";
    // begin
    // 	addInFileName := ApplicationPath() + 'Add-ins\ReportsForNAV_6_0_0_2068\ForNav.Reports.6.0.0.2068.dll';
    // 	if not File.Exists(addInFileName) then begin
    // 		tempAddInFileName := path.GetTempPath() + '\Microsoft Dynamics NAV\Add-Ins\' + ApplicationSystemConstants.PlatformFileVersion() + '\ForNav.Reports.6.0.0.2068.dll';
    // 		if not File.Exists(tempAddInFileName) then
    // 			Error('Please install the ForNAV DLL version 6.0.0.2068 in your service tier Add-ins folder under the file name "%1"\\If you already have the ForNAV DLL on the server, you should move it to this folder and rename it to match this file name.', addInFileName);
    // 	end;
    // 	ReportForNav:= ReportForNav.Report_6_0_0_2068(CurrReport.ObjectId(), CurrReport.Language(), SerialNumber(), UserId(), CompanyName());
    // 	ReportForNav.Init();
    // end;

    // local procedure ReportsForNavPre();
    // begin
    // 	ReportForNav.OpenDesigner:=ReportForNavOpenDesigner;
    // 	if not ReportForNav.Pre() then CurrReport.Quit();
    // end;

    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
