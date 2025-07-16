table 172715 Qualifications
{
    Caption = 'Qualification';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = Qualificationss;
    LookupPageID = Qualificationss;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Qualified Employees"; Boolean)
        {
            CalcFormula = Exist("Employee Qualifications" WHERE("Qualification Code" = FIELD(Code),
                                                                "Employee Status" = CONST(Active)));
            Caption = 'Qualified Employees';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Qualification Type"; Option)
        {
            OptionCaption = ' ,Academic,Professional,Technical,Experience,Personal Attributes';
            OptionMembers = " ",Academic,Professional,Technical,Experience,"Personal Attributes";
            DataClassification = CustomerContent;
            Caption = 'Qualification Type';
        }
        field(5; "Field of Study"; Code[50])
        {
            TableRelation = "Field of Study";
            DataClassification = CustomerContent;
            Caption = 'Field of Study';
        }
        field(6; "Education Level"; Enum "Education Level")
        {
            DataClassification = CustomerContent;
            Caption = 'Education Level';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

table 172716 "Employee Qualifications"
{
    Caption = 'Employee Qualification';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Qualified Employees";
    LookupPageID = "Employee Qualification";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Qualification Code"; Code[10])
        {
            Caption = 'Qualification Code';
            TableRelation = Qualifications;

            trigger OnValidate()
            begin
                Qualification.Get("Qualification Code");
                Description := Qualification.Description;
            end;
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ",Internal,External,"Previous Position";
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "Institution/Company"; Text[100])
        {
            Caption = 'Institution/Company';
        }
        field(9; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
        }
        field(10; "Course Grade"; Text[50])
        {
            Caption = 'Course Grade';
        }
        field(11; "Employee Status"; Enum "Employee Status")
        {
            Caption = 'Employee Status';
            Editable = false;
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name" = CONST("Employee Qualification"),
                                                                     "No." = FIELD("Employee No."),
                                                                     "Table Line No." = FIELD("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Qualification Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Comment then
            Error(Text000);
    end;

    trigger OnInsert()
    begin
        Employee.Get("Employee No.");
        "Employee Status" := Employee.Status;
    end;

    var
        Qualification: Record Qualifications;
        Employee: Record "HR Employees";

        Text000: Label 'You cannot delete employee qualification information if there are comments associated with it.';
}

table 172717 "Field of Study"
{
    Caption = 'Field of Study';
    DataClassification = CustomerContent;
    DrillDownPageId = "Fields of Study";
    LookupPageId = "Fields of Study";

    fields
    {
        field(1; Code; Code[50])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}
table 172718 "Company Job Education"
{
    Caption = 'Company Job Education';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Job ID"; Code[50])
        {
            Caption = 'Job ID';
            DataClassification = CustomerContent;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(3; "Field of Study"; Code[50])
        {
            Caption = 'Field of Study';
            DataClassification = CustomerContent;
            TableRelation = "Field of Study".Code;

            trigger OnValidate()
            begin
                if FieldOfStudy.Get("Field of Study") then
                    "Field Name" := FieldOfStudy.Description;
            end;
        }
        field(4; "Field Name"; Text[100])
        {
            Caption = 'Field Name';
            DataClassification = CustomerContent;
        }
        field(5; "Education Level"; Enum "Education Level")
        {
            DataClassification = CustomerContent;
            Caption = 'Education Level';
        }
        field(6; Score; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score';
        }
        field(7; "Qualification Code"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = Qualifications.Code where("Field of Study" = field("Field of Study"), "Education Level" = field("Education Level"));
            Caption = 'Qualification Code';

            trigger OnValidate()
            begin
                if Qualifications.Get("Qualification Code") then
                    "Qualification Name" := Qualifications.Description;
            end;
        }
        field(8; "Qualification Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Qualification Name';
        }
        field(9; "Proficiency Level"; Enum "Proficiency Level")
        {
            DataClassification = CustomerContent;
            Caption = 'Proficiency Level';
        }
        field(11; "Section/Level"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Section/Level';
        }
        field(12; "Qualification Code Prof"; Code[50])
        {
            DataClassification = CustomerContent;
            // TableRelation = Qualification.Code;
            Caption = 'Qualification Code Prof';

            trigger OnValidate()
            begin
                if Qualifications.Get("Qualification Code Prof") then
                    "Qualification Name" := Qualifications.Description;
            end;
        }
    }

    keys
    {
        key(PK; "Job ID", "Line No")
        {
            Clustered = true;
        }
    }

    var
        FieldOfStudy: Record "Field of Study";
        Qualifications: Record Qualifications;
}

table 172719 "Company Job Industry"
{
    Caption = 'Company Job Industry';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[50])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}

table 172720 "Company Job Experience"
{
    Caption = 'Company Job Experience';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Job ID"; Code[50])
        {
            Caption = 'Job ID';
            DataClassification = CustomerContent;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(3; Industry; Code[50])
        {
            Caption = 'Industry';
            DataClassification = CustomerContent;
            TableRelation = "Company Job Industry".Code;

            trigger OnValidate()
            begin
                if CompanyJobIndustry.Get(Industry) then
                    "Industry Name" := CompanyJobIndustry.Description;
            end;
        }
        field(4; "Industry Name"; Text[100])
        {
            Caption = 'Industry Name';
            DataClassification = CustomerContent;
        }
        field(5; "Hierarchy Level"; Enum "Hierarchy Level")
        {
            Caption = 'Hierarchy Level';
            DataClassification = CustomerContent;
        }
        field(6; "No. of Years"; Decimal)
        {
            Caption = 'No. of Years';
            DataClassification = CustomerContent;
        }
        field(7; Score; Decimal)
        {
            Caption = 'Score';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Job ID", "Line No")
        {
            Clustered = true;
        }
    }

    var
        CompanyJobIndustry: Record "Company Job Industry";
}
table 172721 "Company Job Prof Membership"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Job ID"; Code[50])
        {
            Caption = 'Job ID';
            DataClassification = CustomerContent;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(3; Name; Code[500])
        {
            DataClassification = CustomerContent;
            TableRelation = "Professional Memberships";
            Caption = 'Name';

            trigger OnValidate()
            var
                ProfMemb: Record "Professional Memberships";
            begin
                if ProfMemb.Get(Name) then
                    Description := ProfMemb.Description;
            end;
        }
        field(4; Description; Code[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Job ID", Name, "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
table 172722 "Professional Memberships"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Name; Code[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(2; Description; Code[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
table 172723 "Key Job responsibilities"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No';
        }
        field(2; Code; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(3; Description; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }

    }

    keys
    {
        key(Key1; Code, "Line No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

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
table 172724 "Applicant Job Education"
{
    Caption = 'Applicant Job Education';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Applicant No."; Code[50])
        {
            Caption = 'Applicant No.';
            DataClassification = CustomerContent;
            TableRelation = "HR Job Applications"."Application No";
        }
        field(2; "Education Type"; Enum "Education Types")
        {
            Caption = 'Education Type';
            DataClassification = CustomerContent;
        }
        field(3; Institution; Code[50])
        {
            Caption = 'Institution';
            DataClassification = CustomerContent;
            TableRelation = "Education Institution"."Institution Code" where(Type = field("Institution Type"));

            trigger OnValidate()
            begin
                if EducationInstitutions.Get(Institution) then
                    "Institution Name" := EducationInstitutions."Institution Name";
            end;

        }
        field(4; "Institution Name"; Text[250])
        {
            Caption = 'Institution Name';
            DataClassification = CustomerContent;
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Start Date" > Today then
                    Error('Start date can not be a future date');

                if "End Date" <> 0D then
                    if "Start Date" > "End Date" then
                        Error('Start Date can not be later than Start Date');
            end;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "End Date" > Today then
                    Error('End date can not be a future date');

                if "Start Date" <> 0D then
                    if "End Date" < "Start Date" then
                        Error('End Date can not be earlier than Start Date');
            end;
        }
        field(7; Country; Code[50])
        {
            Caption = 'Country';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region".Code;
        }
        field(8; Region; Code[50])
        {
            Caption = 'Region';
            DataClassification = CustomerContent;
            //TableRelation = Counties."County Code";
        }
        field(9; "Field of Study"; Code[50])
        {
            Caption = 'Field of Study';
            DataClassification = CustomerContent;
            //TableRelation = "Field of Study";
            trigger OnValidate()
            var
                ApplicantJobEducation: Record "Applicant Job Education";
                HRJobApplications: Record "HR Job Applications";
            begin
                // HRJobApplications.Reset();
                // HRJobApplications.SetRange(HRJobApplications."Application No", "Applicant No.");
                // if HRJobApplications.Find('-') then begin
                //     HRJobApplications."Field of Study" := "Field of Study";
                //     HRJobApplications.Modify(true);
                // end;
            end;
        }
        field(10; "Qualification Code"; Code[50])
        {
            Caption = 'Qualification Code';
            DataClassification = CustomerContent;
            TableRelation = Qualifications.Code where("Qualification Type" = const(Academic), "Field of Study" = field("Field of Study"), "Education Level" = field("Education Level"));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin

                if Qualifications.Get("Qualification Code") then
                    "Qualification Name" := Qualifications.Description;
            end;
        }
        field(11; "Qualification Name"; Text[250])
        {
            Caption = 'Qualification Name';
            DataClassification = CustomerContent;
        }
        field(12; "Education Level"; Enum "Education Level")
        {
            Caption = 'Education Level';
            DataClassification = CustomerContent;
        }
        field(13; "Highest Level"; Boolean)
        {
            Caption = 'Highest Level';
            DataClassification = CustomerContent;
        }
        field(14; Grade; Code[10])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
        }
        field(15; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(16; Score; Decimal)
        {
            Caption = 'Score';
            DataClassification = CustomerContent;
        }
        field(17; "Proficiency Level"; Enum "Proficiency Level")
        {
            DataClassification = CustomerContent;
            Caption = 'Proficiency Level';
        }
        field(18; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(19; "Need Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Need Code';
        }
        field(20; "Section/Level"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Section/Level';
        }
        field(21; "Qualification Code Prof"; Text[500])
        {
            Caption = 'Qualification Code';
            DataClassification = CustomerContent;
            //TableRelation = Qualifications.Code where("Education Level" = filter(Professional));

            trigger OnValidate()
            begin
                if Qualifications.Get("Qualification Code Prof") then
                    "Qualification Name" := Qualifications.Description;
            end;
        }
        field(22; "Institution Type"; Enum "Education Institution Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Institution Type';
        }
    }

    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }

    var
        Qualifications: Record Qualifications;
        EducationInstitutions: Record "Education Institution";
}
table 172725 "Education Institution"
{
    Caption = 'Education Institution';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Education Intitutions";
    LookupPageId = "Education Intitutions";

    fields
    {
        field(1; "Institution Code"; Code[20])
        {
            Caption = 'Institution Code';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                if "Institution Code" <> xRec."Institution Code" then begin
                    HRSetup.Get();
                    HRSetup.TestField("Education Institution Nos");
                    NoSeriesMgt.TestManual(HRSetup."Education Institution Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Institution Name"; Text[250])
        {
            Caption = 'Institution Name';
            DataClassification = SystemMetadata;
        }
        field(3; "Type"; Enum "Education Institution Type")
        {
            Caption = 'Type';
            DataClassification = SystemMetadata;
        }
        field(4; "No. Series"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'No. Series';
        }
    }
    keys
    {
        key(PK; "Institution Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Institution Code", "Institution Name")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Institution Code" = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Education Institution Nos");
            NoSeriesMgt.InitSeries(HRSetup."Education Institution Nos", xRec."No. Series", 0D, "Institution Code", "No. Series");
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRSetup: Record "HR Setup";
}
table 172726 "Applicant Job Experience"
{
    Caption = 'Applicant Job Experience';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Applicant No."; Code[50])
        {
            Caption = 'Job ID';
            DataClassification = CustomerContent;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(3; Employer; Text[250])
        {
            Caption = 'Employer';
            DataClassification = CustomerContent;
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Start Date" > Today then
                    Error('You can not input a date in the future');

                if "End Date" <> 0D then
                    if "Start Date" > "End Date" then
                        Error('Start Date can not be greater that End Date');

                if ("Start Date" <> 0D) and ("End Date" <> 0D) then
                    "No. of Years" := Round((("End Date" - "Start Date") / 365), 0.01, '=');
            end;
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "End Date" > Today then
                    Error('You can not input a date in the future');

                if "Start Date" <> 0D then
                    if "End Date" < "Start Date" then
                        Error('End Date can not be earlier than Start Date');

                if ("Start Date" <> 0D) and ("End Date" <> 0D) then
                    "No. of Years" := Round((("End Date" - "Start Date") / 365), 0.01, '=');
            end;
        }
        field(6; "Present Employment"; Boolean)
        {
            Caption = 'Present Employment';
            DataClassification = CustomerContent;
        }
        field(7; Industry; Code[50])
        {
            Caption = 'Industry';
            DataClassification = CustomerContent;
            TableRelation = "Company Job Industry";
        }
        field(8; "Hierarchy Level"; Enum "Hierarchy Level")
        {
            DataClassification = CustomerContent;
            Caption = 'Hierarchy Level';
        }
        field(9; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(10; "Not Under Notice"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Not Under Notice';
        }
        field(11; "Job Title"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Title';
        }
        field(12; "Employer Email Address"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Employer Email Address';

            trigger OnValidate()
            begin
                Mail.CheckValidEmailAddress("Employer Email Address");
            end;
        }
        field(13; "Employer Postal Address"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Employer Postal Address';
        }
        field(14; "Functional Area"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Functional Area';
        }
        field(15; Score; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score';
        }
        field(16; Country; Code[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
            Caption = 'Country';
        }
        field(17; Location; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Location';
        }
        field(18; "No. of Years"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Years';
        }
        field(19; "Need Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Need Code';
        }
        field(20; "Total no of years in industry"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total no of years in industry';
        }
        field(21; "Most relevant industry"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Most relevant industry';
        }
    }

    keys
    {
        key(PK; "Applicant No.", "Line No")
        {
            Clustered = true;
        }
    }

    var
        Mail: Codeunit "Mail Management";
}
table 172727 "Applicant Prof Membership"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Applicant No."; Code[50])
        {
            Caption = 'Applicant No.';
            DataClassification = CustomerContent;
        }
        field(2; "Professional Body"; Text[500])
        {
            DataClassification = CustomerContent;
            // TableRelation = "Professional Memberships";
            Caption = 'Professional Body';

            trigger OnValidate()
            var
                profmemb: Record "Professional Memberships";
            begin
                if profmemb.Get("Professional Body") then
                    Description := profmemb.Description;
            end;
        }
        field(3; MembershipNo; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'MembershipNo';
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(5; "Need Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Need Code';
        }
        field(6; Description; Code[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
table 172728 "Employment History"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Employee."No.";
            Caption = 'Employee No.';
        }
        field(2; From; Date)
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            Caption = 'From';
        }
        field(3; "To"; Date)
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            Caption = 'To';
        }
        field(4; "Company Name"; Text[150])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            Caption = 'Company Name';
        }
        field(5; "Postal Address"; Text[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Postal Address';
        }
        field(6; "Address 2"; Text[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Address 2';
        }
        field(7; "Job Title"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Title';
        }
        field(8; "Key Experience"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Key Experience';
        }
        field(9; "Salary On Leaving"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Salary On Leaving';
        }
        field(10; "Reason For Leaving"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason For Leaving';
        }
        field(11; Current; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Current';

            trigger OnValidate()
            begin

                EmpHistory.Reset();
                EmpHistory.SetRange("Employee No.", "Employee No.");
                if EmpHistory.Find('-') then
                    repeat
                        if (EmpHistory.From <> From) or (EmpHistory."To" <> "To") or
                           (EmpHistory."Company Name" <> "Company Name") then begin
                            if EmpHistory.Current then
                                Error(Text000, EmpHistory."Company Name", EmpHistory.From, EmpHistory."To");
                        end;
                    until EmpHistory.Next() = 0;
            end;
        }
        field(12; Industry; Code[50])
        {
            Caption = 'Industry';
            DataClassification = CustomerContent;
            TableRelation = "Company Job Industry";
        }
        field(13; "Hierarchy Level"; Enum "Hierarchy Level")
        {
            DataClassification = CustomerContent;
            Caption = 'Hierarchy Level';
        }
        field(14; "No. of Years"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Years';
        }
    }

    keys
    {
        key(Key1; "Employee No.", From, "To")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmpHistory: Record "Employment History";
        Text000: Label 'You can''t have more than one current job \ %1  from %2 to %3 is current';
}


