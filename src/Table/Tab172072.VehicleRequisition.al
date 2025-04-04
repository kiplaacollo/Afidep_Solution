table 172072 "Vehicle Requisition"
{
    Caption = 'Vehicle Requisition';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Task Order No"; Code[20])
        {
            Caption = 'Task Order No';
            Editable = false;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(3; "Date Requested"; Date)
        {
            Caption = 'Date Requested';
            Editable = false;
        }
        field(4; "Vehicle Required"; Code[50])
        {
            Caption = 'Vehicle Required';
            TableRelation = Vehicles."Registration No";
            trigger OnValidate()
            begin
                Vehiclez.RESET;
                Vehiclez.SetFilter(Vehiclez."Registration No", "Vehicle Required");
                IF Vehiclez.FINDFIRST THEN BEGIN
                    IF Vehiclez."Allocation Status" <> Vehiclez."Allocation Status"::Available THEN
                        ERROR('This vehicle is currently not available for bookings.');
                END;
            end;

        }
        field(5; "Requested By"; Code[400])
        {
            Caption = 'Requested By';
        }
        field(6; Reasons; Text[1080])
        {
            Caption = 'Reasons';
        }
        field(7; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Pending,Approved;
            Editable = false;
        }
        field(8; "Date required"; Date)
        {
            Caption = 'Date requred ';
        }
        field(28; "Time Required"; DateTime)
        {

        }
        field(9; "Duration"; Code[50])
        {
            Caption = 'Duration';
            trigger OnValidate()
            begin
                "Return Date" := CALCDATE(FORMAT(Duration) + 'D', "Date Required");
            end;
        }
        field(29; "Hours Duration"; Code[50])
        {
            Caption = 'Hours Duration';
            trigger OnValidate()
            var
                StartTime: DateTime;
                DurationInHours: Decimal;
                Duration: Duration;
                ReturnTime: DateTime;
            begin
                // Get the starting time
                StartTime := "Time Required";

                // Convert "Hours Duration" to a decimal representing hours
                if not Evaluate(DurationInHours, "Hours Duration") then
                    Error('Invalid format for Hours Duration. Enter a numeric value, e.g., "4".');

                // Convert hours to Duration (1 hour = 3600 seconds)
                Duration := DurationInHours * 3600000;
                //Message('Duration: %1', Duration);

                // Add the duration to the start time
                ReturnTime := StartTime + Duration;
                // Error('return time: %1, Starttime: %2, Duration: %3', ReturnTime, StartTime, Duration);

                // Assign the result to the "Return Hour" field
                "Return Hour" := ReturnTime;
            end;
        }

        field(10; "Return Date"; Date)
        {
            Caption = 'Return Date';
            Editable = false;
        }
        field(30; "Return Hour"; DateTime)
        {
            Caption = 'Return Hour';
            Editable = false;
        }
        field(11; "Global Dimension 1"; Code[50])
        {
            // Caption = 'Global Dimension 1';
            // CaptionClass = '1,2,1';
            // TableRelation = "Dimension Value" where("Global Dimension No." = const(1));
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                // Rec.ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(12; "Global Dimension 2"; Code[1080])
        {
            // Caption = 'Global Dimension 2';
            // CaptionClass = '1,2,2';
            // TableRelation = "Dimension Value" where("Global Dimension No." = const(2));
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                // Rec.ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(13; Destination; Code[1080])
        {
            Caption = 'Destination';
        }
        field(14; "User Id"; Code[250])
        {
            Caption = 'User Id';
        }
        field(15; "No series"; Code[20])
        {
            Caption = 'No series';
        }
        field(16; "Date Created"; Date)
        {
            Caption = 'Date Created ';
        }
        field(17; "Time Entered"; Time)
        {
            Caption = 'Time Entered';
        }
        field(18; "No of Staff"; Integer)
        {
            Caption = 'No of Staff';
            trigger OnValidate()
            begin
                Vehiclez.RESET;
                Vehiclez.SETRANGE(Vehiclez."Registration No", "Vehicle Required");
                IF Vehiclez.FINDFIRST THEN BEGIN
                    IF "No Of Staff" > Vehiclez.Passagers THEN
                        ERROR('This vehicle cannot carry beyond.%1', Vehiclez.Passagers);
                END;
            end;
        }
        field(19; "Officer Requesting"; Code[100])
        {
            Caption = 'Officer Requesting ';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                Customers.RESET;
                Customers.SETRANGE(Customers."No.", "Officer Requesting");
                IF Customers.FIND('-') THEN BEGIN
                    "Name of the officer" := Customers.Name;
                    "Phone No" := Customers."Phone No.";
                END;
            end;
        }
        field(20; "Name of the officer"; Text[1080])
        {
            Caption = 'Name of the officer';
            Editable = false;
        }
        field(21; "Responsibility Center"; Code[100])
        {
            Caption = 'Responsibility Center';
        }
        field(22; "Allocation Status"; Option)
        {
            Caption = 'Allocation Status';
            OptionMembers = Available,"In-Use","Under Maintanance";
        }
        field(23; "Driver Name"; Text[1080])
        {
            Caption = 'Diver Name';
        }
        field(24; Driver; Code[100])
        {
            Caption = 'Driver';
            trigger OnValidate()
            begin
                Person.RESET;
                Person.SETRANGE(Person."No.", Driver);
                IF Person.FIND('-') THEN BEGIN
                    "Driver Name" := Person."First Name" + '  ' + Person."Last Name";
                END;
            end;
        }
        field(25; "Vehicle Allocated"; Code[400])
        {
            Caption = 'Vehicle Allocated';
            TableRelation = Vehicles."Registration No";
            trigger OnValidate()
            BEGIN
                Vehiclez.RESET;
                Vehiclez.SETRANGE(Vehiclez."Registration No", "Vehicle Allocated");
                IF Vehiclez.FIND('-') THEN BEGIN
                    "Vehicle Description" := Vehiclez.Model;
                END;
            END;
        }
        field(26; "Vehicle Description"; Text[200])
        {
            Caption = 'Vehicle Description';
        }
        field(27; "Phone No"; Code[200])
        {
            Caption = 'Phone No';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Task Order No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()

    begin
        if "Task Order No" = '' then begin
            PurchSetup.Get();
            PurchSetup.TestField("Vehicle Order No");
            Noseries.InitSeries(PurchSetup."Vehicle Order No", xRec."No series", 0D, "Task Order No", "No series");
        end;
        "User Id" := "User Id";
        "Date Created" := Today;
        "Time Entered" := Time;
        "Date Requested" := Today;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        Noseries: Codeunit NoSeriesManagement;
        Vehiclez: Record Vehicles;
        Person: Record "HR Employees";
        Customers: Record Customer;


}
