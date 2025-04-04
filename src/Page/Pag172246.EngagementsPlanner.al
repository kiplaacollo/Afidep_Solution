page 172246 "Engagements Planner"
{
    ApplicationArea = All;
    Caption = 'Engagements planner';
    PageType = List;
    Editable = false;
    SourceTable = EngagementsPlanner;
    UsageCategory = Lists;
    CardPageId = "EmgagementsPlannercard";

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Code"; Rec."Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Donor"; Rec.Funder)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the organisation to engage with.';
                    Caption = 'Organisation';
                }
                field("Funder Name"; Rec."Funder Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the organisation Name to engage with.';
                    Caption = 'Organisation Name';
                }
                field("About donor"; Rec."About funder")
                {
                    Editable = true;
                    Visible = false;
                    caption = 'About donor';
                    ToolTip = 'Specifies the value of the Code field.';
                }



            }
        }
    }
}
