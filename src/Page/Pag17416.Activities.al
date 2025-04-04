page 17416 "Timesheet Activities"
{
    ApplicationArea = All;
    Caption = 'Timesheet Activities';
    PageType = List;
    SourceTable = Activities;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Workplan Code"; Rec."Workplan Code") { }
                field("Activity Code"; Rec."Activity Code") { }
                field("Activity Description"; Rec."Activity Description") { }
            }
        }
    }
}
