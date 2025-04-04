page 17294 "Vehicle Requisition List"
{
    ApplicationArea = All;
    Caption = 'Vehicle Requisition List';
    PageType = List;
    SourceTable = "Vehicle Requisition";
    UsageCategory = Lists;
    CardPageId = "Vehicle Requisition Card";
    SourceTableView = where(Status = filter(Open));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Task Order No"; Rec."Task Order No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Task Order No field.';
                }
                field("Date Requested"; Rec."Date Requested")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Requested field.';
                }
                field("Vehicle Required"; Rec."Vehicle Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Required field.';
                }
                field("Date required"; Rec."Date required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date requred  field.';
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dastination field.';
                }
            }
        }
    }
}
