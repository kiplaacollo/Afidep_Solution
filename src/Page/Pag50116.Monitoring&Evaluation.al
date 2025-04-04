Page 50116 "Monitoring & Evaluation"
{
    PageType = List;
    SourceTable = Projects;
    UsageCategory = Lists;
    ApplicationArea = ALL;
    CardPageId = "Project Card";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Project Code"; Rec."Project Code")
                {
                }
                field("Project Name"; Rec."Project Name")
                {
                }
                field("Thematic Programme"; Rec."Thematic Programme")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }

            }
        }
    }

    actions
    {
        area(Reporting)
        {
            action("Burn Rate Report")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report 80077;
            }
            action("Burn Rate Report 2")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report 80088;
            }
        }
    }
}

