Table 170044 "HR Appraisal Lines"
{



    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Appraisal No"; Code[30])
        {
            TableRelation = "HR Appraisal Header"."No.";
        }
        field(3; "Appraisal Period"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code where(Type = filter("Appraisal Period"),
                                                           Closed = const(false));
        }
        field(4; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Employees";
        }
        field(5; Sections; Option)
        {
            OptionCaption = 'Objectives,Core Responsibilities/Duties,Last year''s goals,Things learnt From Training,Value Added From Training,Attendance&Punctuality,Communication,Cooperation,Internal/External Clients,Initiative,Planning & Organization,Quality,Team Work,Sales Skills,Leadership,Performance Coaching';
            OptionMembers = Objectives,"Core Responsibilities/Duties","Last year's goals","Things learnt From Training","Value Added From Training","Attendance&Punctuality",Communication,Cooperation,"Internal/External Clients",Initiative,"Planning & Organization",Quality,"Team Work","Sales Skills",Leadership,"Performance Coaching";
        }
        field(6; "Perfomance Goals and Targets"; Text[250])
        {
        }
        field(7; "Self Rating"; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                if "Self Rating" > maxRating then Error('[%1 %2] should have a Maximum Score of [%3]', FieldCaption("Self Rating"), "Self Rating", maxRating);
            end;
        }
        field(8; "Peer Rating"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Peer Rating" > maxRating then Error('The score %1 should have a max Score of %2', "Peer Rating", maxRating);
            end;
        }
        field(9; "Supervisor Rating"; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                if "Supervisor Rating" > maxRating then Error('The score %1 should have a max Score of %2', "Supervisor Rating", maxRating);
            end;
        }
        field(10; "Sub-ordinates Rating"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Sub-ordinates Rating" > maxRating then Error('The score %1 should have a max Score of %2', "Sub-ordinates Rating", maxRating);
            end;
        }
        field(11; "Outside Agencies Rating"; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                if "Outside Agencies Rating" > maxRating then Error('The score %1 should have a max Score of %2', "Outside Agencies Rating", maxRating);
            end;
        }
        field(17; "Agreed Rating"; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                if "Agreed Rating" > maxRating then Error('The score %1 should have a max Score of %2', "Agreed Rating", maxRating);
            end;
        }
        field(18; "Agreed Rating x Weighting"; Decimal)
        {
        }
        field(19; "Employee Comments"; Text[250])
        {
        }
        field(21; "Key Performance Indicators"; Text[250])
        {
        }
        field(22; "Supervisor Comments"; Text[250])
        {
        }
        field(23; "Key Output Areas"; Text[200])
        {
        }
        field(25; "Approval Status"; Option)
        {
            OptionMembers = "Pending Approval",Approved;
        }
        field(26; "Categorize As"; Option)
        {
            OptionCaption = ' ,Employee''s Subordinates,Employee''s Peers,External Sources,Job Specific,Self Evaluation,Personal Goals/Objectives,Core Values,Managerial';
            OptionMembers = " ","Employee's Subordinates","Employee's Peers","External Sources","Job Specific","Self Evaluation","Personal Goals/Objectives","Core Values",Managerial;
        }
        field(27; "Sub Category"; Option)
        {
            OptionCaption = ' ,Objectives,Core Responsibilities / Duties,Attendance & Punctuality,Communication,Cooperation,Planning & Organization,Quality,Team Work,Sales Skills,Leadership,Performance Coaching,Personal Goals,Core Value,Managerial';
            OptionMembers = " ",Objectives,"Core Responsibilities / Duties","Attendance & Punctuality",Communication,Cooperation,"Planning & Organization",Quality,"Team Work","Sales Skills",Leadership,"Performance Coaching","Personal Goals","Core Value",Managerial;
        }
        field(28; "External Source Rating"; Decimal)
        {
        }
        field(29; "External Source Comments"; Text[250])
        {
        }
        field(30; "Min. Target Score"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Min. Target Score" > maxRating then Error('The score %1 should have a max Score of %2', "Min. Target Score", maxRating);
            end;
        }
        field(31; "Max Target Score"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Max Target Score" > maxRating then Error('The score %1 should have a max Score of %2', "Max Target Score", maxRating);
            end;
        }
        field(32; Strengths; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(33; Weaknesses; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Areas of Improvement"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Expected Standards"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(36; Descriptors; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(37; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(38; "Core Competencies"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Integrity,Timeliness,Professionalism,Knowledge/Technical Competency,Communication,Team Work,Time Management,Creativity,Continous Learning & Performance Improvement,Customer/Citizen Focus';
            OptionMembers = Integrity,Timeliness,Professionalism,"Knowledge/Technical Competency",Communication,"Team Work","Time Management",Creativity,"Continous Learning & Performance Improvement","Customer/Citizen Focus";
        }
        field(39; "Managerial & Supervisory"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Managerial Accountability,Planning & Organizing skills,Staff Training & Development Skills,Resources management skills,Being Proactive,Judgement and Objectivity,Managing Performance,Promoting use of Informaction Technology';
            OptionMembers = "Managerial Accountability","Planning & Organizing skills","Staff Training & Development Skills","Resources management skills","Being Proactive","Judgement and Objectivity","Managing Performance","Promoting use of Informaction Technology";
        }
        field(40; Comments; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Score Values"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin


            end;
        }
        field(42; "Course Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Appraisee Reaction"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Lessons Learnt"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Appraisee Remarks"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Supervisor Remarks"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Managerial Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                // if Performance.Get("Managerial Score") then begin
                //   Descriptors:=Performance.Assesment;
                //   end;
            end;
        }
        field(48; "S/N"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "M/N"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Assessment Core"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "Key Performance Areas"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Assessment Managerial"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(53; "Performance Assessment"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(54; "Value Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                if "Value Score" > maxRating then begin
                    Error('You cannot rate above the maximum rating of,%1', maxRating);
                end else begin
                    if HRAppraisalLines.Get("Value Score") then begin
                        if "Value Score" = 1 then begin
                            "Assessment Core" := 'Poor';
                        end;
                    end;
                end;
                /*END ELSE
              IF "Value Score"= (2.0-2.9)THEN BEGIN
              Descriptors:='Fair'
                END ELSE
                IF "Value Score"= (3.0-3.9)THEN BEGIN
              Descriptors:='Good'
                END ELSE
                IF "Value Score"= (4.0-4.9)THEN BEGIN
              Descriptors:='Very Good'
                END ELSE
                IF "Value Score"=(5.0) THEN BEGIN
              Descriptors:='Excellent'*/
                //END ;
                //END;

            end;
        }
        field(55; "Managers Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(56; "Comments managers"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Previous Value Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(58; "Previous Managerial Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(59; "Previous Agreed Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(60; "Mean Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(61; "Previous Mean Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Managerial Supervisory Comp"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Values/core competence"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Appraisal Assessment vs"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Score vs"; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Appraisal Assessment ms"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Score ms"; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Appraisal Stage"; Option)
        {
            OptionMembers = "Target Setting","Target Approval","Mid Year Review","End Year Evaluation","Supervisor Evaluation","Appraisal Completed";
            FieldClass = FlowField;
            CalcFormula = lookup("HR Appraisal Header"."Appraisal Stage" where("No." = field("Appraisal No")));
            Editable = false;

        }
    }

    keys
    {
        key(Key1; "Line No", "Appraisal No", "Appraisal Period", "Employee No")
        {
            Clustered = true;
        }
        key(Key2; Sections)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('You cannot delete this data');
    end;

    var
        Employee: Record "HR Employees";
        HRAppraisalGoalSettingH: Record "HR Appraisal Header";
        AppraisalScores: Record "HR Appraisal Lines";
        mycurrStatus: Boolean;
        objHRSetup: Record "HR Setup";
        Vendor: Record Vendor;
        Customer: Record Customer;
        HRAPPHEADER: Record "HR Appraisal Header";
        HRAppraisalLines: Record "HR Appraisal Lines";
    // CoreV: Record "Delegation Header";
    // MainV: Record "Delegation Line";
    // Performance: Record "Perfomance Ratings";


    procedure maxRating() maxRating: Decimal
    begin
        maxRating := 0;
        objHRSetup.Reset;
        objHRSetup.SetRange(objHRSetup."Primary Key");
        if objHRSetup.Find('-') then
            maxRating := objHRSetup."Max Appraisal Rating";
    end;
}

