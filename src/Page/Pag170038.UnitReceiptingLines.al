Page 170038 "Unit Receipting Lines"
{
    PageType = ListPart;
    SourceTable = "Unit Receipting Line";
   UsageCategory=Lists;
    ApplicationArea=ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Type";Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Code";Rec."Account Code")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Pay Mode";Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Rec.Amount)
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

