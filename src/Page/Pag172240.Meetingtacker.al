page 172240 "Meeting tacker "
{
    ApplicationArea = All;
    Caption = 'Meeting tracker';
    PageType = List;
    SourceTable = "Meeting tracker";
    SourceTableView = where(Converted = const(false));
    UsageCategory = Lists;
    CardPageId = "Meeting tracker card ";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Agenda; Rec.Agenda)
                {
                    ToolTip = 'Specifies the value of the Agenda field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Key items"; Rec."Key items")
                {
                    ToolTip = 'Specifies the value of the Key items field.';
                }

                field(Organisation; Rec.Organisation)
                {
                    ToolTip = 'Specifies the value of the Organisation field.';
                }
                field("Other notes"; Rec."Other notes")
                {
                    ToolTip = 'Specifies the value of the Other notes field.';
                }
                field("Priority level"; Rec."Priority level")
                {
                    ToolTip = 'Specifies the value of the Priority level field.';
                }
            }
        }
    }
}
