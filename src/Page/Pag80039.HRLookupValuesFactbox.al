Page 80039 "HR Lookup Values Factbox"
{
    Caption = 'HR Lookup Values Factbox';
    PageType = CardPart;
    SourceTable = "HR Lookup Values";

    layout
    {
        area(content)
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = Basic;
            }
            field("Code"; Rec.Code)
            {
                ApplicationArea = Basic;
            }
            field(Description; Rec.Description)
            {
                ApplicationArea = Basic;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = Basic;
            }
            field("Notice Period"; Rec."Notice Period")
            {
                ApplicationArea = Basic;
            }
            field(Closed; Rec.Closed)
            {
                ApplicationArea = Basic;
            }
            field("Contract Length"; Rec."Contract Length")
            {
                ApplicationArea = Basic;
            }
            field("Current Appraisal Period"; Rec."Current Appraisal Period")
            {
                ApplicationArea = Basic;
            }
            field("Disciplinary Case Rating"; Rec."Disciplinary Case Rating")
            {
                ApplicationArea = Basic;
            }
            field("Disciplinary Action"; Rec."Disciplinary Action")
            {
                ApplicationArea = Basic;
            }
            field(From; Rec.From)
            {
                ApplicationArea = Basic;
            }
            field("To"; Rec."To")
            {
                ApplicationArea = Basic;
            }
            field(Score; Rec.Score)
            {
                ApplicationArea = Basic;
            }
            field("Basic Salary"; Rec."Basic Salary")
            {
                ApplicationArea = Basic;
            }
            field("To be cleared by"; Rec."To be cleared by")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }
}

