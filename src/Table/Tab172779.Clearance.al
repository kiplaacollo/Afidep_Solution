table 172779 Clearance
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees";
        }
        field(2; "Application Code"; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if "Application Code" <> xRec."Application Code" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Clearance Nos");
                    "No series" := '';
                end;
            end;
        }
        field(3; "No series"; Code[30])
        {
        }
        field(4; Position; Text[50])
        {
        }
        field(5; Department; Text[50])
        {
        }
        field(6; Employment; Text[50])
        {
        }
        field(7; "Separation Date"; Date)
        {
        }
        field(8; "Acknowledged/signed separation"; Boolean)
        {
            Caption = 'Acknowledged/ signed separation letter/email';
        }
        field(9; "Hard/ soft copy reports"; Option)
        {
            OptionMembers = "","Yes","No","N/A";
            Caption = '1. Hard/ soft copy of all the reports';
        }
        field(10; "Updated list of reports"; Option)
        {
            OptionMembers = "","Yes","No","N/A";
            Caption = '2. Updated list of all the pending reports/ work ';
        }
        field(11; "Completed Timesheets"; Option)
        {
            OptionMembers = "","Yes","No","N/A";
            Caption = '3. Completed Timesheets for the month';
        }
        field(12; "Finance Clearance note"; Option)
        {
            OptionMembers = "","Yes","No","N/A";
            Caption = '4. Clearance note from Finance/Accounts';
        }
        field(13; "Computer Equipment"; Option)
        {
            OptionMembers = "","Yes","No","N/A";
            Caption = '1. Computer Equipment (laptops, laptop charger, printers, software, Confidential Information disks/ flash disk/memory stick, drawer keys etc.)';
        }
        field(14; "Laptop password"; Option)
        {
            OptionMembers = "","Yes","No","N/A";
            Caption = '2. Laptop password (……………………………………….)';
        }
        field(15; "Laptop bag, cable, Mouse"; Option)
        {
            OptionMembers = "","Yes","No","N/A";
            Caption = '3. Laptop bag, security cable, USB mouse';
        }
        field(16; "Office Phone"; Option)
        {
            OptionMembers = "","Yes","No","N/A";
            Caption = '4. Office Phone';
        }
        field(17; "Library Books/Materials"; Option)
        {
            OptionMembers = "","Yes","No","N/A";
            Caption = '5. Library Books/Materials';
        }
        field(18; "Office Keys"; Option)
        {
            OptionMembers = "","Yes","No","N/A";
            Caption = '6. Office Keys';
        }
        field(19; "Medical card"; Option)
        {
            OptionMembers = "","Yes","No","N/A";
            Caption = '7. Medical card';
        }
        field(20; "Staff ID /Bus card"; Option)
        {
            OptionMembers = "","Yes","No","N/A";
            Caption = '8. Staff ID /Bus card';
        }
        field(21; "Handover confirmation"; Option)
        {
            OptionMembers = "","Yes","No","N/A";
            Caption = '9. Handover confirmation from the supervisor';
        }
        field(22; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Cancelled,Closed;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Cancelled,Closed';

        }
        field(23; "Employee Name"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Line Manager"; Text[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees"."First Name";
        }
    }

    keys
    {
        key(Key1; "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    trigger OnInsert()
    begin
        if "Application Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Clearance Nos");
            NoSeriesMgt.InitSeries(HRSetup."Clearance Nos", xRec."No series", 0D, "Application Code", "No series");
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    // trigger OnInsert()
    // begin

    // end;

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