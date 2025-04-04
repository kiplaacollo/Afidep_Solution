page 17292 "Vehicle List"
{
    ApplicationArea = All;
    Caption = 'Vehicle List';
    PageType = List;
    SourceTable = Vehicles;
    UsageCategory = Lists;
    CardPageId = "Vehicle Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Registration No"; Rec."Registration No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registration No field.';
                }
            
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Make  field.';
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Model field.';
                }
                field(Color; Rec.Color)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Color field.';
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year  field.';
                }
                field("Fixed Asset No"; Rec."Fixed Asset No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the  Fixed Asset No field.';
                }
                field("Log Book No"; Rec."Log Book No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Log Book No field.';
                }
                field(Passagers; Rec.Passagers)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Passagers field.';
                }
            }
        }
    }
}
