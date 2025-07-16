report 50067 "Timesheet Project Summary"
{
    RDLCLayout = './Layouts/TimesheetMonthlySummaryNP.rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(TimesheetLines; "Timesheet Lines")
        {
            // DataItemTableView = sorting("Staff No", Date) where("Timesheet Status" = filter('Approved'), Date = filter('<>0D'), Project = filter('<>RM001&<>AD03&<>CD05&<>RP01&<>RM2025&<>ID0002&<>PD04'));
            DataItemTableView = sorting("Staff No", Date) where(Date = filter('<>0D'), Project = filter('<>RM001&<>AD03&<>CD05&<>RP01&<>RM2025&<>ID0002&<>PD04'));
            RequestFilterFields = "Staff No", Date, Project, "Timesheet Status";

            column(Date; Date) { }
            column(CompanyInformation_Pic; CompanyInfo.Picture) { }
            column(CompanyInformation_address; CompanyInfo.Address) { }
            column(CompanyInformation_Phone; CompanyInfo."Phone No.") { }
            column(CompanyInformation_Name; CompanyInfo.Name) { }
            column(CompanyInformation_Address2; CompanyInfo."Address 2") { }
            column(CompanyInformation_homepage; CompanyInfo."Home Page") { }
            column(CompanyInformation_Email; CompanyInfo."E-Mail") { }
            column(StaffNo; "Staff No") { }
            column(StaffName; "Staff Name") { }
            column(Project; Project) { }
            column(Project_decription; "Project decription") { }
            column(EndDateFilter; EndDateFilter) { }
            column(MonthYear; MonthYear) { }
            column(EndMonth; EndMonth) { }
            column(PercentageTotal; PercentageTotal) { }
            column(Total_Hours; "Total Hours") { }
            column(Activity; Activity) { }
            column(Activity_Discription; "Activity Discription") { }
            column(Workplan; "Workplan ") { }
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


                // Exclude specific projects
                // SetFilter(Project, '<>RM001&<>AD03&<>CD05&<>RP01&<>RM2025&<>ID0002&<>PD04');
            end;



            trigger OnAfterGetRecord()
            begin
                PercentageTotal := 0;

                // Extract month and year
                MonthText := Format(Date2DMY(Date, 2), 0, '<Integer>');
                YearText := Format(Date2DMY(Date, 1), 0, '<Integer>');

                MonthYear := MonthText + '-' + YearText;
                EndMonth := CalcDate('<CM>', Date);

                // Total available working hours (e.g., 264 * 8 = 2112)
                TotalAvailableHours := 264 * 8;
                PercentageTotal := 0;

                TimesheetReport.Reset();
                TimesheetReport.SetRange("Staff No", "Staff No");
                TimesheetReport.SetFilter(Date, '%1..%2', StartDateFilter, EndDateFilter);
                TimesheetReport.SetFilter(Project, '<>RM001&<>AD03&<>CD05&<>RP01&<>RM2025&<>ID0002&<>PD04');

                if TimesheetReport.FindSet() then begin
                    TimesheetReport.CalcSums(Hours);
                    if TotalAvailableHours > 0 then begin
                        PercentageTotal := (TimesheetReport.Hours / TotalAvailableHours) * 100;
                        if PercentageTotal > 100 then
                            PercentageTotal := 100;
                    end;
                end;

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
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CI.Get();
        CI.CalcFields(CI.Picture);

        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        CI: Record "Company Information";
        StartDateFilter: Date;
        EndDateFilter: Date;
        StaffNoFilter: Code[20];
        MonthlyHours: Dictionary of [Text[7], Decimal];
        MonthYearKey: Text[7];
        MonthText: Text[2];
        YearText: Text[4];
        MonthYear: Text[20];
        EndMonth: Date;
        TimesheetReport: Record "Timesheet Lines";
        PercentageTotal: Decimal;
        TotalAvailableHours: Decimal;
}
