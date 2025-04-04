codeunit 80012 "Pagemanagent"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin
        CASE RecordRef.NUMBER OF
            DATABASE::"Purchase Header":
                PageID := GetPurchaseHeaderPageID(RecordRef);
            DATABASE::"HR Leave Application":
                PageID := (Page::"HR Leave Application Card");
            Database::"Time Sheet Header":
                PageID := (Page::"Timesheet Card Custom");

            Database::"Timesheet Lines":
                PageID := (Page::"Timesheet Lines");
            Database::Payroll:
                PageID := (Page::"Payroll card");
            Database::"Payroll M":
                PageID := (Page::"Payroll M card");
            Database::"Purchase Quote Header":
                PageID := (Page::"RFQ Header");
        end;
    end;

    procedure PurchaseHeaderExtension(RecRef: RecordRef): Integer;
    var
        PuchaseHeader: Record "Purchase Header";
        ApprovalEntry: Record "Approval Entry";
    // PurchaseHeader: Record "Purchase Order";
    begin



        // Message('home%1', PuchaseHeader."AU Form Type");
        // RecRef.SetTable(PurchaseHeader);
        // case PurchaseHeader."AU Form Type" of
        //     PurchaseHeader."AU Form Type"::"Request Form":
        //         exit(PAGE::"Request Form");
        //     PurchaseHeader."AU Form Type"::"Imprest Accounting":
        //         exit(PAGE::"Payment Voucher Card");
        //     PurchaseHeader."AU Form Type"::"Imprest Requisition":
        //         exit(PAGE::"Travel Authorization");
        //     PurchaseHeader."AU Form Type"::"Payment Voucher":
        //         exit(PAGE::"Payment Voucher Card");
        //     PurchaseHeader."AU Form Type"::"Salary Advance":
        //         exit(PAGE::"Salary Advance Voucher  Card");
        //     PurchaseHeader."AU Form Type"::"Travel Requsition Form":
        //         exit(PAGE::"Travel Requisition Form");
        //end;


    end;

    local procedure GetPurchaseHeaderPageID(RecRef: RecordRef): Integer
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        RecRef.SetTable(PurchaseHeader);
        case PurchaseHeader."AU Form Type" of

            PurchaseHeader."AU Form Type"::"Imprest Accounting":
                exit(PAGE::"Payment Voucher Card");
            PurchaseHeader."AU Form Type"::"Imprest Requisition":
                exit(PAGE::"Imprest Requisition");
            PurchaseHeader."AU Form Type"::"Payment Voucher":
                exit(PAGE::"Payment Voucher Card");
            PurchaseHeader."AU Form Type"::"Salary Advance":
                exit(PAGE::"Salary Advance Voucher  Card");
            PurchaseHeader."AU Form Type"::"Expense Requisition":
                exit(PAGE::"Expense Requisition Card");
            PurchaseHeader."AU Form Type"::"Purchase Requisition":
                exit(PAGE::"Task Order Card");
            PurchaseHeader."AU Form Type"::"Claim Voucher":
                exit(PAGE::"Claims Voucher Card");


        end;
    end;



}