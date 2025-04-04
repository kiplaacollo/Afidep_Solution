Page 170086 "Board Members"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Board Members";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Member ID No"; Rec."Member ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Telephone"; Rec."Member Telephone")
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

