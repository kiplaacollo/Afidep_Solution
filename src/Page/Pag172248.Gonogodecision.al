page 172248 "Gonogo decision"
{
    ApplicationArea = All;
    Caption = 'Gonogo decision';
    PageType = List;
    SourceTable = GonoGoDecision;
    UsageCategory = Lists;
    CardPageId = GonogodecisionCard;

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
                field(Engagement; Rec.Engagement)
                {
                    ToolTip = 'Specifies the value of the Donor field.';
                }
                field(Donor; Rec.Donor)
                {
                    ToolTip = 'Specifies the value of the Donor field.';
                }


                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field("Strategic fit "; Rec."Strategic fit")
                {
                    ToolTip = 'Specifies the value of the Strategic fit  field.';
                }
                field("Feed back"; Rec."Feed back")
                {
                    ToolTip = 'Specifies the value of the Feed back field.';
                }
                field("Focus countries"; Rec."Focus countries")
                {
                    caption = 'Focust cuntry/ies';
                    ToolTip = 'Specifies the value of the Focus countries field.';
                }
                field("Important links"; Rec."Important links")
                {
                    ToolTip = 'Specifies the value of the Important links field.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
            }
        }
    }
}
