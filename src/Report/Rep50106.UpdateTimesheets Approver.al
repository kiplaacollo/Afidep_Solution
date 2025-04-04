report 50106 "Update Timesheet Approve Id"
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
                        if (timesheet."Timesheet Status" = timesheet."Timesheet Status"::Approved) OR (timesheet."Timesheet Status" = timesheet."Timesheet Status"::"Line Manager Approved") then begin
                            timesheet."Approver ID" := timesheet."SMT Lead";
                        end else
                            if (timesheet."Timesheet Status" = timesheet."Timesheet Status"::"Project Manager Approved") OR (timesheet."Timesheet Status" = timesheet."Timesheet Status"::Open) then begin
                                timesheet."Approver ID" := timesheet."Line Manager";
                            end;

                        timesheet.Modify(true);


                    until timesheet.Next() = 0;
                    Message('Timesheets Updated sucessful');
                end;


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