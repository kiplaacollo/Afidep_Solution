page 17380 "Project Indicators"
{
    ApplicationArea = All;
    Caption = 'Project Indicators';
    PageType = ListPart;
    SourceTable ="Performance Indica Project";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Key Output"; Rec."Key Output")
                {
                    ToolTip = 'Specifies the value of the Key Output field.';
                    MultiLine = true;
                }
                field("Key Performance Indicators"; Rec."Key Performance Indicators")
                {
                    ToolTip = 'Specifies the value of the Key Performance Indicators field.';
                    MultiLine = true;
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}
