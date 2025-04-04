Page 170080 "HR Medical Claims List"
{
    CardPageID = "HR Medical Claims Card";
    Editable = false;
    PageType = List;
    SourceTable = "HR Medical Claims";
    SourceTableView = where(Claimed = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Claim No"; Rec."Claim No")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Type"; Rec."Claim Type")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Date"; Rec."Claim Date")
                {
                    ApplicationArea = Basic;
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Service"; Rec."Date of Service")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Charged"; Rec."Amount Charged")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        Dependants: Record "HR Employee Kin";
}

