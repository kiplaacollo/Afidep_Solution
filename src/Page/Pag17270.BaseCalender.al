page 17270 "Base Calender"
{
    ApplicationArea = All;
    Caption = 'Base Calender';
    PageType = List;
    SourceTable = "Base Calendar Change";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(General)
            {


                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date to change associated with the base calendar in this entry.';

                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date to change associated with the base calendar in this entry.';
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the day of the week associated with this change entry.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the change in this entry.';
                }
                field(Nonworking; Rec.Nonworking)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the date entry was defined as a nonworking day when the base calendar was set up.';
                }
                field("Date Day"; Rec."Date Day")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the date entry was defined as a nonworking day when the base calendar was set up.';
                }
                field("Date Month"; Rec."Date Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the month entry was defined as a nonworking day when the base calendar was set up.';
                }
                field("Recurring System"; Rec."Recurring System")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the Anual recuring day  based on  calendar was set up.';
                }
            }
        }
    }
}
