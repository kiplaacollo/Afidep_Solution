report 50051 "Resource Mobilization Report"
{
    RDLCLayout = './Layouts/ResourceMobilization.rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(PersonaldevelopmentTracker; "Personal development Tracker")
        {
            column(Annualallocations; "Annual allocations")
            {
            }
            column(Afidep_Role; "Afidep Role") { }
            column(AFIDEP_Budget; "AFIDEP Budget") { }
            column(Value__US__; "Value (US$)") { }
            column(Oportunity_value; "Oportunity value") { }
            column(Year_submitted; "Year submitted") { }
            column(Year_grant_given_or_denied; "Year grant given or denied") { }
            column(Year_of_decision; "Year of decision") { }
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
            column(Year_first_submitted; "Year first submitted")
            {
            }
            column(focus_area_code; "focus area code") { }
            column(Status; Status) { }
            column(Funder_Name; "Funder Name") { }
            column(Likelihood_of_gift; "Likelihood of gift") { }
            column(Partner_Type; "Partner Type") { }
            column(Role; Role) { }
            column(Duration; Duration) { }
            column(Engagement; Engagement) { }
            column(BudgetCategory; GetBudgetCategory("Value (US$)")) { }
            //    column(DurationNumeric; GetDurationAsDecimal(Duarion)) { }
            column(Engagement___deadline; "Engagement + deadline") { }

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

    procedure GetBudgetCategory(ValueUSD: Decimal): Text[20]
    begin
        if ValueUSD > 5000000 then
            exit('> $5M');
        if ValueUSD > 3000000 then
            exit('> $3M');
        if ValueUSD > 1000000 then
            exit('> $1M');
        if ValueUSD > 500000 then
            exit('> $500K');
        exit('< $500K');
    end;

    // procedure GetDurationAsDecimal(TextValue: Text[50]): Decimal
    // var
    //     DurationValue: Decimal;
    // begin
    //     Evaluate(DurationValue, TextValue); // safely converts if possible
    //     exit(DurationValue);
    // end;

}
