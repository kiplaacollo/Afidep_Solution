pageextension 50081 "General Journal Ext" extends "General Journal"
{

    layout
    {
        addafter("Currency Code")
        {
            field("Currency Factor"; Rec."Currency Factor")
            {
                ApplicationArea = Basic;
                Editable = true;
            }
            // field("Approval Status"; Rec."Approval Status")
            // {
            //     ApplicationArea = Basic;
            // }
        }
    }
    actions
    {
        addafter(Post)
        {
            action(PostNew)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost New';
                Image = PostOrder;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                begin
                    // Rec.SendToPosting(Codeunit::"Gen. Jnl.-Post");
                    // CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                    // if IsSimplePage then
                    //     if GeneralLedgerSetup."Post with Job Queue" then
                    //         NewDocumentNo()
                    //     else
                    //         SetDataForSimpleModeOnPost();
                    // SetJobQueueVisibility();
                    // CurrPage.Update(false);
                end;
            }
        }

        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                //             if Rec."Approval Status" <> Rec."Approval Status"::Approved then
                //                 Error('Status Must be approved before posting');
                //             // Call the simple approval check before posting
                //             //  CheckApprovalStatusBeforePosting();

                //             // Continue with posting if the journal is approved
                //             // CurrPage.SaveRecord;
                //             //Action::Post.Run();
            end;
        }
    }
}
//     layout
//     {
//         // Add changes to page layout here
//         addafter(Comment)
//         {
//             field("Approval Status"; Rec."Approval Status")
//             {
//                 ApplicationArea = Basic;
//             }

//         }
//     }


//     actions
//     {
//         addafter(CancelApprovalRequest)
//         {
//             action(ApprovalsNew)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Approvals';
//                 Image = Approval;
//                 Promoted = true;
//                 PromotedCategory = Category6;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 var
//                     ApprovalEntries: Page "Approval Entries";
//                 begin
//                     //      DocumentType := DocumentType::" ";

//                     // ApprovalEntries.SetRecordFilters(Database::"Bank Acc. Reconciliation", Rec."Statement Type", Rec."Bank Account No.");
//                     // ApprovalEntries.Run;

//                     // ApprovalEntry.reset;


//                 end;
//             }

//             action("Send A&pproval Request")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Send A&pproval Request New';
//                 Image = SendApprovalRequest;
//                 Promoted = true;
//                 PromotedCategory = Category6;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 var
//                     Text001: label 'This Batch is already pending approval';
//                     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                 begin
//                     // Rec.TestField("Approval Status", Rec."Approval Status"::New);
//                     // Rec.TestField(Amount);

//                     // varrvariant := Rec;

//                     // if CustomApprovalsCodeunit.CheckApprovalsWorkflowEnabled(varrvariant) then
//                     //     CustomApprovalsCodeunit.OnSendDocForApproval(varrvariant);
//                     if ApprovalsMgmt.CheckGeneralJournalLineApprovalsWorkflowEnabled(Rec) then
//                         ApprovalsMgmt.OnSendGeneralJournalLineForApproval(Rec);

//                 end;
//             }
//             action("Cancel Approval Request")
//             {
//                 ApplicationArea = Basic;
//                 Image = Cancel;
//                 Promoted = true;
//                 PromotedCategory = Category6;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 var
//                     ApprovalMgt: Codeunit "Approvals Mgmt.";
//                 begin
//                     //IF ApprovalMgt.CancelBatchAppr(Rec,TRUE,TRUE) THEN;
//                     //varrvariant:=Rec;
//                     //CustomApprovalsCodeunit.OnCancelDocApprovalRequest(varrvariant);
//                     // if Rec."Approval Status" = Rec."Approval Status"::"Pending Approval" then begin
//                     //     ApprovalEntry.Reset;
//                     //     ApprovalEntry.SetRange("Document No.", Rec."No.");
//                     //     if ApprovalEntry.FindSet then begin
//                     //         repeat
//                     //             ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
//                     //             ApprovalEntry."Approver ID" := '';
//                     //             ApprovalEntry.Modify;
//                     //         until ApprovalEntry.Next = 0;
//                     //     end;
//                     //     Rec."Approval Status" := Rec."Approval Status"::New;
//                     //     Rec.Modify;
//                     // end;
//                 end;
//             }
//         }


//     }

//     local procedure CheckApprovalStatusBeforePosting()
//     var
//         ApprovalEntry: Record "Approval Entry";
//     begin
//         // Find the approval entry for the current General Journal Line
//         ApprovalEntry.SetRange("Table ID", DATABASE::"Gen. Journal Line");
//         ApprovalEntry.SetRange("Document No.", Rec."Document No.");

//         if ApprovalEntry.FindFirst() then begin
//             // Ensure the approval status is "Approved" before posting
//             ApprovalEntry.TESTFIELD(Status, ApprovalEntry.Status::Approved);
//         end
//         else begin
//             // Throw an error if no approval entry is found
//             Error('The journal has not been submitted for approval.');
//         end;
//     end;
// }



