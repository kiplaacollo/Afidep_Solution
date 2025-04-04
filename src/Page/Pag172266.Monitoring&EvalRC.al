page 172266 "Monitoring & Eval. RC"
{
    ApplicationArea = All;
    Caption = 'Monitoring & Eval. RC';
    PageType = RoleCenter;
    //
    Editable = false;
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

            group("Fleet Management")
            {
                Visible = false;

                action("Drivers List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diver Management';
                    Visible = false;
                    RunPageMode = view;
                    RunObject = Page "Drivers List";
                }

                action("Vehicle List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vehicle Management';
                    RunPageMode = view;
                    RunObject = Page "Vehicle List";
                }
                group("Vehicle Requisition")
                {
                    action("Vehicle Requestion")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vehicle Requisition Open ';
                        RunPageMode = view;
                        RunObject = Page "Vehicle Requisition List";

                    }
                    action("Vehicle Requestion Pending")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vehicle Requisition Pending Approval';
                        RunPageMode = view;
                        RunObject = Page "Vehicle Requisition Pending";

                    }
                    action("Vehicle Requestion Approved")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vehicle Requisitions Approved';
                        RunPageMode = view;
                        RunObject = Page "Vehicle Requsition Approved";

                    }

                }

            }


            group("Monitoring & Eval. RC")
            {
                Visible = true;
                action("Monitoring & Evaluation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Monitoring & Evaluation';
                    RunPageMode = view;
                    RunObject = Page "Monitoring & Evaluation";
                    // RunPageLink = Status = filter(<> Expired);
                    // Visible = false;
                }

                action("Expired contract list")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Expired Contracts';
                    RunPageMode = view;
                    RunObject = Page "contract list";
                    RunPageLink = Status = filter(Expired);
                    Visible = false;
                }

            }


            group("Proposal development")
            {
                Caption = 'Proposal Development';
                Image = Purchasing;
                Visible = false;
                // ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(Proposaldevelopment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Proposal Development (New)';

                    RunPageMode = view;
                    RunObject = Page "Proposal development tracker";
                    RunPageView = order(ascending) where(Status = filter(New));

                }
                action("Pendingproposaldevelopment")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Proposal Development (Pending)';

                    RunPageMode = view;
                    RunObject = Page "Proposal development tracker";
                    RunPageView = order(ascending) where(Status = filter("Pending approval"));
                }
                action("Approved Proposal development ")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Proposal Development (Approved)';

                    RunPageMode = view;
                    RunObject = Page "Proposal development tracker";
                    RunPageView = order(ascending) where(Status = filter(approved));
                }

            }



            group("Project management ")
            {
                action("Donors")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Donors List';

                    RunObject = Page 560;
                    RunPageLink = "Dimension Code" = filter('DONOR');
                }

                action("Active projects")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Projects';
                    RunPageMode = view;
                    RunObject = Page "Award List";
                    RunPageLink = Blocked = filter(<> Closed);
                }

                action("Active Project Management")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Project Management';
                    RunPageMode = view;
                    RunObject = Page "Project Tracker List";
                    RunPageLink = Blocked = filter(<> Closed);
                    Visible = false;
                }



                action("Closed project")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Closed Projects';
                    RunPageMode = view;
                    RunObject = Page "Award List";
                    RunPageLink = Blocked = filter(Closed);
                    Visible = false;
                }

            }




        }
    }


}
profile "Afidep Monitoring Role Center"
{
    RoleCenter = "Monitoring & Eval. RC";
    Caption = 'Afidep Monitoring & Eval. Role Center';
    //ProfileDescription = 'Procurement profile for non payroll processing  users ';
}