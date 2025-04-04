tableextension 50031 TimeshetHeaderExt extends "Time Sheet Header"
{
    fields
    {
        field(100; Status; Option)
        {
            Editable = false;
            Caption = 'Status';
            OptionMembers = Open,"Submitted Awaiting Approval",Approved;
            DataClassification = ToBeClassified;
        }
    }
}
