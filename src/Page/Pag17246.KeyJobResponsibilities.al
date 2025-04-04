page 17246 "Key Job Responsibilities"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Key Job responsibilities";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Responsibility Code"; Rec.Code)
                {
                    Caption = 'Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Remarks; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
            }
        }
    }

    actions
    {
    }
}
