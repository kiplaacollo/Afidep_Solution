page 17454 "Timesheet header Line Manager"
{
    ApplicationArea = All;
    Caption = 'Timesheet header Pending SMT Lead Approval';
    PageType = List;
    SourceTable = "Timesheet Header";
    SourceTableView = where("Timesheet Status" = filter("Line Manager Approved"));
    CardPageId = "Timesheet Header Card";
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Timesheet Header No"; Rec."Timesheet Header No")
                {
                    ToolTip = 'Specifies the value of the Timesheet Header No field.';
                }
                field("Staff No"; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = basic, Suite;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // timsht.Reset();
        // timsht.SetRange(timsht."Timesheet No", Rec."Timesheet Header No");

        // if timsht.FindSet() then begin
        //     repeat
        //         if (Rec."Timesheet Status" <> timsht."Timesheet Status") then begin
        //             timsht."Timesheet Status" := Rec."Timesheet Status";
        //             timsht.Modify(true);
        //         end;
        //     until timsht.Next() = 0;
        //     Commit();
        // end;
    end;





    trigger OnOpenPage()
    var

    begin

        // timsht.Reset;
        // timsht.SetRange(timsht."Timesheet No", Rec."Timesheet Header No");
        // if timsht.Find('-') then
        //     if timsht."Timesheet No" <> '' then begin
        //         repeat
        //         // timsht."Date Submitted" := DT2Date(Rec.SystemCreatedAt);
        //         // timsht."Line Manager Approved Date" := DT2Date(timsht.SystemModifiedAt);
        //         // timsht."SMT Lead Approve date" := DT2Date(timsht.SystemModifiedAt);
        //         // timsht."Approver ID" := Rec."SMT Lead";

        //         until timsht.Next() = 0;

        //         timsht.Modify(true);
        //     end;

    end;

    var
        timsht: Record "Timesheet Lines";
}
