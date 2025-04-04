page 17267 "Applicant Job Prof Course"
{
    Caption = 'Applicant Job Professional Course';
    PageType = ListPart;
    SourceTable = "Applicant Job Education";
    SourceTableView = where("Education Level" = filter(Professional));
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Qualification Code"; Rec."Qualification Code Prof")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qualification Code field';
                    trigger OnValidate()
                    var
                        Qualifications: Record Qualifications;
                    begin
                        Qualifications.Reset();
                        Qualifications.SetRange(code, Rec."Qualification Code Prof");
                        if Qualifications.Find('-') then
                            Message('Qualification Description %1', Qualifications.Description);
                        Rec."Qualification Name" := Qualifications.Description;

                    end;

                }
                field("Qualification Name"; Rec."Qualification Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qualification Name field';
                }
                field("Section/Level"; Rec."Section/Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Section/Level field';
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Applicant No. field';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Line No. field';
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Education Level" := Rec."Education Level"::Professional;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Education Level" := Rec."Education Level"::Professional;
    end;
}
