Page 80031 "HR Job Responsiblities Lines"
{
    PageType = ListPart;
    SourceTable = "HR Job Responsiblities";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Code"; Rec."Responsibility Code")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Description"; Rec."Responsibility Description")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
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

