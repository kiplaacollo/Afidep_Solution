page 172258 "HR role RC"
{

    Caption = 'Resource Mobilization', Comment = '{Dependency=Match,"Resource mobilization"}';
    PageType = RoleCenter;

    ApplicationArea = ALL;
    layout
    {
        area(rolecenter)
        {
            part(Control139; "Headline RC Business Manager")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(ApprovalActivities; "Approvals Activities")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part(OtherDocActivities; "staff Dashboard Cue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(EmailActivities; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }

            part(Control16; "O365 Activities")
            {
                AccessByPermission = TableData "Activities Cue" = I;
                //AccessByPermission = TableData financecue = 1;
                ApplicationArea = Basic, Suite;
                Visible = false;
            }


            part(Control98; "Power BI Report Spinner Part")
            {
                AccessByPermission = TableData "Power BI User Configuration" = I;
                ApplicationArea = Basic, Suite;
            }
            part(Control46; "Team Member Activities No Msgs")
            {
                ApplicationArea = Suite;
                Visible = false;
            }

        }


    }

    actions
    {
        area(sections)
        {


            group("Company Jobs")
            {
                action("Hr Job List")
                {
                    Caption = 'HR Jobs List';
                    ApplicationArea = basic, suite;
                    Image = Employee;
                    RunObject = page "HR Jobs List";
                }
                action("Company job Industries")
                {
                    Caption = 'Company job Industries';
                    ApplicationArea = basic, suite;
                    Image = Job;
                    RunObject = page "Company Job Industries";
                }



            }



            group("HR Base")
            {
                action("HR Employee List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Employee List';

                    RunObject = Page "HR Employee List";
                }

                action("HR Employee List(Inactive)")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Employee InActive';

                    RunObject = Page "Inactive Employees";
                }

            }
            group(Forms)
            {
                action("Exit form")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Exit Interview Form';
                    RunObject = page 80200;
                }
                action("clearance Form")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Clearance Form';
                    RunObject = page 80182;
                }
                action("appraisal Form")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appraisal Form';
                    RunObject = page 50011;
                }
            }
            group("Leave Management")
            {


                action("HR Leave Periods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Leave Periods';

                    RunObject = Page "HR Leave Period";
                }
                action("HR Leave Types")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Leave Types';

                    RunObject = Page "HR Leave Types";
                }


                action("New HR Leave Applications List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New HR Leave Application';

                    RunObject = Page "HR Leave Applications List";
                    RunPageView = order(ascending) where(Status = filter('New'));
                }
                action("Pending HR Leave Applications List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending HR Leave Application';

                    RunObject = Page "HR Leave Applications List";
                    RunPageView = order(ascending) where(Status = filter('Pending Approval'));
                }
                action("Posted HR Leave Applications List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted HR Leave Application';

                    RunObject = Page "HR Leave Applications List";
                    RunPageView = order(ascending) where(Status = filter('Posted'));
                }
                action("HR Leave Journal Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Leave Journal Lines';

                    RunObject = Page "HR Leave Journal Lines";
                }
                action("Leave Balances")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Leave Balances';

                    RunObject = report "HR Leave Balance Report";
                }




            }

            group("Performance Management")
            {
                action("Appraisal List")
                {
                    Caption = 'Target Setting List(Appraisee)';
                    ApplicationArea = basic, suite;

                    RunObject = page "Appraissal List";
                    RunPageLink = "Appraisal Status" = filter(Appraisee);
                }
                action("Supervisor Appraisal List")
                {

                    ApplicationArea = All;
                    RunObject = page "Appraissal List";
                    RunPageLink = "Appraisal Stage" = filter("Target Approval");
                    Caption = 'Target Setting Approval(Supervisor)';

                }
                action("Appraisee's Evaluation List")
                {
                    ApplicationArea = All;
                    RunObject = page "Appraissal List";
                    RunPageLink = "Appraisal Stage" = filter("End Year Evaluation");
                    Caption = 'Appraisee Evaluation List';

                }
                action("Supervisor Evaluation List")
                {
                    ApplicationArea = All;
                    RunObject = page "Appraissal List";
                    RunPageLink = "Appraisal Stage" = filter("Supervisor Evaluation");
                    Caption = 'Supervisor Evaluation List';

                }

                action("HR Completed Appraisal List")
                {
                    ApplicationArea = All;
                    RunObject = page "Appraissal List";
                    RunPageLink = "Appraisal Stage" = filter("Appraisal Completed");
                    Caption = 'HR Completed Appraisal List';

                }



            }

            group(Recruitment)
            {
                action("Employee Requisition")
                {
                    Caption = 'Employee Requisition';
                    ApplicationArea = basic, suite;
                    Image = Employee;
                    RunObject = page "HR Employee Requisitions List";
                }
                action("Job Application")
                {
                    Caption = 'Job Application';
                    ApplicationArea = basic, suite;
                    Image = Employee;
                    RunObject = page "HR Job Applications List";
                }
                action("Short Listed")
                {
                    Caption = 'Short Listed';
                    ApplicationArea = basic, suite;
                    Image = Employee;
                    RunObject = page "HR Shortlisting List";
                }
                action("Qualified")
                {
                    Caption = 'Qualified Listed';
                    ApplicationArea = basic, suite;
                    Image = Employee;
                    RunObject = page "HR Job Applicants Qualified";
                }
                action("Un-Qualified")
                {
                    Caption = 'Un-Qualified Listed';
                    ApplicationArea = basic, suite;
                    Image = Employee;
                    RunObject = page "HR Applicants UnQualified List";
                }
            }



            group("Hr Setup")
            {
                action("HR Setups")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Setups';

                    RunObject = Page "HR Setup";
                }
                action("Performance Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appraisal Setups';

                    RunObject = Page Perfomacesetup;
                }
                action("Appraisal Period")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appraisal Period';

                    RunObject = Page "Appraisal Periods";
                }
                action("HR Leave journal Template")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Leave Journal Template';

                    RunObject = Page "HR Leave journal Template";
                }
                action("HR Lookup Values List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Lookup Values List';

                    RunObject = page "HR Lookup Values List";
                }
                action("Bank Codes List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Codes List';

                    RunObject = page "Bank Codes Listing";
                }
                action("Base calendar")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Base Calendar';

                    RunObject = page "Base Calendar List";
                }





            }
            group(MEL)
            {
                action("Project Evaluation")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Monitoring & Evaluation";
                }
                action("Project Budget")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Project Budget Card";
                }
            }
            group(Timesheets)
            {
                action("New Timesheet Entries2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Timesheet ';

                    RunObject = Page "Timesheet header2";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }//TimeSheetsC
                action("New Timesheet EntriesSub")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send Awaiting Approval Timesheets';
                    Visible = false;
                    RunObject = Page "Timesheet header Await";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("New Timesheet Entries Proj")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Line Manager Approval Timesheets';

                    RunObject = Page "Timesheet header Project";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("New Timesheet EntriesLine")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending SMT Lead Approval Timesheets';

                    RunObject = Page "Timesheet header Line Manager";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("New Timesheet EntriesSMT")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SMT Lead Approved Timesheets';
                    Visible = false;
                    RunObject = Page "Timesheet header SMT Lead";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("New Timesheet EntriesHR")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Approved Timesheets';
                    Visible = false;

                    RunObject = Page "Timesheet header HR Approved";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("New Timesheet EntriesApprov")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Timesheets';

                    RunObject = Page "Timesheet header Approved";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("Detailed Timesheet Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Timesheet-personel';

                    RunObject = report "TimesheetReport Detail";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("Timesheet Activity Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Timesheets  activity report';
                    RunObject = report "Timesheet Activity Report";
                    // RunObject = report "TimeSheet Report Summary";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("Timesheet Summary Report 2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Timesheet Status summary';
                    //Visible=false;
                    RunObject = report "TimesheetReport Summary";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("Timesheets Monthly")
                {
                    Caption = 'Timesheet summary';
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Timesheet Monthly Summary";
                }
                action("Timesheets SMT")
                {
                    Caption = 'Timesheet summary SMT Lead';
                    ApplicationArea = Basic, Suite;
                    RunObject = report "TimesheetReport SMT LEAD";
                }

                action("Timesheets Line Manager")
                {
                    Caption = 'Timesheet summary Line Manage';
                    ApplicationArea = Basic, Suite;
                    RunObject = report "TimesheetReport Line M";
                }
                action("update Timesheets")
                {
                    ApplicationArea = Basic, Siuite;
                    Visible = false;
                    RunObject = report "Update Timesheet status";
                }
            }
            group("Contracts")
            {
                action("Initiated contract list ")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Contracts';

                    RunObject = Page "contract list";
                    RunPageLink = Status = filter(<> Expired);
                }

                action("Expired contract list")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Expired Contracts';

                    RunObject = Page "contract list";
                    RunPageLink = Status = filter(Expired);
                }

            }





        }
    }


}
