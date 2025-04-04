report 50042 "Engagements planner"
{
    RDLCLayout = './Layouts/EngagementsPlanner.rdlc';
    DefaultLayout = RDLC;
    Caption = 'Engagements planner';
    dataset
    {
        dataitem(EngagementsPlanner; EngagementsPlanner)
        {
            column(Amountasked; "Amount asked")
            {
            }
            column(Askdate; "Ask date")
            {
            }
            column(Code; "Code")
            {
            }
            column(Description; Description)
            {
            }
            column(Estimatedfunds; "Estimated funds")
            {
            }
            column(Fundraisingmethod; "Fundraising method")
            {
            }
            column(Keydecisionmakers; "Key decision makers")
            {
            }
            column(Levelofgiving; "Level of giving")
            {
            }
            column(Likelihoodofgift; "Likelihood of gift")
            {
            }
            column(Location; Location)
            {
            }
            column(Name; Name)
            {
            }
            column(Nextsteps; "Next steps")
            {
            }
            column(Priority; Priority)
            {
            }
            column(Quartelyupdates; "Quartely updates")
            {
            }
            column(Stageofprocess; "Stage of process")
            {
            }
            column(Targettype; "Target type")
            {
            }
            column(Timelineofactivity; "Timeline of activity")
            {
            }
            column(Timingofgiftcompletion; "Timing of gift completion")
            {
            }
            column(Website; "Website ")
            {
            }
            column(Who; Who)
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
