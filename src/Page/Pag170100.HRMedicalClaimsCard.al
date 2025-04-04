Page 170100 "HR Medical Claims Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR Medical Claims";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Claim No"; Rec."Claim No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field("Document Ref"; Rec."Document Ref")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Service"; Rec."Date of Service")
                {
                    ApplicationArea = Basic;
                }
                field(Hospital; Rec.Hospital)
                {
                    ApplicationArea = Basic;
                }
                field(Other; Rec.Other)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Amount Charged"; Rec."Amount Charged")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Attachments)
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page Documents;
                RunPageLink = "Doc No." = field("No. Series");
            }
        }
    }
}

