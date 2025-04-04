page 172250 "Proposal development tracker"
{
    ApplicationArea = All;
    Caption = 'Proposal development tracker';
    PageType = List;
    SourceTable = "Personal development Tracker";
    UsageCategory = Lists;
    CardPageId = "Proposal development trac card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }


                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Duarion; Rec.Duarion)
                {
                    ToolTip = 'Specifies the value of the Duarion field.';
                }
                field("Focus area"; Rec."Focus area")
                {
                    ToolTip = 'Specifies the value of the Focus area field.';
                }
                field(Funder; Rec.Funder)
                {
                    ToolTip = 'Specifies the value of the Funder field.';
                }
                field("Funder profile"; Rec."Funder profile")
                {
                    ToolTip = 'Specifies the value of the Funder profile field.';
                }
                field("Funder type"; Rec."Funder type")
                {
                    ToolTip = 'Specifies the value of the Funder type field.';
                }
                field(Lead; Rec.Lead)
                {
                    ToolTip = 'Specifies the value of the Lead field.';
                }
                field("Annual allocations"; Rec."Annual allocations")
                {
                    ToolTip = 'Specifies the value of the Annual allocations field.';
                }
                field(Partner; Rec.Partner)
                {
                    ToolTip = 'Specifies the value of the Partner field.';
                }
                field("Total call"; Rec."Total call")
                {
                    ToolTip = 'Specifies the value of the Total call field.';
                }
                field("Year grant given or denied"; Rec."Year grant given or denied")
                {
                    ToolTip = 'Specifies the value of the Year grant given or denied field.';
                }
                field("Year submitted"; Rec."Year first submitted")
                {
                    ToolTip = 'Specifies the value of the Year submitted field.';
                }

                field("Year of decision"; Rec."Year of decision")
                {
                    ToolTip = 'Specifies the value of the Year submitted field.';
                }
                field(Role; Rec.Role)
                {
                    ToolTip = 'Specifies the value of the Year submitted field.';
                }
                field("Oportunity value"; Rec."Oportunity value")
                {
                    ToolTip = 'Specifies the value of the Year submitted field.';
                }
            }
        }
    }
}
