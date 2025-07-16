Page 50101 ProjectWorkLoad
{
    PageType = ListPart;
    SourceTable = "Projects Work Load";
    UsageCategory = Tasks;
    ApplicationArea = ALL;
    Editable = true;
    DeleteAllowed = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Header No"; Rec."Header No")
                {
                    ApplicationArea = Basic;
                }
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = Basic;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Project/Function area';
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = Basic;
                    Caption = 'Weighting/Level of Effort (%)';
                }

            }
        }
    }
}