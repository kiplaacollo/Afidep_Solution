Page 50070 "Budget Main Categorization"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Budget T Description Category";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
               field("Budget Template Description Category";Rec."Budget Template Description Category")
               {
                ApplicationArea=basic;
               }
               
                }
        }
    }

    actions
    {
    }
}

