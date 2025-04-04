Page 170077 "HR Medical Schemes List"
{
    CardPageID = "HR Medical Schemes Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "HR Medical Schemes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Scheme No";Rec."Scheme No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Medical Insurer";Rec."Medical Insurer")
                {
                    ApplicationArea = Basic;
                }
                field("Scheme Name";Rec."Scheme Name")
                {
                    ApplicationArea = Basic;
                }
                field("In-patient limit";Rec."In-patient limit")
                {
                    ApplicationArea = Basic;
                }
                field("Out-patient limit";Rec."Out-patient limit")
                {
                    ApplicationArea = Basic;
                }
                field("Area Covered";Rec."Area Covered")
                {
                    ApplicationArea = Basic;
                }
                field("Dependants Included";Rec."Dependants Included")
                {
                    ApplicationArea = Basic;
                }
                field(Comments;Rec.Comments)
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

