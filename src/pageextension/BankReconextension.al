pageextension 50010 "Bank Account Recon" extends "Bank Acc. Reconciliation"
{

    layout
    {
        // Add changes to page layout here
        addafter(StatementEndingBalance)
        {
            field(Status; Rec.Status)
            {
                // Editable = false;
            }
            field("Branch Code"; Rec."Branch Code") { }
        }

    }

    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            Visible = false;
        }

        modify(PostAndPrint)
        {
            Visible = false;
        }
        addbefore("&Test Report")
        {


            action("Custom Bank Recon.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Rec. Report';
                Ellipsis = true;
                Image = Transactions;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ToolTip = 'Preview the resulting bank account reconciliations to see the consequences before you perform the actual posting.';

                trigger OnAction()
                var
                    BankRecon: Record "Bank Acc. Reconciliation";
                begin

                    BankRecon.Reset();
                    BankRecon.SetRange("Statement No.", Rec."Statement No.");
                    BankRecon.SetRange("Bank Account No.", Rec."Bank Account No.");
                    report.Run(80071, true, false, BankRecon);
                end;
            }

        }
        addbefore(Post)
        {
            action(PostCustom)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post Bank Rec';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Approved then Error('Bank Rec has not been fully Approved');
                    //CODEUNIT.Run(CODEUNIT::"Bank Acc. Recon. Post Y/N 4", Rec);//Bank Acc. Reconciliation Post2
                    CODEUNIT.Run(CODEUNIT::"Bank Acc. Reconciliation Post2", Rec);//Bank Acc. Reconciliation Post2
                    // RefreshSharedTempTable;
                end;
            }

        }
        addafter(Post)
        {

            group(Approval)
            {
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        //      DocumentType := DocumentType::" ";

                        ApprovalEntries.SetRecordFilters(Database::"Bank Acc. Reconciliation", Rec."Statement Type", Rec."Bank Account No.");
                        ApprovalEntries.Run;

                        ApprovalEntry.reset;


                    end;
                }

                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // Rec.TestField("Approval Status", Rec."Approval Status"::New);
                        // Rec.TestField(Amount);

                        varrvariant := Rec;

                        if CustomApprovalsCodeunit.CheckApprovalsWorkflowEnabled(varrvariant) then
                            CustomApprovalsCodeunit.OnSendDocForApproval(varrvariant);

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalMgt.CancelBatchAppr(Rec,TRUE,TRUE) THEN;
                        //varrvariant:=Rec;
                        //CustomApprovalsCodeunit.OnCancelDocApprovalRequest(varrvariant);
                        // if Rec."Approval Status" = Rec."Approval Status"::"Pending Approval" then begin
                        //     ApprovalEntry.Reset;
                        //     ApprovalEntry.SetRange("Document No.", Rec."No.");
                        //     if ApprovalEntry.FindSet then begin
                        //         repeat
                        //             ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                        //             ApprovalEntry."Approver ID" := '';
                        //             ApprovalEntry.Modify;
                        //         until ApprovalEntry.Next = 0;
                        //     end;
                        //     Rec."Approval Status" := Rec."Approval Status"::New;
                        //     Rec.Modify;
                        // end;
                    end;
                }
            }

        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        User: Record User;
    begin
        // Set RequesterName to the current User ID
        Rec.RequesterName := UserId;
        Rec.RequesterDate := Today;
        Rec.Modify(true);
        // Optionally show a message for confirmation
        //Error('Requester Name set to %1', UserId);
    end;

    var
        ApprovalEntry: Record "Approval Entry";
        CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
        varrvariant: Variant;
}