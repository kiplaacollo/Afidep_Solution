page 20454 "Notification Users"
{
    PageType = ListPart;
    SourceTable = 170108;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Email; Rec.Email)
                {
                }
            }
        }
    }

    actions
    {
    }


}

