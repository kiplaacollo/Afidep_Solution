page 172259 "Senior Managemnt RC"
{

    Caption = 'Senior Management RC', Comment = '{Dependency=Match,"Resource mobilization"}';
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
            part(Control55; "Help And Chart Wrapper")
            {
                //AccessByPermission = TableData UnknownTableData1803=I;
                ApplicationArea = Basic, Suite;
                Caption = '';
                ToolTip = 'Specifies the view of your business assistance';
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
            group(Timesheets)
            {
                Caption = 'Timesheets';
                Image = CostAccounting;
              

                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("New Timesheet Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Timesheet Entries';

                    RunObject = Page "New Timesheet Entries";
                    RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }

                action("New Timesheet Entries2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Timesheet ';

                    RunObject = Page "Time Sheet";
                    //RunPageLink = Status = filter(Open);//
                    //RunPageView = where (Status = filter(New));
                }
                action("Pending Timesheet Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Timesheet Entries';
                    RunObject = Page "New Timesheet Entries";
                   // RunPageLink = Status = filter("Pending Approval");

                    //RunObject = Page "Pending Timesheet Entries";
                }
                action("Approved Timesheet Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Timesheet Entries';
                    RunObject = Page "New Timesheet Entries";
                    RunPageLink = Status = filter(Approved);

                    //RunObject = Page "Approved Timesheet Entries";
                }
                action("Timesheet Activities")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Timesheet Activities';
                    RunObject = Page "Timesheet Activities";

                }
                action("Timesheet Workplan")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Timesheet Workplans';
                    RunObject = Page Workplans;

                }
            }


            group("Fleet Management")
            {
                action("Drivers List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diver Management';

                    RunObject = Page "Drivers List";
                }

                action("Vehicle List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vehicle Management';

                    RunObject = Page "Vehicle List";
                }
                group("Vehicle Requisition")
                {
                    action("Vehicle Requestion")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vehicle Requisition Open ';

                        RunObject = Page "Vehicle Requisition List";

                    }
                    action("Vehicle Requestion Pending")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vehicle Requisition Pending Approval';

                        RunObject = Page "Vehicle Requisition Pending";

                    }
                    action("Vehicle Requestion Approved")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vehicle Requisitions Approved';

                        RunObject = Page "Vehicle Requsition Approved";

                    }

                }

            }




        }
    }


}
