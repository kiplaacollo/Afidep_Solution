report 50048 Propopsaldevelopmenttracker
{
    RDLCLayout = './Layouts/Proposaldevelopmenttracker.rdlc';
    DefaultLayout = RDLC;
    Caption = 'Propopsaldevelopmenttracker';
    dataset
    {
        dataitem(PersonaldevelopmentTracker; "Personal development Tracker")
        {
            column(Annualallocations; "Annual allocations")
            {
            }
            column(Code; "Code")
            {
            }
            column(Description; Description)
            {
            }
            column(Duarion; Duarion)
            {
            }
            column(Focusarea; "Focus area")
            {
            }
            column(Funder; Funder)
            {
            }
            column(Funderprofile; "Funder profile")
            {
            }
            column(Fundertype; "Funder type")
            {
            }
            column(Lead; Lead)
            {
            }
            column(Partner; Partner)
            {
            }
            column(Totalcall; "Total call")
            {
            }
            column(Yeargrantgivenordenied; "Year grant given or denied")
            {
            }
            column(Yearsubmitted; "Year submitted")
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
