page 172256 "Engagement plan quartely upda"
{
    ApplicationArea = All;
    Caption = 'Engagement plan quartely upda';
    PageType = ListPart;
    SourceTable = "Engagement plan Q updates";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Date of update"; Rec."Date of update")
                {
                    ToolTip = 'Specifies the value of the Date of update field.';
                }
                field(Update; Rec.Update)
                {
                    ToolTip = 'Specifies the value of the Update field.';
                }
                field(Links; Rec.Links)
                {
                    ToolTip = 'Specifies the value of the Links field.';
                }
            }
        }
    }
}
