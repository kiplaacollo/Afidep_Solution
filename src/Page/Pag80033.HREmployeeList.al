Page 80033 "HR Employee List"
{
    CardPageID = "HR Employee Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Employee';
    SourceTable = "HR Employees";
    SourceTableView = where(Status = filter(Active));
    DeleteAllowed = false;
    ModifyAllowed = true;
    InsertAllowed = true;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Employee UserID"; Rec."Employee UserID")
                {
                    ApplicationArea = Basic;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(Travelaccountno; Rec.Travelaccountno)
                {
                    ApplicationArea = Basic;
                    Caption = 'Imprest Account No';
                }
                field("Portal Password"; Rec."Portal Password")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HR Employees Factbox")
            {
                SubPageLink = "No." = field("No.");
            }
            systempart(Control1102755003; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Employee)
            {
                Caption = 'Employee';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Card";
                    RunPageLink = "No." = field("No.");
                }
                action("Kin/Beneficiaries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Kin/Beneficiaries';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = field("No.");
                }
                action("Assigned Assets")
                {
                    ApplicationArea = Basic;
                    Caption = 'Assigned Assets';
                    Image = ResourceJournal;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Fixed Asset List";
                    RunPageLink = "Responsible Employee" = field("No.");
                }
                action("HR Leave Allocation")
                {
                    ApplicationArea = Basic;
                    Caption = 'HR Leave Allocation';
                    Image = ChangeDates;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Report "HR Leave Adjustment";
                }
                action("HR Leave Journal Lines")
                {
                    ApplicationArea = Basic;
                    Caption = 'HR Leave Journal Lines';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "HR Leave Journal Lines";
                }
                action("HR Job Vacancy Report")
                {
                    ApplicationArea = Basic;
                    Caption = 'HR Job Vacancy Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "HR Job Vacancy Report";
                }
                action("HR Employee List")
                {
                    ApplicationArea = Basic;
                    Caption = 'HR Employee List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "HR Employee List";
                }
                action("HR Employee PIF")
                {
                    ApplicationArea = Basic;
                    Caption = 'HR Employee PIF';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "HR Employee PIF";
                }
                action(" HR Leave Applications ")
                {
                    ApplicationArea = Basic;
                    Caption = ' HR Leave Applications ';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "HR Leave Applications List";
                }
                action("HR Leave Liability Report")
                {
                    ApplicationArea = Basic;
                    Caption = 'HR Leave Liability Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "HR Leave Balance Report";
                }
                action("Leave Planner")
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Planner';
                    Image = ResourceJournal;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Leave Planner";
                }
                action("Timesheet List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Timesheet List';
                    Image = ResourceJournal;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Timesheet List";
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        /*HREmp.RESET;
        HREmp.SETRANGE(HREmp."User ID",USERID);
        IF HREmp.GET THEN*/
        //SETRANGE("User ID",USERID)
        //ELSE
        //user id may not be the creator of the doc
        //rec.SETRANGE(rec."Employee UserID", USERID);

        // HREmp.Reset();
        // HREmp.SetRange("No.", Rec."No.");
        // if HREmp.Find('-') then begin
        //     HREmp."Company E-Mail" := LowerCase(Rec."Company E-Mail");
        //     HREmp."E-Mail" := LowerCase(Rec."E-Mail");
        //     HREmp.Modify(true);
        // end;

    end;

    trigger OnAfterGetRecord()
    begin
        HREmp.Reset();
        HREmp.SetRange("No.", Rec."No.");
        if HREmp.Find('-') then begin
            HREmp."Company E-Mail" := LowerCase(Rec."Company E-Mail");
            HREmp."E-Mail" := LowerCase(Rec."E-Mail");
            HREmp.Modify(true);
        end;
    end;

    var
        HREmp: Record "HR Employees";
        EmployeeFullName: Text;
}

