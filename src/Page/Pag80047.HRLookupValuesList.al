Page 80047 "HR Lookup Values List"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "HR Lookup Values";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = true;
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
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Only"; Rec."Supervisor Only")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Stage"; Rec."Appraisal Stage")
                {
                    ApplicationArea = Basic;
                }
                field("Previous Appraisal Code"; Rec."Previous Appraisal Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Lookup Values Factbox")
            {
                SubPageLink = Type = field(Type);
            }
        }
    }

    actions
    {
    }
}

