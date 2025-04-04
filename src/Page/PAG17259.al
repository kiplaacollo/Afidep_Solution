page 17259 "Award Notification"
{
    PageType = ListPart;
    SourceTable = 170081;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Notification Code"; Rec."Notification Code")
                {
                    Caption = 'Deliverable Name';
                }
                field(Type; Rec.Type)
                {

                }
                field("Notification Header"; Rec."Notification Header")
                {
                    Caption = 'Email Header e.g Financial Report';
                }
                field("Notification Body"; Rec."Notification Body")
                {
                }
                field(Deadline; Rec.Deadline)
                {
                }
                field("Notify (Days before Deadline)"; Rec."Notify (Days before Deadline)")
                {
                    Caption = '1st  Notification (Days before Deadline)';
                }
                field("Notify2 (Days before Deadline)"; Rec."Notify2 (Days before Deadline)")
                {
                    Caption = '2nd  Notification (Days before Deadline)';
                }
                field("Notify3 (Days before Deadline)"; Rec."Notify3 (Days before Deadline)")
                {
                    Caption = 'Final Notification (Days before Deadline)';
                }
                field(Status; Rec.Status)
                {

                }
                field("Date Submitted"; Rec."Date Submitted")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Notification Users")
            {
                Caption = 'Notification Users';
                Image = Employee;
                RunObject = Page 17266;
                Visible = false;
            }
            action(Attachments)
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page Documents;
                RunPageLink = "Doc No." = field("Award No");
            }
        }
    }
}

