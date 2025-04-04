report 50063 "Timesheet Monthly Summary"
{
    RDLCLayout = './Layouts/TimesheetMonthlySummaryN.rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(TimesheetLines; "Timesheet Lines")
        {
            DataItemTableView = sorting("Staff No", Date) where("Timesheet Status" = filter('Approved'), Date = filter('<>0D'));
            RequestFilterFields = "Staff No", Date, Project;

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
            end;



            trigger OnAfterGetRecord()
            begin
                PercentageTotal := 0;

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
                TimesheetReport.Reset();
                TimesheetReport.SetRange(TimesheetReport."Staff No", "Staff No");
                TimesheetReport.SetFilter(Date, '%1..%2', StartDateFilter, EndDateFilter);
                if TimesheetReport.FindSet() then begin
                    TimesheetReport.CalcSums(Hours);
                    PercentageTotal := TimesheetReport.Hours;
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
}
