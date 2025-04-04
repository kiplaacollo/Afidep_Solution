Page 50057 "Supplier Categories"
{
    PageType = List;
    SourceTable = "Supplier Categories";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Category;Rec.Category)
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

