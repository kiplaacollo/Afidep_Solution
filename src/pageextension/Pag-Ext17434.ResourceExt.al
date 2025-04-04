pageextension 17434 "Resource Ext" extends "Resource Card"
{
    layout
    {

    }
    actions
    {
        modify(CreateTimeSheets)
        {
            Visible = false;
        }
        addafter(CreateTimeSheets)
        {

            action(CreateTimeSheetsee)
            {
                ApplicationArea = Jobs;
                Caption = 'Create Time Sheets Header';
                Ellipsis = true;
                Image = NewTimesheet;
                ToolTip = 'Create new time sheets for the resource.';

                trigger OnAction()
                var
                    Resource: Record Resource;
                    IsHandled: Boolean;
                begin

                    Rec.TestField("Use Time Sheet", true);
                    Resource.Get(Rec."No.");
                    Resource.SetRecFilter();
                    REPORT.RunModal(REPORT::"Create Time Sheets - AFIDEP", true, false, Resource);
                end;//50080
            }
            action(CreateTimeSheetsr)
            {
                ApplicationArea = Jobs;
                Caption = 'Create Time Sheets Header';
                Ellipsis = true;
                Image = NewTimesheet;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Create new time sheets for the resource.';

                trigger OnAction()
                var
                    Resource: Record Resource;
                    IsHandled: Boolean;
                begin

                    Rec.TestField("Use Time Sheet", true);
                    Resource.Get(Rec."No.");
                    Resource.SetRecFilter();
                    REPORT.RunModal(REPORT::"Create Time Sheets - AFIDEP", true, false, Resource);
                end;//50080
            }
        }
    }
}
