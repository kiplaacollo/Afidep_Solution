Page 80042 "HR Leave Types"
{
    CardPageID = "HR Leave Types Card";
    PageType = List;
    SourceTable = "HR Leave Types";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                field("Code";Rec.Code)
                {
                    ApplicationArea = Basic;
                    Style = StandardAccent;
                    StyleExpr = true;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Days;Rec.Days)
                {
                    ApplicationArea = Basic;
                }
                field(Gender;Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field("Max Carry Forward Days";Rec."Max Carry Forward Days")
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
        area(factboxes)
        {
            systempart(Control1102755003;Outlook)
            {
            }
            systempart(Control1102755004;Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

