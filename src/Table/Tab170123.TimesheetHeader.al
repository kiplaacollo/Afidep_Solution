table 170123 "Timesheet Header"
{
    Caption = 'Timesheet Header ';
    DataClassification = ToBeClassified;



    fields
    {
        field(1; "Timesheet Header No"; Code[20])
        {
            Caption = 'Timesheet Header No';
            Editable = false;

        }
        field(2; "Staff No"; Code[20])
        {
            Caption = 'Staff No';
            TableRelation = "HR Employees";
            trigger OnValidate()
            begin
                HREmployee.Reset();
                HREmployee.SetRange("No.", "Staff No");
                if HREmployee.Find('-') then begin
                    "Staff Name" := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                end;
            end;
        }
        field(3; "Staff Name"; Text[1000])
        {
            Caption = 'Staff Name';
            Editable = false;
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(6; "No series"; Code[30])
        {
        }
        field(7; "Timesheet Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"Send Awaiting Approval","Project Manager Approved","Line Manager Approved","SMT Lead Approved","HR Approved","Timesheet Rejected",Approved;
        }
        field(8; "Approver ID"; Code[30])
        {
            FieldClass = Normal;
            //  CalcFormula = lookup("Timesheet Lines"."Approver ID" where("Timesheet Status" = filter("Line Manager Approved")));

        }
        field(9; "SMT Lead"; code[50])
        {
            TableRelation = "HR Employees"."Employee UserID";
        }
        field(10; "Human Resource manager"; code[50])
        {
            TableRelation = "HR Employees"."Employee UserID";
        }
        field(11; "Line Manager"; Code[50])
        {
            TableRelation = "HR Employees"."Supervisor ID";
        }
        field(12; "employee Signature"; Blob)
        {
            // TableRelation = "HR Employees".Signature;
        }
        field(13; "SMT Lead Signature"; Blob)
        {
            //TableRelation = "HR Employees".Signature;
        }
        field(14; "Line manager Signature"; Blob)
        {
            //  TableRelation = "HR Employees".Signature;
        }
        field(15; "Date Submitted"; Date)
        {
        }
        field(16; "Line Manager Approved Date"; Date)
        {
        }
        field(17; "SMT Lead Approve date"; Date)
        {
        }
    }
    keys
    {
        key(PK; "Timesheet Header No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

        //No. Series
        if "Timesheet Header No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Timesheet No");
            NoSeriesMgt.InitSeries(HRSetup."Timesheet No", xRec."No series", 0D, "Timesheet Header No", "No series");
        end;
    end;

    trigger OnModify()
    begin
        // if xRec."Timesheet Status" <> "Timesheet Status"::Open then
        //     Error('You cannot modify the timesheet');
    end;

    trigger OnDelete()
    var
        TimesheetLine: Record "Timesheet Lines";
    begin
        TimesheetLine.Reset;
        TimesheetLine.SetRange(TimesheetLine."Timesheet No", Rec."Timesheet Header No");
        if TimesheetLine.FindSet() then begin
            repeat
                TimesheetLine.Delete();
            until TimesheetLine.Next() = 0;
        end;
    end;

    var
        HREmployee: Record "HR Employees";
        HrSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
