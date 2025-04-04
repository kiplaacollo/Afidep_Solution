page 172300 "Action items Patner"
{
    ApplicationArea = All;
    Caption = 'Action items ';
    PageType = ListPart;
    SourceTable = "Action items meeting tacker P";

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Action item"; Rec."Action item")
                {
                    ToolTip = 'Specifies the value of the Action item field.';
                }
                field("Action by"; rec.ActionByPatner)
                {

                }

                field("Action by Whom"; Rec."Action by Whom Patner")
                {
                    ToolTip = 'Specifies the value of the Action by Whom field.';

                }
                field("By when"; Rec."By when")
                {
                    ToolTip = 'Specifies the value of the By when field.';
                }
            }
        }
    }
}
