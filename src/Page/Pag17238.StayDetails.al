page 17238 "Stay Details List"
{
    ApplicationArea = All;
    Caption = 'Academic Qualifications';
    PageType = List;
    CardPageId = "Stay Details Card";
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