page 17232 "Company Job Experience"
{
    Caption = 'Company Job Experience';
    PageType = ListPart;
    SourceTable = "Company Job Experience";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Industry; Rec.Industry)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Industry field';
                }
                field("Industry Name"; Rec."Industry Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Industry Name field';
                }
                field("Hierarchy Level"; Rec."Hierarchy Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hierarchy Level field';
                }
                field("No. of Years"; Rec."No. of Years")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Years field';
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