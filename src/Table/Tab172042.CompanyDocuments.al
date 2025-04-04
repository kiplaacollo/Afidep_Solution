Table 172042 "Company Documents"
{
    DrillDownPageID = Documents;
    LookupPageID = Documents;

    fields
    {
        field(1; "Doc No."; Code[20])
        {
        }
        field(2; "Document Description"; Text[300])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                /*CompanyDocs.RESET;
                CompanyDocs.SETRANGE("Document Description","Document Description");
                IF CompanyDocs.FINDFIRST THEN ERROR('Document already exists');*/

            end;
        }
        field(3; "Document Link"; Text[300])
        {
        }
        field(6; "Attachment No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(7; "Language Code (Default)"; Code[10])
        {
            TableRelation = Language;
        }
        field(8; Attachment; Option)
        {
            Editable = false;
            OptionMembers = No,Yes;
        }
        field(9; "No. Series"; Code[20])
        {
        }
        field(10; Type; Option)
        {
            OptionCaption = 'Company,Leave';
            OptionMembers = Company,Leave;
        }
        field(11; Mandatory; Boolean)
        {
        }
        field(12; Checked; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Doc No.", "Document Description")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*IF "Doc No." = '' THEN BEGIN
          HRSetup.GET;
          HRSetup.TESTFIELD("Company Documents");
          NoSeriesMgt.InitSeries(HRSetup."Company Documents",xRec."No. Series",0D,"Doc No.","No. Series");
        END;*/

    end;

    var
        CompanyDocs: Record "Company Documents";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

