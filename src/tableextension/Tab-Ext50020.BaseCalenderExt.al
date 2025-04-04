tableextension 50020 "Base CalenderExt" extends "Base Calendar Change"
{
    fields
    {
        field(7; "Date Day"; Integer)
        {
            Caption = 'Day';
            DataClassification = ToBeClassified;
        }
        field(8; "Date Month"; Integer)
        {
            Caption = 'Month';
            DataClassification = ToBeClassified;
        }
    }
}
