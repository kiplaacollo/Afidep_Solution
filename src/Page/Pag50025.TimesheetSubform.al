Page 50025 "Timesheet Subform"
{
    PageType = List;
    SourceTable = TimesheetLines;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(projectCode;Rec.projectCode)
                {
                    ApplicationArea = Basic;
                }
                field(projectText;Rec.projectText)
                {
                    ApplicationArea = Basic;
                }
                field(hours;Rec.hours)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

