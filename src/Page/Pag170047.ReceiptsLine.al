Page 170047 "Receipts Line"
{
    PageType = ListPart;
    SourceTable = "Receipt Lines";
   UsageCategory=Lists;
    ApplicationArea=ALL;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Receipt Transaction Type";Rec."Receipt Transaction Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Type";Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Property;Rec.Property)
                {
                    ApplicationArea = Basic;
                }
                field(Ammenity;Rec.Ammenity)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount";Rec."Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
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

