report 17366 "Quotations Bidders List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Quotations Bidders List.rdlc';

    dataset
    {
        dataitem(DataItem1; "Purchase Quote Header")
        {
            RequestFilterFields = "No.";
            column(RequesterDate; RequesterDate) { }
            column(PostingDescription_PurchaseQuoteHeader; "Posting Description")
            {
            }
            column(No_PurchaseQuoteHeader; "No.")
            {
            }
            column(Observations_PurchaseQuoteHeader; Observations)
            {
            }
            column(Recommendations_PurchaseQuoteHeader; Recommendations)
            {
            }
            column(Employee_Name; "Employee Name") { }
            column(RequesterSignature_PurchaseHeader; "Requester Signature")
            {
            }
            column(Approver1Name_PurchaseHeader; DataItem1.Approver1Name)
            {
            }
            column(Approver1Signature_PurchaseHeader; DataItem1.Approver1Signature)
            {
            }
            column(Approver2Name_PurchaseHeader; DataItem1.Approver2Name)
            {
            }
            column(Approver2Signature_PurchaseHeader; DataItem1.Approver2Signature)
            {
            }
            column(Approver3Name_PurchaseHeader; DataItem1.Approver3Name)
            {
            }
            column(Approver3Signature_PurchaseHeader; DataItem1.Approver3Signature)
            {
            }
            column(EmployeeName_PurchaseHeader; DataItem1."Employee Name")
            {
            }
            column(Approver1Date_PurchaseHeader; DataItem1.Approver1Date)
            {
            }
            column(Approver2Date_PurchaseHeader; DataItem1.Approver2Date)
            {
            }
            column(Approver3Date_PurchaseHeader; DataItem1.Approver3Date)
            {
            }
            column(Approver4Name_PurchaseHeader; DataItem1.Approver3Name)
            {
            }
            column(Approver4Signature_PurchaseHeader; DataItem1.Approver3Signature)
            {
            }


            dataitem(DataItem4; "Quotation Request Vendors")
            {
                DataItemLink = "Requisition Document No." = FIELD("No.");
                column(VendorNo_QuotationRequestVendors; "Vendor No.")
                {
                }
                column(VendorName_QuotationRequestVendors; "Vendor Name")
                {
                }
                column(Currency; "Currency Code")
                {
                }
                column(Selected; Selected)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unitcost; "Unit Cost")
                {
                }
                column(Currencyfactor; "Currency Factor")
                {
                }
                column(TotalQuotedCost_QuotationRequestVendors; "Total Quoted Cost")
                {
                }
                dataitem(DataItem8; "Bidders Mandatory requirements")
                {
                    DataItemLink = "Tendor No" = FIELD("Requisition Document No."),
                                   "Vendor No" = FIELD("Vendor No.");
                    column(Code_BiddersMandatoryrequirements; Code)
                    {
                    }
                    column(Requirement_BiddersMandatoryrequirements; Requirement)
                    {
                    }
                    column(Status_BiddersMandatoryrequirements; Status)
                    {
                    }
                    column(VendorNo_BiddersMandatoryrequirements; "Vendor No")
                    {
                    }
                }
                dataitem(DataItem11; "Purchase Quote Line")
                {
                    DataItemLink = "Document No." = field("Requisition Document No.");
                    column(Unit_of_Measure; "Unit of Measure")
                    {

                    }
                }

            }
            dataitem(DataItem24; "Tender Committee")
            {
                DataItemLink = "Tender No" = FIELD("No.");
                column(MemberName_TenderCommittee; "Member Name")
                {
                }
                column(Signature_TenderCommittee; Signature)
                {
                }
                column(text; text)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    text := '';

                    TenderCommittee.RESET;
                    TenderCommittee.SETRANGE(TenderCommittee."Tender No", "Tender No");
                    IF TenderCommittee.FIND('-') THEN BEGIN
                        REPEAT
                            HREmployees.RESET;
                            HREmployees.SETRANGE(HREmployees."No.", TenderCommittee."Staff  No.");
                            IF HREmployees.FIND('-') THEN BEGIN
                                HREmployees.CALCFIELDS(Signature);
                                IF HREmployees.Signature.HASVALUE THEN
                                    TenderCommittee.Signature := HREmployees.Signature;
                                TenderCommittee.MODIFY(TRUE);
                            END;
                        UNTIL TenderCommittee.NEXT = 0;
                    END;
                    HREmployees.Reset;
                    HREmployees.SetRange(HREmployees."No.", DataItem1."Employee No");
                    if HREmployees.FindFirst then begin
                        HREmployees.CALCFIELDS(Signature);
                        DataItem1."Requester Signature" := HREmployees.Signature;
                        ApprovalEntry.Reset;
                        ApprovalEntry.SetRange("Document No.", DataItem1."No.");
                        ApprovalEntry.SetRange("Sequence No.", 1);
                        if ApprovalEntry.FindFirst then begin
                            DataItem1.RequesterDate := ApprovalEntry."Date-Time Sent for Approval";
                        end;
                    end;
                    // if "Purchase Header".Approver1Name = '' then begin
                    ApprovalEntry.Reset;
                    ApprovalEntry.SetRange("Document No.", DataItem1."No.");
                    ApprovalEntry.SetRange("Sequence No.", 1);
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                    if ApprovalEntry.FindFirst then begin
                        HREmployees.Reset;
                        HREmployees.SetRange(HREmployees."Employee UserID", ApprovalEntry."Approver ID");
                        if HREmployees.FindFirst then begin
                            HREmployees.CALCFIELDS(Signature);
                            DataItem1.Approver1Signature := HREmployees.Signature;
                            DataItem1.Approver1Name := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                            DataItem1.Approver1Date := ApprovalEntry."Last Date-Time Modified";
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
                    ApprovalEntry.SetRange("Document No.", DataItem1."No.");
                    ApprovalEntry.SetRange("Sequence No.", 2);
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                    if ApprovalEntry.FindFirst then begin
                        HREmployees.Reset;
                        HREmployees.SetRange(HREmployees."Employee UserID", ApprovalEntry."Approver ID");
                        if HREmployees.FindFirst then begin
                            HREmployees.CALCFIELDS(Signature);
                            DataItem1.Approver2Signature := HREmployees.Signature;
                            DataItem1.Approver2Name := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                            DataItem1.Approver2Date := ApprovalEntry."Last Date-Time Modified";
                        end;
                    end;
                    //end;
                    //if "Purchase Header".Approver3Name = '' then begin
                    ApprovalEntry.Reset;
                    ApprovalEntry.SetRange("Document No.", DataItem1."No.");
                    ApprovalEntry.SetRange("Sequence No.", 3);
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                    if ApprovalEntry.FindFirst then begin
                        HREmployees.Reset;
                        HREmployees.SetRange(HREmployees."Employee UserID", ApprovalEntry."Approver ID");
                        if HREmployees.FindFirst then begin
                            HREmployees.CALCFIELDS(Signature);
                            DataItem1.Approver3Signature := HREmployees.Signature;
                            DataItem1.Approver3Name := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                            DataItem1.Approver3Date := ApprovalEntry."Last Date-Time Modified";
                        end;
                    end;


                    //end;
                    DataItem1.Modify;
                end;
            }
        }
    }

    requestpage
    {

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

    var
        TenderCommittee: Record "170178";
        // HREmployees: Record "172021";
        text: Text;
        HREmployees: Record "HR Employees";
        ApprovalEntry: Record "Approval Entry";
}

