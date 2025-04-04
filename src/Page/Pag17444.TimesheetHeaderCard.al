page 17444 "Timesheet Header Card"
{
    ApplicationArea = All;
    Caption = 'Timesheet Header Card';
    PageType = Card;
    SourceTable = "Timesheet Header";
    Editable = true;
    DeleteAllowed = false;
    ;
    InsertAllowed = true;
    ModifyAllowed = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = statuseditable;

                field("Timesheet Header No"; Rec."Timesheet Header No")
                {
                    ToolTip = 'Specifies the value of the Timesheet Header No field.';
                }
                field("Staff No"; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = basic, Suite;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Line Manager"; Rec."Line Manager")
                {
                    ApplicationArea = basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Line Manager field.';
                }
                field("SMT Lead"; Rec."SMT Lead")
                {
                    ApplicationArea = basic, Suite;
                    ToolTip = 'Specifies the value of the SMT Lead field.';
                }
                field("Human Resource manager"; Rec."Human Resource manager")
                {
                    ApplicationArea = basic, Suite;
                    ToolTip = 'Specifies the value of the Human Resource manager field.';
                }
                field("Timesheet Status"; Rec."Timesheet Status")
                {
                    Editable = true;
                }
            }
            part(timesheet; "Timesheet Lines")
            {
                SubPageLink = "Timesheet No" = field("Timesheet Header No"), "Staff No" = field("Staff No"), "Staff Name" = field("Staff Name");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Timesheet Report")
            {
                Promoted = true;
                PromotedCategory = Process;
                Image = Report;
                trigger OnAction()
                begin
                    TimesheetHeader.Reset();
                    TimesheetHeader.SetRange("Timesheet Header No", Rec."Timesheet Header No");
                    if TimesheetHeader.FindFirst() then begin
                        Report.Run(50060, true, false, TimesheetHeader);
                    end;

                end;
            }
            action("Send For Approval")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                trigger OnAction()
                var
                    varrvariant: Variant;
                    CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
                    TimesheetLines: Record "Timesheet Lines";
                begin
                    Rec.TestField(Rec."Timesheet Status", Rec."Timesheet Status"::Open);
                    TimesheetLines.Reset();
                    TimesheetLines.SetRange("Timesheet No", Rec."Timesheet Header No");
                    if TimesheetLines.Find('-') then begin
                        //  varrvariant := TimesheetLines;
                        repeat
                            TimesheetLines."Timesheet Status" := TimesheetLines."Timesheet Status"::"Send Awaiting Approval";
                            TimesheetLines.Modify(true);
                        until TimesheetLines.Next() = 0;
                    end;



                    // if CustomApprovalsCodeunit.CheckApprovalsWorkflowEnabled(varrvariant) then
                    //     CustomApprovalsCodeunit.OnSendDocForApproval(varrvariant);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                trigger OnAction()
                var
                    varrvariant: Variant;
                    CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
                    TimesheetLines: Record "Timesheet Lines";
                begin
                    //IF NOT Rec.TestField(Rec."Timesheet Status", Rec."Timesheet Status"::Open) THEN
                    IF Rec."Timesheet Status" <> Rec."Timesheet Status"::Open THEN
                        TimesheetLines.Reset();
                    TimesheetLines.SetRange("Timesheet No", Rec."Timesheet Header No");
                    if TimesheetLines.Find('-') then begin
                        //  varrvariant := TimesheetLines;
                        repeat
                            TimesheetLines."Timesheet Status" := TimesheetLines."Timesheet Status"::Open;
                            TimesheetLines.Modify(true);
                        until TimesheetLines.Next() = 0;
                        Rec."Timesheet Status" := rec."Timesheet Status"::Open;
                        Rec.Modify(true);
                    end;



                    // if CustomApprovalsCodeunit.CheckApprovalsWorkflowEnabled(varrvariant) then
                    //     CustomApprovalsCodeunit.OnSendDocForApproval(varrvariant);
                end;
            }
            action("Approval Entries")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Image = Approvals;
                Visible = false;
                trigger OnAction()
                var
                    ApprovalCodeunit: Codeunit "Approvals Mgmt.";
                    RecI: RecordId;
                    TimesheetLines: Record "Timesheet Lines";
                begin
                    TimesheetLines.Reset();
                    TimesheetLines.SetRange("Timesheet No", Rec."Timesheet Header No");
                    if TimesheetLines.Find('-') then begin
                        RecI := TimesheetLines.RecordId;
                    end;


                    ApprovalCodeunit.OpenApprovalEntriesPage(RecI);
                end;

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPageUpdate;
    end;


    var
        TimesheetHeader: Record "Timesheet Header";
        hremp: Record "HR Employees";
        StatusEditable: Boolean;


    procedure UpdateControls()
    begin
        if Rec."Timesheet Status" = Rec."Timesheet Status"::Open then
            StatusEditable := true
        else
            StatusEditable := false;
    end;


    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        CurrPage.Update;
    end;

}
