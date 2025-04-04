Page 170085 "Scheme Subcategories"
{
    PageType = List;
    SourceTable = "Scheme Subcategory";
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Scheme Category"; Rec."Scheme Category")
                {
                    ApplicationArea = Basic;
                }
                field("Scheme Name"; Rec."Scheme Name")
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

