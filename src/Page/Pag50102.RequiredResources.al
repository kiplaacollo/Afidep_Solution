Page 50103 "Required Resources"
{
    PageType = ListPart;
    SourceTable = "Resources Required ";
    UsageCategory = Tasks;
    ApplicationArea = ALL;
    Editable = true;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Header No"; Rec."Header No")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                }
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Project/Function area';
                    Visible = false;
                }
                field(Intervention; Rec.Intervention)
                {
                    ApplicationArea = Basic;
                    Caption = 'Identified need/Intervention';
                }
                field("Resources Required"; Rec."Resources Required")
                {
                    ApplicationArea = Basic;
                }
                field("Targets and timelines"; Rec."Targets and timelines")
                {
                    ApplicationArea = Basic;
                }
                field("Person Responsible"; Rec."Person Responsible")
                {
                    ApplicationArea = Basic;
                }


            }
        }
    }
}