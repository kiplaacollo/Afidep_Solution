Codeunit 80008 "Custom Approvals Codeunit"
{

    trigger OnRun()
    begin
    end;

    var
        WorkflowManagement: Codeunit "Workflow Management";
        UnsupportedRecordTypeErr: label 'Record type %1 is not supported by this workflow response.', Comment = 'Record type Customer is not supported by this workflow response.';
        NoWorkflowEnabledErr: label 'This record is not supported by related approval workflow.';
        //HR": ;
        //HR Jobs": ;
        OnSendHRJobsApprovalRequestTxt: label 'Approval of a HR Job is requested';
        RunWorkflowOnSendHRJobsForApprovalCode: label 'RUNWORKFLOWONSENDHRJOBSFORAPPROVAL';
        OnCancelHRJobsApprovalRequestTxt: label 'Approval of a HR Job is canceled';
        RunWorkflowOnCancelHRJobsForApprovalCode: label 'RUNWORKFLOWONCANCELHRJOBSFORAPPROVAL';
        //Employee Requisitions": ;
        OnSendEmpReqApprovalRequestTxt: label 'Approval of an Employee Requsition is requested';
        RunWorkflowOnSendEmpReqForApprovalCode: label 'RUNWORKFLOWONSENDEMPREQFORAPPROVAL';
        OnCancelEmpReqApprovalRequestTxt: label 'Approval of an Employee Requsition is canceled';
        RunWorkflowOnCancelEmpReqForApprovalCode: label 'RUNWORKFLOWONCANCELEMPREQFORAPPROVAL';
        //HR Employees": ;
        OnSendEmployeesApprovalRequestTxt: label 'Approval of an Employee is requested';
        RunWorkflowOnSendEmployeesForApprovalCode: label 'RUNWORKFLOWONSENDEMPLOYEESFORAPPROVAL';
        OnCancelEmployeesApprovalRequestTxt: label 'Approval of an Employee is canceled';
        RunWorkflowOnCancelEmployeesForApprovalCode: label 'RUNWORKFLOWONCANCELEMPLOYEESFORAPPROVAL';
        //Employee Confirmation": ;
        OnSendEmpConfApprovalRequestTxt: label 'Approval of an Employee Confirmation is requested';
        RunWorkflowOnSendEmpConfForApprovalCode: label 'RUNWORKFLOWONSENDEMPCONFFORAPPROVAL';
        OnCancelEmpConfApprovalRequestTxt: label 'Approval of an Employee Confirmation is canceled';
        RunWorkflowOnCancelEmpConfForApprovalCode: label 'RUNWORKFLOWONCANCELEMPCONFFORAPPROVAL';
        //Employee Promotion": ;
        OnSendEmpPromoApprovalRequestTxt: label 'Approval of an Employee Promotion is requested';
        RunWorkflowOnSendEmpPromoForApprovalCode: label 'RUNWORKFLOWONSENDEMPPROMOFORAPPROVAL';
        OnCancelEmpPromoApprovalRequestTxt: label 'Approval of an Employee Promotion is canceled';
        RunWorkflowOnCancelEmpPromoForApprovalCode: label 'RUNWORKFLOWONCANCELEMPPROMOFORAPPROVAL';
        //Employee Transfer": ;
        OnSendEmpTransApprovalRequestTxt: label 'Approval of an Employee Transfer is requested';
        RunWorkflowOnSendEmpTransForApprovalCode: label 'RUNWORKFLOWONSENDEMPTRANSFORAPPROVAL';
        OnCancelEmpTransApprovalRequestTxt: label 'Approval of an Employee Transfer is canceled';
        RunWorkflowOnCancelEmpTransForApprovalCode: label 'RUNWORKFLOWONCANCELEMPTRANSFORAPPROVAL';
        //Asset Transfer": ;
        OnSendAssTransApprovalRequestTxt: label 'Approval of an Asset Transfer is requested';
        RunWorkflowOnSendAssTransForApprovalCode: label 'RUNWORKFLOWONSENDASSTRANSFORAPPROVAL';
        OnCancelAssTransApprovalRequestTxt: label 'Approval of an Asset Transfer is canceled';
        RunWorkflowOnCancelAssTransForApprovalCode: label 'RUNWORKFLOWONCANCELASSTRANSFORAPPROVAL';
        //Transport Requisition": ;
        OnSendTranspReqApprovalRequestTxt: label 'Approval of a Transport Requsition is requested';
        RunWorkflowOnSendTranspReqForApprovalCode: label 'RUNWORKFLOWONSENDTRANSPREQFORAPPROVAL';
        OnCancelTranspReqApprovalRequestTxt: label 'Approval of a Transport Requisition is canceled';
        RunWorkflowOnCancelTranspReqForApprovalCode: label 'RUNWORKFLOWONCANCELTRANSPREQFORAPPROVAL';
        //Overtime": ;
        OnSendOvertimeApprovalRequestTxt: label 'Approval of an Overtime Requisition is requested';
        RunWorkflowOnSendOvertimeForApprovalCode: label 'RUNWORKFLOWONSENDOVERTIMEFORAPPROVAL';
        OnCancelOvertimeApprovalRequestTxt: label 'Approval of an Overtime Requisition is canceled';
        RunWorkflowOnCancelOvertimeForApprovalCode: label 'RUNWORKFLOWONCANCELOVERTIMEFORAPPROVAL';
        //Training Application": ;
        OnSendTrainAppApprovalRequestTxt: label 'Approval of a Training Application is requested';
        RunWorkflowOnSendTrainAppForApprovalCode: label 'RUNWORKFLOWONSENDTRAINAPPFORAPPROVAL';
        OnCancelTrainAppApprovalRequestTxt: label 'Approval of a Training Application is canceled';
        RunWorkflowOnCancelTrainAppForApprovalCode: label 'RUNWORKFLOWONCANCELTRAINAPPFORAPPROVAL';
        //Leave Applications": ;
        OnSendLeaveApprovalRequestTxt: label 'Approval of a Leave Application is requested';
        RunWorkflowOnSendLeaveForApprovalCode: label 'RUNWORKFLOWONSENDLEAVEFORAPPROVAL';
        OnCancelLeaveApprovalRequestTxt: label 'Approval of a Leave Application is canceled';
        RunWorkflowOnCancelLeaveForApprovalCode: label 'RUNWORKFLOWONCANCELLEAVEFORAPPROVAL';
        OnRejectLeaveApprovalRequestTxt: label 'Approval of a Leave Application is rejected';
        RunWorkflowOnRejectLeaveForApprovalCode: label 'RUNWORKFLOWONREJECTLEAVEFORAPPROVAL';

        //Bank Reconciliation
        OnSendBankRecApprovalRequestTxt: label 'Approval of Bank Reconciliation is requested';
        RunWorkflowOnSendBankRecForApprovalCode: label 'RUNWORKFLOWONSENDBANKRECFORAPPROVAL';
        OnCancelBankRecApprovalRequestTxt: label 'Approval of a Bank Reconciliation is canceled';
        RunWorkflowOnCancelBankRecForApprovalCode: label 'RUNWORKFLOWONCANCELBANKRECFORAPPROVAL';
        OnRejectBankRecApprovalRequestTxt: label 'Approval of a Bank Reconciliation is rejected';
        RunWorkflowOnRejectBankRecForApprovalCode: label 'RUNWORKFLOWONREJECTBANKRECFORAPPROVAL';
        //Purchase Invoice
        OnSendPurchaseInvApprovalRequestTxt: label 'Approval of Purchase Invoice is requested';
        RunWorkflowOnSendPurchaseInvForApprovalCode: label 'RUNWORKFLOWONSENDPurchaseInvFORAPPROVAL';
        OnCancelPurchaseInvApprovalRequestTxt: label 'Approval of a Purchase Invoice is canceled';
        RunWorkflowOnCancelPurchaseInvForApprovalCode: label 'RUNWORKFLOWONCANCELPurchaseInvFORAPPROVAL';
        OnRejectPurchaseInvApprovalRequestTxt: label 'Approval of a Purchase Invoice is rejected';
        RunWorkflowOnRejectPurchaseInvForApprovalCode: label 'RUNWORKFLOWONREJECTPurchaseInvFORAPPROVAL';


        //VEHICLE REQUSITION
        RunWorkflowOnSendVehicleRequisitionForApprovalCode: Label 'RUNWORKFLOWONSENDVEHICLEFORAPPROVAL';
        OnSendVehicleReqApprovalRequestTxt: label 'Approval of a Vehicle requsition is requested';
        RunWorkflowOnCancelVehicleForApprovalCode: label 'RUNWORKFLOWONCANCELVehicleFORAPPROVAL';
        OnCancelVehicleReqApprovalRequestTxt: label 'Approval of a Vehicle is canceled';

        //Leave Reimbursement": ;
        OnSendLeaveReApprovalRequestTxt: label 'Approval of a Leave Reimbursement is requested';
        RunWorkflowOnSendLeaveReForApprovalCode: label 'RUNWORKFLOWONSENDLEAVEREFORAPPROVAL';
        OnCancelLeaveReApprovalRequestTxt: label 'Approval of a Leave Reimbursment is canceled';
        RunWorkflowOnCancelLeaveReForApprovalCode: label 'RUNWORKFLOWONCANCELLEAVEREFORAPPROVAL';
        //Disciplinary Cases": ;
        OnSendDisciplinaryCaseApprovalRequestTxt: label 'Approval of a Disciplinary Case is requested';
        RunWorkflowOnSendDisciplinaryCaseForApprovalCode: label 'RUNWORKFLOWONSENDDISCIPLINARYCASEFORAPPROVAL';
        OnCancelDisciplinaryCaseApprovalRequestTxt: label 'Approval of a Disciplinary Case is canceled';
        RunWorkflowOnCancelDisciplinaryCaseForApprovalCode: label 'RUNWORKFLOWONCANCELDISCIPLINARYCASEFORAPPROVAL';
        //Exit Interviews": ;
        OnSendExitApprovalRequestTxt: label 'Approval of an Exit Interview is requested';
        RunWorkflowOnSendExitForApprovalCode: label 'RUNWORKFLOWONSENDEXITFORAPPROVAL';
        OnCancelExitApprovalRequestTxt: label 'Approval of an Exit Interview is canceled';
        RunWorkflowOnCancelExitForApprovalCode: label 'RUNWORKFLOWONCANCELEXITFORAPPROVAL';
        //Clearance: ;
        OnSendClearanceApprovalRequestTxt: label 'Approval of an Clearance is requested';
        RunWorkflowOnSendClearanceForApprovalCode: label 'RUNWORKFLOWONSENDCLEARANCEFORAPPROVAL';
        OnCancelClearanceApprovalRequestTxt: label 'Approval of an Clearance is canceled';
        RunWorkflowOnCancelClearanceForApprovalCode: label 'RUNWORKFLOWONCANCELClearanceFORAPPROVAL';
        //Receipts": ;
        OnSendReceiptApprovalRequestTxt: label 'Approval of a Receipt is requested';
        RunWorkflowOnSendReceiptForApprovalCode: label 'RUNWORKFLOWONSENDRECEIPTFORAPPROVAL';
        OnCancelReceiptApprovalRequestTxt: label 'An Approval of a Receipt is canceled';
        RunWorkflowOnCancelReceiptForApprovalCode: label 'RUNWORKFLOWONCANCELRECEIPTFORAPPROVAL';
        //Item Journal": ;
        OnSendItemJournalApprovalRequestTxt: label 'Approval of Item Journal is requested';
        RunWorkflowOnSendItemJournalForApprovalCode: label 'RUNWORKFLOWONSENDITEMJOURNALFORAPPROVAL';
        OnCancelItemJournalApprovalRequestTxt: label 'An Approval of Item Journal is canceled';
        RunWorkflowOnCancelItemJournalForApprovalCode: label 'RUNWORKFLOWONCANCELITEMJOURNALFORAPPROVAL';
        //Customer Registrations": ;
        OnSendCustomerRegistrationApprovalRequestTxt: label 'An approval request for customer registration is requested';
        RunWorkflowOnSendCustomerRegistrationForApprovalCode: label 'RUNWORKFLOWONSENDCUSTOMERREGISTRATIONFORAPPROVAL';
        OnCancelCustomerRegistrationApprovalRequestTxt: label 'An approval request for customer registration is canceled';
        RunWorkflowOnCancelCustomerRegistrationForApprovalCode: label 'RUNWORKFLOWONCANCELCUSTOMERREGISTRATIONFORAPPROVAL';
        //Payments Document": ;
        OnSendPaymentDocumentApprovalRequestTxt: label 'An approval request for Payment voucher is requested';
        RunWorkflowOnSendPaymentDocuemntForApprovalCode: label 'RUNWORKFLOWONSENDPAYMENTDOCUMENTFORAPPROVAL';
        OnCancelPaymentDocumentApprovalRequestTxt: label 'An approval request for Payment voucher is canceled';
        RunWorkflowOnCancelPaymentDocumentForApprovalCode: label 'RUNWORKFLOWONCANCELPAYMENTDOCUMENTFORAPPROVAL';
        ///Item Journal line": ;
        OnSendItemJournalLineApprovalRequestTxt: label 'Approval of Item Journal line is requested';
        RunWorkflowOnSendItemJournalLineForApprovalCode: label 'RUNWORKFLOWONSENDITEMJOURNALLINEFORAPPROVAL';
        OnCancelItemJournalApprovalLineRequestTxt: label 'An Approval of Item Journal line is canceled';
        RunWorkflowOnCancelItemJournalLineForApprovalCode: label 'RUNWORKFLOWONCANCELITEMJOURNALLINEFORAPPROVAL';
        //// Bank in slip confirmation": ;
        OnSendBankinslipApprovalRequestTxt: label 'Approval of Bank in slip is requested';
        RunWorkflowOnSendBankInSlipForApprovalCode: label 'RUNWORKFLOWONSENBANKINSLIPFORAPPROVAL';
        OnCancelBankInslipRequestTxt: label 'An Approval of Bank in slip is canceled';
        RunWorkflowOnCancelBankInSlipForApprovalCode: label 'RUNWORKFLOWONCANCEBANKINSLIPFORAPPROVAL';

        /// Gonogo decision GONOGO

        OnSendGonogoApprovalRequestTxt: label 'Approval of Go no go decision is requested';
        RunWorkflowOnSendGonogoForApprovalCode: label 'RUNWORKFLOWONSENGONOGOFORAPPROVAL';
        OnCancelGonogoRequestTxt: label 'An Approval of  Go no go decision is canceled';
        RunWorkflowOnCancelGonogoForApprovalCode: label 'RUNWORKFLOWONCANCELGONOGOFORAPPROVAL';

        //  Proposal development  PROPOSALDEVELOPMENT
        OnSendProposaldevelopmentApprovalRequestTxt: label 'Approval of Proposal development is requested';
        RunWorkflowOnSendProposaldevelopmentForApprovalCode: label 'RUNWORKFLOWONSENPROPOSALDEVELOPMENTFORAPPROVAL';
        OnCancelProposaldevelopmentRequestTxt: label 'An Approval of  Proposal development is canceled';
        RunWorkflowOnCancelProposaldevelopmentForApprovalCode: label 'RUNWORKFLOWONCANCELPROPOSALDEVELOPMENTFORAPPROVAL';

        //RFQ Approvals;
        OnSendRFQHeaderApprovalRequestTxt: label 'Approval of a RFQHeader is requested';
        RunWorkflowOnSendRFQHeaderForApprovalCode: label 'RUNWORKFLOWONSENDRFQHeaderFORAPPROVAL';
        OnCancelRFQHeaderApprovalRequestTxt: label 'An Approval of a RFQHeader is canceled';
        RunWorkflowOnCancelRFQHeaderForApprovalCode: label 'RUNWORKFLOWONCANCELRFQHeaderFORAPPROVAL';

        //Payroll Approvals K;
        OnSendPayrollApprovalRequestTxt: label 'Approval of a Payroll is requested';
        RunWorkflowOnSendPayrollForApprovalCode: label 'RUNWORKFLOWONSENDPayrollFORAPPROVAL';
        OnCancelPayrollApprovalRequestTxt: label 'An Approval of a Payroll is canceled';
        RunWorkflowOnCancelPayrollForApprovalCode: label 'RUNWORKFLOWONCANCELPayrollFORAPPROVAL';

        //Payroll Approvals M;
        OnSendPayrollMApprovalRequestTxt: label 'Approval of a Payroll M is requested';
        RunWorkflowOnSendPayrollMForApprovalCode: label 'RUNWORKFLOWONSENDPayrollMFORAPPROVAL';
        OnCancelPayrollMApprovalRequestTxt: label 'An Approval of a Payroll M is canceled';
        RunWorkflowOnCancelPayrollMForApprovalCode: label 'RUNWORKFLOWONCANCELPayrollMFORAPPROVAL';


        //timesheet Approvals
        //Receipts": ;
        OnSendTimesheetHeaderApprovalRequestTxt: label 'Approval of a TimesheetHeader is requested';
        RunWorkflowOnSendTimesheetHeaderForApprovalCode: label 'RUNWORKFLOWONSENDTimesheetHeaderFORAPPROVAL';
        OnCancelTimesheetHeaderApprovalRequestTxt: label 'An Approval of a TimesheetHeader is canceled';
        RunWorkflowOnCancelTimesheetHeaderForApprovalCode: label 'RUNWORKFLOWONCANCELTimesheetHeaderFORAPPROVAL';

        //approval For timesheet Lines request
        OnSendTimesheetLinesApprovalRequestTxt: label 'Approval of a TimesheetLines is requested';
        RunWorkflowOnSendTimesheetLinesForApprovalCode: label 'RUNWORKFLOWONSENDTimesheetLinesFORAPPROVAL';
        OnCancelTimesheetLinesApprovalRequestTxt: label 'An Approval of a TimesheetLines is canceled';
        RunWorkflowOnCancelTimesheetLinesForApprovalCode: label 'RUNWORKFLOWONCANCELTimesheetLinesFORAPPROVAL';

    procedure CheckApprovalsWorkflowEnabled(var Variant: Variant): Boolean
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of

            //HR

            Database::"Vehicle Requisition":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendVehicleRequisitionForApprovalCode));

            //Leave Application
            Database::"HR Leave Application":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendLeaveForApprovalCode));

            //Bank Reconciliation
            Database::"Bank Acc. Reconciliation":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendBankRecForApprovalCode));

            //Purchase Invoice
            Database::"Purchase Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendPurchaseInvForApprovalCode));

            //Training Application
            Database::"Training Requests":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTrainAppForApprovalCode));
            Database::"HR Jobss":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendHRJobsForApprovalCode));
            Database::"HR Employee Requisitions":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendEmpReqForApprovalCode));

            Database::GonoGoDecision:
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendGonogoForApprovalCode));

            Database::"Personal development Tracker":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendProposaldevelopmentForApprovalCode));
            Database::"Time Sheet Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnsendTimesheetHeaderForApprovalCode));
            Database::"TimeSheet Lines":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTimesheetLinesForApprovalCode));
            Database::"Purchase Quote Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnsendRFQHeaderForApprovalCode));
            Database::Payroll:
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnsendPayrollForApprovalCode));
            Database::"Payroll M":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnsendPayrollMForApprovalCode));
            Database::"Exit Interviews":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnsendEXITForApprovalCode));
            Database::Clearance:
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnsendCLEARANCEForApprovalCode));


            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;


    procedure CheckApprovalsWorkflowEnabledCode(var Variant: Variant; CheckApprovalsWorkflowTxt: Text): Boolean
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        begin
            if not WorkflowManagement.CanExecuteWorkflow(Variant, CheckApprovalsWorkflowTxt) then
                Error(NoWorkflowEnabledErr);
            exit(true);
        end;
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendDocForApproval(var Variant: Variant)
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelDocApprovalRequest(var Variant: Variant)
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnRejectDocApprovalRequest(var Variant: Variant)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddWorkflowEventsToLibrary()
    var
        WorkFlowEventHandling: Codeunit "Workflow Event Handling";
    begin
        //HR


        //Timesheet LinesApplication
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendTimesheetLinesForApprovalCode, Database::"Timesheet Lines", OnSendTimesheetLinesApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
       RunWorkflowOnCancelTimesheetLinesForApprovalCode, Database::"Timesheet Lines", OnCancelTimesheetLinesApprovalRequestTxt, 0, false);
        //RFQ
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendRFQHeaderForApprovalCode, Database::"Purchase Quote Header", OnSendRFQHeaderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
       RunWorkflowOnCancelRFQHeaderForApprovalCode, Database::"Purchase Quote Header", OnCancelRFQHeaderApprovalRequestTxt, 0, false);

        //Payroll K
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendPayrollForApprovalCode, Database::Payroll, OnSendPayrollApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
       RunWorkflowOnCancelPayrollForApprovalCode, Database::Payroll, OnCancelPayrollApprovalRequestTxt, 0, false);

        //Payroll M
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendPayrollMForApprovalCode, Database::"Payroll M", OnSendPayrollMApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
       RunWorkflowOnCancelPayrollMForApprovalCode, Database::"Payroll M", OnCancelPayrollMApprovalRequestTxt, 0, false);

        //Exit
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendExitForApprovalCode, Database::"Exit Interviews", OnSendExitApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
       RunWorkflowOnCancelExitForApprovalCode, Database::"Exit Interviews", OnCancelExitApprovalRequestTxt, 0, false);

        //Clearance
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendClearanceForApprovalCode, Database::"Purchase Quote Header", OnSendCLEARANCEApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
       RunWorkflowOnCancelClearanceForApprovalCode, Database::"Purchase Quote Header", OnCancelCLEARANCEApprovalRequestTxt, 0, false);


        //Leave Application
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendLeaveForApprovalCode, Database::"HR Leave Application", OnSendLeaveApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelLeaveForApprovalCode, Database::"HR Leave Application", OnCancelLeaveApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
               RunWorkflowOnRejectLeaveForApprovalCode, Database::"HR Leave Application", OnRejectLeaveApprovalRequestTxt, 0, false);

        //Bank Reconciliation
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendBankRecForApprovalCode, Database::"Bank Acc. Reconciliation", OnSendBankRecApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelBankRecForApprovalCode, Database::"Bank Acc. Reconciliation", OnCancelBankRecApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
               RunWorkflowOnRejectBankRecForApprovalCode, Database::"Bank Acc. Reconciliation", OnRejectBankRecApprovalRequestTxt, 0, false);

        //Purchase Invoice
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendPurchaseInvForApprovalCode, Database::"Purchase Header", OnSendPurchaseInvApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelPurchaseInvForApprovalCode, Database::"Purchase Header", OnCancelPurchaseInvApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
               RunWorkflowOnRejectPurchaseInvForApprovalCode, Database::"Purchase Header", OnRejectPurchaseInvApprovalRequestTxt, 0, false);


        //Vehicle Requisition
        //Leave Application
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendVehicleRequisitionForApprovalCode, Database::"Vehicle Requisition", OnSendVehicleReqApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelVehicleForApprovalCode, Database::"Vehicle Requisition", OnCancelVehicleReqApprovalRequestTxt, 0, false);
        //timesheet header

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendTimesheetHeaderForApprovalCode, Database::"Time Sheet Header", OnSendTimesheetHeaderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelTimesheetHeaderForApprovalCode, Database::"Time Sheet Header", OnCancelTimesheetHeaderApprovalRequestTxt, 0, false);
        //Training Application
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendTrainAppForApprovalCode, Database::"Training Requests", OnSendTrainAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelTrainAppForApprovalCode, Database::"Training Requests", OnCancelTrainAppApprovalRequestTxt, 0, false);
        //hr Application
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendHRJobsForApprovalCode, Database::"HR Jobss", OnSendHRJobsApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelHRJobsForApprovalCode, Database::"HR Jobss", OnCancelHRJobsApprovalRequestTxt, 0, false);
        //hr Employeee requ
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendEmpReqForApprovalCode, Database::"HR Employee Requisitions", OnSendEmpReqApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelEmpReqForApprovalCode, Database::"HR Employee Requisitions", OnCancelEmpReqApprovalRequestTxt, 0, false);

        // go no go
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendGonogoForApprovalCode, Database::GonoGoDecision, OnSendGonogoApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelGonogoForApprovalCode, Database::GonoGoDecision, OnCancelGonogoRequestTxt, 0, false);


        // Propposal development
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendProposaldevelopmentForApprovalCode, Database::"Personal development Tracker", OnSendProposaldevelopmentApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelProposaldevelopmentForApprovalCode, Database::"Personal development Tracker", OnCancelProposaldevelopmentRequestTxt, 0, false);





    end;

    local procedure RunWorkflowOnSendApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Approvals Codeunit", 'OnSendDocForApproval', '', false, false)]

    procedure RunWorkflowOnSendApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of

            //Timesheet Lines
            Database::"Timesheet Lines":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTimesheetLinesForApprovalCode, Variant);
            //RFQ
            Database::"Purchase Quote Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendRFQHeaderForApprovalCode, Variant);
            //Payroll K
            Database::Payroll:
                WorkflowManagement.HandleEvent(RunWorkflowOnSendPayrollForApprovalCode, Variant);
            //Payroll M
            Database::"Payroll M":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendPayrollMForApprovalCode, Variant);
            //Exit
            Database::"Exit Interviews":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendExitForApprovalCode, Variant);
            //Clearance
            Database::Clearance:
                WorkflowManagement.HandleEvent(RunWorkflowOnSendClearanceForApprovalCode, Variant);
            //Vehicle Application
            Database::"Vehicle Requisition":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendVehicleRequisitionForApprovalCode, Variant);
            //Leave Application
            Database::"HR Leave Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaveForApprovalCode, Variant);
            //Bank Reconciliation
            Database::"Bank Acc. Reconciliation":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBankRecForApprovalCode, Variant);
            //Purchase Inv
            Database::"Purchase Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendPurchaseInvForApprovalCode, Variant);
            //Training Application
            Database::"Training Requests":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTrainAppForApprovalCode, Variant);
            Database::"HR Jobss":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendHRJobsForApprovalCode, Variant);
            Database::"HR Employee Requisitions":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendEmpReqForApprovalCode, Variant);
            //timesheet
            Database::"Time Sheet Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTimesheetHeaderForApprovalCode, Variant);
            Database::GonoGoDecision:
                WorkflowManagement.HandleEvent(RunWorkflowOnSendGonogoForApprovalCode, Variant);
            Database::"Personal development Tracker":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendProposaldevelopmentForApprovalCode, Variant);
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Approvals Codeunit", 'OnRejectDocApprovalRequest', '', false, false)]

    procedure RunWorkflowOnRejectApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
        gonogo: Record GonoGoDecision;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of

            Database::GonoGoDecision:
                begin
                    RecRef.SetTable(gonogo);
                    gonogo.Validate(Decision, gonogo.Decision::"No-go");
                    gonogo.Modify;
                    Variant := gonogo;


                end;

            //Leave Application
            Database::"HR Leave Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnRejectLeaveForApprovalCode, Variant);

            //Bank Reconciliation
            Database::"Bank Acc. Reconciliation":
                WorkflowManagement.HandleEvent(RunWorkflowOnRejectBankRecForApprovalCode, Variant);
            //Purchase Invoice
            Database::"Purchase Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnRejectPurchaseInvForApprovalCode, Variant);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Approvals Codeunit", 'OnCancelDocApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of


            //timesheetlines
            //Leave Application
            Database::"Timesheet Lines":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTimesheetLinesForApprovalCode, Variant);
            //HR
            //Leave Application
            Database::"Vehicle Requisition":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelVehicleForApprovalCode, Variant);


            //Leave Application
            Database::"HR Leave Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaveForApprovalCode, Variant);

            //Bank Reconciliation
            Database::"Bank Acc. Reconciliation":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBankRecForApprovalCode, Variant);
            //Purchase Invoice
            Database::"Purchase Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelPurchaseInvForApprovalCode, Variant);
            //Training Application
            Database::"Training Requests":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTrainAppForApprovalCode, Variant);
            //hr job Application
            Database::"HR Jobss":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelHRJobsForApprovalCode, Variant);
            //hr Employee req
            Database::"HR Employee Requisitions":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendEmpReqForApprovalCode, Variant);
            //Timesheet header
            Database::"Time Sheet Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTimesheetHeaderForApprovalCode, Variant);

            //RFQ header
            Database::"Purchase Quote Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelRFQHeaderForApprovalCode, Variant);

            //Payroll K
            Database::Payroll:
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelPayrollForApprovalCode, Variant);
            //Payroll M
            Database::"Payroll M":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelPayrollMForApprovalCode, Variant);
            //Exit
            Database::"Exit Interviews":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelExitForApprovalCode, Variant);
            //Clearance
            Database::Clearance:
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelClearanceForApprovalCode, Variant);

            Database::GonoGoDecision:
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelGonogoForApprovalCode, Variant);
            Database::"Personal development Tracker":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelProposaldevelopmentForApprovalCode, Variant);

            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;


    procedure ReOpen(var Variant: Variant)
    var
        RecRef: RecordRef;
        HRLeaveApplication: Record "HR Leave Application";
        BankRec: Record "Bank Acc. Reconciliation";
        PurchaseInv: Record "Purchase Header";
        ItemJournalBatch: Record "Item Journal Batch";
        itemjnlline: Record "Item Journal Line";
        TrainingRequests: Record "Training Requests";
        HrJob: Record "HR Jobss";
        HrEmpReq: Record "HR Employee Requisitions";
        VehicleReq: Record "Vehicle Requisition";
        gonogo: Record GonoGoDecision;
        proposal: Record "Personal development Tracker";
        TimesheetHeader: Record "Time Sheet Header";
        TimesheetLines: Record "Timesheet Lines";
        RFQHeader: Record "Purchase Quote Header";
        Payroll: Record Payroll;
        PayrollM: Record "Payroll M";
        exitInt: Record "Exit Interviews";
        Clearance: Record Clearance;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of


            Database::GonoGoDecision:
                begin
                    RecRef.SetTable(gonogo);
                    gonogo.Validate(Decision, gonogo.Decision::Open);
                    gonogo.Modify;
                    Variant := gonogo;


                end;

            Database::"Personal development Tracker":
                begin
                    RecRef.SetTable(proposal);
                    proposal.Validate(proposal.Status, proposal.Status::New);
                    proposal.Modify;
                    Variant := proposal;
                end;
            //Vehicle Requisition
            Database::"Vehicle Requisition":
                begin
                    RecRef.SetTable(VehicleReq);
                    VehicleReq.Validate(Status, VehicleReq.Status::Open);
                    VehicleReq.Modify;
                    Variant := VehicleReq;
                end;
            //Leave Application
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(HRLeaveApplication);
                    HRLeaveApplication.Status := HRLeaveApplication.Status::New;
                    HRLeaveApplication.Modify;
                    Variant := HRLeaveApplication;
                end;

            //Bank Reconciliation
            Database::"Bank Acc. Reconciliation":
                begin
                    RecRef.SetTable(BankRec);
                    BankRec.Status := BankRec.Status::New;
                    BankRec.Modify;
                    Variant := BankRec;
                end;

            //Purchase Invoice
            Database::"Purchase Header":
                begin
                    RecRef.SetTable(PurchaseInv);
                    PurchaseInv.Status := PurchaseInv.Status::Open;
                    PurchaseInv.Modify;
                    Variant := PurchaseInv;
                end;

            //RFQ
            Database::"Purchase Quote Header":
                begin
                    RecRef.SetTable(RFQHeader);
                    RFQHeader.Validate(RFQHeader."Approval Status", RFQHeader."Approval Status"::New);
                    RFQHeader.Modify;
                    Variant := RFQHeader;
                end;

            //Payroll K
            Database::Payroll:
                begin
                    RecRef.SetTable(Payroll);
                    Payroll.Validate(Payroll.Status, Payroll.Status::Open);
                    Payroll.Modify;
                    Variant := Payroll;
                end;

            //Payroll M
            Database::"Payroll M":
                begin
                    RecRef.SetTable(PayrollM);
                    PayrollM.Validate(PayrollM.Status, PayrollM.Status::Open);
                    PayrollM.Modify;
                    Variant := PayrollM;
                end;

            //Exit
            Database::"Exit Interviews":
                begin
                    RecRef.SetTable(exitInt);
                    exitInt.Validate(exitInt.Status, exitInt.Status::New);
                    exitInt.Modify;
                    Variant := exitInt;
                end;

            //clearance
            Database::Clearance:
                begin
                    RecRef.SetTable(Clearance);
                    Clearance.Validate(Clearance.Status, Clearance.Status::Open);
                    Clearance.Modify;
                    Variant := Clearance;
                end;


            //Timesheet
            Database::"Time Sheet Header":
                begin
                    RecRef.SetTable(TimesheetHeader);
                    TimesheetHeader.Validate(TimesheetHeader.Status, TimesheetHeader.Status::Open);
                    TimesheetHeader.Modify;
                    Variant := TimesheetHeader;
                end;

            //timesheet Lines
            Database::"Timesheet Lines":
                begin
                    RecRef.SetTable(TimesheetLines);
                    TimesheetLines.Validate(TimesheetLines."Timesheet Status", TimesheetLines."Timesheet Status"::Open);
                    TimesheetLines.Modify;
                    Variant := TimesheetLines;
                end;
            //Training Application
            Database::"Training Requests":
                begin
                    RecRef.SetTable(TrainingRequests);
                    TrainingRequests.Validate(Status, TrainingRequests.Status::New);
                    TrainingRequests.Modify;
                    Variant := TrainingRequests;
                end;
            //hr Application
            Database::"HR Jobss":
                begin
                    RecRef.SetTable(HrJob);
                    HrJob.Validate(Status, HrJob.Status::New);
                    HrJob.Modify;
                    Variant := HrJob;
                end;
            //HR EMP Rq
            Database::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(HrEmpReq);
                    HrEmpReq.Validate(Status, HrEmpReq.Status::New);
                    HrEmpReq.Modify;
                    Variant := HrEmpReq;

                end;

            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]

    procedure Release(RecRef: RecordRef; var Handled: Boolean)
    var
        // RecRef: RecordRef;
        HRLeaveApplication: Record "HR Leave Application";
        BankRec: Record "Bank Acc. Reconciliation";
        PurchaseInv: Record "Purchase Header";
        ItemJournalBatch: Record "Item Journal Batch";
        usersetup: Record "User Setup";
        genjnline: Record "Gen. Journal Line";
        itemjournalline: Record "Item Journal Line";
        TrainingRequests: Record "Training Requests";
        HrJobs: Record "HR Jobss";
        HrEmpReq: Record "HR Employee Requisitions";
        VehicleReq: Record "Vehicle Requisition";
        gonogo: Record GonoGoDecision;
        proposal: record "Personal development Tracker";
        TimesheetHeader: Record "Time Sheet Header";
        TimesheetLines: Record "Timesheet Lines";
        RFQHeader: Record "Purchase Quote Header";
        Payroll: Record Payroll;
        PayrollM: Record "Payroll M";
        ExitInt: Record "Exit Interviews";
        Clearance: Record Clearance;

    begin
        //RecRef..set;
        case RecRef.Number of

            Database::GonoGoDecision:
                begin
                    RecRef.SetTable(gonogo);
                    gonogo.Validate(Decision, gonogo.Decision::Go);
                    gonogo.Modify;
                    Handled := true;
                    // Variant := gonogo;
                end;

            //RFQ
            Database::"Purchase Quote Header":
                begin
                    RecRef.SetTable(RFQHeader);
                    RFQHeader.Validate(RFQHeader."Approval Status", RFQHeader."Approval Status"::Approved);
                    RFQHeader.Modify;
                    Handled := true;
                end;

            //Payroll K
            Database::Payroll:
                begin
                    RecRef.SetTable(Payroll);
                    Payroll.Validate(Payroll.Status, Payroll.Status::Approved);
                    Payroll.Modify;
                    Handled := true;
                end;

            //Payroll M
            Database::"Payroll M":
                begin
                    RecRef.SetTable(PayrollM);
                    PayrollM.Validate(PayrollM.Status, PayrollM.Status::Approved);
                    PayrollM.Modify;
                    Handled := true;
                end;

            //Exit
            Database::"Exit Interviews":
                begin
                    RecRef.SetTable(ExitInt);
                    ExitInt.Validate(ExitInt.Status, ExitInt.Status::Approved);
                    ExitInt.Modify;
                    Handled := true;
                end;

            //Clearance
            Database::Clearance:
                begin
                    RecRef.SetTable(Clearance);
                    Clearance.Validate(Clearance.Status, Clearance.Status::Approved);
                    Clearance.Modify;
                    Handled := true;
                end;
            //Timesheet
            Database::"Time Sheet Header":
                begin
                    RecRef.SetTable(TimesheetHeader);
                    TimesheetHeader.Validate(TimesheetHeader.Status, TimesheetHeader.Status::Approved);
                    TimesheetHeader.Modify;
                    Handled := true;
                end;

            //timesheet lines
            Database::"Timesheet Lines":
                begin
                    RecRef.SetTable(TimesheetLines);
                    TimesheetLines.Validate(TimesheetLines."Timesheet Status", TimesheetLines."Timesheet Status"::Approved);
                    TimesheetLines.Modify;
                    Handled := true;
                end;

            Database::"Personal development Tracker":
                begin
                    RecRef.SetTable(proposal);
                    proposal.Validate(proposal.Status, proposal.Status::Approved);
                    proposal.Modify;
                    Handled := true;
                    //Variant := proposal;
                end;

            //Leave Application
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(HRLeaveApplication);
                    HRLeaveApplication.Status := HRLeaveApplication.Status::Approved;
                    HRLeaveApplication.Modify;
                    Handled := true;
                    HRLeaveApplication.CreateLeaveLedgerEntries;

                    // Variant := HRLeaveApplication;
                end;

            //Bank Reconciliation
            Database::"Bank Acc. Reconciliation":
                begin
                    RecRef.SetTable(BankRec);
                    BankRec.Status := BankRec.Status::Approved;
                    BankRec.Modify;
                    Handled := true;

                end;

            //Purchase Invoice
            Database::"Purchase Header":
                begin
                    RecRef.SetTable(PurchaseInv);
                    PurchaseInv.Status := PurchaseInv.Status::Released;
                    PurchaseInv.Modify;
                    Handled := true;

                end;

            //Training Application
            Database::"Training Requests":
                begin
                    RecRef.SetTable(TrainingRequests);
                    TrainingRequests.Validate(Status, TrainingRequests.Status::Approved);
                    TrainingRequests.Modify;
                    Handled := true;

                end;

            //Vehicle Req
            Database::"Vehicle Requisition":
                begin
                    RecRef.SetTable(VehicleReq);
                    VehicleReq.Validate(Status, VehicleReq.Status::Approved);
                    VehicleReq.Modify;
                    Handled := true;

                end;

            //HR Job Application
            Database::"HR Jobss":
                begin
                    RecRef.SetTable(HrJobs);
                    HrJobs.Validate(Status, HrJobs.Status::Approved);
                    HrJobs.Modify;
                    Handled := true;

                end;
            //HR EMP Rq
            Database::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(HrEmpReq);
                    HrEmpReq.Validate(Status, HrEmpReq.Status::Approved);
                    HrEmpReq.Modify;
                    Handled := true;

                end;


            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    procedure SetStatusToPending(RecRef: RecordRef; Variant: Variant; var IsHandled: Boolean)
    var
        //RecRef: RecordRef;
        HRLeaveApplication: Record "HR Leave Application";
        BankRec: Record "Bank Acc. Reconciliation";
        PurchaseInv: Record "Purchase Header";
        ItemJournalBatch: Record "Item Journal Batch";
        usersetup: Record "User Setup";
        genjnline: Record "Gen. Journal Line";
        itemjournalline: Record "Item Journal Line";
        TrainingRequests: Record "Training Requests";
        HrJobs: Record "HR Jobss";
        HrEmpReq: Record "HR Employee Requisitions";
        VehicleReq: Record "Vehicle Requisition";
        gonogo: Record GonoGoDecision;
        proposal: Record "Personal development Tracker";
        TimeSheetHeader: Record "Time Sheet Header";
        TimesheetLines: Record "Timesheet Lines";
        RFQHeader: Record "Purchase Quote Header";
        Payroll: Record Payroll;
        PayrollM: Record "Payroll M";
        ExitInt: Record "Exit Interviews";
        Clearance: Record Clearance;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of


            //Leave Application
            Database::"HR Leave Application":
                begin

                    RecRef.SetTable(HRLeaveApplication);
                    HRLeaveApplication.Status := HRLeaveApplication.Status::"Pending Approval";
                    HRLeaveApplication.Modify(true);
                    Commit();
                    IsHandled := true;
                    Commit();
                    // 

                end;

            //Bank Reconciliation
            Database::"Bank Acc. Reconciliation":
                begin

                    RecRef.SetTable(BankRec);
                    BankRec.Status := BankRec.Status::"Pending Approval";
                    BankRec.Modify(true);
                    Commit();
                    IsHandled := true;
                    Commit();
                    // 

                end;

            //Purchase Invoice
            Database::"Purchase Header":
                begin

                    RecRef.SetTable(PurchaseInv);
                    PurchaseInv.Status := PurchaseInv.Status::"Pending Approval";
                    PurchaseInv.Modify(true);
                    Commit();
                    IsHandled := true;
                    Commit();
                    // 

                end;




            //Training Application
            Database::"Training Requests":
                begin
                    RecRef.SetTable(TrainingRequests);
                    TrainingRequests.Validate(Status, TrainingRequests.Status::"Pending Approval");
                    TrainingRequests.Modify;
                    IsHandled := true;
                end;
            //timesheet Lines
            //Training Application
            Database::"Timesheet Lines":
                begin
                    RecRef.SetTable(TimesheetLines);
                    TimesheetLines.Validate(TimesheetLines."Timesheet Status", TimesheetLines."Timesheet Status"::"Send Awaiting Approval");
                    TimesheetLines.Modify;
                    IsHandled := true;
                end;
            //Timesheet
            Database::"Time Sheet Header":
                begin
                    RecRef.SetTable(TimesheetHeader);
                    TimesheetHeader.Validate(TimesheetHeader.Status, TimesheetHeader.Status::"Submitted Awaiting Approval");
                    TimesheetHeader.Modify;
                    IsHandled := true;
                end;

            //RFQ
            Database::"Purchase Quote Header":
                begin
                    RecRef.SetTable(RFQHeader);
                    RFQHeader.Validate(RFQHeader."Approval Status", RFQHeader."Approval Status"::"Pending Approval");
                    RFQHeader.Modify;
                    Commit();
                    IsHandled := true;
                    Commit();
                end;


            //Payroll K
            Database::Payroll:
                begin
                    RecRef.SetTable(Payroll);
                    Payroll.Validate(Payroll.Status, Payroll.Status::"Pending Approval");
                    Payroll.Modify;
                    IsHandled := true;
                end;

            //Payroll M
            Database::"Payroll M":
                begin
                    RecRef.SetTable(PayrollM);
                    PayrollM.Validate(PayrollM.Status, PayrollM.Status::"Pending Approval");
                    PayrollM.Modify;
                    IsHandled := true;
                end;


            //Exit
            Database::"Exit Interviews":
                begin
                    RecRef.SetTable(ExitInt);
                    ExitInt.Validate(ExitInt.Status, ExitInt.Status::"Pending Approval");
                    ExitInt.Modify;
                    IsHandled := true;
                end;


            //clearance
            Database::Clearance:
                begin
                    RecRef.SetTable(Clearance);
                    Clearance.Validate(Clearance.Status, Clearance.Status::"Pending Approval");
                    Clearance.Modify;
                    IsHandled := true;
                end;


            //Vehicle Requsition
            Database::"Vehicle Requisition":
                begin
                    RecRef.SetTable(VehicleReq);
                    VehicleReq.Validate(Status, VehicleReq.Status::Pending);
                    VehicleReq.Modify;
                    IsHandled := true;
                end;
            //HR Job Application
            Database::"HR Jobss":
                begin
                    RecRef.SetTable(HrJobs);
                    HrJobs.Validate(Status, HrJobs.Status::"Pending Approval");
                    HrJobs.Modify;
                    IsHandled := true;

                end;

            //HR EMP Rq
            Database::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(HrEmpReq);
                    HrEmpReq.Validate(Status, HrEmpReq.Status::"Pending Approval");
                    HrEmpReq.Modify;
                    IsHandled := true;

                end;

            Database::GonoGoDecision:
                begin
                    RecRef.SetTable(gonogo);
                    gonogo.Validate(Decision, gonogo.Decision::"Pending approval");
                    gonogo.Modify;
                    IsHandled := true;


                end;

            Database::"Personal development Tracker":
                begin
                    RecRef.SetTable(proposal);
                    proposal.Validate(proposal.Status, proposal.Status::"Pending approval");
                    proposal.Modify;
                    Variant := proposal;
                    IsHandled := true;
                end;
            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end
    end;


    procedure UpdateRct(ApprovalEntry: Record "Approval Entry")
    begin

        if ApprovalEntry.Status = ApprovalEntry.Status::Open then begin
            ApprovalEntry.Status := ApprovalEntry.Status::Approved;
            ApprovalEntry.Modify(true);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure fnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        //RecRef: RecordRef;
        HRLeaveApplication: Record "HR Leave Application";
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterPostItemJnlLine', '', false, false)]

    procedure fnUpdateItemJournal(var ItemJournalLine: Record "Item Journal Line")
    var
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        /*ItemJournalBatch.RESET;
        ItemJournalBatch.SETRANGE("Journal Template Name",ItemJournalLine."Journal Template Name");
        ItemJournalBatch.SETRANGE(Name,ItemJournalLine."Journal Batch Name");
        IF ItemJournalBatch.FINDFIRST THEN
        BEGIN
          ItemJournalBatch.Status := ItemJournalBatch.Status::Open;
          ItemJournalBatch.MODIFY;
        END*/

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]

    procedure PopulateSurestepEntries(RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance"; var ApprovalEntryArgument: Record "Approval Entry")
    var
        Hrleave: Record "HR Leave Application";
        BankRec: Record "Bank Acc. Reconciliation";
        PurchaseInv: Record "Purchase Header";
        HrJobs: Record "HR Jobss";
        HrEmpReq: Record "HR Employee Requisitions";
        VehicleReq: Record "Vehicle Requisition";
        TimesheetLines: Record "Timesheet Lines";
        GoNoGo: Record GonoGoDecision;
        Proposal: Record "Personal development Tracker";
        RFQ: Record "Purchase Quote Header";
        Clearance: Record Clearance;
        exitI: Record "Exit Interviews";
        LPO: Record "Purchase Header";
        RecordCaption: Text;
        payroll: Record Payroll;
        PayrollM: Record "Payroll M";
    begin

        case RecRef.Number of
            DATABASE::"HR Leave Application":
                begin
                    RecRef.SetTable(Hrleave);

                    ApprovalEntryArgument."Document No." := Hrleave."Application Code";

                end;
            Database::Payroll:
                begin
                    RecRef.SetTable(payroll);
                    ApprovalEntryArgument."Document No." := payroll."Document No";
                end;
            Database::"Payroll M":
                begin
                    RecRef.SetTable(PayrollM);
                    ApprovalEntryArgument."Document No." := PayrollM."Document No";
                end;
            DATABASE::"Bank Acc. Reconciliation":
                begin
                    RecRef.SetTable(BankRec);

                    ApprovalEntryArgument."Document No." := BankRec."Bank Account No.";
                    ApprovalEntryArgument.Amount := BankRec."Statement Ending Balance";
                    ApprovalEntryArgument."Amount (LCY)" := BankRec."Statement Ending Balance";
                    // ApprovalEntryArgument."Currency Code" := RFQ."Currency Code";
                    ApprovalEntryArgument."Document Type" := BankRec."Statement Type";

                end;
            DATABASE::"Purchase Header":
                begin
                    RecRef.SetTable(PurchaseInv);

                    ApprovalEntryArgument."Document No." := PurchaseInv."No.";
                    ApprovalEntryArgument.Amount := PurchaseInv.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := PurchaseInv."Net Amount";
                    ApprovalEntryArgument."Currency Code" := PurchaseInv."Currency Code";
                    ApprovalEntryArgument."Document Type" := PurchaseInv."AU Form Type";

                end;
            Database::"Purchase Header":
                begin
                    RecRef.SetTable(LPO);

                    // Store the RecordCaption() result in a local variable

                    RecordCaption := ApprovalEntryArgument.RecordCaption();

                    // Check if RecordCaption is empty
                    if RecordCaption = '' then
                        RecordCaption := Format(LPO."No.");

                    //ApprovalEntryArgument.Description := CustomCaption;
                end;
            DATABASE::GonoGoDecision:
                begin
                    RecRef.SetTable(GoNoGo);

                    ApprovalEntryArgument."Document No." := GoNoGo.Code;
                    ApprovalEntryArgument.Status := ApprovalEntryArgument.Status::Open;

                end;

            DATABASE::"Personal development Tracker":
                begin
                    RecRef.SetTable(Proposal);

                    ApprovalEntryArgument."Document No." := Proposal.Code;
                    ApprovalEntryArgument.Amount := Proposal."Value (US$)";
                    ApprovalEntryArgument.Status := ApprovalEntryArgument.Status::Open;

                end;
            DATABASE::"Purchase Quote Header":
                begin
                    RecRef.SetTable(RFQ);

                    ApprovalEntryArgument."Document No." := RFQ."No.";
                    ApprovalEntryArgument.Amount := RFQ.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := RFQ.Amount;
                    ApprovalEntryArgument."Currency Code" := RFQ."Currency Code";
                    ApprovalEntryArgument."Document Type" := RFQ."Document Type";

                end;
            DATABASE::Clearance:
                begin
                    RecRef.SetTable(Clearance);

                    ApprovalEntryArgument."Document No." := Clearance."Application Code";

                end;
            DATABASE::"Exit Interviews":
                begin
                    RecRef.SetTable(exitI);

                    ApprovalEntryArgument."Document No." := exitI."Application Code";

                end;
            DATABASE::"HR Jobss":
                begin
                    RecRef.SetTable(HrJobs);

                    ApprovalEntryArgument."Document No." := HrJobs."Job ID";

                end;
            DATABASE::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(HrEmpReq);

                    ApprovalEntryArgument."Document No." := HrEmpReq."Requisition No.";

                end;

            DATABASE::"Vehicle Requisition":
                begin
                    RecRef.SetTable(VehicleReq);

                    ApprovalEntryArgument."Document No." := VehicleReq."Task Order No";

                end;
            DATABASE::"Timesheet Lines":
                begin
                    RecRef.SetTable(TimesheetLines);

                    ApprovalEntryArgument."Document No." := TimesheetLines.Project;

                end;
        end;
    end;
}

