table 172077 "Payroll M"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[45])
        {
            DataClassification = ToBeClassified;

        }

        field(2; "Payroll Period."; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Payroll Date"; Date)
        {
            DataClassification = ToBeClassified;

        }

        field(4; "User ID"; Code[200])
        {
            DataClassification = ToBeClassified;

        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Cancelled,Closed;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Cancelled,Closed';

        }
        field(6; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(7; Processed; Boolean)
        {
            DataClassification = ToBeClassified;

        }

        field(8; "Sender Signature"; Blob)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Approver Signature"; Blob)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PayrolSetup: Record "Payroll General Setup_AU";
        Payroll: Record "Payroll CalenderMalawi";

    trigger OnInsert()
    begin
        IF "Document No" = '' THEN BEGIN
            PayrolSetup.GET;
            PayrolSetup.TESTFIELD(PayrolSetup."Payrol Numbers");
            NoSeriesMgt.InitSeries(PayrolSetup."Payrol Numbers", xRec."No. Series", 0D, "Document No", "No. Series");
        END;
        "User ID" := USERID;
        "Payroll Date" := TODAY;

        IF Payroll.FINDLAST THEN
            "Payroll Period." := Payroll."Date Opened";

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}