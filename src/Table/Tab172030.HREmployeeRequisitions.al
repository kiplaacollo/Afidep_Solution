Table 172030 "HR Employee Requisitions"
{
    DrillDownPageID = "HR Employee Requisitions List";
    LookupPageID = "HR Employee Requisitions List";

    fields
    {
        field(2; "Job ID"; Code[60])
        {
            NotBlank = true;
            TableRelation = "HR Jobss"."Job ID";

            trigger OnValidate()
            begin
                HRJobs.Reset;
                if HRJobs.Get("Job ID") then begin

                    "Job Description" := HRJobs."Job Description";
                    "Vacant Positions" := HRJobs."Vacant Positions";
                    "Job Grade" := HRJobs.Grade;
                    "Global Dimension 2 Code" := HRJobs."Global Dimension 2 Code";
                    "Job Supervisor/Manager" := HRJobs."Supervisor/Manager";
                    HRJobs."Responsibility Center" := "Responsibility Center";
                end;


                /*
              mDivision:='';
              mResponsibility:='';

              userSetup.RESET;
              userSetup.SETRANGE(userSetup."User ID",USERID);
              IF userSetup.FIND('-') THEN BEGIN
               mDivision:=userSetup."Global Dimension 2 Code";
               mResponsibility:=userSetup."Responsibility Center";
              END;

              HRJobs.RESET;
              HRJobs.SETRANGE(HRJobs."Job ID","Job ID");
              HRJobs.SETFILTER(HRJobs."Global Dimension 2 Code",'=%1',mDivision);
              HRJobs.SETFILTER(HRJobs."Responsibility Center",'=%1',mResponsibility);
              IF HRJobs.FIND('-') THEN
               BEGIN
              //  message('success');
               END
              ELSE BEGIN
                "Job ID":='';
                ERROR('The job position chosen is not in your division');
              END;
                    */

            end;
        }
        field(3; "Requisition Date"; Date)
        {

            trigger OnValidate()
            begin
                if (Rec."Requisition Date" - Today) < 0 then
                    Message('Days in the past are not allowed');
            end;
        }
        field(4; Priority; Option)
        {
            OptionCaption = 'High,Medium,Low';
            OptionMembers = High,Medium,Low;
        }
        field(5; Positions; Integer)
        {
        }
        field(6; Approved; Boolean)
        {

            trigger OnValidate()
            begin
                "Date Approved" := Today;
            end;
        }
        field(7; "Date Approved"; Date)
        {
        }
        field(8; "Job Description"; Text[200])
        {
            Editable = false;
        }
        field(9; Stage; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(10; Score; Decimal)
        {
            FieldClass = Normal;
        }
        field(11; "Stage Code"; Code[20])
        {
        }
        field(12; Qualified; Boolean)
        {
            FieldClass = Normal;
        }
        field(13; "Job Supervisor/Manager"; Code[20])
        {
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(17; "Turn Around Time"; Integer)
        {
            Editable = false;
        }
        field(21; "Grace Period"; Integer)
        {
        }
        field(25; Closed; Boolean)
        {
            Editable = false;
        }
        field(26; "Requisition Type"; Option)
        {
            OptionCaption = ' ,Internal,External,Both';
            OptionMembers = " ",Internal,External,Both;
        }
        field(27; "Closing Date"; Date)
        {

            trigger OnValidate()
            begin
                //mercy
                if "Closing Date" < "Requisition Date" then begin
                    Error('Closing Date cannot be before requisition date');
                end;

                if "Closing Date" - "Requisition Date" < 30 then begin
                    Error('The period cannot be less than 30 Days');
                end;
                //endmercy
            end;
        }
        field(28; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Advertised';
            OptionMembers = New,"Pending Approval",Approved,Advertised;
        }
        field(38; "Required Positions"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Required Positions" > "Vacant Positions" then begin
                    Error('Required positions exceed the total  no of Vacant Positions');
                end;

                if "Required Positions" <= 0 then begin
                    Error('Required positions cannot be Less Than or Equal to Zero');
                end;
            end;
        }
        field(39; "Vacant Positions"; Decimal)
        {
            Editable = false;
        }
        field(3949; "Reason for Request(Other)"; Text[100])
        {
        }
        field(3950; "Any Additional Information"; Text[100])
        {
        }
        field(3958; "Job Grade"; Text[100])
        {
            Editable = false;
            TableRelation = "HR Lookup Values".Code where(Type = const(Grade));
        }
        field(3964; "Type of Contract Required"; Code[200])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Contract Type"));
        }
        field(3965; "Reason For Request"; Option)
        {
            OptionMembers = "New Vacancy",Replacement,Retirement,Retrenchment,Demise,Other;
        }
        field(3966; Requestor; Code[50])
        {
            
        }
        field(3967; "No. Series"; Code[100])
        {
        }
        field(3968; "Requisition No."; Code[20])
        {
        }
        field(3969; "Responsibility Center"; Code[100])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(3970; "Shortlisting Comittee"; Code[20])
        {
        }
        field(3971; Advertise; Boolean)
        {
        }
        field(3972; "Type of Advertisement"; Option)
        {
            OptionMembers = " ",Internal,"Internal&External";
        }
        field(3973; "Advertise Internally"; Boolean)
        {
        }
        field(3974; "No. of Interviews"; Integer)
        {
        }
        field(3980; "Education Type"; Enum "Education Types")
        {
            DataClassification = CustomerContent;
            Caption = 'Education Type';
        }
        field(3983; "Education Level"; Enum "Education Level")
        {
            DataClassification = CustomerContent;
            Caption = 'Education Level';
        }
        field(3982; "Proficiency Level"; Enum "Proficiency Level")
        {
            DataClassification = CustomerContent;
            Caption = 'Proficiency Level';
        }
        field(3984; "Minimum years of experience"; integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum years of experience';
        }
        field(3975; "Maximum years of experience"; integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum years of experience';
        }
        field(3976; "Experience industry"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Company Job Industry";
            Caption = 'Experience industry';
        }
        field(3977; "Professional Course"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = Qualifications.Code where("Qualification Type" = const(Academic), "Education Level" = const(Professional));
            Caption = 'Professional Course';
        }
        field(3978; "Professional Membership"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Professional Memberships";
            Caption = 'Professional Membership';
        }
        field(3979; "Field of Study"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Field of Study";
            Caption = 'Field of Study';
        }
        field(3987; "Date Advertised"; date)
        {
            //Editable = false;
        }
        field(3986; "Date Closed"; date)
        {
            //Editable = false;
        }
    }

    keys
    {
        key(Key1; "Requisition No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Job ID", "Job Description")
        {
        }
    }

    trigger OnDelete()
    begin

        if Status <> Status::New then
            Error('You cannot delete this record if its status is' + ' ' + Format(Status));
    end;

    trigger OnInsert()
    begin
        //GENERATE DOCUMENT NUMBER
        if "Requisition No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Employee Requisition Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Employee Requisition Nos.", xRec."No. Series", 0D, "Requisition No.", "No. Series");
        end;

        userSetup.Reset;
        userSetup.SetRange(userSetup."User ID", UserId);

        Requestor := UserId;
        "Requisition Date" := Today;
        "Responsibility Center" := mResponsibility;
        "Global Dimension 2 Code" := mDivision;
    end;

    trigger OnModify()
    begin
        userSetup.Reset;
        userSetup.SetRange(userSetup."User ID", UserId);

    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRJobs: Record "HR Jobss";
        HREmployeeReq: Record "HR Employee Requisitions";
        userSetup: Record "User Setup";
        mDivision: Code[50];
        mResponsibility: Code[50];
}

