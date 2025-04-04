report 50065 "TimesheetReport Line M"
{
    ApplicationArea = All;
    Caption = 'TimesheetReport Line Manager';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/TimesheetMonthlyLineM.rdlc';
    dataset
    {

        dataitem(TimesheetHeader; "Timesheet Header")
        {
            DataItemTableView = sorting("Timesheet Header No");
            RequestFilterFields = "Line Manager";
            column(SMT_Lead; "SMT Lead") { }

            //  trigger OnPreDataItem()
            // begin
            //     // Apply SMT Lead filter
            //     if SMTLeadFilter <> '' then
            //         SetFilter("SMT Lead", SMTLeadFilter);
            // end;

            dataitem(TimesheetLines; "Timesheet Lines")
            {
                DataItemLink = "Timesheet No" = field("Timesheet Header No");
                DataItemTableView = sorting("Staff No", Date) where("Timesheet Status" = filter('Approved'), Date = filter('<>0D'));
                //  RequestFilterFields = "Staff No", Date, Project;

                column(Date; Date) { }
                column(StaffNo; "Staff No") { }
                column(StaffName; "Staff Name") { }
                column(Project; Project) { }
                column(EndDateFilter; EndDateFilter) { }
                column(MonthYear; MonthYear) { }
                column(EndMonth; EndMonth) { }
                column(Total_Hours; "Total Hours") { }
                column(Hours; Hours) { }

                trigger OnPreDataItem()
                begin
                    // Apply the date filter
                    if (StartDateFilter <> 0D) and (EndDateFilter <> 0D) then
                        SetFilter(Date, '%1..%2', StartDateFilter, EndDateFilter);

                    // Apply the employee filter if set
                    if StaffNoFilter <> '' then
                        SetFilter("Staff No", StaffNoFilter);

                    // // Apply SMT Lead filter
                    // if SMTLeadFilter <> '' then
                    //     SetFilter(TimesheetHeader."SMT Lead", SMTLeadFilter);
                end;

                trigger OnAfterGetRecord()
                begin
                    // Extract month and year
                    MonthText := Format(Date2DMY(Date, 2), 0, '<Integer>');
                    YearText := Format(Date2DMY(Date, 1), 0, '<Integer>');

                    MonthYear := MonthText + '-' + YearText;
                    EndMonth := CalcDate('<CM>', Date);
                end;
            }
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
                    // field(StaffNoFilter; StaffNoFilter)
                    // {
                    //     ApplicationArea = All;
                    // }
                    // field(SMTLeadFilter; SMTLeadFilter)
                    // {
                    //     ApplicationArea = All;
                    // }
                }
            }
        }
    }

    var
        StartDateFilter: Date;
        EndDateFilter: Date;
        StaffNoFilter: Code[20];
        SMTLeadFilter: Code[20];
        MonthlyHours: Dictionary of [Text[7], Decimal];
        MonthYearKey: Text[7];
        MonthText: Text[2];
        YearText: Text[4];
        MonthYear: Text[20];
        EndMonth: Date;
}
