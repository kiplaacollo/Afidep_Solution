//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17287 "Funds Transfer Card"
{
    PageType = Card;
    SourceTable = "Funds Transfer Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }

                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }

                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Bank Name"; Rec."Paying Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Balance"; Rec."Bank Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Total Line Amount"; Rec."Total Line Amount") { ApplicationArea = Basic; }
                field("Total Line Amount(LCY)"; Rec."Total Line Amount(LCY)") { ApplicationArea = Basic; }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Enabled = false;

                }
                field("Currency Factor"; Rec."Currency Factor") { Enabled = false; }
                field(Description; rec.Description)
                {
                    ApplicationArea = Basic;
                    //  Editable = false;
                }
                field("Cheque/Doc. No"; Rec."Cheque/Doc. No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Time Created"; Rec."Time Created")
                {
                    ApplicationArea = Basic;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch Code';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Project Code';
                }


            }
            part(Control24; "Funds Transfer Lines")
            {
                SubPageLink = "Document No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post Transfer")
            {
                ApplicationArea = Basic;
                Caption = 'Post Transfer';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    JTemplate := 'General';
                    JBatch := 'B TRF';
                    FundsManager.PostFundsTransfer(Rec, JTemplate, JBatch);




                end;
            }
            action(Print)
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin


                    FHeader.Reset;
                    FHeader.SetRange(FHeader."No.", Rec."No.");
                    if FHeader.FindFirst then
                        Report.run(50076, true, true, FHeader);

                end;
            }
            separator(Action1000000005)
            {
                Caption = '-';
            }
            action(Approval)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                var
                //  ApprovalEntries: Page "Approval Entries";
                begin
                    //DocumentType := Documenttype::FundsTransfer;
                    //  ApprovalEntries.Setfilters(Database::"Funds Transfer Header", DocumentType, Rec."No.");
                    //ApprovalEntries.Run;
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                var
                    Text001: label 'This request is already pending approval';
                // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    //IF ApprovalsMgmt.CheckSaccoTransferApprovalsWorkflowEnabled(Rec) THEN
                    //      ApprovalsMgmt.OnSendSaccoTransferForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                var
                //  Approvalmgt: Codeunit "Approvals Mgmt.";
                begin

                    if Confirm('Are you sure you want to cancel this approval request', false) = true then begin
                        // Rec.Status := Rec.Status::New;
                        //Rec.Modify;
                    end;
                end;
            }
            separator(Action1000000001)
            {
                Caption = '       -';
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Pay Mode":="Pay Mode"::Cash;
        //Rec."Transfer Type" := Rec."transfer type"::InterBank;
    end;

    var
        FundsManager: Codeunit "AU factory";

        JTemplate: Code[50];
        JBatch: Code[50];
        FHeader: Record "Funds Transfer Header";
        FLine: Record "Funds Transfer Line";
        DocumentType: enum "Approval Document Type";

    procedure CheckRequiredItems()
    begin
        /*         Rec.TestField("Posting Date");
               Rec. TestField("Paying Bank Account");
                Rec.TestField("Amount to Transfer");
                Rec.TestField("Global Dimension 2 Code");
                if Rec."Pay Mode" = Rec."pay mode"::Cheque then
                    Rec.TestField("Cheque/Doc. No");
                Rec.TestField(Description); */
        //TESTFIELD("Transfer To");

        FLine.Reset;
        FLine.SetRange(FLine."Document No", Rec."No.");
        FLine.SetFilter(FLine."Amount to Receive", '<>%1', 0);
        if FLine.FindSet then begin
            repeat
                FLine.TestField(FLine."Receiving Bank Account");
            until FLine.Next = 0;
        end;
    end;
}





