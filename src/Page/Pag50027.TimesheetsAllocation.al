Page 50027 "Timesheets Allocation"
{
    PageType = List;
    SourceTable = "Timesheets Allocation";
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Period; Rec.Period)
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
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = Basic;
                }
                field("BudgetLine Code"; Rec."BudgetLine Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Total Hours"; Rec."Total Hours")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        if (Rec."Total Hours" > 0) then
                            Rec.Hours := Rec."Total Hours" / Rec.Allocation;
                        Rec.Modify(true);
                    end;
                }
                field(Hours; Rec.Hours)
                {
                    ApplicationArea = Basic;
                    //Caption = 'Total Housrs';

                }
                field(Allocation; Rec.Allocation)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(SuggestAllocations)
            {
                ApplicationArea = Basic;
                Caption = 'Suggest Allocations';
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // Clear the PayrollProjectAllocation table before loading new data
                    PayrollProjectAllocation.DeleteAll();

                    TimesheetHdr.Reset();
                    TimesheetHdr.SetRange(TimesheetHdr."Timesheet Status", TimesheetHdr."Timesheet Status"::Approved);
                    TimesheetHdr.SetFilter(TimesheetHdr."Timesheet Header No", '<>%1', 'TMS_0578');

                    if TimesheetHdr.FindSet() then begin
                        repeat
                            TimesheetLns.Reset();
                            TimesheetLns.SetRange(TimesheetLns."Timesheet No", TimesheetHdr."Timesheet Header No");


                            if TimesheetLns.FindSet() then begin
                                // Step 1: Clear temporary table and calculate total work hours per timesheet header
                                ProjectHoursTemp.DeleteAll(); // Clear any previous records in the temporary table
                                TotalWork := 0;

                                repeat
                                    TotalWork += TimesheetLns.Hours; // Sum total work hours per timesheet header

                                    // Check if the combination of Timesheet No, Staff No, and Project exists in the temp table
                                    if ProjectHoursTemp.Get(TimesheetLns."Timesheet No", TimesheetLns."Staff No", TimesheetLns.Project) then begin
                                        ProjectHoursTemp."Total Hours" := ProjectHoursTemp."Total Hours" + TimesheetLns.Hours;
                                        ProjectHoursTemp."Hours" := ProjectHoursTemp."Hours" + TimesheetLns.Hours; // Add hours for this specific project
                                        ProjectHoursTemp.Modify();
                                    end else begin
                                        // Insert new record in the temporary table for the combination of Timesheet No, Staff No, and Project
                                        ProjectHoursTemp.Init();
                                        ProjectHoursTemp."Timesheet No" := TimesheetLns."Timesheet No";
                                        ProjectHoursTemp."Staff No" := TimesheetLns."Staff No";
                                        ProjectHoursTemp."Project Code" := TimesheetLns.Project;
                                        ProjectHoursTemp."Total Hours" := TimesheetLns.Hours; // Store the total hours
                                        ProjectHoursTemp."Hours" := TimesheetLns.Hours; // Store the hours for the specific project
                                        ProjectHoursTemp.Insert();
                                    end;
                                until TimesheetLns.Next() = 0;

                                // Extract the first and last date for the month of the timesheet line dates
                                TimesheetLns.Reset();
                                TimesheetLns.SetRange(TimesheetLns."Timesheet No", TimesheetHdr."Timesheet Header No");
                                if TimesheetLns.FindFirst() then begin
                                    // Get the year and month from the timesheet line
                                    Month := Date2DMY(TimesheetLns.Date, 2); // Extract month from the date field
                                    Year := Date2DMY(TimesheetLns.Date, 3);  // Extract year from the date field
                                                                             // Error('Month: %1, Year: %2', Month, Year);
                                                                             // Calculate the first and last day of the month
                                    PeriodStartDate := DMY2DATE(1, Month, Year); // First day of the month
                                    PeriodEndDate := CALCDATE('<+1M-1D>', PeriodStartDate); // Last day of the month


                                    // Check if the dates are valid
                                    if (PeriodStartDate = 0D) or (PeriodEndDate = 0D) then
                                        exit; // Skip this iteration if the dates are invalid                                                      //  Error('PeriodStartDate: %1, PeriodEndDate: %2', PeriodStartDate, PeriodEndDate);
                                end;

                                // Step 3: Loop through the temp table and calculate percentages for each timesheet header
                                if ProjectHoursTemp.FindSet() then begin
                                    repeat
                                        if ProjectHoursTemp."Total Hours" > 0 then
                                            AllocationPercentage := Round((ProjectHoursTemp."Total Hours" / TotalWork) * 100, 0.01, '=');
                                        // Message('total hours: %1', ProjectHoursTemp."Total Hours");
                                        TimesheetLns.Reset();
                                        TimesheetLns.SetRange(TimesheetLns."Timesheet No", ProjectHoursTemp."Timesheet No");
                                        TimesheetLns.SetRange(TimesheetLns."Staff No", ProjectHoursTemp."Staff No");
                                        TimesheetLns.SetRange(TimesheetLns.Project, ProjectHoursTemp."Project Code");
                                        TimesheetLns.SetRange(TimesheetLns.Date, PeriodStartDate, PeriodEndDate); // Filter by the calendar month

                                        if TimesheetLns.FindSet() then begin
                                            repeat
                                                // Initialize/reset PayrollProjectAllocation for each TimesheetLns record
                                                PayrollProjectAllocation.Reset();
                                                PayrollProjectAllocation.SetRange(PayrollProjectAllocation."Employee No", TimesheetLns."Staff No");
                                                PayrollProjectAllocation.SetRange(PayrollProjectAllocation."Project Code", TimesheetLns.Project);
                                                PayrollProjectAllocation.SetRange(PayrollProjectAllocation.Period, PeriodStartDate); // Use the first day of the month

                                                if PayrollProjectAllocation.FindFirst() then begin
                                                    // If a record exists, modify the existing record
                                                    PayrollProjectAllocation."Employee Name" := TimesheetLns."Staff Name";
                                                    PayrollProjectAllocation.Allocation := AllocationPercentage;
                                                    PayrollProjectAllocation."Hours" := ProjectHoursTemp."Hours"; // Store the hours for the specific project
                                                    PayrollProjectAllocation.Modify();
                                                end else begin
                                                    // If no record exists, insert a new record
                                                    PayrollProjectAllocation.Init();  // Initialize the record
                                                    PayrollProjectAllocation."Employee No" := TimesheetLns."Staff No";
                                                    PayrollProjectAllocation."Employee Name" := TimesheetLns."Staff Name";
                                                    PayrollProjectAllocation."Project Code" := TimesheetLns.Project;
                                                    PayrollProjectAllocation.Period := PeriodStartDate; // Store the first day of the month as period
                                                    PayrollProjectAllocation.Allocation := AllocationPercentage; // Store allocation percentage
                                                    PayrollProjectAllocation."Total Hours" := TotalWork; // Store the total work hours
                                                                                                         //  Error('total hours: %1', TotalWork);
                                                    PayrollProjectAllocation."Hours" := ProjectHoursTemp."Hours"; // Store the specific project hours
                                                    PayrollProjectAllocation.Insert(); // Insert the new record
                                                end;

                                            until TimesheetLns.Next() = 0;
                                        end;
                                    until ProjectHoursTemp.Next() = 0;
                                end;
                            end;
                        until TimesheetHdr.Next() = 0;
                    end;

                    Message('Allocations Loaded Successfully.');
                end;
            }

        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec."Employee Name" = '' then begin
            if HREmployees.Get(Rec."Employee No") then begin
                Rec."Employee Name" := HREmployees.Firstname + ' ' + HREmployees.Lastname;
                Rec.Modify();
            end;
        end;
    end;

    var
        HREmployees: Record "Payroll Employee_AU";
        PayrollProjectAllocation: Record "Timesheets Allocation";
        PayrollCalender_AU: Record "Payroll Calender_AU";
        PayrollCalender_AU2: Record "Payroll Calender_AU";
        PayrollProjectAllocation2: Record "Timesheets Allocation";
        TimesheetLns: Record "Timesheet Lines";
        TimesheetHdr: Record "Timesheet Header";
        TotalWork: Decimal;
        AllocationPercentage: Decimal;
        ProjectHoursTemp: Record "Project Hours Temp" temporary;
        PeriodDate: Date; // Declare PeriodDate here
        Month: Integer;
        Year: Integer;
        PeriodStartDate: Date;
        PeriodEndDate: Date;

}

