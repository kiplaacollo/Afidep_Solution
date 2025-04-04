page 50097 Milestones1
{
    ApplicationArea = All;
    Caption = 'Milestones';
    PageType = ListPart;
    SourceTable = "Milestones ";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Milestone description"; Rec."Milestone description")
                {
                    ToolTip = 'Specifies the value of the Milestone description field.';
                }

                field(Deadline; Rec.Deadline)
                {
                    ToolTip = 'Specifies the value of the Deadline field.';
                }
                field("Notification 1"; Rec."Notification 1")
                {
                    ToolTip = 'Specifies the value of the Notification 1 field.';
                }
                field("Notification 2"; Rec."Notification 2")
                {
                    ToolTip = 'Specifies the value of the Notification 2 field.';
                }
                field("Notification 3"; Rec."Notification 3")
                {
                    ToolTip = 'Specifies the value of the Notification 3 field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Action by"; Rec."Action by")
                {
                    ToolTip = 'Specifies the value of the Action by field.';
                }
                
            }
        }
    }
}
