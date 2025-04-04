page 17229 Qualificationss
{
    ApplicationArea = BasicHR;
    Caption = 'Qualifications';
    PageType = List;
    SourceTable = Qualifications;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a qualification code.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a description for the qualification.';
                }
                field("Qualified Employees"; Rec."Qualified Employees")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies if the company has employees with this qualification.';
                }
                field("Qualification Type"; Rec."Qualification Type") { }
                field("Field of Study"; Rec."Field of Study") { Visible = false; }
                field("Education Level"; Rec."Education Level") { Visible = false; }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Q&ualification")
            {
                Caption = 'Q&ualification';
                Image = Certificate;
                action("Q&ualification Overview")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Q&ualification Overview';
                    Image = QualificationOverview;
                    RunObject = Page "Qualification Overview";
                    ToolTip = 'View qualifications that are registered for the employee.';
                }
            }
        }
    }
}

