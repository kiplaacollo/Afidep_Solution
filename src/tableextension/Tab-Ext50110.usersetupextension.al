tableextension 50110 "usersetupextension" extends "User Setup"
{
    fields
    {

        field(172201; "View Payroll"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(172202; ImprestAccount; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(172203; "Payments Batch"; Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = const('PAYMENTS'));
        }
        field(172204; "Run payslip"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(172205; Signature; Blob)
        {
            Caption = 'Signature';
            SubType = Bitmap;
        }
        field(172000; "Responsibility Center"; Code[500])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(172001; "Post Rights"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(172002; "Supper Approver Rights"; Boolean)
        {
            DataClassification = ToBeClassified;


        }
        field(172003; "Modify Forms"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(172004; "View Malawi Payroll"; Boolean)
        {

        }
        field(172005; "Keep Change"; Boolean)
        {

        }
        field(172006; "Changes"; Boolean)
        {

        }
        field(172007; "Company Change"; Boolean)
        {

        }
        field(172008; "Change Work Date"; Boolean)
        {

        }
        field(172010; "Delegation Rights"; Boolean)
        {
        }

    }




}

