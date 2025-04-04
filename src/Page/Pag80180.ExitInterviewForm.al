Page 80199 "Exit Interview Form"
{
    PageType = Card;
    SourceTable = "Exit Interviews";

    layout
    {
        //
        area(content)
        {
            group(General)

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

            group("Section 1")
            {
                group("This section relates to the reasons' for leaving. You may have more than one reason for leaving.") 
                {
                    field("Reason 1 For leaving"; Rec."Reason 1 For leaving")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Reason 1 Remarks"; Rec."Reason 1 Remarks")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Relevant Info. For Reason Above';
                        ShowMandatory = true;
                    }
                    field("Reason 2 For leaving"; Rec."Reason 2 For leaving")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Reason 2 Remarks"; Rec."Reason 2 Remarks")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Relevant Info. For Reason Above';
                    }
                    field("Reason 3 For leaving"; Rec."Reason 3 For leaving")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Reason 3 Remarks"; Rec."Reason 3 Remarks")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Relevant Info. For Reason Above';
                    }
                    group("If you are moving to another job please give below as much relevant information as possible, e.g. organisation,")
                    {
                        group(" new position, salary, benefits etc. Please note that this information will help AFIDEP  look at its ")
                        {
                            group("compensation and other policies and practice. Get ensured that the information you give will be treated confidential.")
                            {
                                field(Organization; Rec.Organization) { }
                                field("New Position"; Rec."New Position") { }
                                field("Other Remarks"; Rec."Other Remarks") { }

                            }

                        }
                    }

                }
            }
            group("Section 2")
            {
                group("This section relates to the job you have been performing, support, training, relationship during your time with AFIDEP")
                {
                    group("Please give the response that best describes your feelings: 1. Strongly agree 2. Agree 3. Neutral 4. Disagree ")
                    {
                        field("The work I was doing on the whole was approximately what I was originally expected to be doing."; Rec."The work I was doing on the whole was approximately what I was originally expected to be doing.")
                        {
                            ShowMandatory = true;

                        }
                        field("I had  ample opportunities to use initiative"; Rec."I had  ample opportunities to use initiative")
                        {
                            ShowMandatory = true;
                        }
                        field("The work I was doing was interesting and challenging"; Rec."The work I was doing was interesting and challenging")
                        {
                            ShowMandatory = true;
                        }
                        field("Overall, I was satisfied with the general conditions"; Rec."Overall, I was satisfied with the general conditions")
                        {
                            ShowMandatory = true;
                        }
                        field("I was able to make full use of my skills and abilities"; Rec."I was able to make full use of my skills and abilities")
                        {
                            ShowMandatory = true;
                        }
                        field("There was team spirit in the organisation"; Rec."There was team spirit in the organisation")
                        {
                            ShowMandatory = true;
                        }
                        field("There was too much pressure on my job"; Rec."There was too much pressure on my job")
                        {
                            ShowMandatory = true;
                        }
                        field("I had ample opportunities for personal training and development"; Rec."I had ample opportunities for personal training and development")
                        {
                            ShowMandatory = true;
                        }
                        field("I received adequate support from my line manager"; Rec."I received adequate support from my line manager")
                        {
                            ShowMandatory = true;
                        }
                        field("I was satisfied with my salary"; Rec."I was satisfied with my salary")
                        {
                            ShowMandatory = true;
                        }
                        field("I found the policies and procedures fair."; Rec."I found the policies and procedures fair.")
                        {
                            ShowMandatory = true;
                        }
                        field("I had the necessary freedom to make my own decisions"; Rec."I had the necessary freedom to make my own decisions")
                        {
                            ShowMandatory = true;
                        }
                        field("I had opportunities to discuss my performance with my line manager."; Rec."I had opportunities to discuss my performance with my line manager.")
                        {
                            ShowMandatory = true;
                        }
                        field("I received communication to enable me know what was going on in other parts of the organisation."; Rec."I received communication to enable me know what was going on in other parts of the organisation.")
                        {
                            ShowMandatory = true;
                        }
                        field("Overall, I felt involved in the work of  AFIDEP"; Rec."Overall, I felt involved in the work of  AFIDEP")
                        {
                            ShowMandatory = true;
                        }
                    }
                }
            }
            group("SECTION 3")
            {
                group("1. If you have resigned due to one or more of the reasons given above, what might have prevented you from resigning?")
                {
                    field("Other Reasons for Leaving"; Rec."Other Reasons for Leaving") { }
                    field("State Reason For Leaving"; Rec."State Reason For Leaving")
                    {
                        ShowMandatory = true;
                    }
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

