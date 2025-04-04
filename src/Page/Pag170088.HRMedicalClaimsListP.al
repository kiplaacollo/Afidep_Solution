Page 170088 "HR Medical Claims ListP"
{
    CardPageID = "HR Medical Claims CardP";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "HR Medical Claims";
    SourceTableView = where(Claimed = filter(true));

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

