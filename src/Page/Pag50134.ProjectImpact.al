Page 50134 "Project Impact"
{
    PageType = ListPart;
    SourceTable = "Project Impact";

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Project Goal/Impact"; Rec."Project Goal/Impact")
                {
                    ApplicationArea = Basic;
                }
                field("Project Objectives/ Outcomes"; Rec."Project Objectives/ Outcomes")
                {
                    ApplicationArea = Basic;
                }
                field("Project Learning Questions"; Rec."Project Learning Questions")
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

