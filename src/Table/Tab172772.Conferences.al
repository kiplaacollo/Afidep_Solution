table 172772 Conferences
{
    Caption = 'Conferences';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Conference; Text[200])
        {
            Caption = 'Conference';
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(4; "Where"; Text[100])
        {
            Caption = 'Where';
        }
        field(5; "Focus fit"; Text[100])
        {
            Caption = 'Focus fit';
            //TableRelation = Dimension.code where(Code = const('THEMATIC'));
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                          Blocked = const(false));
        }
        field(6; "What is needed"; Text[2048])
        {
            Caption = 'What is needed';
        }
        field(7; "Action by Who"; Text[2048])
        {
            Caption = 'Action by Who';
            TableRelation = "HR Employees"."No.";
        }
        field(8; "How we can engage"; Text[2048])
        {
            Caption = 'How we can engage';
        }
        field(9; Links; Text[100])
        {
            Caption = 'Links';
        }
        field(10; "End Date"; Date)
        {

        }
    }
    keys
    {
        key(PK; "Code")
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
        Code := noseries.GetNextNo(setup.Conference, TODAY, TRUE);

    end;
}
