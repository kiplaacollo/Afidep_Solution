page 172255 "Resource mobilization RC"
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
            group(Contacts_)
            {
                Caption = 'Contacts';
                Image = AdministrationSalesPurchases;

                action(Persons)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Persons ';


                    RunObject = Page "Contact List";
                    RunPageView = order(ascending) where(Type = const("Contact Type"::Person));
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }


                action(Organisations)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Organisations';


                    RunObject = Page "Contact List";
                    RunPageView = order(ascending) where(Type = const("Contact Type"::Company));
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action(Opportunities)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Opportunities';


                    RunObject = Page "Opportunity List";
                    // RunPageView = order(ascending) where(Type = const("Contact Type"::Company));
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
            }


            group("Conferences+Events Map_")
            {
                Caption = 'Events';
                Image = CostAccounting;
                //ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("Conferences+Events Map")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Events';


                    RunObject = Page "Confernces";
                }

            }

            group("Meetings tracker")
            {
                Caption = 'Meetings';
                Visible = false;
                Image = CostAccounting;
                //ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action("Meeting tracket")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Meetings';


                    RunObject = Page "Meeting tacker ";
                }
                action("Meeting tracker")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Converted Meetings';


                    RunObject = Page "Converted Meeting tacker";
                }

            }

            group("Engagements planner")
            {
                Caption = 'Engagements';
                Image = Purchasing;
                // ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(EngagementPlan)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Engagements (New)';


                    RunObject = Page "engagements planner";
                    RunPageView = order(ascending) where(Converted = const(false));
                }
                action("Converted Engagement plans")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Engagements (Converted)';


                    RunObject = Page "Engagements Planner";
                    RunPageView = order(ascending) where(Converted = const(true));
                }


            }

            group("Gonogodecision")
            {
                Caption = 'Go-No-Go Decision';
                Image = Purchasing;
                // ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(gonogo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Go-No-Go Decision (New)';


                    RunObject = Page "Gonogo decision";
                    RunPageView = order(ascending) where(Converted = const(false), Decision = filter(Open));

                }
                action("Pending Approval")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Go-No-Go Decision';


                    RunObject = Page "Gonogo decision";
                    RunPageView = order(ascending) where(Converted = const(false), Decision = filter("Pending approval"));

                }
                action("Go decisions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = ' Go-No-Go Decision (Go)';


                    RunObject = Page "Gonogo decision";
                    RunPageView = order(ascending) where(Converted = const(false), Decision = filter(Go));
                }
                action("Converted Go no go decisions")
                {

                    ApplicationArea = Basic, Suite;
                    Caption = ' Go-No-Go Decision (Converted)';


                    RunObject = Page "Gonogo decision";
                    RunPageView = order(ascending) where(Converted = const(true));
                }
                action("Nogodecision")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = ' Go-No-Go Decision (No-go)';


                    RunObject = Page "Gonogo decision";
                    RunPageView = order(ascending) where(Converted = const(false), Decision = filter("No-go"));
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
            group("Resource Mobilization Setup")
            {
                action(Setup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Resource Mobilization Setup';
                    RunObject = page "Resource mobilization setup";
                }
            }
            group("Grants management ")
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
