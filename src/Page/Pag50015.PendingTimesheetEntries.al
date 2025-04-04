Page 50015 "Pending Timesheet Entries"
{
    PageType = List;
    SourceTable = "TE Time Sheet1";
    SourceTableView = where(Status = const(ApprovalPending));
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Hours; Rec.Hours)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approve)
            {
                ApplicationArea = Basic;
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to approve') then begin
                        repeat
                            Rec.Status := Rec.Status::Approved;
                            Rec.Modify;
                        until Rec.Next = 0;
                    end;
                end;
            }
            action("Staff Project Hours")
            {
                ApplicationArea = Basic;
                Image = Receipt;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Staff Project Hours";
            }
            action("TimeSheet Report")
            {
                ApplicationArea = Basic;
                Image = Receipt;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "TimeSheet Report";
            }
            action("TimeSheet Report Summary")
            {
                ApplicationArea = Basic;
                Image = Receipt;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "TimeSheet Report Summary";
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*IF HREmployees.GET("Employee No") THEN BEGIN
          "Employee Name":=HREmployees.FullName;
          MODIFY;
          END;*/

    end;

    var
        HREmployees: Record "HR Employees";
}

