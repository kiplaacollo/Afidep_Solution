Page 170076 "HR Medical Schemes Card"
{
    PageType = Card;
    PromotedActionCategories = 'Manage,Process,Report,Members';
    SourceTable = "HR Medical Schemes";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Scheme No";Rec."Scheme No")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Insurer";Rec."Medical Insurer")
                {
                    ApplicationArea = Basic;
                }
                field("Insurer Name";Rec."Insurer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
            group(Control6)
            {
                part(Control5;"Scheme Categories")
                {
                    Editable = true;
                    SubPageLink = "Scheme Number"=field("Scheme No");
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Medical Scheme Members")
                {
                    ApplicationArea = Basic;
                    Caption = 'Medical Scheme Members';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Medical Scheme Members List";
                    RunPageLink = "Scheme No"=field("Scheme No");
                }
                action(Attachments)
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Documents;
                }
            }
        }
    }
}

