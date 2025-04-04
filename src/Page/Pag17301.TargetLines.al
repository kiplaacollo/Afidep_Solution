page 17316 "Target Lines"
{
    Caption = 'Target Lines';
    PageType = Card;
    SourceTable = "Target Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';

                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period field.';
                }
                field("Key Value Drivers"; Rec."Key Value Drivers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Key Value Drivers field.';
                }
                field("Key Performance Indicator"; Rec."Key Performance Indicator")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Key Performance Indicator field.';
                }

                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Weight field.';
                }

                field(Target; Rec.Target)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target field.';
                }
                field("Target Header"; Rec."Target Header")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target Header field.';
                }
                field("Target Score"; Rec."Target Score")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target Score field.';
                }

            }
        }
    }
}
