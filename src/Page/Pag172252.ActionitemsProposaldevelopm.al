page 172252 "Action items Proposal developm"
{
    ApplicationArea = All;
    Caption = 'Action items ';
    PageType = ListPart;
    SourceTable = "Action items meeting tacker";

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
                field("Action by Whom"; Rec."Action by Whom Staff")
                {
                    ToolTip = 'Specifies the value of the Action by Whom field.';
                }
                field("By when"; Rec."By when")
                {
                    ToolTip = 'Specifies the value of the By when field.';
                }
                field(Notes; Rec.Notes)
                {

                }
            }
        }
    }
}
