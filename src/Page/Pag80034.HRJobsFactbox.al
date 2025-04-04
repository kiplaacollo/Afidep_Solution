Page 80034 "HR Jobs Factbox"
{
    PageType = ListPart;
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            field("Job ID"; Rec."Job ID")
            {
                ApplicationArea = Basic;
            }
            field("Job Description"; Rec."Job Description")
            {
                ApplicationArea = Basic;
            }
            field("No of Posts"; Rec."No of Posts")
            {
                ApplicationArea = Basic;
            }
            field("Position Reporting to"; Rec."Position Reporting to")
            {
                ApplicationArea = Basic;
            }
            field("Occupied Positions"; Rec."Occupied Positions")
            {
                ApplicationArea = Basic;
            }
            field("Vacant Positions"; Rec."Vacant Positions")
            {
                ApplicationArea = Basic;
            }
            field(Category; Rec.Category)
            {
                ApplicationArea = Basic;
            }
            field(Grade; Rec.Grade)
            {
                ApplicationArea = Basic;
            }
            field("Employee Requisitions"; Rec."Employee Requisitions")
            {
                ApplicationArea = Basic;
            }
            field("Supervisor Name"; Rec."Supervisor Name")
            {
                ApplicationArea = Basic;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = Basic;
            }
            field("Date Created"; Rec."Date Created")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.Validate("Vacant Positions");
    end;
}

