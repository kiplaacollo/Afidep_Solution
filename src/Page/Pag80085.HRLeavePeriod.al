Page 80085 "HR Leave Period"
{
    PageType = List;
    SourceTable = "HR Leave Periods";

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
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Period Description"; Rec."Period Description")
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

