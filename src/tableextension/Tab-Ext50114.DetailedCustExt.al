tableextension 50114 "DetailedCustExt" extends "Detailed Cust. Ledg. Entry"
{
    fields
    {

        field(50003; Period; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Ammenity; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Property; Code[40])
        {
            DataClassification = ToBeClassified;
        }
    }

}