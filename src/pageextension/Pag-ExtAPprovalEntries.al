pageextension 50014 "Approval lines" extends "Requests to Approve"
{



    layout
    {
        modify(ToApprove)
        {
            Width = 50;
            Visible = false;
        }


        addafter(Details)
        {
            field("Document No."; Rec."Document No.") { ApplicationArea = all; }
            field("Document Types"; Rec."Document Types") { }
            field("Payment Voucher No"; Rec."Payment Voucher No") { }
            field("Paying Bank Name"; Rec."Paying Bank Name") { }
            field("Paying Bank Number"; Rec."Paying Bank Number") { }
            field("CashBook Narration"; Rec."CashBook Narration") { }
            field(Memo; Rec.Memo) { ApplicationArea = all; Caption = 'Memo/Payee'; }
            field("Employee Name"; Rec."Employee Name") { }
            field("CurrencyCode"; Rec."Currency Code") { Caption = 'Currency'; }
            field(ForeignAmount; Rec.Amount) { Caption = 'Amount in Foreign'; }
            field("Amount(LCY)"; Rec."Amount (LCY)") { Caption = 'Amount in Base Currency'; }
            field("Leave Types"; Rec."Leave Types") { }
            field("Days Applied"; Rec."Days Applied") { }
            field("Pending Task"; Rec."Pending Task") { }
            field(Comments; Rec.Comments)
            {
                Editable = true;

            }



        }

    }

    actions
    {
        modify(Reject)
        {
            Visible = false;
        }
        modify(Approve)
        {
            Visible = false;
        }
        addafter(Approve)
        {
            action("Approve Button")
            {
                ApplicationArea = Suite;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Approve the requested changes.';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    if Confirm('Are you sure you want to Approve this Document?') = false then exit;
                    CurrPage.SetSelectionFilter(ApprovalEntry);
                    ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
                end;
            }
            action(OpenRelatedDocument)
            {
                Caption = 'Open Purchase Inv.';
                ToolTip = 'Open the related document based on the document type and document number.';
                ApplicationArea = Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PageToOpen: Integer;
                begin
                    GetDrillDownPageID();
                end;
            }
            action("Reject Action")
            {
                ApplicationArea = Suite;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Reject the approval request.';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    if Confirm('Are you sure you want to Reject This Document?') = false then exit;

                    //Rec.TestField(Comments);
                    CurrPage.SetSelectionFilter(ApprovalEntry);
                    ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
                end;
            }

        }
    }

    var
        myInt: Integer;

    trigger OnOpenPage();
    begin
        CurrPage.Editable(true);
    end;


    procedure GetDrillDownPageID(): Integer
    var
        PurchaseHeader: Record "Purchase Header"; // Declare the Purchase Header record variable
    begin
        // Filter the Purchase Header based on Document No.
        PurchaseHeader.SetRange("No.", Rec."Document No.");

        // Check if there is any record that matches the filter
        if PurchaseHeader.FindFirst() then begin
            // If found, open the Purchase Invoice page
            PAGE.Run(PAGE::"Purchase Invoice", PurchaseHeader);
        end else begin
            // If not found, show an error message
            Error('Purchase Invoice with Document No. %1 not found.', Rec."Document No.");
        end;
    end;
}
// }

pageextension 50099 "CompanyInformation" extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
        addafter("Home Page")
        {
            field("Sharepoint Path"; Rec."Sharepoint Path")
            {
                ApplicationArea = all;
            }
            field("Report Header"; Rec."Report Header") { }
            field("Report header Address"; Rec."Report header Address") { MultiLine = true; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}