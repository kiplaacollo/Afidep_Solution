page 17303 "Key Performance Indicator"
{
    ApplicationArea = All;
    Caption = 'Key Performance Indicator';
    PageType = List;
    SourceTable = "Key Performance Indicators";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Indicator; Rec.Indicator)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Indicator field.';
                }
                field("Key Value Drivers"; Rec."Key Value Drivers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Key Value Drivers field.';
                }
                field(Activity; Rec.Activity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity field.';
                }

                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Frequency field.';
                }

                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period field.';
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Weight field.';
                }
                field("Completion Date"; Rec."Completion Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion Date field.';
                }
            }
        }
    }
}
