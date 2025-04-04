Page 80053 "HR Employees Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            field(PersonalDetails; PersonalDetails)
            {
                ApplicationArea = Basic;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("No."; Rec."No.")
            {
                ApplicationArea = Basic;
            }
            field("First Name"; Rec."First Name")
            {
                ApplicationArea = Basic;
            }
            field("Middle Name"; Rec."Middle Name")
            {
                ApplicationArea = Basic;
            }
            field("Last Name"; Rec."Last Name")
            {
                ApplicationArea = Basic;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = Basic;
            }
            field("Company E-Mail"; Rec."Company E-Mail")
            {
                ApplicationArea = Basic;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
            field(JobDetails; JobDetails)
            {
                ApplicationArea = Basic;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("Job Title"; Rec."Job Title")
            {
                ApplicationArea = Basic;
            }
            field(Grade; Rec.Grade)
            {
                ApplicationArea = Basic;
            }
            field(LeaveDetails; LeaveDetails)
            {
                ApplicationArea = Basic;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("Annual Leave Account"; Rec."Annual Leave Account")
            {
                ApplicationArea = Basic;
            }
            field("Compassionate Leave Acc."; Rec."Compassionate Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Maternity Leave Acc."; Rec."Maternity Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Paternity Leave Acc."; Rec."Paternity Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Sick Leave Acc."; Rec."Sick Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Study Leave Acc"; Rec."Study Leave Acc")
            {
                ApplicationArea = Basic;
                Caption = 'Adoption Leave';
            }
            field("CTO  Leave Acc."; Rec."CTO  Leave Acc.")
            {
                ApplicationArea = Basic;
                Caption = 'Compensatory Leave';
            }
            field("Special  Leave Acc."; Rec."Special  Leave Acc.")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }

    var
        PersonalDetails: label 'Personal Details';
        BankDetails: label 'Bank Details';
        JobDetails: label 'Job Details';
        LeaveDetails: label 'Leave Details';
}

