codeunit 50114 "Auto Post Purchase Invoice"
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterPurchaseHeaderModify(var Rec: Record "Purchase Header"; xRec: Record "Purchase Header"; RunTrigger: Boolean)
    begin
        // Check if the status has changed to "Approved" and it's an Invoice
        if (Rec."Document Type" = Rec."Document Type"::Invoice) and
           (Rec.Status = Rec.Status::Released) and
           (xRec.Status = Rec.Status) then begin
            // Check if the Purchase Header has been fully approved
            if IsFullyApproved(Rec) then begin
                // Call the post action on the Purchase Invoice page
                PostPurchaseInvoice(Rec);
            end;
        end;
    end;

    local procedure IsFullyApproved(PurchaseHeader: Record "Purchase Header"): Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        // Filter the approval entries related to the Purchase Header
        ApprovalEntry.SetRange("Table ID", DATABASE::"Purchase Header");
        ApprovalEntry.SetRange("Document No.", PurchaseHeader."No.");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);

        // If there are no open approval entries, it is fully approved
        exit(ApprovalEntry.IsEmpty());
    end;

    local procedure PostPurchaseInvoice(PurchaseHeader: Record "Purchase Header")
    var
        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
    begin
        // Run the posting process using the Purch.-Post (Yes/No) codeunit
        PurchPostYesNo.Run(PurchaseHeader);

        Message('Purchase Invoice %1 has been posted successfully.', PurchaseHeader."No.");
    end;
}
