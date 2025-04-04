table 50031 "Attachments"
{
    DrillDownPageID = "Attachments Setup";
    LookupPageID = "Attachments Setup";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Attachment; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Attachment';
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; Attachment)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}