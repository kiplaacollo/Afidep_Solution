tableextension 50108 "StandardTextEx" extends "Standard Text"
{
    fields
    {

        field(7; "G/L Account"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(8; "No. Series2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(9; "Type2"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"Focus Area","Sub Pillar","GL Category",Department;
        }
    }


    fieldgroups
    {
    }


}

