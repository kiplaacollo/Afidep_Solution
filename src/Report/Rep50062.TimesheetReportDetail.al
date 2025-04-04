report 50062 "TimesheetReport Detail"
{
    ApplicationArea = All;
    Caption = 'TimesheetReport Summary';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/TimesheetReportDetail.rdlc';
    dataset
    {
        dataitem(TimesheetHeader; "Timesheet Header")
        {
            // DataItemTableView = T
            RequestFilterFields = "Start Date", "End Date", "Staff No";
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo__Address_2_; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo__Country_Region_Code_; CompanyInfo."Country/Region Code")
            {
            }
            column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo__E_Mail_; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo__Home_Page_; CompanyInfo."Home Page")
            {
            }
            column(Staff_No; "Staff No") { }
            column(Staff_Name; "Staff Name") { }
            column(Start_Date; "Start Date") { }
            column(End_Date; "End Date") { }
            column(PercentageTotal; PercentageTotal) { }
            column(EmployeeJobTitle; EmployeeJobTitle) { }
            column(EmployeeSupervisor; EmployeeSupervisor) { }
            column(Timesheet_Status; "Timesheet Status")
            { }
            column(employee_Signature; "employee Signature") { }
            column(Line_manager_Signature; "Line manager Signature") { }
            column(SMT_Lead_Signature; "SMT Lead Signature") { }
            column(Date_Submitted; "Date Submitted") { }
            column(Line_Manager_Approved_Date; "Line Manager Approved Date") { }
            column(SMT_Lead_Approve_date; "SMT Lead Approve date") { }
            dataitem("Timesheet Lines"; "Timesheet Lines")
            {
                RequestFilterFields = Project, Date;
                DataItemLink = "Timesheet No" = field("Timesheet Header No");
                column(Timesheet_No; "Timesheet No") { }
                column(Project; Project) { }
                column(Project_decription; "Project decription") { }
                column(Workplan;"Workplan ") { }
                column(Workplan_Description; "Workplan Description") { }
                column(Activity; Activity) { }
                column(Activity_Discription; "Activity Discription") { }
                column(Narration; Narration) { }
                column(Date; Date) { }
                column(Hours; Hours) { }
                column(Timesheet_Status_Lines; "Timesheet Status") { }
                column(Approver_ID; "Approver ID") { }
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);

                // HrEmployee.Get;
                HrEmployee.CalcFields(Signature);
                if ("Start Date" <> 0D) AND ("End Date" <> 0D) then
                    "Timesheet Lines".SetFilter("Timesheet Lines".Date, '%1..%2', "Start Date", "End Date");


                // Get the filter value set by the user for "Staff No."
                StaffNoFilter := TimesheetHeader.GetFilter("Staff No");

                // If there is a filter set by the user, apply it to the data item
                if StaffNoFilter <> '' then begin
                    TimesheetHeader.SetFilter("Staff No", StaffNoFilter);
                end else begin
                    // If no filter is set, clear any existing filter
                    TimesheetHeader.SetRange("Staff No");

                end;

                // Filter to show only approved timesheets
                TimesheetHeader.SetRange("Timesheet Status", "Timesheet Status"::Approved);

            end;

            trigger OnAfterGetRecord()
            begin
                PercentageTotal := 0;
                EmployeeJobTitle := '';
                EmployeeSupervisor := '';
                HrEmployee.Reset();
                HrEmployee.SetRange("No.", "Staff No");
                if HrEmployee.FindFirst() then begin
                    HrEmployee.CalcFields(Signature);
                    EmployeeJobTitle := LowerCase(HrEmployee."Job Title");
                    "employee Signature" := HrEmployee.Signature;
                end;
                HrEmployee.Reset();
                HrEmployee.SetRange(HrEmployee."Employee UserID", "Line Manager");
                if HrEmployee.FindFirst() then begin
                    HrEmployee.CalcFields(Signature);
                    EmployeeSupervisor := HrEmployee."First Name" + ' ' + HrEmployee."Last Name";
                    "Line manager Signature" := HrEmployee.Signature;
                end;
                TimesheetReport.Reset();
                TimesheetReport.SetRange("Timesheet No", "Timesheet Header No");
                if TimesheetReport.FindSet() then begin
                    TimesheetReport.CalcSums(Hours);
                    PercentageTotal := TimesheetReport.Hours;
                end;
                HrEmployee.Reset();
                HrEmployee.SetRange(HrEmployee."Employee UserID", "SMT Lead");
                if HrEmployee.FindFirst() then begin
                    HrEmployee.CalcFields(Signature);
                    // EmployeeSupervisor := HrEmployee."First Name" + ' ' + HrEmployee."Last Name";
                    "SMT Lead Signature" := HrEmployee.Signature;
                end;
                timesheet.Reset();
                timesheet.SetRange("Timesheet Header No", "Timesheet Header No");
                if timesheet.FindSet() then begin
                    "Date Submitted" := DT2Date(SystemModifiedAt);//"Date Submitted";//DT2Date(SystemCreatedAt);
                    "Line Manager Approved Date" := DT2Date(SystemModifiedAt);//"Line Manager Approved Date";//DT2Date(SystemModifiedAt);
                    "SMT Lead Approve date" := DT2Date(SystemModifiedAt);//"SMT Lead Approve date";//DT2Date(SystemModifiedAt);
                    timesheet.Modify();
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
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        TimesheetReport: Record "Timesheet Lines";
        timesheet: Record "Timesheet Header";
        PercentageTotal: Decimal;
        CompanyInfo: Record "Company Information";
        HrEmployee: Record "HR Employees";
        EmployeeJobTitle: Code[300];
        EmployeeSupervisor: Text[200];
        StaffNoFilter: Text[200];
    //emplSign: blob;
}

