page 17299 Perfomacesetup
{
    Caption = 'Perfomacesetup';
    PageType = Card;
    SourceTable = "PMS Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("External Maximum Score"; Rec."External Maximum Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Maximum Score field.';
                    Visible = false;
                }
                field("External Minimum Score"; Rec."External Minimum Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Minimum Score field.';
                    Visible = false;
                }
                field("Maximun value Core Performance"; Rec."Maximun value Core Performance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximun value Core Performance field.';
                    Visible = false;
                }
                field("Minimum Value Core Performance"; Rec."Minimum Value Core Performance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Value Core Performance field.';
                    Visible = false;
                }
                field("Target Numbers"; Rec."Target Numbers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target Numbers field.';
                    Visible = false;
                }
                field("Performance Numbers"; Rec."Performance Numbers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Performance Numbers field.';
                    Editable = true;
                }
                field("Peers Minimum Score"; Rec."Peers Minimum Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Peers Minimum Score field.';
                    Visible = false;
                }
                field("Peers Maximum Score"; Rec."Peers Maximum Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Peers Maximum Score field.';
                    Visible = false;
                }
                field("Surbodinate Minimum Score"; Rec."Surbodinate Minimum Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Surbodinate Minimum Score field.';
                    Visible = false;
                }
                field("Surbodinate Maximum Score"; Rec."Surbodinate Maximum Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Surbodinate Maximum Score field.';
                    Visible = false;
                }
                field("Total Rating% Peers"; Rec."Total Rating% Peers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Rating% Peers field.';
                    Visible = false;
                }
                field("Total Rating% External"; Rec."Total Rating% External")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Rating% External field.';
                    Visible = false;
                }
                field("Total Rating%Subordinates"; Rec."Total Rating%Subordinates")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Rating%Subordinates field.';
                    Visible = false;
                }
                field("Values Minimum Score"; Rec."Values Minimum Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Values Minimum Score field.';
                    Visible = false;
                }
                field("Values Maximum Score"; Rec."Values Maximum Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Values Maximum Score field.';
                    Visible = false;
                }
                field("Workplan Application Nos"; Rec."Workplan Application Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Workplan Application Nos field.';
                    Visible = false;
                }
                field("Workplan Department Nos"; Rec."Workplan Department Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Workplan Department Nos field.';
                    Visible = false;
                }
                field("Workplan Numbers"; Rec."Workplan Numbers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Workplan Numbers field.';
                    Visible = false;
                }
            }
        }
    }
}
