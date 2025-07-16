Page 50017 "Payroll Project Allocation"
{
    PageType = List;
    SourceTable = "Payroll Project Allocation";
    UsageCategory = Lists;
    ApplicationArea = ALL;
    DeleteAllowed = true;
    Editable = true;
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
                        // if (Rec."Total Hours" > 0) then
                        //     Rec.Hours := Rec."Total Hours" / Rec.Allocation;
                        // Rec.Modify(true);
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
            action(LoadAllocations)
            {
                ApplicationArea = Basic;
                Caption = 'Load Allocations';
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TotalHoursPerTimesheet: Decimal;
                    ProjectHours: Decimal;
                    AllocationPercentage: Decimal;
                    Month: Integer;
                    Year: Integer;
                    PeriodDate: Date;
                    ProjectCode: Code[20];
                    ProjectName: Text[2048];
                    TimesheetLnsByProject: Record "Timesheet Lines"; // New instance for project-specific summing
                begin
                    // Clear PayrollProjectAllocation table before loading new data
                    PayrollProjectAllocation.DeleteAll();

                    // Filter for approved timesheets only
                    TimesheetHdr.Reset();
                    TimesheetHdr.SetRange("Timesheet Status", TimesheetHdr."Timesheet Status"::Approved);

                    if TimesheetHdr.FindSet() then begin
                        repeat
                            // Calculate the first day of the month based on End Date
                            Month := Date2DMY(TimesheetHdr."End Date", 2); // Extract month
                            Year := Date2DMY(TimesheetHdr."End Date", 3);  // Extract year
                            PeriodDate := DMY2DATE(1, Month, Year); // First day of the month

                            // Calculate total hours for the current timesheet (per employee)
                            TimesheetLns.Reset();
                            TimesheetLns.SetRange("Timesheet No", TimesheetHdr."Timesheet Header No");
                            TimesheetLns.SetFilter(TimesheetLns.Project, '<>%1', '');
                            TotalHoursPerTimesheet := 0;
                            if TimesheetLns.FindSet() then begin
                                // Sum total hours across all projects for the current timesheet
                                repeat
                                    TotalHoursPerTimesheet += TimesheetLns.Hours;
                                until TimesheetLns.Next() = 0;
                            end;

                            // Process each unique project for the employee and calculate hours and allocation
                            TimesheetLns.Reset();
                            TimesheetLns.SetRange("Timesheet No", TimesheetHdr."Timesheet Header No");
                            // TimesheetLns.SetFilter(TimesheetLns.Project, '<>%1', '');

                            // Loop through each unique project within the timesheet
                            if TimesheetLns.FindSet() then begin
                                repeat
                                    ProjectCode := TimesheetLns.Project; // Current project code
                                    ProjectName := TimesheetLns."Project decription";
                                    ProjectHours := 0; // Reset for each project

                                    // Use TimesheetLnsByProject to filter and sum hours for the specific project
                                    TimesheetLnsByProject.Reset();
                                    TimesheetLnsByProject.SetRange(TimesheetLnsByProject."Timesheet No", TimesheetHdr."Timesheet Header No");
                                    TimesheetLnsByProject.SetRange(TimesheetLnsByProject.Project, ProjectCode);

                                    if TimesheetLnsByProject.FindSet() then begin
                                        repeat
                                            ProjectHours += TimesheetLnsByProject.Hours; // Accumulate hours for this project
                                        until TimesheetLnsByProject.Next() = 0;
                                    end;

                                    // Calculate the allocation percentage based on project hours and total timesheet hours
                                    if TotalHoursPerTimesheet <> 0 then
                                        AllocationPercentage := Round((ProjectHours / TotalHoursPerTimesheet) * 100, 0.01, '=');

                                    // Load or insert data into PayrollProjectAllocation
                                    PayrollProjectAllocation.Reset();
                                    PayrollProjectAllocation.SetRange("Employee No", TimesheetLns."Staff No");
                                    PayrollProjectAllocation.SetRange("Project Code", ProjectCode);
                                    PayrollProjectAllocation.SetRange(Period, PeriodDate);

                                    if PayrollProjectAllocation.FindFirst() then begin
                                        // Modify existing allocation record
                                        PayrollProjectAllocation."Total Hours" := TotalHoursPerTimesheet;
                                        PayrollProjectAllocation.Hours := ProjectHours; // Store hours for specific project
                                        PayrollProjectAllocation.Allocation := AllocationPercentage;
                                        PayrollProjectAllocation."Project Name" := ProjectName;

                                        PayrollProjectAllocation.Modify();
                                    end else begin
                                        // Insert new allocation record
                                        PayrollProjectAllocation.Init();
                                        PayrollProjectAllocation."Employee No" := TimesheetLns."Staff No";
                                        PayrollProjectAllocation."Employee Name" := TimesheetLns."Staff Name";
                                        PayrollProjectAllocation."Project Code" := ProjectCode;
                                        PayrollProjectAllocation."Project Name" := ProjectName;
                                        PayrollProjectAllocation.Period := PeriodDate; // First day of the month as period
                                        PayrollProjectAllocation."Total Hours" := TotalHoursPerTimesheet;
                                        PayrollProjectAllocation.Hours := ProjectHours; // Store hours for specific project
                                        PayrollProjectAllocation.Allocation := AllocationPercentage;
                                        PayrollProjectAllocation.Insert();
                                    end;
                                until TimesheetLns.Next() = 0;
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

        PayrollProjectAllocation.Reset;
        PayrollProjectAllocation.SetRange(PayrollProjectAllocation.Period, Rec.Period);
        if PayrollProjectAllocation.FindSet() then begin
            if (PayrollProjectAllocation."Total Hours" > 0) and (Rec.Allocation <> 0) then
                PayrollProjectAllocation.Hours := PayrollProjectAllocation."Total Hours" / Rec.Allocation;
            PayrollProjectAllocation.Modify(true);
        end;
    end;

    var
        HREmployees: Record "Payroll Employee_AU";
        PayrollProjectAllocation: Record "Payroll Project Allocation";
        PayrollCalender_AU: Record "Payroll Calender_AU";
        PayrollCalender_AU2: Record "Payroll Calender_AU";
        PayrollProjectAllocation2: Record "Payroll Project Allocation";
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

