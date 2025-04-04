page 17413 "Documen Mandatory Requirements"
{
    PageType = ListPart;
    SourceTable = "Tender Mandatory Requirements";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tendor No"; Rec."Tendor No")
                {
                    Caption = 'Doc No';
                }
                field(Code; Rec.Code)
                {
                }
                field(Requirement; Rec.Requirement)
                {
                }
            }
        }
    }

    actions
    {
    }
}

