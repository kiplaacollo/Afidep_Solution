page 172262 Confernces
{
    ApplicationArea = All;
    Caption = 'Confernces';
    CardPageId = 172263;
    PageType = List;
    SourceTable = Conferences;
    UsageCategory = Lists;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Conference; Rec.Conference)
                {
                    ToolTip = 'Specifies the value of the Conference field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Where"; Rec."Where")
                {
                    ToolTip = 'Specifies the value of the Where field.';
                }
                field("Focus fit"; Rec."Focus fit")
                {
                    ToolTip = 'Specifies the value of the Focus fit field.';
                    Caption = 'Focus Area Fit';
                }
                field("What is needed"; Rec."What is needed")
                {
                    ToolTip = 'Specifies the value of the What is needed field.';
                }
                field("Action by Who"; Rec."Action by Who")
                {
                    ToolTip = 'Specifies the value of the Action by Who field.';
                }
                field("How we can engage"; Rec."How we can engage")
                {
                    ToolTip = 'Specifies the value of the How we can engage field.';
                }
                field(Links; Rec.Links)
                {
                    ToolTip = 'Specifies the value of the Links field.';
                }
            }
        }
    }
}
