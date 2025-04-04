Page 170039 "Unit Transaction Types"
{
    PageType = List;
    SourceTable = "Unit Transaction Types";
       UsageCategory=Lists;
    ApplicationArea=ALL;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code";Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description";Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";Rec."Account Name")
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

