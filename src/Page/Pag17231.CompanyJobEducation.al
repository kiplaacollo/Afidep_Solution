page 17231 "Company Job Education"
{
    Caption = 'Company Job Education';
    PageType = ListPart;
    SourceTable = "Company Job Education";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Field of Education"; Rec."Field of Study")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Field of Study field';
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Field Name field';
                }
                field("Education Level"; Rec."Education Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Education Level field';
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qualification Code field';
                }
                field("Qualification Name"; Rec."Qualification Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qualification Name field';
                }
                field("Proficiency Level"; Rec."Proficiency Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Proficiency Level field';
                }
                field(Score; Rec.Score)
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Score field';
                }
            }
        }
    }
}