page 17269 "Applicant Job Experience"
{
    Caption = 'Applicant Job Experience';
    PageType = ListPart;
    SourceTable = "Applicant Job Experience";
    AutoSplitKey = true;

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
                field(Employer; Rec.Employer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer field';
                }
                field(Industry; Rec.Industry)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Industry field';
                }
                field("Hierarchy Level"; Rec."Hierarchy Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hierarchy Level field';
                }
                field("Functional Area"; Rec."Functional Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Functional Area field';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Title field';
                }
                field("Present Employment"; Rec."Present Employment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Present Employment field';
                }
                field("No. of Years"; Rec."No. of Years")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Years field';
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location field';
                }
                field("Employer Email Address"; Rec."Employer Email Address")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Employer Email Address field';
                }
                field("Employer Postal Address"; Rec."Employer Postal Address")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Employer Postal Address field';
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Job ID field';
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Line No field';
                }
            }
        }
    }
}