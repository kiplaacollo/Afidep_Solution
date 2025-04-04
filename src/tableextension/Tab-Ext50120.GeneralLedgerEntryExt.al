tableextension 50120 "GeneralLedgerEntryExt" extends "G/L Entry"
{
    fields
    {
        field(17203; "Currency Code 3"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
         field(17204; "Currency Factor3"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable=false;
        }
        field(172030; "Country3"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" =filter('COUNTRY')
                                                          );
        }
        field(172032; "Payee2"; Text[2048])
        {
            DataClassification = ToBeClassified;
            
        }
        field(172033; "BudgetLineDescription2"; Text[2048])
        {
            DataClassification = ToBeClassified;
            
        }
    }


}