pageextension 172246 ExtendsionSRolecenter extends "Sales & Relationship Mgr. RC"
{

    actions
    {

        addafter(Analysis)
        {

            group(ResourceMobilization)
            {

                Caption = 'Resource mobilization';


                action("Contacts ")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contacts';

                    RunObject = Page "Contact List";
                    //RunPageLink = Status = filter(Open);
                    //RunPageView = where (Status = filter(New));
                }
                action("Meeting tracker")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Meeting tracker';

                    RunObject = Page "Meeting tacker ";
                    //RunPageLink = Status = filter(Open);
                    //RunPageView = where (Status = filter(New));
                }

                action("Engagements planner")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Engagements planner';

                    RunObject = Page "Engagements Planner";
                    //RunPageLink = Status = filter(Open);
                    //RunPageView = where (Status = filter(New));
                }

                action("Go no go decision tool ")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Go no go decision tool';

                    RunObject = Page "Gonogo decision";
                    //RunPageLink = Status = filter(Open);
                    //RunPageView = where (Status = filter(New));
                }

                action("Proposal development tracker")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Proposal development tracker';

                    RunObject = Page "Proposal development tracker";
                    //RunPageLink = Status = filter(Open);
                    //RunPageView = where (Status = filter(New));
                }

                action("Resource mobilization No. series setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Resource mobilization No. series setup';

                    RunObject = Page "Resource mobilization setup";
                    //RunPageLink = Status = filter(Open);
                    //RunPageView = where (Status = filter(New));
                }
            }

        }
    }
}
