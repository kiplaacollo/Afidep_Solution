page 50099 "budget Line Matrix"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Donors Budget Matrix line";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Budget Line No Code"; Rec."Budget Line No Code")
                {
                    ApplicationArea = All;

                }
                field("Budget Line code Category"; Rec."Budget Line code Category") { ApplicationArea = all; }
                field("Budget Line Description."; Rec."Budget Line Description.") { ApplicationArea = basic; }
                field("Fund No Code"; Rec."Fund No Code") { ApplicationArea = all; }
                field("Donor Code"; Rec."Donor Code") { ApplicationArea = all; }

            }
        }
        area(Factboxes)
        {

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
}