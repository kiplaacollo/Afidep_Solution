page 17288 "Partner List"
{
    PageType = ListPart;
    SourceTable = 170105;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Proposal Code"; Rec."Proposal Code")
                {
                    Caption = 'Code';
                    Editable = false;
                }
                field("Partner Name"; Rec."Partner Name")
                {
                }
                field(Amount; Rec.Amount)
                {

                }
                field("Telephone No."; Rec."Telephone No.")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field(Country; Rec.Country)
                {
                }
                field(Region; Rec.Region)
                {
                }
                field(Scope; Rec.Scope)
                {
                }
            }
        }

    }

    actions
    {
    }
}

