Table 50018 "HR Appraisal Header"
{

    fields
    {
        field(1; "No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            //
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    PerformanceSetup.Get;
                    NoSeriesMgt.TestManual(PerformanceSetup."Performance Numbers");
                    "No. series" := '';
                end;
            end;
        }
        field(2; "Supervisor User ID"; Code[200])
        {
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(3; "Appraisal Type"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Appraisal Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Appraisal Periods".Code where(Open = const(true));
        }
        field(5; "Appraisal Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Appraisee,Supervisor,Others';
            OptionMembers = Appraisee,Supervisor,Others;
            trigger OnValidate()
            var
                InStr: InStream;
                OutStr: OutStream;
            begin
                if "Appraisal Status" = "Appraisal Status"::Supervisor then begin
                    if HREmp.Get("Employee No.") then begin
                        if HREmp."Signature".HasValue then begin
                            HREmp."Signature".CreateInStream(InStr);
                            "Employee Signature".CreateOutStream(OutStr);
                            CopyStream(OutStr, InStr);
                        end;
                    end;
                end;

                if ("Appraisal Status" = "Appraisal Status"::Supervisor) and ("Appraisal Stage" <> "Appraisal Stage"::"Target Setting") then begin
                    if HREmp.Get("Supervisor User ID") then begin
                        if HREmp."Signature".HasValue then begin
                            HREmp."Signature".CreateInStream(InStr);
                            "Appraiser Signature".CreateOutStream(OutStr);
                            CopyStream(OutStr, InStr);
                        end;
                    end;
                end;
            end;
        }
        field(6; Recommendations; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Appraisal Stage"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Target Setting","Target Approval","Mid Year Review","End Year Evaluation","Supervisor Evaluation","Appraisal Completed";
        }
        field(9; Sent; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Appraisee,Supervisor,Completed,Rated';
            OptionMembers = Appraisee,Supervisor,Completed,Rated;
        }
        field(10; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(11; Picture; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(12; "Employee No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmp.Reset();
                HREmp.SetRange(HREmp."No.", "Employee No.");
                if HREmp.FindFirst() then begin
                    "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Department Code" := HREmp."Global Dimension 2 Code";
                    "Supervisor No." := HREmp."Manager Emp No";
                    "User ID" := UserId;
                    "Supervisor User ID" := HREmp."Supervisor ID";
                    "Supervisor Name" := HREmp."Supervisor  Name";
                    "Date of First Appointment" := HREmp."Date Of Join";
                    "Job Title" := HREmp."Job Title";
                end;

                TargetSeries := 0;
                TargetLines.Reset;
                TargetLines.SetRange(TargetLines.Period, "Appraisal Period");
                TargetLines.SetRange(TargetLines."Staff No", "Employee No.");
                if TargetLines.FindFirst then begin
                    repeat
                        TargetSeries := TargetSeries + 1;
                        AppraissalLinesWP.Init;
                        AppraissalLinesWP."Appraisal No." := TargetSeries;
                        AppraissalLinesWP."Key Value Driver" := TargetLines."Key Value Drivers";
                        AppraissalLinesWP."Key Performance Indicator" := TargetLines."Key Performance Indicator";
                        AppraissalLinesWP."Agreed Performance Targets" := TargetLines.Target;
                        AppraissalLinesWP.Weight := TargetLines.Weight;
                        AppraissalLinesWP."Header No" := "No.";
                        AppraissalLinesWP.Insert(true);
                    until TargetLines.Next = 0;
                end;

                ValueSeries := 0;
                StaffValues.Reset;
                if StaffValues.FindFirst then begin
                    repeat
                        ValueSeries := ValueSeries + 1;
                        AppraisalLinesValues.Init;
                        AppraisalLinesValues."Appraisal No." := ValueSeries;
                        AppraisalLinesValues."Header No" := "No.";
                        // AppraisalLinesValues.Values := StaffValues.Value;
                        AppraisalLinesValues.Description := StaffValues.Description;
                        AppraisalLinesValues.Insert(true);
                    until StaffValues.Next = 0;
                end;
            end;
        }
        field(13; "Employee Name"; Text[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Date of First Appointment"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; Designation; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
            end;
        }
        field(18; "Department Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Comments Appraisee"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Comments Appraiser"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Evaluation Period Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Evaluation Period End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Target Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Company Targets,Individual Targets,Peer Targets,Surbodinates Targets,Out Agencies Targets,Company Rating,Individual Rating,Peer Rating,Surbodinates Rating,Out Agencies Rating';
            OptionMembers = " ","Company Targets","Individual Targets","Peer Targets","Surbodinates Targets","Out Agencies Targets","Company Rating","Individual Rating","Peer Rating","Surbodinates Rating","Out Agencies Rating";
        }
        field(25; "Supervisor No."; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees"."No.";
        }
        field(26; "Final Scores"; Decimal)
        {
        }
        field(27; "Final Soft Scores"; Decimal)
        {
        }
        field(28; "Total Scores"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
        }
        field(29; "Rating Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Locked; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; "Supervisor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "E-mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(33; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Closed;
            Editable = false;
        }
        field(34; "Current Scale"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Scale Year"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Appraisal Period."; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "No. series"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(38; Manager; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Total Target Score"; Decimal)
        {
            CalcFormula = sum("Appraissal Lines WP"."Agreed-Assesment Score" where("Header No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Total Behavioral Score"; Decimal)
        {
            CalcFormula = sum("Appraisal Lines Values"."Agreed Score" where("Header No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "Surbodinate Line Scores"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(42; "Performance Line Scores"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(43; "Competencies Line Scores"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(44; "Appraised Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(45; "Appraised Narration"; Text[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(46; "Score Grading"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(47; "Assign To Peers"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(48; "Assign To Subordinate"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(49; "Assign To Customer"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(50; Appraised; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "Appraised By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52; "Directorate Code"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(53; "Directorate Name"; Code[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(54; "User Designation"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Officer,Asst Manager,Manager,Director,CEO,BOD';
            OptionMembers = " ",Officer,"Asst Manager",Manager,Director,CEO,BOD;
        }
        field(55; Remark; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Total Targets"; Decimal)
        {
            CalcFormula = sum("Appraissal Lines WP".Weight where("Header No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Job Title"; Text[1000])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees"."Job Title";
            Editable = false;
        }
        field(58; "Goal Setting (31 Jan)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Annual Review (31 Dec)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Mid Term Review (31 Jul)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Supervisor Target Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Supervisor Target Rejected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "HR Target Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Hr Target Rejected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Supervisor Target Comments"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "HR Target Comments"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "HR Mid Comments"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "HR Annual Comments"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Supervisor MID Rejected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Supervisor MID Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "HR Mid Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Hr Mid Rejected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Supervisor Annual Rejected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Supervisor Annual Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "HR Annual Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(76; "Hr Annual Rejected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(77; HR; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(78; "Employee Signature"; Blob)
        {
            Caption = 'Employee Signature';
            SubType = Bitmap;
        }

        field(79; "Appraiser Signature"; Blob)
        {
            Caption = 'Appraiser Signature';
            SubType = Bitmap;
        }
        field(80; "Date sent Aprroval"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Date Aprroved"; Date)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            PerformanceSetup.Get;
            PerformanceSetup.TestField(PerformanceSetup."Performance Numbers");
            NoSeriesMgt.InitSeries(PerformanceSetup."Performance Numbers", xRec."No. series", 0D, "No.", "No. series");
        end;
        "Document Date" := Today;
        "Appraisal Stage" := "Appraisal Stage"::"Target Setting";

        HREmp.Reset();
        HREmp.SetRange(HREmp."Employee UserID", UserId);
        if HREmp.FindFirst then begin
            "Employee No." := HREmp."No.";
            "Employee Name" := HREmp."First Name" + ' ' + HREmp."Last Name";
            "Supervisor User ID" := HREmp."Supervisor ID";
            "Supervisor Name" := HREmp."Supervisor  Name";
            "User ID" := HREmp."Employee UserID";

        end else begin
            Error('User not set up.');
        end;

        AppraisalPeriods.Reset;
        AppraisalPeriods.SetRange(AppraisalPeriods.Open, true);
        if AppraisalPeriods.FindFirst then begin
            "Appraisal Period" := AppraisalPeriods.Code;
            "Evaluation Period End Date" := AppraisalPeriods."Period End Date";
            "Evaluation Period Start Date" := AppraisalPeriods."Period Start Date";
        end;
    end;

    // TargetSeries := 0;
    // TargetLines.Reset;
    // TargetLines.SetRange(TargetLines.Period, "Appraisal Period");
    // TargetLines.SetRange(TargetLines."Staff No", "Employee No.");
    // if TargetLines.FindFirst then begin
    //     repeat
    //         TargetSeries := TargetSeries + 1;
    //         AppraissalLinesWP.Init;
    //         AppraissalLinesWP."Appraisal No." := TargetSeries;
    //         AppraissalLinesWP."Key Value Driver" := TargetLines."Key Value Drivers";
    //         AppraissalLinesWP."Key Performance Indicator" := TargetLines."Key Performance Indicator";
    //         AppraissalLinesWP."Agreed Performance Targets" := TargetLines.Target;
    //         AppraissalLinesWP.Weight := TargetLines.Weight;
    //         AppraissalLinesWP."Header No" := "No.";
    //         AppraissalLinesWP.Insert(true);
    //     until TargetLines.Next = 0;
    // end;

    //     ValueSeries := 0;
    //     StaffValues.Reset;
    //     if StaffValues.FindFirst then begin
    //         repeat
    //             ValueSeries := ValueSeries + 1;
    //             AppraisalLinesValues.Init;
    //             AppraisalLinesValues."Appraisal No." := ValueSeries;
    //             AppraisalLinesValues."Header No" := "No.";
    //             // AppraisalLinesValues.Values := StaffValues.Value;
    //             AppraisalLinesValues.Description := StaffValues.Description;
    //             AppraisalLinesValues.Insert(true);
    //         until StaffValues.Next = 0;
    //     end;
    // end;

    var
        HRAppHeader: Record "HR Appraisal Header";
        HREmp: Record "HR Employees";
        HREmpCopy: Record "HR Employees";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmpCard: Page "Employee Card";
        CompanyScoreAppraisee: Decimal;
        KPIScoreAppraisee: Decimal;
        PFScoreAppraisee: Decimal;
        PFBase: Decimal;
        UserSetup: Record "User Setup";
        Approver: Record "User Setup";
        KPIScoreAppraiser: Decimal;
        KPIScoreMgt: Decimal;
        PFScoreAppraiser: Decimal;
        PFScoreMgt: Decimal;
        LineNo: Integer;
        DimensionValue: Record "Dimension Value";
        PerformanceSetup: Record "PMS Setup";
        AppraissalLinesWP: Record "Appraissal Lines WP";
        AppraisalPeriods: Record "Appraisal Periods";
        TargetLines: Record "Target Lines";
        StaffValues: Record "Staff Values";
        AppraisalLinesValues: Record "Appraisal Lines Values";
        ValueSeries: Integer;
        TargetSeries: Integer;
}

