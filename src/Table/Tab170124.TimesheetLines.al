table 170124 "Timesheet Lines"
{
    Caption = 'Timesheet Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Timesheet No"; Code[20])
        {
            Caption = 'Timesheet No';
        }
        field(2; "Staff No"; Code[20])
        {
            Caption = 'Staff No';
        }
        field(3; "Staff Name"; Code[1000])
        {
            Caption = 'Staff Name';
        }
        field(4; Project; Code[50])
        {
            Caption = 'Project';
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROJECTS'));
            //TableRelation = WorkPlan."Project Code";
            trigger OnValidate()
            var
                Dim: Record "Dimension Value";
                HREmployee: Record "HR Employees";
                Workplan2: Record WorkPlan;
            begin
                Dim.Reset();
                Dim.SetRange(Code, Project);
                if Dim.Find('-') then begin
                    "Project decription" := Dim.Name;
                    "Approver ID" := Dim."Approver ID";
                end;

                HREmployee.Reset();
                HREmployee.SetRange("No.", "Staff No");
                if HREmployee.Find('-') then begin
                    "Staff Name" := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                end;
            end;
        }
        field(5; "Workplan "; Code[100])
        {
            Caption = 'Workplan';
            TableRelation = WorkPlan."Workplan Code" where("Project Code" = field(Project));
            trigger OnValidate()
            var
                Workplan2: Record WorkPlan;
            begin
                Workplan2.Reset();
                Workplan2.SetRange("Workplan Code", "Workplan ");
                if Workplan2.Find('-') then begin
                    "Workplan Description" := Workplan2."Workplan Descption";
                end;
            end;
        }
        field(6; Activity; Code[50])
        {
            Caption = 'Activity';
            TableRelation = Activities."Activity Code" where("Workplan Code" = field("Workplan "));
            trigger OnValidate()
            var
                Dim: Record "Dimension Value";
                Activity2: Record Activities;
            begin

                Activity2.Reset();
                Activity2.SetRange("Activity Code", Activity);
                if Activity2.Find('-') then begin
                    "Activity Discription" := Activity2."Activity Description";
                end;
            end;
        }
        field(7; Narration; Text[2048])
        {
            Caption = 'Narration';
        }
        field(8; "Creatin Date"; Date)
        {
            Caption = 'Creatin Date';
        }
        field(9; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(10; Hours; Decimal)
        {
            Caption = 'Hours';
        }
        field(11; "Timesheet Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"Send Awaiting Approval","Project Manager Approved","Line Manager Approved","SMT Lead Approved","HR Approved","Timesheet Rejected",Approved;

        }
        field(12; "Project decription"; Text[2048])
        {
            Caption = 'Projecct description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Activity Discription"; Text[1000])
        {
            Editable = false;
        }
        field(14; Entry; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Workplan Description"; Text[2000])
        {
            Editable = false;
        }
        field(16; "Total Hours"; Decimal)
        {

        }
        field(17; "Total Days"; Decimal)
        {

        }
        field(18; "Approver ID"; Code[30])
        {
            TableRelation = "User Setup"."User ID";
            //Editable = false;
        }
        field(19; "Comments"; Text[2048])
        {
            Editable = false;
        }
        field(20; FieldName; Text[2048])
        {
            Editable = false;
        }
        field(21; "Approval Email Sent"; Boolean)
        {

        }
    }
    keys
    {
        key(PK; "Timesheet No", Entry, "Staff No")
        {
            Clustered = true;
        }
    }
    trigger OnModify()
    begin

    end;
}
