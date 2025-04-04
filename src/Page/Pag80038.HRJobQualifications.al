Page 80038 "HR Job Qualifications"
{
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Qualifications';
    SourceTable = "HR Job Qualifications";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = Basic;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Equivalence; Rec.Equivalence)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Qualification)
            {
                Caption = 'Qualification';
                action("Q&ualification Overview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Q&ualification Overview';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Qualification Overview";
                }
            }
        }
    }
}

