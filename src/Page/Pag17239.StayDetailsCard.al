page 17239 "Stay Details Card"
{
    ApplicationArea = All;
    Caption = 'Academic Qualifications';
    PageType = Card;
    SourceTable = "Stay Details";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = Basic;
                }
                field("Cost of Stay"; Rec."Cost of Stay")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

    end;
}