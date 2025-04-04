Page 17320 "Timesheet Card"
{
    SourceTable = TimesheetLines;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            field(Timesheetcode; Rec.Timesheetcode)
            {
                ApplicationArea = Basic;
            }
            field(From; Rec.From)
            {
                ApplicationArea = Basic;
                trigger OnValidate()
                var
                    Page: page "Timesheet ListPart";
                    i: Integer;
                    NoOfDays: Integer;
                begin
                    NoOfDays := 0;
                    Rec."To Date" := CalcDate('1M-1D', Rec.From);
                    NoOfDays := Rec."To Date" - Rec.From;
                    Page.GenerateDaysOfMonth(Rec.from, Rec.Timesheetcode, NoOfDays + 1);

                end;
            }
            field("To Date"; Rec."To Date")
            {
                ApplicationArea = Basic;
                Editable = false;
                trigger onvalidate()
                var
                    Page: page "Timesheet ListPart";
                begin
                    PeriodTypeOnAfterValidate();
                end;
            }
            field("Employee No"; Rec."Employee No")
            {
                ApplicationArea = Basic;
            }
            field("Employee Name"; Rec."Employee Name")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Supervisor ID"; Rec."Supervisor ID")
            {
                ApplicationArea = Basic;
                Enabled = false;
            }
            part("Timesheet Lines"; "Timesheet ListPart")
            {
                SubPageLink = "Document No." = field(Timesheetcode);
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::Timesheet;

                    ApprovalEntries.SetRecordFilters(Database::TimesheetLines, DocumentType, Rec.Timesheetcode);
                    ApprovalEntries.Run;


                end;
            }

            action("Send A&pproval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Text001: label 'This Batch is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField(Status, Rec.Status::Open);

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
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    //IF ApprovalMgt.CancelBatchAppr(Rec,TRUE,TRUE) THEN;
                    //varrvariant:=Rec;
                    //CustomApprovalsCodeunit.OnCancelDocApprovalRequest(varrvariant);
                    ApprovalEntry.Reset;
                    ApprovalEntry.SetRange("Document No.", Rec.Timesheetcode);
                    if ApprovalEntry.FindSet then begin
                        repeat
                            ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                            ApprovalEntry.Modify;
                        until ApprovalEntry.Next = 0;
                    end;
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                end;
            }
        }
        area(reporting)
        {
            action("TimeSheet Summary")
            {
                ApplicationArea = Basic;
                PromotedCategory = Report;
                Promoted = true;

                trigger OnAction()
                begin
                    TimesheetLines.Reset;
                    TimesheetLines.SetRange(TimesheetLines.Timesheetcode, Rec.Timesheetcode);
                    TimesheetLines.SetRange("Employee No", Rec."Employee No");
                    if TimesheetLines.Find('-') then begin
                        Report.Run(50045, true, false, TimesheetLines);
                    end;
                end;
            }
            action("TimeSheet Report")
            {
                ApplicationArea = Basic;
                PromotedCategory = Report;
                Promoted = true;

                trigger OnAction()
                begin
                    TETimeSheet1.Reset;
                    TETimeSheet1.SetRange("Document No.", Rec.Timesheetcode);
                    TETimeSheet1.SetRange("Employee No", Rec."Employee No");
                    if TETimeSheet1.Find('-') then begin
                        Report.Run(50044, true, false, TETimeSheet1);
                    end;
                end;
            }
        }
    }

    protected procedure UpdateMatrixSubform()
    begin
        CurrPage."Timesheet Lines".PAGE.ValidateQuantity2(MATRIX_CaptionSet, MATRIX_MatrixRecords, MATRIX_CurrentNoOfColumns);

        CurrPage.Update();
    end;

    procedure PeriodTypeOnAfterValidate()
    begin
        UpdateMatrixSubform();

    end;

    var
        MATRIX_CaptionSet: array[32] of Text[80];
        ApprovalEntry: Record "Approval Entry";
        CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
        varrvariant: Variant;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Leave,Training,Payroll,BankRec,Timesheet;
        TimesheetLines: Record TimesheetLines;
        TETimeSheet1: Record "TE Time Sheet1";
        ColumnDimType: Enum "G/L Budget Matrix Dimensions";
        MATRIX_MatrixRecords: array[32] of Record "Dimension Code Buffer";

        MATRIX_CaptionRange: Text;
        FirstColumn: Text;
        LastColumn: Text;
        MATRIX_PrimKeyFirstCaptionInCu: Text;
        MATRIX_CurrentNoOfColumns: Integer;
}

