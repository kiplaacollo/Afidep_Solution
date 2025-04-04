page 172245 "Status update"
{
    ApplicationArea = All;
    Caption = 'Status update';
    PageType = ListPart;
    SourceTable = StatusUpdateMeetingTracker;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }

            }
        }
    }
}
