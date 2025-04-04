page 17266 "Applicant Job Education"
{
    Caption = 'Applicant Job Education';
    PageType = ListPart;
    SourceTable = "Applicant Job Education";
    AutoSplitKey = true;
    SourceTableView = where("Education Level" = filter(<> Professional));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Education Type"; Rec."Education Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Education Type field';
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
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qualification Code field';
                    Visible = false;
                }
                field("Qualification Name"; Rec."Qualification Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qualification Name field';
                }
                field("Institution Type"; Rec."Institution Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Institution Type field.';
                    Visible = false;
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Institution field';
                    Visible = false;
                }
                field("Institution Name"; Rec."Institution Name")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Institution Name field';
                }
                field("Proficiency Level"; Rec."Proficiency Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Proficiency Level field';
                    Visible = false;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country field';
                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Region field';
                }
                field("Highest Level"; Rec."Highest Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Highest Level field';
                }


                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Applicant No. field';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = true;
                    ToolTip = 'Specifies the value of the Line No. field';
                }
                field("Need Code"; Rec."Need Code")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Need Code field';
                }
            }
        }
    }
}