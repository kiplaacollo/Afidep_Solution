pageextension 50112 "Approval comments ext" extends "Approval Comments"
{

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        ApprovalEntry: Record "Approval Entry";

    begin
        // Message('Begin edit');
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document No.", Rec."Document No.");
        //ApprovalEntry.SetRange("Approver ID", UserId);
        IF ApprovalEntry.FindLast() THEN BEGIN
            ApprovalEntry.Comments := Rec.Comment;
            ApprovalEntry.Modify(true);

        END

    end;
}
