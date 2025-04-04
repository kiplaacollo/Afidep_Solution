Page 80087 "HR Setups"
{
    Editable = false;
    PageType = List;
    SourceTable = "HR Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Nos.";Rec."Employee Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Application Nos.";Rec."Leave Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Base Calendar";Rec."Base Calendar")
                {
                    ApplicationArea = Basic;
                }
                field("Timesheet No";Rec."Timesheet No")
                {
                    
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("HR SETUP")
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Setup";
                }
                action("Notice Board")
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = AddWatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Notice Board";
                }
                action("Badge of Appreciation")
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = Alerts;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Badge of Appreciation";
                }
                action("HR Documents")
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = DocumentEdit;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Documents";
                }
                action("Diarized Dates")
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = DueDate;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Chart of Cost Types";
                }
                action("HR Leave Types")
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = DueDate;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Leave Types";
                }
            }
        }
    }
}

