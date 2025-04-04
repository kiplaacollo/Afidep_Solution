Page 170090 "Medical Periods"
{
    Editable = false;
    PageType = List;
    SourceTable = "Medical Periods";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Code"; Rec."Period Code")
                {
                    ApplicationArea = Basic;
                }
                field("Period Start Date"; Rec."Period Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Period End Date"; Rec."Period End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Close Period")
            {
                ApplicationArea = Basic;
                Caption = 'Close Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                //RunObject = Report UnknownReport51525869;
            }
        }
    }
}

