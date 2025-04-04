page 17445 "Timesheet header2"
{
    ApplicationArea = All;
    Caption = 'Timesheet header ';
    PageType = List;
    SourceTable = "Timesheet Header";
    SourceTableView = where("Timesheet Status" = filter(Open));
    CardPageId = "Timesheet Header Card";
    UsageCategory = Lists;
    Editable = true;
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update Approver ID")
            {
                Promoted = true;
                PromotedCategory = Process;
                Image = UpdateDescription;
                trigger OnAction()
                var
                    Timesheet: Record "Timesheet Header";
                begin
                    Timesheet.Reset;
                    // Timesheet.SetRange(Timesheet."Timesheet Header No", Rec."Timesheet Header No");
                    if Timesheet.FindSet() then begin
                        repeat
                            if (Timesheet."Timesheet Status" = Timesheet."Timesheet Status"::Open) or
                               (Timesheet."Timesheet Status" = Timesheet."Timesheet Status"::"Project Manager Approved") then begin
                                if Timesheet."Line Manager" <> '' then
                                    Timesheet."Approver ID" := Timesheet."Line Manager";
                                Timesheet.Validate("Approver ID");
                                Timesheet.Modify(true); // Save the changes
                            end;

                            if (Timesheet."Timesheet Status" = Timesheet."Timesheet Status"::"Line Manager Approved") or
                               (Timesheet."Timesheet Status" = Timesheet."Timesheet Status"::Approved) then begin
                                if Timesheet."SMT Lead" <> '' then
                                    Timesheet."Approver ID" := Timesheet."SMT Lead";
                                Timesheet.Validate("Approver ID");
                                Timesheet.Modify(true); // Save the changes
                            end;
                        until Timesheet.Next() = 0;
                    end;

                    Message('Approver IDs updated for all applicable records.');
                end;
            }
        }
    }
    // trigger OnOpenPage()
    // begin

    // end;
    // // end;


    var
        TimesheetHeader: Record "Timesheet Header";
        hremp: Record "HR Employees";
}
