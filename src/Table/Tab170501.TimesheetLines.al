Table 170501 "TimesheetLines"
{

    fields
    {
        field(1; Timesheetcode; Code[45])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(2; From; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "To"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            Enabled = true;
        }
        field(5; comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; projectCode; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROJECT'));

            trigger OnValidate()
            begin
                DimensionValue.Reset;
                DimensionValue.SetRange(Code, projectCode);
                if DimensionValue.FindFirst then begin
                    projectText := DimensionValue.Name;
                end;
            end;
        }
        field(7; projectText; Text[450])
        {
            DataClassification = ToBeClassified;
        }
        field(8; hours; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Employee No"; Code[25])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                if HREmployees.Get("Employee No") then
                    "Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                "Supervisor ID" := HREmployees."Supervisor ID";
            end;
        }
        field(10; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,"Send Awaiting Approval","Project Manager Approved","Line Manager Approved","SMT Lead Approved","HR Approved","Timesheet Rejected",Approved';
            OptionMembers = Open,"Send Awaiting Approval","Project Manager Approved","Line Manager Approved","SMT Lead Approved","HR Approved","Timesheet Rejected",Approved;
        }
        field(13; "Supervisor ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees";
        }
        field(14; "To Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(15; "Requester Signature"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Approver1Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(17; Approver2Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Timesheetcode)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Timesheetcode = '' then begin
            GenSetup.Get;
            GenSetup.TestField(GenSetup."Time Sheet Nos.");
            NoSeriesMgt.InitSeries(GenSetup."Time Sheet Nos.", xRec."No series", 0D, Timesheetcode, "No series");
        end;
    end;

    var
        GenSetup: Record "Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmployees: Record "HR Employees";
        DimensionValue: Record "Dimension Value";
        TETimeSheet1: Record "TE Time Sheet1";

    local procedure GetEndOfMonthDate(Date: Date)
    var
        Year: Integer;
        Month: Integer;
        DaysInMonth: Integer;
    begin
    end;
}

