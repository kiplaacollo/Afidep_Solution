Page 80200 "Exit Interview List"
{
    PageType = List;
    CardPageId = "Exit Interview Form";
    SourceTable = "Exit Interviews";

    layout
    {
        //
        area(content)
        {
            repeater(Control1)

            {

                //Caption = 'EXIT INTERVIEW FORM';
                Editable = true;

                field("Application Code"; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                    Editable = false;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = Basic;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                }
                field("Start date"; Rec."Start date")
                {
                    ApplicationArea = Basic;
                }
                field("Termination date"; Rec."Termination date")
                {
                    ApplicationArea = Basic;
                }
                field("Line Manager"; Rec."Line Manager")
                {
                    ApplicationArea = Basic;
                }
                field(status; Rec.status)
                {
                    ApplicationArea = Basic;
                }

            }
        }
    }

    actions
    {

        area(reporting)
        {
            action("Exit Form")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Exit Report";

                trigger OnAction()
                var
                    PayrollCalender: Record "Payroll Calender_AU";
                    "Payroll Period": Date;
                    "Period Name": Text;
                    PayrollManager: Codeunit "Payroll Management_AU";
                begin
                end;
            }
        }
        area(navigation)
        {

            group("Approval")
            {
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := DocumentType::" ";
                        ApprovalEntries.SetRecordFilters(DATABASE::"HR Leave Application", DocumentType, Rec."Application Code");
                        ApprovalEntries.RUN;

                        ApprovalEntry.Reset;


                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /// Rec.TestField(Rec."Leave Type");
                        // Rec.TestField(Rec."Days Applied");
                        //Rec.TestField(Rec.Reliever);
                        // Rec.TestField(Rec."Cell Phone Number");
                        // Rec.TestField(Rec."E-mail Address");

                        Rec.TestField(Rec.Status, Rec.Status::New);//

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
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalMgt.CancelBatchAppr(Rec,TRUE,TRUE) THEN;
                        //varrvariant:=Rec;
                        //CustomApprovalsCodeunit.OnCancelDocApprovalRequest(varrvariant);
                        ApprovalEntry.Reset;
                        ApprovalEntry.SetRange("Document No.", Rec."Application Code");
                        if ApprovalEntry.FindSet then begin
                            repeat
                                ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                                ApprovalEntry.Modify;
                            until ApprovalEntry.Next = 0;
                        end;
                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                    end;
                }
            }
        }
    }
    var
        ApprovalEntry: Record "Approval Entry";
        varrvariant: Variant;
        CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,Leave;
}

