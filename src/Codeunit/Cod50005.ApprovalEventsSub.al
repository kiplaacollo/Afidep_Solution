codeunit 50005 "Approval Event Sub"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    local procedure OnApproveApprovalRequest(ApprovalEntry: Record "Approval Entry")
    begin
        Codeunit.Run(Codeunit::"Approval Notification Push");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(ApprovalEntry: Record "Approval Entry")
    begin
        Codeunit.Run(Codeunit::"Approval Notification Push");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertApprovalEntry(var Rec: Record "Approval Entry"; RunTrigger: Boolean)
    begin
        if Rec.Status = Rec.Status::Open then
            Codeunit.Run(Codeunit::"Approval Notification Push");
    end;
}
