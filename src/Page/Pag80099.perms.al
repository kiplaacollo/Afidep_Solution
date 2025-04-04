Page 80099 "perms"
{
    PageType = List;
    SourceTable = "License Permission";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Object Type";Rec."Object Type")
                {
                    ApplicationArea = Basic;
                }
                field("Object Number";Rec."Object Number")
                {
                    ApplicationArea = Basic;
                }
                field("Read Permission";Rec."Read Permission")
                {
                    ApplicationArea = Basic;
                }
                field("Insert Permission";Rec."Insert Permission")
                {
                    ApplicationArea = Basic;
                }
                field("Modify Permission";Rec."Modify Permission")
                {
                    ApplicationArea = Basic;
                }
                field("Delete Permission";Rec."Delete Permission")
                {
                    ApplicationArea = Basic;
                }
                field("Execute Permission";Rec."Execute Permission")
                {
                    ApplicationArea = Basic;
                }
                field("Limited Usage Permission";Rec."Limited Usage Permission")
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

