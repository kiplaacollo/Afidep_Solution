Page 50037 "Project List"
{
    CardPageID = "Project Card";
    PageType = List;
    SourceTable = Projects;
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = Basic;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = Basic;
                }
                field(Partner; Rec.Partner)
                {
                    ApplicationArea = Basic;
                }
                field(Donor; Rec.Donor)
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

