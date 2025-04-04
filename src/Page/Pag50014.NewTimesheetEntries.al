Page 50014 "New Timesheet Entries"
{
    CardPageID = "Timesheet Card";
    PageType = List;
    SourceTable = TimesheetLines;
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Timesheetcode; Rec.Timesheetcode)
                {
                    ApplicationArea = Basic;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = Basic;
                }
                field("To"; Rec."To")
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

