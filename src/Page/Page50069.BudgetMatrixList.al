Page 50069 "Budget Matrix List"
{
    DeleteAllowed = false;
    PageType = List;
    
    SourceTable = "Donors Budget Matrix";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
               field(Code;Rec.Code)
               {
                ApplicationArea=basic;
               }
               field("Budget Line code Category";Rec."Budget Line code Category")
               {
                ApplicationArea=basic;
               }
               field("Budget Line No Code";Rec."Budget Line No Code")
               {
                ApplicationArea=basic;

               } 
               field("Budget Template Description Category";Rec."Budget Template Description Category") {}
               field("Budget Template Description";Rec."Budget Template Description")
               {
                ApplicationArea=basic;
               }
               field("Total Budget Amount";Rec."Total Budget Amount"){}
               field("GL Account No";Rec."GL Account No"){}
               field("GL Account Name";Rec."GL Account Name"){}
               field("Fund No Code";Rec."Fund No Code"){}
               field("Programme Code";Rec."Programme Code"){}
               field("Donor Code";Rec."Donor Code"){}
               field("Output Code";Rec."Output Code"){}
               field("Total Actual Amount";Rec."Total Actual Amount")
               {
                Editable=false;
               }
                }
        }
    }

    actions
    {
    }
}

