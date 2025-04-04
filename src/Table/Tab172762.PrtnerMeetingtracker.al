table 172762 PrtnerMeetingtracker
{
    Caption = 'PrtnerMeetingtracker';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Partner staff code"; Code[60])
        {
            Caption = 'Partner staff code';
        }
        field(3; "Partner staff name"; Text[100])
        {
            Caption = 'Partner staff name';
        }
        field(4; "Partner title"; Text[100])
        {
            Caption = 'Partner title';
        }
        field(5; "Partner email"; Text[30])
        {
            Caption = 'Partner email';
        }
        field(6; "Partner phone"; Code[30])
        {
            Caption = 'Partner phone';
        }
    }



    keys
    {
        key(PK; "Code", "Partner staff code")
        {
            Clustered = true;
        }
    }


}
