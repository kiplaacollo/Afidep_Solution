report 50061 "TimesheetReport Summary"
{
    ApplicationArea = All;
    Caption = 'TimesheetReport Summary';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/TimesheetReportSummary.rdlc';
    dataset
    {
        dataitem(TimesheetHeader; "Timesheet Header")
        {
            RequestFilterFields = "Start Date", "End Date";
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
            column(EmployeeJobTitle; EmployeeJobTitle) { }
            column(EmployeeSupervisor; EmployeeSupervisor) { }
            column(Timesheet_Status; "Timesheet Status")
            { }
            dataitem("HR Employees"; "HR Employees")
            {
                DataItemLink = "No." = field("Staff No");
                RequestFilterFields = "Global Dimension 1 Code";

                trigger OnPreDataItem()
                begin
                    // Apply filter for Global Dimension 1 Code from HR Employees
                    if GetFilter("Global Dimension 1 Code") <> '' then
                        SetRange("Global Dimension 1 Code", GetFilter("Global Dimension 1 Code"));
                end;
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);



            end;

            trigger OnAfterGetRecord()
            begin
            end;
        }
    }
    requestpage
    {

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
        StartDateFilter: Date;
        EndDateFilter: Date;

    //emplSign: blob;
}
