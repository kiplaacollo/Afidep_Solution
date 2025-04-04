Page 80037 "HR Job Responsibilities"
{
    Caption = 'HR Job Responsibilities';
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Qualification';
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Job Details';
                field("Job ID";Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Job Description";Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Position Reporting to";Rec."Position Reporting to")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Supervisor Name";Rec."Supervisor Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("No of Posts";Rec."No of Posts")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Occupied Positions";Rec."Occupied Positions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Vacant Positions";Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Employee Requisitions";Rec."Employee Requisitions")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1102755008;"HR Job Responsiblities Lines")
            {
                Caption = 'Job Responsibilities';
                SubPageLink = "Job ID"=field("Job ID");
            }
        }
        area(factboxes)
        {
            systempart(Control1102755013;Outlook)
            {
            }
        }
    }

    actions
    {
    }

    var
        HRJobResponsibilities: Record "HR Job Responsiblities";
}

