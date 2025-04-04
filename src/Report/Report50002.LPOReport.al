report 50002 "LPOReport"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/LPOReport.rdlc';


    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(Invoice_No; "Invoice No")
            {

            }
            column(No_; "No.") { }
            column(RequesterDate; RequesterDate) { }
            column(User_ID; "User ID") { }
            column(Paying_Account_No; "Paying Account No") { }
            column(Posting_Date; "Posting Date") { }
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
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(Buy_from_Address; "Buy-from Address") { }
            column(Buy_from_Address_2; "Buy-from Address 2") { }
            column(Buy_from_Contact; "Buy-from Contact") { }
            column(Buy_from_Contact_No_; "Buy-from Contact No.") { }
            column(Buy_from_Post_Code; "Buy-from Post Code") { }
            column(Quote_No_; "Quote No.") { }
            column(Purcahse_Requisition_No; "Purcahse Requisition No") { }
            column(RequesterSignature_PurchaseHeader; "Purchase Header"."Requester Signature")
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
            column(Approver4Date_PurchaseHeader; "Purchase Header".Approver1Date)
            {
            }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Description; Description) { }
                column(No_PV; "No.") { }
                column(Amount; Amount) { }
                column(Withholding_Tax_Amount; "Withholding Tax Amount") { }
                column(Consultancy_Fee; "Consultancy Fee") { }
                column(Currency_Code; "Currency Code") { }
                column(Description_2; "Description 2") { }
                column(Net_Amount; "Net Amount") { }
                column(Quantity; Quantity) { }
                column(Line_Comments; "Line Comments") { }
                column(Direct_Unit_Cost; "Direct Unit Cost" * Quantity) { }
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
                column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code") { }
                column(ShortcutDimCode_3_; "ShortcutDimCode[3]") { }
                column(ShortcutDimCode_4_; "ShortcutDimCode[4]") { }
                column(ShortcutDimCode_5_; "ShortcutDimCode[5]") { }
                column(ShortcutDimCode_6_; "ShortcutDimCode[6]") { }
                column(ShortcutDimCode_7_; "ShortcutDimCode[7]") { }
                column(ShortcutDimCode_8_; "ShortcutDimCode[8]") { }
            }
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                DimVal.Reset;
                DimVal.SetRange(Code, "Shortcut Dimension 1 Code");
                if DimVal.FindFirst then
                    //Dim1Name := DimVal.Name;
                DimVal.Reset;
                DimVal.SetRange(Code, "Shortcut Dimension 2 Code");
                if DimVal.FindFirst then
                    //Dim2Name := DimVal.Name;
                    DimVal.Reset;
                DimVal.SetRange(Code, "Shortcut Dimension 3 Code");
                if DimVal.FindFirst then
                    Dim1Name := DimVal.Name;
                DimVal.Reset;
                DimVal.SetRange(Code, "Shortcut Dimension 4 Code");
                if DimVal.FindFirst then
                    Dim2Name := DimVal.Name;
                if "Purchase Header"."Requester Signature".Hasvalue = false then begin
                    HREmployees.Get("Purchase Header"."Employee No");
                    HREmployees.CALCFIELDS(Signature);
                    "Purchase Header"."Requester Signature" := HREmployees.Signature;
                    ApprovalEntry.Reset;
                    ApprovalEntry.SetRange("Document No.", "Purchase Header"."No.");
                    ApprovalEntry.SetRange("Sequence No.", 1);
                    if ApprovalEntry.FindFirst then begin
                        "Purchase Header".RequesterDate := ApprovalEntry."Date-Time Sent for Approval";
                    end;
                end;
                if "Purchase Header".Approver1Name = '' then begin
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
                end;
                if "Purchase Header".Approver2Name = '' then begin
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
                end;
                if "Purchase Header".Approver3Name = '' then begin
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
                end;
                if "Purchase Header".Approver4Name = '' then begin
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
                end;
                "Purchase Header".Modify;
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
}