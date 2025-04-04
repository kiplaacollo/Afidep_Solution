Page 170082 "Hr Scheme Dependants"
{
    PageType = List;
    SourceTable = "HR Medical Dependants";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Scheme No"; Rec."Scheme No")
                {
                    ApplicationArea = Basic;
                }
                field("Dependant Names"; Rec."Dependant Names")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Relationship Type"; Rec."Relationship Type")
                {
                    ApplicationArea = Basic;
                }
                field("Dependant Year Of Birth"; Rec."Dependant Year Of Birth")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Of Birth';
                }
                field("Dependant Id No"; Rec."Dependant Id No")
                {
                    ApplicationArea = Basic;
                }
                field("Dependant Phone No"; Rec."Dependant Phone No")
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

