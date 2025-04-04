tableextension 50111 "CountryRegion" extends "Country/Region"
{
    fields
    {

        field(8009; Type3; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Country,County;
        }
    }




    var
        CountryRegionNotFilledErr: label 'You must specify a country or region.';
        ISOCodeLengthErr: label 'The length of the string is %1, but it must be equal to %2 characters. Value: %3.', Comment = '%1, %2 - numbers, %3 - actual value';
        ASCIILetterErr: label 'must contain ASCII letters only';
        TypeHelper: Codeunit "Type Helper";
        NumericErr: label 'must contain numbers only';




}



tableextension 50050 "BankLine" extends "Bank Acc. Reconciliation Line"
{
    fields
    {

        modify("Statement Amount")
        {
            trigger OnAfterValidate()
            begin
                
            end;
        }
    }




    var
        CountryRegionNotFilledErr: label 'You must specify a country or region.';
        ISOCodeLengthErr: label 'The length of the string is %1, but it must be equal to %2 characters. Value: %3.', Comment = '%1, %2 - numbers, %3 - actual value';
        ASCIILetterErr: label 'must contain ASCII letters only';
        TypeHelper: Codeunit "Type Helper";
        NumericErr: label 'must contain numbers only';




}
