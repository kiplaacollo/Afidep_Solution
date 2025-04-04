Page 80026 "HR Leave journal Template"
{
    PageType = List;
    SourceTable = "HR Leave Journal Template";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Test Report ID"; Rec."Test Report ID")
                {
                    ApplicationArea = Basic;
                }
                field("Form ID"; Rec."Form ID")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Report ID"; Rec."Posting Report ID")
                {
                    ApplicationArea = Basic;
                }
                field("Force Posting Report"; Rec."Force Posting Report")
                {
                    ApplicationArea = Basic;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = Basic;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = Basic;
                }
                field("Test Report Name"; Rec."Test Report Name")
                {
                    ApplicationArea = Basic;
                }
                field("Form Name"; Rec."Form Name")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Report Name"; Rec."Posting Report Name")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
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

