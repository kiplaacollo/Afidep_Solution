page 17236 "Academic Qualifications"
{
    ApplicationArea = All;
    Caption = 'Academic Qualifications';
    PageType = List;
    SourceTable = Qualifications;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field';
                    Caption = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Education Level"; Rec."Education Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Education Level field';
                }
                field("Field of Study"; Rec."Field of Study")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Field of Study field';
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Qualification Type" := Rec."Qualification Type"::Academic;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Qualification Type" := Rec."Qualification Type"::Academic;
    end;
}