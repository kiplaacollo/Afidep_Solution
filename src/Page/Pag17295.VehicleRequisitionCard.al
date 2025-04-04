page 17295 "Vehicle Requisition Card"
{
    Caption = 'Vehicle Requisition Card';
    PageType = Card;
    SourceTable = "Vehicle Requisition";
    PromotedActionCategories = 'New,Process,Report,Approvals';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Task Order No"; Rec."Task Order No")
                {
                    ApplicationArea = All;
                    Enabled = FieldEdditable;
                    ToolTip = 'Specifies the value of the Task Order No field.';
                }
                field("Date Requested"; Rec."Date Requested")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Requested field.';
                    Enabled = FieldEdditable;
                }
                field("Officer Requesting"; Rec."Officer Requesting")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Officer Requesting  field.';
                    Enabled = FieldEdditable;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No field.';
                    Enabled = FieldEdditable;
                }
                field("Name of the officer"; Rec."Name of the officer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name of the officer field.';
                    Enabled = FieldEdditable;
                }
                field("Vehicle Required"; Rec."Vehicle Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Required field.';
                    Enabled = FieldEdditable;
                }
                field(Reasons; Rec.Reasons)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reasons field.';
                    Enabled = FieldEdditable;
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dastination field.';
                    Enabled = FieldEdditable;
                }
                field("No of Staff"; Rec."No of Staff")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No of Staff field.';
                    Enabled = FieldEdditable;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Enabled = FieldEdditable;
                }
                field("Date required"; Rec."Date required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date requred  field.';
                    Enabled = FieldEdditable;
                    Visible = false;
                }
                field("Date & Time Required"; Rec."Time Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time requred  field.';
                    Caption = 'Date & Time Required';
                    Enabled = FieldEdditable;
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    Caption = 'Duration in Days';
                    ToolTip = 'Specifies the value of the Duration field.';
                    Enabled = FieldEdditable;
                    Visible = false;
                }
                field("Hours Duration"; Rec."Hours Duration")
                {
                    ApplicationArea = All;
                    Caption = 'Duration in Hours';
                    ToolTip = 'Specifies the value of the Hours Duration field.';
                    Enabled = FieldEdditable;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    Enabled = FieldEdditable;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Date field.';
                    Enabled = FieldEdditable;
                    Visible = false;
                }
                field("Return Hour"; Rec."Return Hour")
                {
                    ApplicationArea = All;
                    Caption = 'Return Time';
                    ToolTip = 'Specifies the value of the Return Date field.';
                    Enabled = FieldEdditable;
                }
                field("Global Dimension 1"; Rec."Global Dimension 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 field.';
                    Enabled = FieldEdditable;
                }
                field("Global Dimension 2"; Rec."Global Dimension 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 field.';
                    Enabled = FieldEdditable;
                }
                field("Vehicle Allocated"; Rec."Vehicle Allocated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Allocated.';
                    Enabled = AllocateVehicle;
                }
            }

        }

    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Allocate Vehicle';

                trigger OnAction()
                begin

                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField(Destination);
                    Rec.TestField(Reasons);

                    IF Rec."Vehicle Allocated" = '' THEN
                        ERROR('Vehicle must be Specified before allocation by the Fleet Manager');


                    vehicles.RESET;
                    vehicles.SETRANGE(vehicles."Registration No", Rec."Vehicle Allocated");
                    IF vehicles.FIND('-') THEN BEGIN
                        vehicles."Allocation Status" := vehicles."Allocation Status"::"In-Use";
                        vehicles.MODIFY;
                    END;
                    Rec."Allocation Status" := Rec."Allocation Status"::"In-Use";
                    Rec.MODIFY;

                    MESSAGE('Vehicle Has been Allocated to the Requesting Officer');
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

                begin

                    Rec.TestField(Rec.Status, Rec.Status::Open);
                    Rec.TestField(Destination);
                    Rec.TestField(Reasons);
                    Rec.TestField(Duration);

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

                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = Basic;
                Caption = 'Re-Open';
                Image = ReopenCancelled;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                end;
            }

        }
    }


    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        AllocateVehicle := false;
        FieldEdditable := false;
        if Rec.Status = Rec.Status::Approved then begin
            AllocateVehicle := true
        end else begin
            AllocateVehicle := false;
        end;
        if Rec.Status = Rec.Status::Open then begin
            FieldEdditable := true
        end else begin
            FieldEdditable := false;
        end;
    end;

    trigger OnOpenPage()
    begin
        AllocateVehicle := false;
        FieldEdditable := false;
        if Rec.Status = Rec.Status::Approved then begin
            AllocateVehicle := true
        end else begin
            AllocateVehicle := false;
        end;
        if Rec.Status = Rec.Status::Open then begin
            FieldEdditable := true
        end else begin
            FieldEdditable := false;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        AllocateVehicle := false;
        FieldEdditable := false;
        if Rec.Status = Rec.Status::Approved then begin
            AllocateVehicle := true
        end else begin
            AllocateVehicle := false;
        end;
        if Rec.Status = Rec.Status::Open then begin
            FieldEdditable := true
        end else begin
            FieldEdditable := false;
        end;
    end;

    var
        vehicles: Record Vehicles;
        CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
        varrvariant: Variant;
        AllocateVehicle: Boolean;
        FieldEdditable: Boolean;
}
