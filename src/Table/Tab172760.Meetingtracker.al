table 172760 "Meeting tracker"
{
    Caption = 'Meeting tracker';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; Organisation; Code[50])
        {
            Caption = 'Organisation';
        }
        field(3; "Priority level"; option)
        {
            OptionMembers = "P1","P2","P3","NA";
            Caption = 'Priority level';
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(5; Agenda; Text[2048])
        {
            Caption = 'Agenda';
        }
        field(6; "Key items"; Text[2048])
        {
            Caption = 'Key items discussed';
        }
        field(7; "Other notes"; Text[2048])
        {
            Caption = 'Other notes';
        }
        field(8; Designation; Code[100])
        {
            Caption = 'Designation';
        }
        field(9; Converted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        noseries: Codeunit NoSeriesManagement;
        setup: record ResourceMobilizationSetup;
    begin
        setup.get();
        No := noseries.GetNextNo(setup.Mettingtracker, TODAY, TRUE);

    end;
}
