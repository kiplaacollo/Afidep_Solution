report 50064 "Timesheet Activity Report"
{
    RDLCLayout = './Layouts/TimesheetActivityRep.rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(TimesheetLines; "Timesheet Lines")
        {
            DataItemTableView = sorting("Staff No", Date) where("Timesheet Status" = filter('Approved'), Date = filter('<>0D'));
            RequestFilterFields = "Staff No", Date, Project;

            column(Date; Date) { }
            column(StaffNo; "Staff No") { }
            column(StaffName; "Staff Name") { }
            column(Project; Project) { }
            column(Project_decription; "Project decription") { }
            column(EndDateFilter; EndDateFilter) { }
            column(MonthYear; MonthYear) { }
            column(EndMonth; EndMonth) { }
            column(Total_Hours; "Total Hours") { }
            column(Activity; Activity) { }
            column(Activity_Discription; "Activity Discription") { }
            column(Workplan;"Workplan ") { }
            column(Workplan_Description; "Workplan Description") { }
            column(Hours; Hours) { }



            trigger OnPreDataItem()
            begin
                // Apply the date filter
                if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then
                    SetFilter(Date, '%1..%2', StartDateFilter, EndDateFilter);

                // Apply the employee filter if set
                if StaffNoFilter <> '' then
                    SetFilter("Staff No", StaffNoFilter);
            end;



            trigger OnAfterGetRecord()
            begin
                // Extract month and year
                MonthText := Format(Date2DMY(Date, 2), 0, '<Integer>');
                YearText := Format(Date2DMY(Date, 1), 0, '<Integer>');

                MonthYear := MonthText + '-' + YearText;
                EndMonth := CalcDate('<CM>', Date);

                // // Check if key exists or add hours accordingly
                // if MonthlyHours.ContainsKey(MonthYear) then begin
                //     MonthlyHours.Get(MonthYear, Hours);
                //     Hours := Hours + "Hours";
                //     MonthlyHours.Set(MonthYear, Hours);
                // end
                // else begin
                //     MonthlyHours.Add(MonthYear, "Hours");
                // end;
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Group)
                {
                    field(StartDateFilter; StartDateFilter)
                    {
                        ApplicationArea = All;
                    }
                    field(EndDateFilter; EndDateFilter)
                    {
                        ApplicationArea = All;
                    }
                    field(StaffNoFilter; StaffNoFilter)
                    {
                        TableRelation = "HR Employees";
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        StartDateFilter: Date;
        EndDateFilter: Date;
        StaffNoFilter: Code[20];
        MonthlyHours: Dictionary of [Text[7], Decimal];
        MonthYearKey: Text[7];
        MonthText: Text[2];
        YearText: Text[4];
        MonthYear: Text[20];
        EndMonth: Date;
}
