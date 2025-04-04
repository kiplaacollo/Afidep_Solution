pageextension 50006 "Dimension Value" extends "Dimension Values"
{
    layout
    {

        addbefore("Dimension Value Type")
        {
            field(Description; Rec.Description)
            {
                ApplicationArea = all;
            }
        }
        addbefore(Code)
        {
            field("Project Code"; Rec."Project Code")
            {
                ApplicationArea = all;

            }
        }
        // Add changes to page layout here
        addafter("Dimension Value Type")
        {

            field("BudgetLine Disabled"; Rec."BudgetLine Disabled")
            {
                ApplicationArea = all;
            }
            field("G/L Account"; Rec."G/L Account")
            {
                ApplicationArea = all;
            }
            field("G/L Account Name"; Rec."G/L Account Name")
            {
                ApplicationArea = all;
            }
            field("Budget Amount"; Rec."Budget Amount")
            {
                ApplicationArea = all;
            }
            field("Actual Spent"; Rec."Actual Spent")
            {
                ApplicationArea = all;
            }


            field("Department Code"; Rec."Department Code") { }
            field("Branch Code"; Rec."Branch Code") { }

            field("Outcome Code"; Rec."Outcome Code") { }
            field("Thematic Code"; Rec."Thematic Code") { }
            field("Approver ID"; Rec."Approver ID")
            { }
        }
        addafter(Blocked)
        {
            field(Closed; Rec.Closed)
            {
            }
        }

    }

    actions
    {
        // Add changes to page actions here
        addafter("F&unctions")
        {
            action(Project)
            {
                ApplicationArea = Dimensions;
                Caption = 'Project Budget';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Project Budget";
                RunPageLink = "Dimension Code" = const('BUDGETLINES'), "Project Code" = field(Code);

                ToolTip = 'Shows the budget of specific projects';
            }


        }
    }

    var
        myInt: Integer;
}