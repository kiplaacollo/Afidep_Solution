

Report 80075 "HR Leave ApplicationS"
{
    RDLCLayout = 'Layouts/HR Leave ApplicationS.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("HR Leave Application"; "HR Leave Application")
        {
            RequestFilterFields = "Application Code";
            RequestFilterHeading = 'Document Number';
            column(ReportForNavId_1000000000; 1000000000) { } // Autogenerated by ForNav - Do not delete															
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(EmployeeNo_HRLeaveApplication; "HR Leave Application"."Employee No")
            {
                IncludeCaption = true;
            }
            column(DaysApplied_HRLeaveApplication; "HR Leave Application"."Days Applied")
            {
                IncludeCaption = true;
            }
            column(ApplicationCode_HRLeaveApplication; "HR Leave Application"."Application Code")
            {
                IncludeCaption = true;
            }
            column(RequestLeaveAllowance_HRLeaveApplication; "HR Leave Application"."Request Leave Allowance")
            {
                IncludeCaption = true;
            }
            column(LeaveAllowanceAmount_HRLeaveApplication; "HR Leave Application"."Leave Allowance Amount")
            {
                IncludeCaption = true;
            }
            column(NumberofPreviousAttempts_HRLeaveApplication; "HR Leave Application"."Number of Previous Attempts")
            {
                IncludeCaption = true;
            }
            column(DetailsofExamination_HRLeaveApplication; "HR Leave Application"."Details of Examination")
            {
                IncludeCaption = true;
            }
            column(DateofExam_HRLeavseApplication; "HR Leave Application"."Date of Exam")
            {
                IncludeCaption = true;
            }
            column(Reliever_HRLeaveApplication; "HR Leave Application".Reliever)
            {
                IncludeCaption = true;
            }
            column(RelieverName_HRLeaveApplication; "HR Leave Application"."Reliever Name")
            {
                IncludeCaption = true;
            }
            column(StartDate_HRLeaveApplication; "HR Leave Application"."Start Date")
            {
                IncludeCaption = true;
            }
            column(ReturnDate_HRLeaveApplication; "HR Leave Application"."Return Date")
            {
                IncludeCaption = true;
            }
            column(LeaveType_HRLeaveApplication; "HR Leave Application"."Leave Type")
            {
                IncludeCaption = true;
            }
            column(JobTittle_HRLeaveApplication; "HR Leave Application"."Job Tittle")
            {
                IncludeCaption = true;
            }
            column(ApplicationDate_HRLeaveApplication; "HR Leave Application"."Application Date")
            {
                IncludeCaption = true;
            }
            column(EmailAddress_HRLeaveApplication; "HR Leave Application"."E-mail Address")
            {
                IncludeCaption = true;
            }
            column(CellPhoneNumber_HRLeaveApplication; "HR Leave Application"."Cell Phone Number")
            {
                IncludeCaption = true;
            }
            column(Approveddays_HRLeaveApplication; "HR Leave Application"."Approved days")
            {
            }
            dataitem("Approval Comment Line"; "Approval Comment Line")
            {
                DataItemLink = "Document No." = field("Application Code");
                DataItemTableView = sorting("Entry No.") order(ascending);
                // Autogenerated by ForNav - Do not delete															

                // column(ApprovedStartDate_ApprovalCommentLine; "Approval Comment Line"."Approved Start Date")															
                // {															
                // 	IncludeCaption = true;														
                // }															
                // column(ApprovedReturnDate_ApprovalCommentLine; "Approval Comment Line"."Approved Return Date")															
                // {															
                // 	IncludeCaption = true;														
                // }															
                // column(Reason_ApprovalCommentLine; "Approval Comment Line".Reason)															
                // {															
                // 	IncludeCaption = true;														
                // }															
                // column(LeaveAllowanceGranted_ApprovalCommentLine; "Approval Comment Line"."Leave Allowance Granted")															
                // {															
                // 	IncludeCaption = true;														
                // }															
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = field("Application Code");
                DataItemTableView = sorting("Table ID", "Document Type", "Document No.", "Sequence No.") order(ascending);
                column(ReportForNavId_1000000008; 1000000008) { } // Autogenerated by ForNav - Do not delete															
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                    IncludeCaption = true;
                }
                dataitem("User Setup"; "User Setup")
                {
                    DataItemLink = "User ID" = field("Approver ID");
                    DataItemTableView = sorting("User ID") order(ascending);
                    column(ReportForNavId_1000000009; 1000000009) { } // Autogenerated by ForNav - Do not delete															
                }
            }
        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            //:= false;															
        end;
    }

    trigger OnInitReport()
    begin
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        CI.Get;
        CI.CalcFields(CI.Picture);
        ;

    end;

    var
        CI: Record "Company Information";

}



