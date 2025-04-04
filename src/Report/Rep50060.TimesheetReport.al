report 50060 TimesheetReport
{
    ApplicationArea = All;
    Caption = 'TimesheetReport';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/TimesheetLinesReport.rdlc';
    dataset
    {
        dataitem(TimesheetHeader; "Timesheet Header")
        {
            column(Cpicture; CompanyInfo.Picture) { }
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
                DataItemLink = "Timesheet No" = field("Timesheet Header No");
                column(Timesheet_No; "Timesheet No") { }
                column(Project; Project) { }
                column(Project_decription; "Project decription") { }
                column(Workplan; "Workplan ") { }
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
            end;

            trigger OnAfterGetRecord()
            begin
                PercentageTotal := 0;
                EmployeeJobTitle := '';
                EmployeeSupervisor := '';
                HrEmployee.Reset();
                HrEmployee.SetRange(HrEmployee."No.", TimesheetHeader."Staff No");
                if HrEmployee.FindFirst() then begin
                    HrEmployee.CalcFields(Signature);
                    EmployeeJobTitle := LowerCase(HrEmployee."Job Title");
                    timesheet.Reset();
                    timesheet.SetRange(timesheet."Timesheet Header No", TimesheetHeader."Timesheet Header No");
                    if timesheet.FindSet() then begin
                        if ("Timesheet Status" = "Timesheet Status"::"Project Manager Approved") then
                            "employee Signature" := HrEmployee.Signature;
                        //  "Line manager Signature" := 0;
                        timesheet.Modify();
                    end;
                end;
                HrEmployee.Reset();
                HrEmployee.SetRange(HrEmployee."Employee UserID", TimesheetHeader."Line Manager");
                if HrEmployee.FindFirst() then begin
                    HrEmployee.CalcFields(Signature);
                    EmployeeSupervisor := HrEmployee."First Name" + ' ' + HrEmployee."Last Name";
                    timesheet.Reset();
                    timesheet.SetRange(timesheet."Timesheet Header No", TimesheetHeader."Timesheet Header No");
                    if timesheet.FindSet() then begin
                        if ("Timesheet Status" = "Timesheet Status"::"Project Manager Approved") or ("Timesheet Status" = "Timesheet Status"::"Line Manager Approved")
                        then
                            "Line manager Signature" := HrEmployee.Signature;
                        timesheet.Modify();
                    end;
                end;
                TimesheetReport.Reset();
                TimesheetReport.SetRange("Timesheet No", "Timesheet Header No");
                if TimesheetReport.FindSet() then begin
                    TimesheetReport.CalcSums(Hours);
                    PercentageTotal := TimesheetReport.Hours;
                end;
                HrEmployee.Reset();
                HrEmployee.SetRange(HrEmployee."Employee UserID", TimesheetHeader."SMT Lead");
                if HrEmployee.FindFirst() then begin
                    HrEmployee.CalcFields(Signature);
                    // EmployeeSupervisor := HrEmployee."First Name" + ' ' + HrEmployee."Last Name";
                    timesheet.Reset();
                    timesheet.SetRange(timesheet."Timesheet Header No", TimesheetHeader."Timesheet Header No");
                    if timesheet.FindSet() then begin
                        if ("Timesheet Status" = "Timesheet Status"::"Project Manager Approved") or ("Timesheet Status" = "Timesheet Status"::"Line Manager Approved")
                        or ("Timesheet Status" = "Timesheet Status"::"SMT Lead Approved") then
                            "SMT Lead Signature" := HrEmployee.Signature;
                        timesheet.Modify();
                    end;
                end;

                timesheet.Reset();
                timesheet.SetRange(timesheet."Timesheet Header No", TimesheetHeader."Timesheet Header No");
                if timesheet.FindSet() then begin
                    if (timesheet."Timesheet Status" = timesheet."Timesheet Status"::Approved) then begin
                        HrEmployee.Reset();
                        HrEmployee.SetRange(HrEmployee."Employee UserID", TimesheetHeader."SMT Lead");
                        if HrEmployee.FindFirst() then begin
                            HrEmployee.CalcFields(Signature);
                            "SMT Lead Signature" := HrEmployee.Signature;
                            timesheet.Modify();
                        end;
                        HrEmployee.Reset();
                        HrEmployee.SetRange(HrEmployee."Employee UserID", TimesheetHeader."Line Manager");
                        if HrEmployee.FindFirst() then begin
                            HrEmployee.CalcFields(Signature);
                            "Line manager Signature" := HrEmployee.Signature;
                            timesheet.Modify();
                        end;
                        HrEmployee.Reset();
                        HrEmployee.SetRange(HrEmployee."No.", TimesheetHeader."Staff No");
                        if HrEmployee.FindFirst() then begin
                            HrEmployee.CalcFields(Signature);
                            "employee Signature" := HrEmployee.Signature;
                            timesheet.Modify();
                        end;
                    end;
                end;
                timesheet.Reset();
                timesheet.SetRange("Timesheet Header No", "Timesheet Header No");
                if timesheet.FindSet() then begin
                    if timesheet."Date Submitted" = 0D then begin
                        "Date Submitted" := DT2Date(SystemCreatedAt);
                        // "Line Manager Approved Date" := DT2Date(SystemModifiedAt);//"Line Manager Approved Date";//DT2Date(SystemModifiedAt);
                        // "SMT Lead Approve date" := DT2Date(SystemModifiedAt);//"SMT Lead Approve date";//DT2Date(SystemModifiedAt);
                        timesheet.Modify();
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
    //emplSign: blob;
}
