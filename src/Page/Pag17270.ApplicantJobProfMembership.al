page 17271 "Applicant Job Prof Membership"
{
    Caption = 'Applicant Job professional membership';
    PageType = ListPart;
    SourceTable = "Applicant Prof Membership";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Professional Body"; Rec."Professional Body")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Professional Body field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(MembershipNo; Rec.MembershipNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the MembershipNo field';
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Applicant No. field';
                }
                field("Line No"; Rec."Line No.")
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