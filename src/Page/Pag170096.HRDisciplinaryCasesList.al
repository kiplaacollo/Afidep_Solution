Page 170096 "HR Disciplinary Cases List"
{
    Caption = 'Employee Disciplinary Cases ';
    CardPageID = "HR Disciplinary Case Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = all;
    PromotedActionCategories = 'New,Process,Reports,Functions,Case Status,Show';
    SourceTable = "HR Disciplinary Cases NCA";
    SourceTableView = where("Disciplinary Stage Status" = filter(<> Closed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("Type of Complaint"; Rec."Type of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(Reporter; Rec.Reporter)
                {
                    ApplicationArea = Basic;
                }
                field("Accused Employee"; Rec."Accused Employee")
                {
                    ApplicationArea = Basic;
                }
                field("Description of Complaint"; Rec."Description of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Stage Status"; Rec."Disciplinary Stage Status")
                {
                    ApplicationArea = Basic;
                    Style = StandardAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755006; "HR Disciplinary Cases Factbox")
            {
                Caption = 'HR Disciplinary Cases Factbox';
                SubPageLink = "Case Number" = field("Case Number");
            }
            systempart(Control1102755009; Outlook)
            {
            }
        }
    }

    actions
    {
    }

    var
        AppMgmt: Codeunit "Approvals Mgmt.";
        "Document Type": Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Leave Journal","Medical Claims","Activity Approval","Disciplinary Approvals";
}

