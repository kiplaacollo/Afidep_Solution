report 50043 Gonogodecision
{
    RDLCLayout = './Layouts/gonogodecision.rdlc';
    DefaultLayout = RDLC;
    Caption = 'Gonogodecision';
    dataset
    {
        dataitem(GonoGoDecision; GonoGoDecision)
        {
            column(Budget; Budget)
            {
            }
            column(Call; Call)
            {
            }
            column(Code; "Code")
            {
            }
            column(Engagement; Engagement) { }
            column(Likelihood_of_gift; "Likelihood of gift") { }
            column(Afidep_Role; "Afidep Role") { }
            column(Partner_Type; "Partner Type") { }
            column(Value__US__; "Value (US$)") { }

            column(Decision; Decision)
            {
            }
            column(Decisionnarration; "Decision narration")
            {
            }
            column(Donor; Donor)
            {
            }
            column(Donor_Name; "Donor Name") { }
            column(Donorcontact; "Donor contact")
            {
            }
            column(Duration; "Duration")
            {
            }
            column(Feedback; "Feed back")
            {
            }
            column(Focuscountries; "Focus countries")
            {
            }
            column(Importantlinks; "Important links")
            {
            }
            column(Leadsource; "Lead source")
            {
            }
            column(News; News)
            {
            }
            column(Objectivegoal; "Objective/goal")
            {
            }
            column(Partners; Partners)
            {
            }
            column(Probability; Probability)
            {
            }
            column(Prospecttype; "Prospect type")
            {
            }
            column(Quarter; Quarter)
            {
            }
            column(Status; Status)
            {
            }
            column(Strategicfit; "Strategic fit")
            {
            }
            column(Submissiondeadlinedate; "Submission deadline date")
            {
            }
            column(Submissiondeadlinetime; "Submission deadline time")
            {
            }
            column(Technicalskills; "Technical skills")
            {
            }
            column(Type; "Type")
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
