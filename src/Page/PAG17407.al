page 17407 "Bidders requirements List"
{
    CardPageID = "Bidders Mandatory Requirements";
    PageType = ListPart;
    SourceTable = "Bidders Mandatory requirements";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code;Rec.Code)
                {
                }
                field(Requirement;Rec.Requirement)
                {
                }
                field(Status;Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}

