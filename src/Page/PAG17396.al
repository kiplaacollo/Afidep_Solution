page 17396 "Item Groups"
{
    PageType = List;
    SourceTable = "Item Groups";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Def. Gen. Prod. Posting Group"; Rec."Def. Gen. Prod. Posting Group")
                {
                    Visible = false;
                }
                field("Def. Inventory Posting Group"; Rec."Def. Inventory Posting Group")
                {
                    Visible = false;
                }
                field("Def. VAT Prod. Posting Group"; Rec."Def. VAT Prod. Posting Group")
                {
                    Visible = false;
                }
                field("Def. Costing Method"; Rec."Def. Costing Method")
                {
                    Visible = false;
                }
            }
        }

    }

    actions
    {
        area(processing)
        {
            action("&Item Category Code")
            {
                Caption = '&Item Category Code';
                Image = ItemGroup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 5730;

            }
        }
    }
}

