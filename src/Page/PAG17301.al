page 17301 "Award Countries/Regions"
{
    PageType = ListPart;
    SourceTable = 170122;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Country Code";Rec."Country Code")
                {
                }
                field("Country Name";Rec."Country Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

