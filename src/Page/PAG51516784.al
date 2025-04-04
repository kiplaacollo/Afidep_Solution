page 50095 "Contract List"
{
    CardPageID = "Contract Card";
    PageType = List;
    SourceTable = 172774;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec. No)
                {
                }
                field("Contract Title";  Rec."Contract Title")
                {
                }
                field("Company Name"; Rec. "Company Name")
                {
                }
                field(Status;  Rec.Status)
                {
                }
                field("Expiry Date";  Rec."Expiry Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

