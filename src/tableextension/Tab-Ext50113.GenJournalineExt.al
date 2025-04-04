tableextension 50113 "GenJournalineExt" extends "Gen. Journal Line"
{
    fields
    {

        field(50000; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(50001; "Pay Mode"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50002; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Period; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Billing and Payments Periods"."Starting Date";
        }
        field(50004; Ammenity; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit Transaction Types"."Transaction Code";
        }
        field(50005; Property; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Property Details".No;
        }
        field(172014; "Country2"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" =filter('COUNTRY')
                                                          );
        }
         field(172015; "Budget Line Description"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
         field(172016; "Payee"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }

}