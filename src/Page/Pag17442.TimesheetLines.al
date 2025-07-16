page 17446 "Timesheet Lines"
{
    ApplicationArea = All;
    Caption = 'Timesheet Lines';
    PageType = ListPart;
    SourceTable = "Timesheet Lines";
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
                Editable = statuseditable;
                field("Timesheet No"; Rec."Timesheet No")
                {
                    ToolTip = 'Specifies the value of the Timesheet No field.';
                }
                field(Date; Rec.Date) { }
                field("Staff No"; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
                field(Project; Rec.Project)
                {
                    ToolTip = 'Specifies the value of the Project field.';
                }
                field("Projecct decription"; Rec."Project decription")
                {
                    ToolTip = 'Specifies the value of the Projecct decription field.';
                }
                field(Workplan; Rec."Workplan ")
                {
                    ToolTip = 'Specifies the value of the Workplan field.';
                }
                field("Workplan Description"; Rec."Workplan Description")
                {
                    ToolTip = 'Specifies the value of the Workplan description field.';
                }
                field(Activity; Rec.Activity)
                {
                    ToolTip = 'Specifies the value of the Activity field.';
                }
                field("Activity Discription"; Rec."Activity Discription")
                {
                    ToolTip = 'Specifies the value of the Activity Discription field.';
                }
                field(Narration; Rec.Narration)
                {
                    ToolTip = 'Specifies the value of the Narration field.';
                }
                field(Hours; Rec.Hours)
                {
                    ToolTip = 'Specifies the value of the Hours field.';
                }
                field("Total Hours"; Rec."Total Hours")
                {
                    ToolTip = 'Specifies the value of the Total Hours field.';
                }
                field("Total Days"; Rec."Total Days")
                {
                    ToolTip = 'Specifies the value of the Total Days field.';
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ToolTip = 'Provide the userId of the Approver';
                    Editable = true;
                }
                field("Timesheet Status"; Rec."Timesheet Status")
                {
                    ToolTip = 'Specifies the value of the Total Days field.';
                    Editable = true;
                }
                field("Approval Email Sent"; Rec."Approval Email Sent")
                {

                }
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
            StatusEditable := true;
    end;


    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        CurrPage.Update;
    end;
}
