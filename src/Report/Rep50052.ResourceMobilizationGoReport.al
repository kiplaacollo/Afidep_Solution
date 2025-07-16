report 50052 "Resource Mobilization Go-No-Go"
{
    RDLCLayout = './Layouts/ResourceMobilizationGo.rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(GonoGoDecision; GonoGoDecision)
        {
            column(Code; Code) { }
            column(Donor; Donor) { }
            column(Engagement; Engagement) { }
            column(Donor_Name; "Donor Name") { }
            column(Strategic_fit; "Strategic fit") { }
            column(Value__US__;"Value (US$)"){}
            column(Likelihood_of_gift;"Likelihood of gift"){}
            column(Focus_area_code;"Focus area code"){}
            

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
