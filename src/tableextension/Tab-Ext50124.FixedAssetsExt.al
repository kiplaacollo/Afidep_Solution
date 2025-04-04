tableextension 50124 "FixedAssetExt" extends "Fixed Asset"
{
    fields
    {
        field(1720; "Asset Tag No."; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(1721; "Employee No."; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees";
        }
        modify("Responsible Employee")
        {
            TableRelation = "HR Employees";
        }

    }



}