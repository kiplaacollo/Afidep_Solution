page 17317 "Key value drivers"
{
    ApplicationArea = All;
    Caption = 'Key value drivers';
    PageType = List;
    SourceTable = "Key Value Drivers";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Key Value Driver"; Rec."Key Value Driver")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Key Value Driver field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }

            }
        }
    }
}
