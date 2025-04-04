page 172243 "Staff "
{
    ApplicationArea = All;
    Caption = 'Staff ';
    PageType = ListPart;
    SourceTable = StaffMeetingTracker;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Staff code"; Rec."Staff code")
                {

                    ToolTip = 'Specifies the value of the Staff code field.';
                    TableRelation = "HR Employees"."No.";
                    trigger OnValidate()
                    var
                        emp: Record "HR Employees";
                    begin
                        emp.get(Rec."Staff code");
                        Rec."Staff name" := emp."First Name" + ' ' + emp."Last Name";
                    end;

                }
                field("Staff name"; Rec."Staff name")
                {
                    ToolTip = 'Specifies the value of the Staff name field.';
                }
            }
        }
    }
}
