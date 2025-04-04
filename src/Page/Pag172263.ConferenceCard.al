page 172263 "Conference Card"
{
    ApplicationArea = All;
    Caption = 'Conference Card';
    PageType = Card;
    SourceTable = conferences;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    Editable = false;
                }
                field(Conference; Rec.Conference)
                {
                    Caption = 'Conference / Event';
                    ToolTip = 'Specifies the value of the Conference field.';
                    MultiLine = true;
                    RowSpan = 5;
                }
                field("Date"; Rec."Date")
                {
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("End Date"; Rec."End Date")
                {

                    trigger OnValidate()
                    begin
                        if Rec."End Date" < Rec.Date then
                            Error('End date should not be a before start date');
                    end;

                }
                field("Where"; Rec."Where")
                {
                    ToolTip = 'Specifies the value of the Where field.';
                    MultiLine = true;
                    RowSpan = 5;
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
                    MultiLine = true;
                    RowSpan = 6;

                }
                field(Links; Rec.Links)
                {
                    ToolTip = 'Specifies the value of the Links field.';
                }

            }
            group(Other)
            {
                part("Action items"; "Action items ")
                {
                    SubPageLink = Code = field(Code);
                }




            }
            group("Status update_")
            {
                part("Status update"; "Status update")
                {
                    SubPageLink = Code = field(Code);
                }
            }
        }
    }
}
