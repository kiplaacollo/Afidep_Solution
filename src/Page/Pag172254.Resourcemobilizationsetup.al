page 172254 "Resource mobilization setup"
{
    ApplicationArea = All;
    Caption = 'Resource mobilization setup';
    PageType = List;
    SourceTable = ResourceMobilizationSetup;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Primary Key "; Rec."Primary Key ")
                {
                    ToolTip = 'Specifies the value of the Primary Key  field.';
                }
                field(Mettingtracker; Rec.Mettingtracker)
                {
                    ToolTip = 'Specifies the value of the Mettingtracker field.';
                }
                field(Engagement; Rec.Engagement)
                {
                    ToolTip = 'Specifies the value of the Engagement field.';
                }
                field(Gonogodecision; Rec.Gonogodecision)
                {
                    ToolTip = 'Specifies the value of the Gonogodecision field.';
                }
                field(Professionaldevelopment; Rec.Professionaldevelopment)
                {
                    ToolTip = 'Specifies the value of the Professionaldevelopment field.';
                }

                field(Conference; Rec.Conference)
                {
                    ToolTip = 'Specifies the value of the Professionaldevelopment field.';
                }
            }
        }
    }
}
