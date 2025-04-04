page 50086 "Bid Analysis Committee"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bid Analysis Committee";

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
                field("Name of the Member"; Rec."Name of the Member") { ApplicationArea = all; }
                field("Phone No"; Rec."Phone No") { ApplicationArea = all; }
                field("ID No."; Rec."ID No.") { ApplicationArea = all; }
                field(Position; Rec.Position) { ApplicationArea = all; }
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