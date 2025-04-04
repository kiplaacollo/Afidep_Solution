Page 80089 "Line Allocation subform"
{
    PageType = ListPart;
    SourceTable = "Allocation Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
              
                field(Amount;Rec.Amount)
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

