page 172261 "Projects and administration RC"
{

    Caption = 'Projects and administration RC', Comment = '{Dependency=Match,"Projects and administration RC"}';
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

            group("Fleet Management")
            {
                Visible = false;
                action("Drivers List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diver Management';
                    Visible = false;
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


            group("Proposal development")
            {
                Caption = 'Proposal Development';
                Image = Purchasing;
                // ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(Proposaldevelopment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Proposal Development (New)';


                    RunObject = Page "Proposal development tracker";
                    RunPageView = order(ascending) where(Status = filter(New));

                }
                action("Pendingproposaldevelopment")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Proposal Development (Pending)';


                    RunObject = Page "Proposal development tracker";
                    RunPageView = order(ascending) where(Status = filter("Pending approval"));
                }
                action("Approved Proposal development ")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Proposal Development (Approved)';


                    RunObject = Page "Proposal development tracker";
                    RunPageView = order(ascending) where(Status = filter(approved));
                }

            }



            group("Grants Management ")
            {
                 action("Donors")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Donors List';

                    RunObject = Page 560;
                    RunPageLink = "Dimension Code" = filter('DONOR');
                }
                action("Donor Claim Report G")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Donor Claim Report';

                    RunObject = report "Donor Claim";
                }

                action("Active projects")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Projects';

                    RunObject = Page "Award List";
                    RunPageLink = Blocked = filter(<> Closed);
                }



                action("Closed projects")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Closed Projects';

                    RunObject = Page "Award List";
                    RunPageLink = Blocked = filter(Closed);
                }

            }




        }
    }


}
