Page 80043 "HR Leave Types Card"
{
    PageType = Card;
    SourceTable = "HR Leave Types";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code";Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Days;Rec.Days)
                {
                    ApplicationArea = Basic;
                }
                field("Acrue Days";Rec."Acrue Days")
                {
                    ApplicationArea = Basic;
                }
                field("Unlimited Days";Rec."Unlimited Days")
                {
                    ApplicationArea = Basic;
                }
                field(Gender;Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field(Balance;Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Max Carry Forward Days";Rec."Max Carry Forward Days")
                {
                    ApplicationArea = Basic;
                }
                field("Carry Forward Allowed";Rec."Carry Forward Allowed")
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive of Non Working Days";Rec."Inclusive of Non Working Days")
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive of Saturday";Rec."Inclusive of Saturday")
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive of Sunday";Rec."Inclusive of Sunday")
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive of Holidays";Rec."Inclusive of Holidays")
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

