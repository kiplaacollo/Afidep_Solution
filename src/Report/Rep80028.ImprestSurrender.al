// dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
// {	
// 	assembly("ForNav.Reports.6.0.0.2068")
// 	{
// 		type(ForNav.Report_6_0_0_2068; ForNavReport80028_v6_0_0_2068){}   
// 	}
// } // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 80028 "Imprest Surrender"
{
    RDLCLayout = './Layouts/Imprest Surrender.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(Invoice_No; "Invoice No")
            {
            }
            column(No_; "No.") { }
            column(RequesterDate; RequesterDate) { }
            column(Paying_Account_No; "Paying Account No") { }
            column(Bank_No_Series; "Bank No Series") { }
            column(Posting_Date; "Posting Date") { }
            column(Being_Payment_for; "Being Payment for") { }
            column(Amount_H; Amount) { }
            column(Pay_mode; "Pay mode") { }
            column(Budget_Center_Name; "Budget Center Name") { }
            column(Currency_Code_H; "Currency Code") { }
            column(Amount_Including_VAT; "Amount Including VAT") { }
            column(AMOUNT_IN_WORDS____AmtInWords_1_; CapitalizeWords(AmtInWords[1])) { }
            column(Posting_Description; "Posting Description") { }
            column(CompanyInformation_Pic; CompanyInformation.Picture) { }
            column(CompanyInformation_address; CompanyInformation.Address) { }
            column(CompanyInformation_Phone; CompanyInformation."Phone No.") { }
            column(CompanyInformation_name; CompanyInformation.Name) { }
            column(CompanyInformation_Address2; CompanyInformation."Address 2") { }
            column(CompanyInformation_homepage; CompanyInformation."Home Page") { }
            column(CompanyInformation_Email; CompanyInformation."E-Mail") { }
            column(Shortcut_Dimension_3_Code; "Shortcut Dimension 3 Code") { }
            column(Paying_Account_Name; "Paying Account Name") { }
            column(Payee_Naration; "Payee Naration") { }
            column(Employee_Name; "Employee Name") { }
            column(RequesterSignature_PurchaseHeader; "Requester Signature")
            {
            }
            column(Approver1Name_PurchaseHeader; "Purchase Header".Approver1Name)
            {
            }
            column(Approver1Signature_PurchaseHeader; "Purchase Header".Approver1Signature)
            {
            }
            column(Approver2Name_PurchaseHeader; "Purchase Header".Approver2Name)
            {
            }
            column(Approver2Signature_PurchaseHeader; "Purchase Header".Approver2Signature)
            {
            }
            column(Approver3Name_PurchaseHeader; "Purchase Header".Approver3Name)
            {
            }
            column(Approver3Signature_PurchaseHeader; "Purchase Header".Approver3Signature)
            {
            }
            column(EmployeeName_PurchaseHeader; "Purchase Header"."Employee Name")
            {
            }
            column(Approver1Date_PurchaseHeader; "Purchase Header".Approver1Date)
            {
            }
            column(Approver2Date_PurchaseHeader; "Purchase Header".Approver2Date)
            {
            }
            column(Approver3Date_PurchaseHeader; "Purchase Header".Approver3Date)
            {
            }
            column(Approver4Name_PurchaseHeader; "Purchase Header".Approver3Name)
            {
            }
            column(Approver4Signature_PurchaseHeader; "Purchase Header".Approver3Signature)
            {
            }
            column(Approver4Date_PurchaseHeader; "Purchase Header".Approver4Date)
            {
            }
            column(Shortcut_Dimension_1_Code_; "Shortcut Dimension 1 Code") { }
            column(Shortcut_Dimension_2_Code_; "Shortcut Dimension 2 Code") { }


            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Description; Description) { }
                column(No_PV; "No.") { }
                column(Document_No_; "Document No.") { }
                column(Amount; Amount * "Currency Factor") { }
                column(Withholding_Tax_Amount; "Withholding Tax Amount") { }
                column(Consultancy_Fee; "Consultancy Fee") { }
                column(Currency_Code; "Currency Factor") { }
                column(Description_2; "Description 2") { }
                column(Direct_Unit_Cost; "Direct Unit Cost") { }
                column(Net_Amount; "Net Amount") { }
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
                column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code") { }
                column(ShortcutDimCode_3_; "ShortcutDimCode[3]") { }
                column(ShortcutDimCode_4_; "ShortcutDimCode[4]") { }
                column(ShortcutDimCode_5_; "ShortcutDimCode[5]") { }
                column(ShortcutDimCode_6_; "ShortcutDimCode[6]") { }
                column(ShortcutDimCode_7_; "ShortcutDimCode[7]") { }
                column(ShortcutDimCode_8_; "ShortcutDimCode[8]") { }
                column(Budget_Line_description; "Budget Line description") { }

            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where("Document Type" = const(Quote), Status = const(Approved));
                column(ReportForNavId_1102755002; 1102755002) { } // Autogenerated by ForNav - Do not delete
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
                //  HREmployees.Get();
                HREmployees.CalcFields(Signature);
            end;

            trigger OnAfterGetRecord();
            begin
                // DimVal.Reset;
                // DimVal.SetRange(Code, "Shortcut Dimension 1 Code");
                // if DimVal.FindFirst then
                //     //Dim1Name := DimVal.Name;
                // DimVal.Reset;
                // DimVal.SetRange(Code, "Shortcut Dimension 2 Code");
                // if DimVal.FindFirst then
                HREmployees.Reset;
                HREmployees.SetRange(HREmployees."No.", "Purchase Header"."Employee No");
                if HREmployees.FindFirst then begin
                    HREmployees.CALCFIELDS(Signature);
                    "Purchase Header"."Requester Signature" := HREmployees.Signature;
                    ApprovalEntry.Reset;
                    ApprovalEntry.SetRange("Document No.", "Purchase Header"."No.");
                    ApprovalEntry.SetRange("Sequence No.", 1);
                    if ApprovalEntry.FindFirst then begin
                        "Purchase Header".RequesterDate := ApprovalEntry."Date-Time Sent for Approval";
                    end;
                end;
                // if "Purchase Header".Approver1Name = '' then begin
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Document No.", "Purchase Header"."No.");
                ApprovalEntry.SetRange("Sequence No.", 1);
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst then begin
                    HREmployees.Reset;
                    HREmployees.SetRange(HREmployees."Employee UserID", ApprovalEntry."Approver ID");
                    if HREmployees.FindFirst then begin
                        HREmployees.CALCFIELDS(Signature);
                        "Purchase Header".Approver1Signature := HREmployees.Signature;
                        "Purchase Header".Approver1Name := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                        "Purchase Header".Approver1Date := ApprovalEntry."Last Date-Time Modified";
                    end;
                end;
                // end;
                //     if "Purchase Header"."Net Amount in foreign Currency" <= 10000 then begin
                //    // if "Purchase Header".Approver2Name = '' then begin
                //         ApprovalEntry.Reset;
                //         ApprovalEntry.SetRange("Document No.", "Purchase Header"."No.");
                //         ApprovalEntry.SetRange("Sequence No.", 1);
                //         ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                //         if ApprovalEntry.FindFirst then begin
                //             HREmployees.Reset;
                //             HREmployees.SetRange(HREmployees."Employee UserID", ApprovalEntry."Approver ID");
                //             if HREmployees.FindFirst then begin
                //                 HREmployees.CALCFIELDS(Signature);
                //                 "Purchase Header".Approver2Signature := HREmployees.Signature;
                //                 "Purchase Header".Approver2Name := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                //                 "Purchase Header".Approver2Date := ApprovalEntry."Last Date-Time Modified";
                //             end;
                //         end;
                //     end;
                //if "Purchase Header".Approver2Name = '' then begin
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Document No.", "Purchase Header"."No.");
                ApprovalEntry.SetRange("Sequence No.", 2);
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst then begin
                    HREmployees.Reset;
                    HREmployees.SetRange(HREmployees."Employee UserID", ApprovalEntry."Approver ID");
                    if HREmployees.FindFirst then begin
                        HREmployees.CALCFIELDS(Signature);
                        "Purchase Header".Approver2Signature := HREmployees.Signature;
                        "Purchase Header".Approver2Name := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                        "Purchase Header".Approver2Date := ApprovalEntry."Last Date-Time Modified";
                    end;
                end;
                //end;
                //if "Purchase Header".Approver3Name = '' then begin
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Document No.", "Purchase Header"."No.");
                ApprovalEntry.SetRange("Sequence No.", 3);
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst then begin
                    HREmployees.Reset;
                    HREmployees.SetRange(HREmployees."Employee UserID", ApprovalEntry."Approver ID");
                    if HREmployees.FindFirst then begin
                        HREmployees.CALCFIELDS(Signature);
                        "Purchase Header".Approver3Signature := HREmployees.Signature;
                        "Purchase Header".Approver3Name := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                        "Purchase Header".Approver3Date := ApprovalEntry."Last Date-Time Modified";
                    end;
                end;
                //end;
                //if "Purchase Header".Approver4Name = '' then begin
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange("Document No.", "Purchase Header"."No.");
                ApprovalEntry.SetRange("Sequence No.", 4);
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst then begin
                    HREmployees.Reset;
                    HREmployees.SetRange(HREmployees."Employee UserID", ApprovalEntry."Approver ID");
                    if HREmployees.FindFirst then begin
                        HREmployees.CALCFIELDS(Signature);
                        "Purchase Header".Approver3Signature := HREmployees.Signature;
                        "Purchase Header".Approver4Name := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                        "Purchase Header".Approver4Date := ApprovalEntry."Last Date-Time Modified";
                    end;
                end;
                //end;
                "Purchase Header".Modify;

                if "Purchase Header"."Currency Code" = ''
                then
                    "Currency Code" := 'USD' else
                    "Currency Code" := "Currency Code";


                CheckforMillion.InitTextVariable;
                CheckforMillion.FormatNoText(AmtInWords, Abs("Amount Including VAT"), '');

                AmtInWords[1] := "Currency Code" + ' ' + CapitalizeWords(AmtInWords[1]);
            end;
        }

    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

    // actions
    // {
    //     area(processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;

    //         }
    //     }
    // }
    //  }



    var
        myInt: Integer;
        CompanyInformation: Record "Company Information";
        DimVal: Record "Dimension Value";
        Dim1Name: Text;
        Dim2Name: Text;
        HREmployees: Record "HR Employees";
        ApprovalEntry: Record "Approval Entry";
        AmtInWords: array[2] of Text[160];
        CheckforMillion: Report "Check for Million";

    procedure CapitalizeWords(InputText: Text): Text
    var
        Words: List of [Text];
        Word, CapitalizedText : Text;
    begin
        // Split text into words (keeping spaces intact)
        Words := InputText.Split(' ');

        // Process each word
        foreach Word in Words do begin
            if Word <> '' then begin
                // Capitalize first letter and keep the rest unchanged
                Word := UpperCase(CopyStr(Word, 1, 1)) + LowerCase(CopyStr(Word, 2));
            end;
            CapitalizedText += Word + ' '; // Keep spaces
        end;

        // Return capitalized text without trimming spaces
        exit(CapitalizedText);
    end;




}