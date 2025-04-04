page 17268 "Education Intitutions"
{
    ApplicationArea = All;
    Caption = 'Education Intitutions';
    PageType = List;
    SourceTable = "Education Institution";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Institution Code"; Rec."Institution Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Institution Code field.';
                }
                field("Institution Name"; Rec."Institution Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Institution Name field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
            }
        }
    }
}
