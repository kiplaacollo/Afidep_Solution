codeunit 50113 "Bulk Payment Voucher Approval"
{
    //  Caption = 'Bulk Approval with Header Update';

    trigger OnRun()
    var
        PurchaseHeader: Record "Purchase Header";
        ApprovalEntry: Record "Approval Entry";
        ApprovalMgmt: Codeunit "Approvals Mgmt.";
    begin
        // Filter Purchase Headers by AU Form Type for Payment Vouchers in 'Pending Approval' status
        PurchaseHeader.SetRange("AU Form Type", PurchaseHeader."AU Form Type"::"Payment Voucher"); // Filter for payment vouchers
        PurchaseHeader.SetRange(Status, PurchaseHeader.Status::"Pending Approval"); // Pending Approval status in Purchase Header

        // Loop through all relevant Purchase Headers
        if PurchaseHeader.FindSet() then begin
            repeat
             // Skip Purchase Header if the amount is zero
             
               
                // Find approval entries related to this purchase header
               // ApprovalEntry.SetRange("Table ID", Database::"Purchase Header");
               // ApprovalEntry.SetRange("Document No.", PurchaseHeader."No.");

                // // Loop through the approval entries for this Purchase Header to open Created entries
                // if ApprovalEntry.FindSet() then begin
                //     repeat
                //         // Open created entries
                //         if ApprovalEntry.Status = ApprovalEntry.Status::Created then begin
                //             ApprovalEntry.Status := ApprovalEntry.Status::Open;
                //             ApprovalEntry.Modify(true);
                //         end;
                //     until ApprovalEntry.Next() = 0;
                // end;

                // Reset the filter and find approval entries again to approve Open entries
                ApprovalEntry.SetRange("Table ID", Database::"Purchase Header");
                ApprovalEntry.SetRange("Document No.", PurchaseHeader."No.");
                ApprovalEntry.SetFilter(Status, '%1', ApprovalEntry.Status::Open); // Look for Open entries

                // Loop through Open entries to approve them
                if ApprovalEntry.FindSet() then begin
                    repeat
                        ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                        ApprovalEntry.Modify(true);

                        // Run the Approval Management Codeunit to handle workflow and approval logic
                        ApprovalMgmt.ApproveApprovalRequests(ApprovalEntry);
                    until ApprovalEntry.Next() = 0;
                end;

            // // After processing all related approval entries, check for remaining Open entries
            // ApprovalEntry.SetRange("Table ID", Database::"Purchase Header");
            // ApprovalEntry.SetRange("Document No.", PurchaseHeader."No.");
            // ApprovalEntry.SetFilter(Status, '%1', ApprovalEntry.Status::Open); // Check for Open entries

            // // If no Open entries remain, check if the Purchase Header can be released
            // if not ApprovalEntry.FindSet() then begin
            //     // Re-fetch the Purchase Header record to ensure it's up-to-date
            //     if PurchaseHeader.Get(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
            //         // Check if the amount is greater than zero before releasing
            //         if PurchaseHeader.Amount > 0 then begin
            //             PurchaseHeader.Status := PurchaseHeader.Status::Released;
            //             PurchaseHeader.Modify(true);
            //         end else begin
            //             // Optional: Log a message or handle the zero amount case
            //             Message('Purchase Header %1 cannot be released because the amount is zero.', PurchaseHeader."No.");
            //         end;
            //     end else begin
            //         Error('The Purchase Header record could not be found.');
            //     end;
            // end;

            until PurchaseHeader.Next() = 0; // Process all purchase headers in the dataset
        end else begin
            Message('No pending payment vouchers found.');
        end;
    end;
}


// {
//     // Caption = 'Bulk Payment Voucher Approval';

//     trigger OnRun()
//     var
//         PurchaseHeader: Record "Purchase Header";
//         ApprovalEntry: Record "Approval Entry";
//         ApprovalMgmt: Codeunit "Approvals Mgmt.";
//     begin
//         // Filter Purchase Headers by the AU Form Type field for Payment Vouchers
//         PurchaseHeader.SetRange("AU Form Type", PurchaseHeader."AU Form Type"::"Payment Voucher"); // Adjust this to the exact value used for payment vouchers
//         PurchaseHeader.SetRange(Status, PurchaseHeader.Status::"Pending Approval"); // Only open entries (pending approval)

//         if PurchaseHeader.FindSet() then begin
//             repeat
//                 // Find the related approval entry
//                 ApprovalEntry.SetRange("Table ID", Database::"Purchase Header");
//                 ApprovalEntry.SetRange("Document No.", 'PVUSD-2481');
//                 //  ApprovalEntry.SetFilter(Status, '%1|%2', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
//                 ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
//                 // Error(PurchaseHeader."No.");

//                 if ApprovalEntry.FindFirst() then begin
//                     // Approve each entry
//                     ApprovalEntry.Status := ApprovalEntry.Status::Approved;
//                     ApprovalEntry.Modify(true);

//                     // Run the Approval Management Codeunit to handle workflow and approval logic
//                     ApprovalMgmt.ApproveApprovalRequests(ApprovalEntry);
//                 end;

//             until PurchaseHeader.Next() = 0;
//         end else begin
//             Message('No pending payment vouchers found.');
//         end;
//     end;
// }


// // {
// //     [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidateEvent', 'Currency Code', true, true)]
// //     local procedure CurrencyFactorOnAfterValidate(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header")
// //     begin
// //         // Check if Currency Factor is 0 and set it to 1
// //         if Rec."Currency Factor" = 0 then begin
// //             Rec."Currency Factor" := 1;
// //             Rec.Modify(true);
// //             Commit();
// //         end;
// //     end;
// // }