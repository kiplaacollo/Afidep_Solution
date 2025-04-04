table 50030 "Job Attachments"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Job ID"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Job ID';
        }
        field(2; Attachment; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Attachments;
            Caption = 'Attachment';

            trigger OnValidate()
            begin

                if Attachments.Get(Attachment) then
                    Description := Attachments.Description;
            end;
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Job ID", Attachment)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Attachments: Record Attachments;
}