page 17452 "Timesheet header Await"
{
    ApplicationArea = All;
    Caption = 'Timesheet header ';
    PageType = List;
    SourceTable = "Timesheet Header";
    SourceTableView = where("Timesheet Status" = filter("Send Awaiting Approval"));
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
}
