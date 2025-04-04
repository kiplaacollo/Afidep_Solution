report 50105 "Update Timesheet status"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    // DefaultRenderingLayout = LayoutName;
    // DefaultLayout = RDLC;
    //  RDLCLayout = 'Layouts/UpdateDetailed.Rdlc';

    dataset
    {

        dataitem("Timesheet Header"; "Timesheet Header")
        {
            DataItemTableView = SORTING("End Date") WHERE("Timesheet Status" = CONST("SMT LEAD APPROVED"));
            RequestFilterFields = "End Date";
            //RequestFilterFields = "Customer No.";
            column(Timesheet_Header_No; "Timesheet Header No")
            {

            }
            trigger
            OnAfterGetRecord()
            var
                timesheet: Record "Timesheet Header";
                prtransm: Record "Payroll Monthly Trans_Malawi";

            begin
                timesheet.Reset();
                timesheet.SetRange(timesheet."Timesheet Header No", "Timesheet Header No");

                if timesheet.FindSet() then begin
                    repeat
                        if (timesheet."Timesheet Status" = timesheet."Timesheet Status"::"SMT Lead Approved") and (timesheet."End Date" < DMY2Date(1, 7, 2024)) then begin
                            timesheet."Timesheet Status" := timesheet."Timesheet Status"::Approved;
                            // end else
                            //     if timesheet."Timesheet Status" = timesheet."Timesheet Status"::"Send Awaiting Approval" then begin
                            //         timesheet."Timesheet Status" := timesheet."Timesheet Status"::Open;
                        end;

                        timesheet.Modify(true);


                    until timesheet.Next() = 0;

                end;

                Message('Timesheets Updated sucessful');
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
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
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        myInt: Integer;
}