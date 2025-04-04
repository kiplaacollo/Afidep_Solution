Page 170078 "HR Medical Scheme Member Claim"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "HR Medical Claims";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Claim No";Rec."Claim No")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Type";Rec."Claim Type")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Date";Rec."Claim Date")
                {
                    ApplicationArea = Basic;
                }
                field("Patient Name";Rec."Patient Name")
                {
                    ApplicationArea = Basic;
                }
                field("Document Ref";Rec."Document Ref")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Service";Rec."Date of Service")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Charged";Rec."Amount Charged")
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

