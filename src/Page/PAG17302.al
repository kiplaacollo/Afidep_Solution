page 17302 "Projects Team"
{
    PageType = ListPart;
    SourceTable = 170108;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Email; Rec.Email)
                {
                }
                field("Allocation %"; Rec."Allocation %")
                {
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                }
                field("Actual Amount"; Rec."Actual Amount")
                {
                    Caption = 'Actual Monthly claim';
                }
            }
        }
    }

    actions
    {
    }


}

