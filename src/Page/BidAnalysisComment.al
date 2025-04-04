page 50087 "Bid Analysis Comment"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bid Analysis Comment";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment) { ApplicationArea = all; }
                field("Captured by"; Rec."Captured by") { ApplicationArea = all; }
                field("Date Time"; Rec."Date Time") { ApplicationArea = all; }
            }
        }


    }


    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Captured by" := UserId;
        Rec."Date Time" := CurrentDateTime;
    end;
}

