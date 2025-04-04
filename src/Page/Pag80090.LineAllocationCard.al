Page 80090 "Line Allocation Card"
{
    PageType = Card;
    SourceTable = "Allocation Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Allocation No";Rec."Allocation No")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount";Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked;Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Description";Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control8;"Line Allocation subform")
            {
                //SubPageLink = "Allocation No"=field("Allocation No");
            }
        }
    }

    actions
    {
    }
}

