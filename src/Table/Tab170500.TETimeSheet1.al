Table 170500 "TE Time Sheet1"
{


    Caption = 'Time Sheet Lines';

    fields
    {
        field(1; "Line No."; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = TimesheetLines;
        }
        field(2; "Document No."; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = TimesheetLines.Timesheetcode;
        }
        field(5; "User ID"; Code[50])
        {
            Caption = 'User ID';

            trigger OnValidate()
            begin
                UpdateDefaults;
            end;
        }
        field(10; "Week Start Date"; Date)
        {
            Caption = 'Week Start Date';
        }
        field(15; "Time Type Code"; Code[10])
        {
            Caption = 'Time Type Code';
        }
        field(20; Description; Text[1000])
        {
            Caption = 'Description';
        }
        field(30; "Day 1"; Decimal)
        {
            Caption = 'Day 1';

            trigger OnValidate()
            begin


            end;
        }
        field(31; "Day 2"; Decimal)
        {
            Caption = 'Day 2';

            trigger OnValidate()
            begin
                if ("Day 2" <> xRec."Day 2") then begin
                    Error(TX002);
                end;

            end;
        }
        field(32; "Day 3"; Decimal)
        {
            Caption = 'Day 3';

            trigger OnValidate()
            begin
                if ("Day 3" <> xRec."Day 3") then begin

                end;

            end;
        }
        field(33; "Day 4"; Decimal)
        {
            Caption = 'Day 4';

            trigger OnValidate()
            begin
                if ("Day 4" <> xRec."Day 4") then begin

                end;

            end;
        }
        field(34; "Day 5"; Decimal)
        {
            Caption = 'Day 5';

            trigger OnValidate()
            begin
                if ("Day 5" <> xRec."Day 5") then begin

                end;

            end;
        }
        field(35; "Day 6"; Decimal)
        {
            Caption = 'Day 6';

            trigger OnValidate()
            begin


            end;
        }
        field(36; "Day 7"; Decimal)
        {
            Caption = 'Day 7';

            trigger OnValidate()
            begin


            end;
        }
        field(38; "Global Dimension 1 Code"; Code[200])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin


                DimValues.SetRange(DimValues.Code, "Global Dimension 1 Code");
                if DimValues.FindFirst then BEGIN
                    Description := DimValues.Name;

                END;



            end;
        }
        field(39; "Global Dimension 2 Code"; Code[200])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(40; "Global Dimension 3 Code"; Code[200])
        {
            CaptionClass = 'Deliverables / activity';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));//, "Project Code" = field("Global Dimension 2 Code"));
        }
        field(41; "Global Dimension 4 Code"; Code[200])
        {
            CaptionClass = '1,1,4';
            Caption = 'Global Dimension 4 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(42; "Global Dimension 5 Code"; Code[200])
        {
            CaptionClass = '1,1,5';
            Caption = 'Global Dimension 5 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
        field(43; "Global Dimension 6 Code"; Code[200])
        {
            CaptionClass = '1,1,6';
            Caption = 'Global Dimension 6 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
        }
        field(44; "Global Dimension 7 Code"; Code[200])
        {
            CaptionClass = '1,1,7';
            Caption = 'Global Dimension 7 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
        }
        field(45; "Global Dimension 8 Code"; Code[200])
        {
            CaptionClass = '1,1,8';
            Caption = 'Global Dimension 8 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
        }
        field(46; "Fund No."; Code[10])
        {
            Caption = 'Fund No.';

            trigger OnValidate()
            begin

            end;
        }
        field(47; "Dimension Speedkey Code"; Code[10])
        {
            Caption = 'Dimension Speedkey Code';

            trigger OnValidate()
            begin


            end;
        }
        field(70; Chargeable; Boolean)
        {
            Caption = 'Chargeable';
        }
        field(150; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(300; "Internal Control No."; Code[50])
        {
            Caption = 'Internal Control No.';
        }
        field(305; DateDisplay; Date)
        {
            Caption = 'DateDisplay';
        }
        field(310; DayStatus; Option)
        {
            Caption = 'DayStatus';
            OptionCaption = 'New,Submitted,Approval Pending,Approved,Historical';
            OptionMembers = New,Submitted,"Approval Pending",Approved,Historical;
        }
        field(800; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(801; "Status Filter"; Option)
        {
            Caption = 'Status Filter';
            OptionCaption = 'New,Submitted,,Approved,Posted';
            OptionMembers = New,Submitted,,Approved,Posted;
        }
        field(50000; "Employee No"; Code[30])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Last Name";


            end;
        }
        field(50001; "Employee Name"; Text[100])
        {
        }
        field(50002; "Leave Type"; Code[30])
        {

            trigger OnValidate()
            begin

                Leave.Get("Leave Type");
                Description := Leave.Description;


            end;
        }
        field(50003; Hours; Integer)
        {
        }
        field(50004; Date; Date)
        {

            trigger OnValidate()
            begin

                Hrs := 0;
                TETimeSheet.Reset;
                TETimeSheet.SetRange(Date, Date);
                TETimeSheet.SetRange("Employee No", "Employee No");
                if TETimeSheet.FindSet then begin
                    repeat
                        Hrs := TETimeSheet.Hours;
                    until TETimeSheet.Next = 0;
                end;
                if Hrs + Hours > 8 then
                    Error('You cannot book for more than 14 hours in a day');


            end;
        }
        field(50005; Narration; Text[2048])
        {
        }
        field(50006; Supurvisor; Code[30])
        {
        }
        field(50007; "Program Accountant"; Code[30])
        {
        }
        field(50008; Sequency; Integer)
        {
        }
        field(50009; Status; Option)
        {
            OptionCaption = 'New,ApprovalPending,Canceled,Approved';
            OptionMembers = New,ApprovalPending,Canceled,Approved;

            trigger OnValidate()
            begin
                TETimeSheet.Reset;
                TETimeSheet.SetRange("Document No.", TimesheetLines.Timesheetcode);
                TETimeSheet.SetRange(Status, TimesheetLines.Status::Approved);
                if TETimeSheet.FindFirst then begin
                    Status := Status::Approved;
                end;
            end;
        }
        field(50010; Entry; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Entry, Date, "Global Dimension 1 Code", "Global Dimension 3 Code")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin


    end;

    trigger OnInsert()
    begin




    end;

    trigger OnModify()
    begin


    end;

    var
        TEText001: label 'Cannot change hours unless Day Status is New.';
        TEText002: label 'Cannot change User ID. You must delete the line instead.';
        TEText003: label 'Cannot modify unless Day Status is New.';
        TEText004: label 'Fund %1 is blocked. ';
        Employee: Record "HR Employees";
        DimValues: Record "Dimension Value";
        TX001: label 'You can''t have Project & Leave Timesheet on the same line';
        TimeControl: Decimal;
        TX002: label 'Timesheet Shouldn''t Exceed 8 hours';
        Usersetup: Record "User Setup";
        Hrs: Decimal;
        Employee6: Record Employee;
        Usersetup6: Record "User Setup";
        TETimeSheet: Record "TE Time Sheet1";
        Leave: Record "HR Leave Types";
        TimesheetLines: Record TimesheetLines;


    procedure GetNextEntryNo(): Integer
    begin

        TETimeSheet.Reset;
        TETimeSheet.SetCurrentkey("Line No.");
        if TETimeSheet.FindLast then
            exit(TETimeSheet.Entry + 100)
        else
            exit(100);
    end;


    procedure CheckDays()
    begin


    end;


    procedure UpdateDefaults()
    var
        UserSetup: Record "User Setup";
        Employee: Record Employee;
    begin

    end;


    procedure TestRequiredFields()
    begin

    end;


    procedure SetSourceCode(): Code[10]
    var
        SourceCodeSetup: Record "Source Code Setup";
    begin

    end;
}

