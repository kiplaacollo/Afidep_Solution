page 172253 PropposaldevelopmentSubform
{
    ApplicationArea = All;
    Caption = 'PropposaldevelopmentSubform';
    PageType = ListPart;
    SourceTable = Proposaldevelopment;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }
}
