table 17350 "Check-in"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[45])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                purchHeader: Record "Purchase Header";
            begin

            end;




        }
        field(2; "Claim No"; Code[45])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if rec."Claim No" <> '' then begin
                    rec."Doc Status" := Rec."Doc Status"::Closed;
                end;

            end;

        }
        field(3; "Location"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(4; "Latitude"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(5; Longitude; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Employee No"; code[45])
        {
            TableRelation = "HR Employees"."No.";
            trigger
            OnValidate()
            var
                HrEmployees: Record "HR Employees";
            begin
                HrEmployees.Reset();
                HrEmployees.SetRange("No.", "Employee No");
                if HrEmployees.Find('-') then begin
                    "Employee Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                    "Captured by" := UserId;
                    "Document Date" := Today;
                end;
            end;
        }
        field(7; "Employee Name"; text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Duration"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Released,Pending Approval,Approved,Rejected';
            OptionMembers = Open,Released,"Pending Approval",Approved,Rejected;
        }
        field(17; "Doc Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Closed';
            OptionMembers = Open,Closed;
        }
        field(12; "Captured by"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "No. Series"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(15; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Current Status"; Boolean)
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
        key(Key2; "Claim No")
        {
            //Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PerformanceSetup: Record "PMS Setup";
        HrSetup: Record "HR Setup";
        HREmployees: Record "HR Employees";

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            HrSetup.Get();
           // HrSetup.TestField(HrSetup."Geolocation No");
          //  NoSeriesMgt.InitSeries(HrSetup."Geolocation No", xRec."No. Series", 0D, "Document No", "No. Series");
        end;
        "Document Date" := Today;
        HREmployees.Reset;
        HREmployees.SetRange(HREmployees."User ID", UserId);
        if HREmployees.FindFirst then begin
            "Employee No" := HREmployees."No.";
            "Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Last Name";
        end;

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