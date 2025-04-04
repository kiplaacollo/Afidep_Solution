page 17224 "Project Budget Card"
{
    Caption = 'Project Budget Card';
    PageType = Card;
    SourceTable = "Project Budget";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                    Enabled = Edition;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field.';
                    Enabled = Edition;
                }
                field("Title 2"; Rec."Title 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title 2 field.';
                    Enabled = Edition;
                }
                field("Sub Award No"; Rec."Sub Award No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub Award No field.';
                    Enabled = Edition;
                }
                field("Agreement No"; Rec."Agreement No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agreement No field.';
                    Enabled = Edition;
                }
                field("Approval Satus"; Rec."Approval Satus")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Aprroval Satus field.';
                    Enabled = Edition;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blocked field.';
                    Enabled = Edition;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Code field.';
                    Enabled = Edition;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email  field.';
                    Enabled = Edition;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                    Enabled = Edition;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                    Enabled = Edition;
                }

                field(Objective; Rec.Objective)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Objective field.';
                    Enabled = Edition;
                }
                field("Period Performance"; Rec."Period Performance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Performance field.';
                    Enabled = Edition;
                }
                field("Person Responsible"; Rec."Person Responsible")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Person Responsible field.';
                    Enabled = Edition;
                }


                field("Amount Awarded"; Rec."Amount Awarded")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Awarded field.';
                    Enabled = Edition;
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budgeted Amount field.';
                    Enabled = Edition;
                }
                field("Received Amount"; Rec."Received Amount")
                {
                    Enabled = Edition;
                }
                field("Remaining Balance"; Rec."Remaining Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remaining Balance field.';
                    Enabled = Edition;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    Enabled = Edition;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    // Enabled = Edition;
                }



            }


        }



    }
    actions
    {
        area(Processing)
        {
            action(Project)
            {
                ApplicationArea = Dimensions;
                Caption = 'Project Budget';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Project Budget";
                RunPageLink = "Dimension Code" = const('DELIVERABLE/ACTIVITY'), "Project Code" = field(No);
                ToolTip = 'Shows the budget of specific projects';
            }
        }
    }


    var
        Edition: Boolean;

    trigger OnOpenPage()
    begin
        Edition := false;
        if Rec."Approval Satus" = Rec."Approval Satus"::Approved then begin
            Edition := false
        end else begin
            Edition := true;
        end;
    end;
}

