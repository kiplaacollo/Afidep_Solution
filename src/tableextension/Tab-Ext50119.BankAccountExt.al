tableextension 50119 "BankAccountExt" extends "Bank Account"
{
    fields
    {
        field(500; "Transaction No Series"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            
        }
    }


}