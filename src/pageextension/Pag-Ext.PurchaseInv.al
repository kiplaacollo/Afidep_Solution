pageextension 50120 "Purch. Invoice Subform Ext" extends "Purchase Invoice"
{
    layout
    {
        modify("Posting Description")
        {
            Visible = true;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ShowMandatory = true;

        }
        addafter(Status)
        {
            field("Currency Code."; Rec."Currency Code")
            {
                ApplicationArea = Basic;
            }
            field("Currency Factor"; Rec."Currency Factor")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        // modify("Re&lease")
        // {
        //     Visible = false; // Hide the action
        // }

        // Hide the original "Post" action
        // modify(Post)
        // {
        //    // Visible = false;
        // }

        // Add a new action: "Custom Post"
        addlast(Release)
        {
            action(CustomPost)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Custom Post';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Post the document after status validation.';

                trigger OnAction()
                var
                    PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                begin
                    // Check if the status is either Released or Approved
                    if (Rec.Status <> Rec.Status::Released) then
                        Rec.Status := Rec.Status::Released;
                    // Error('The document must be either Released or Approved to be posted.');

                    VerifyTotal(); // Verifies the total purchase lines

                    // Proceed with posting using the Purch.-Post (Yes/No) codeunit
                    PurchPostYesNo.Run(Rec); // Executes the posting logic for the purchase document
                end;
            }
        }
        addafter(CancelApprovalRequest)
        {
            action("Send A&pproval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                // Visible = false;

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
            action("Cancel A&pproval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Reopen A&pproval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                // Visible = false;

                trigger OnAction()
                var
                    Text001: label 'This Batch is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    // Rec.TestField("Approval Status", Rec."Approval Status"::New);
                    // Rec.TestField(Amount);

                    if Rec.Status = Rec.Status::"Pending Approval" then
                        Rec.Status := Rec.Status::Open;
                    Rec.Modify;

                end;
            }

            action("Update A&pproval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Update A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                // Visible = false;

                trigger OnAction()
                var
                    Text001: label 'This Batch is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    // Rec.TestField("Approval Status", Rec."Approval Status"::New);
                    // Rec.TestField(Amount);

                    if Rec.Status = Rec.Status::Open then
                        Rec.Status := Rec.Status::"Pending Approval";
                    Rec.Modify;

                end;
            }


        }
    }
    var
        ApprovalEntry: Record "Approval Entry";
        CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
        varrvariant: Variant;
}

