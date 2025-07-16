codeunit 80151 "Recruitement Port"
{
    var
        JobApplicationsTable: Record "HR Job Applications";
        JobsAvailableTable: Record "HR Employee Requisitions";
        JobDescriptionsTable: Record "HR Jobss";
        lJsonArray: DotNet JArray;
        lJObject: dotnet JObject;
        lJObject2: dotnet JObject;
        lJObject1: dotnet JObject;
        FilePath: DotNet Path;

    trigger OnRun()
    begin
    end;


    procedure RetrieveUserJobApplications(args: Text): Text
    var
        appsjsonobj: JsonObject;
        appsjsonarr: JsonArray;
    begin
        Clear(appsjsonarr);
        Clear(appsjsonobj);
        JobApplicationsTable.Reset();
        if args <> '' then begin
            lJObject := lJObject.Parse(args);
            if Format(lJObject.SelectToken('userid')) <> '' then
                JobApplicationsTable.SetRange("ID Number", Format(lJObject.SelectToken('userid')));
            if JobApplicationsTable.FindSet() then begin
                repeat
                    Clear(appsjsonobj);
                    appsjsonobj.Add('applicationnumber', JobApplicationsTable."Application No");
                    appsjsonobj.add('status', Format(JobApplicationsTable.Status));
                    appsjsonobj.add('stage', JobApplicationsTable.Stage);
                    appsjsonobj.add('dateapplied', JobApplicationsTable."Date Applied");
                    appsjsonobj.add('description', JobApplicationsTable."Job Applied for Description");
                    appsjsonarr.Add(appsjsonobj);
                until JobApplicationsTable.Next() = 0;
            end;
        end;

        exit(Format(appsjsonarr));
    end;


    procedure AddJobApplication(args: Text): Text
    var
        appsjsonobj: JsonObject;
        appsjsonarr: JsonArray;
    begin
        if (args <> '') then begin
            lJObject := lJObject.Parse(args);
            JobApplicationsTable.Reset();

            if ((Format(lJObject.SelectToken('userid')) <> '') and (Format(lJObject.SelectToken('requestid')) <> '')) then begin
                JobApplicationsTable.Init();
                JobApplicationsTable."ID Number" := Format(lJObject.SelectToken('userid'));
                JobApplicationsTable."Employee Requisition No" := Format(lJObject.SelectToken('requestid'));
                JobApplicationsTable."Date Applied" := Today;
                JobApplicationsTable.Validate("Employee Requisition No");
                JobApplicationsTable.Validate("Job Applied For");
                JobApplicationsTable.Insert(true);
            end;
            appsjsonobj.Add('applicationnumber', JobApplicationsTable."Application No");
            appsjsonobj.Add('applicationdate', JobApplicationsTable."Date Applied");
        end;
        exit(Format(appsjsonobj));
    end;

    procedure RetrieveJobApplication(args: Text): Text
    var
        appsjsonobj: JsonObject;
        appsjsonarr: JsonArray;

        pinfoobj: JsonObject;

        //Academic Qualifications
        AcademicsTable: Record "Applicant Job Education";
        academicsobj: JsonObject;
        academicsarr: JsonArray;

        //Experience Qualifications
        ExperienceTable: Record "Applicant Job Experience";
        exparr: JsonArray;
        expobj: JsonObject;

        //Professional Courses
        pqualobj: JsonObject;
        pqualarr: JsonArray;

        //Profession Memberships
        ProfMemberTable: Record "Applicant Prof Membership";
        pmembobj: JsonObject;
        pmembarr: JsonArray;

        //Referees
        RefereesTable: Record "HR Applicant Referees";
        refobj: JsonObject;
        refarr: JsonArray;

        //Attachments
        AttachmentsTable: Record "Job Attachments";
        attobj: JsonObject;
        attarr: JsonArray;

    begin
        Clear(appsjsonobj);
        if (args <> '') then begin
            lJObject := lJObject.Parse(args);
            JobApplicationsTable.Reset();

            if ((Format(lJObject.GetValue('requestid')) <> '') and (Format(lJObject.GetValue('userid')) <> '')) then begin
                JobApplicationsTable.SetRange("Employee Requisition No", Format(lJObject.GetValue('requestid')));
                JobApplicationsTable.SetRange("ID Number", Format(lJObject.GetValue('userid')));
            end;
            if ((Format(lJObject.GetValue('applicationnumber')) <> '')) then begin
                JobApplicationsTable.SetRange("Application No", Format(lJObject.GetValue('applicationnumber')));
            end;
            if JobApplicationsTable.Find('-') then begin
                appsjsonobj.Add('applicationnumber', JobApplicationsTable."Application No");
                appsjsonobj.Add('applicationdate', JobApplicationsTable."Date Applied");
                appsjsonobj.add('status', Format(JobApplicationsTable.Status));
                appsjsonobj.add('stage', JobApplicationsTable.Stage);
                appsjsonobj.add('description', JobApplicationsTable."Job Applied for Description");

                //Personal Information
                pinfoobj.Add('firstname', JobApplicationsTable."First Name");
                pinfoobj.Add('middlename', JobApplicationsTable."Middle Name");
                pinfoobj.Add('lastname', JobApplicationsTable."Last Name");
                pinfoobj.Add('gender', Format(JobApplicationsTable.Gender));
                pinfoobj.Add('specialneeds', format(JobApplicationsTable.Disabled));
                pinfoobj.Add('disabilitydetails', JobApplicationsTable."Disabling Details");
                pinfoobj.Add('citizenship', JobApplicationsTable.Citizenship);
                pinfoobj.Add('applicantstatus', JobApplicationsTable.Status);
                pinfoobj.Add('email', JobApplicationsTable."E-Mail");
                pinfoobj.Add('telephone', JobApplicationsTable."Cell Phone Number");
                appsjsonobj.Add('personalinfo', pinfoobj);

                //Academic Qualification
                Clear(academicsarr);
                AcademicsTable.Reset();
                AcademicsTable.SetRange("Applicant No.", JobApplicationsTable."Application No");
                AcademicsTable.SetFilter("Education Level", '<>%1', AcademicsTable."Education Level"::Professional);
                if AcademicsTable.FindSet() then begin
                    repeat
                        Clear(academicsobj);
                        academicsobj.Add('lineno', AcademicsTable."Line No.");
                        academicsobj.Add('startdate', AcademicsTable."Start Date");
                        academicsobj.Add('enddate', AcademicsTable."End Date");
                        academicsobj.Add('educationtype', Format(AcademicsTable."Education Type"));
                        academicsobj.Add('educationlevel', Format(AcademicsTable."Education Level"));
                        academicsobj.Add('fieldofstudy', AcademicsTable."Field of Study");
                        academicsobj.Add('coursename', AcademicsTable."Qualification Name");
                        academicsobj.Add('institutionname', AcademicsTable."Institution Name");
                        academicsobj.Add('country', AcademicsTable.Country);
                        academicsobj.Add('grade', AcademicsTable.Grade);
                        academicsarr.Add(academicsobj);
                    until AcademicsTable.Next() = 0;
                end;
                appsjsonobj.Add('academicqualifications', academicsarr);

                //Experience Table
                Clear(exparr);
                ExperienceTable.Reset();
                ExperienceTable.SetRange("Applicant No.", JobApplicationsTable."Application No");
                if ExperienceTable.FindSet() then begin
                    repeat
                        Clear(expobj);
                        expobj.Add('lineno', ExperienceTable."Line No");
                        expobj.Add('startdate', ExperienceTable."Start Date");
                        expobj.Add('enddate', ExperienceTable."End Date");
                        expobj.Add('presentemployer', Format(ExperienceTable."Present Employment"));
                        expobj.Add('employer', ExperienceTable.Employer);
                        expobj.Add('industry', ExperienceTable.Industry);
                        expobj.Add('hierarchylevel', Format(ExperienceTable."Hierarchy Level"));
                        expobj.Add('jobtitle', ExperienceTable."Job Title");
                        expobj.Add('country', ExperienceTable.Country);
                        expobj.Add('summaryresponsibilities', ExperienceTable.Description);
                        exparr.Add(expobj);
                    until ExperienceTable.Next() = 0;
                end;
                appsjsonobj.Add('experiences', exparr);

                //Professional Qualifications
                Clear(pqualarr);
                AcademicsTable.Reset();
                AcademicsTable.SetRange("Applicant No.", JobApplicationsTable."Application No");
                AcademicsTable.SetFilter("Education Level", '%1', AcademicsTable."Education Level"::Professional);
                if AcademicsTable.FindSet() then begin
                    repeat
                        Clear(pqualobj);
                        pqualobj.Add('lineno', AcademicsTable."Line No.");
                        pqualobj.Add('description', AcademicsTable.Description);
                        pqualobj.Add('level', Format(AcademicsTable."Section/Level"));
                        pqualarr.Add(pqualobj);
                    until AcademicsTable.Next() = 0;
                end;
                appsjsonobj.Add('profqualifications', pqualarr);

                //Professional Memberships
                Clear(pmembarr);
                ProfMemberTable.Reset();
                ProfMemberTable.SetRange("Applicant No.", JobApplicationsTable."Application No");
                if ProfMemberTable.FindSet() then begin
                    repeat
                        Clear(pmembobj);
                        pmembobj.Add('lineno', ProfMemberTable."Line No.");
                        pmembobj.Add('description', ProfMemberTable.Description);
                        pmembobj.Add('profbody', ProfMemberTable."Professional Body");
                        pmembobj.Add('memberno', ProfMemberTable.MembershipNo);
                        pmembarr.Add(pmembobj);
                    until ProfMemberTable.Next() = 0;
                end;
                appsjsonobj.Add('profmembership', pmembarr);

                //Referees
                Clear(refarr);
                RefereesTable.Reset();
                RefereesTable.SetRange("Application No.", JobApplicationsTable."Application No");
                if RefereesTable.FindSet() then begin
                    repeat
                        Clear(refobj);
                        refobj.Add('lineno', RefereesTable."Line No");
                        refobj.Add('names', RefereesTable.Names);
                        refobj.Add('designation', RefereesTable.Designation);
                        refobj.Add('company', RefereesTable.Institution);
                        refobj.Add('address', RefereesTable.Address);
                        refobj.Add('telephone', RefereesTable."Telephone No");
                        refobj.Add('email', RefereesTable."E-Mail");
                        refarr.Add(refobj);
                    until RefereesTable.Next() = 0;
                end;
                appsjsonobj.Add('referees', refarr);

                //Attachments
                Clear(attarr);
                AttachmentsTable.Reset();
                AttachmentsTable.SetRange("Job ID", JobApplicationsTable."Application No");
                if AttachmentsTable.FindSet() then begin
                    repeat
                        Clear(attobj);
                        attobj.Add('description', AttachmentsTable.Description);
                        attobj.Add('documentpath', AttachmentsTable.Attachment);
                        attarr.Add(attobj);
                    until AttachmentsTable.Next() = 0;
                end;
                appsjsonobj.Add('attachments', attarr);
            end else begin

            end;
            ;
        end;
        exit(Format(appsjsonobj));
    end;

    procedure RetrieveAvailableJobs(args: text): Text
    var
        appsjsonobj: JsonObject;
        appsjsonarr: JsonArray;
    begin
        JobsAvailableTable.Reset();
        JobsAvailableTable.SetFilter("Closing Date", ('<=' + Format(Today)));
        JobsAvailableTable.SetRange(Advertise, true);
        if JobsAvailableTable.FindSet() then begin
            repeat
                Clear(appsjsonobj);
                appsjsonobj.Add('requestid', JobsAvailableTable."Requisition No.");
                appsjsonobj.Add('jobid', JobsAvailableTable."Job ID");
                appsjsonobj.Add('jobdescription', JobsAvailableTable."Job Description");
                appsjsonobj.Add('postingdate', JobsAvailableTable."Requisition Date");
                appsjsonobj.Add('closingdate', JobsAvailableTable."Date Closed");
                appsjsonobj.Add('contracttype', JobsAvailableTable."Type of Contract Required");
                appsjsonarr.Add(appsjsonobj);
            until JobsAvailableTable.Next() = 0;
        end;
        exit(Format(appsjsonarr));
    end;


    procedure RetrieveAvailableJobDetails(args: text): Text
    var
        appsjsonobj: JsonObject;
        appsjsonarr: JsonArray;

        //Job Responsibilities
        ResponsibilitiesTable: Record "Key Job Responsibilities";
        respobj: JsonObject;
        resparr: JsonArray;

        //Academic Qualifications
        AcademicsQualificationTable: Record "Company Job Education";
        academicsobj: JsonObject;
        academicsarr: JsonArray;

        //Industry Experience Qualifications
        ExperienceTable: Record "Company Job Experience";
        expobj: JsonObject;
        exparr: JsonArray;

        //Professional Course
        profcourseobj: JsonObject;
        profcoursearr: JsonArray;

        //Professional Memberships
        ProfessionalMembTable: Record "Company Job Prof Membership";
        profmembarr: JsonArray;
        profmembobj: JsonObject;
    begin
        Clear(appsjsonobj);
        JobsAvailableTable.Reset();
        if (args <> '') then begin
            lJObject := lJObject.Parse(args);
            if (Format(lJObject.SelectToken('requestid')) <> '') then
                JobsAvailableTable.SetRange("Requisition No.", Format(lJObject.SelectToken('requestid')));
            JobsAvailableTable.SetFilter("Closing Date", ('<=' + Format(Today)));
            JobsAvailableTable.SetRange(Advertise, true);
            if JobsAvailableTable.FindSet() then begin
                appsjsonobj.Add('requestid', JobsAvailableTable."Requisition No.");
                appsjsonobj.Add('jobid', JobsAvailableTable."Job ID");
                appsjsonobj.Add('jobdescription', JobsAvailableTable."Job Description");
                appsjsonobj.Add('postingdate', JobsAvailableTable."Requisition Date");
                appsjsonobj.Add('closingdate', JobsAvailableTable."Date Closed");
                appsjsonobj.Add('contracttype', JobsAvailableTable."Type of Contract Required");
                if JobDescriptionsTable.get(JobsAvailableTable."Job ID") then begin
                    appsjsonobj.Add('mainobjective', JobDescriptionsTable."Main Objective");

                    //Jobs Responsibilities
                    ResponsibilitiesTable.Reset();
                    ResponsibilitiesTable.SetRange(code, JobsAvailableTable."Job ID");
                    if ResponsibilitiesTable.Find('-') then begin
                        Clear(resparr);
                        repeat
                            Clear(respobj);
                            respobj.Add('responsibility', ResponsibilitiesTable.Description);
                            resparr.Add(respobj);
                        until ResponsibilitiesTable.Next() = 0;
                    end;
                    appsjsonobj.Add('jobresponsibilities', resparr);

                    //Academic Qualifications
                    AcademicsQualificationTable.Reset();
                    AcademicsQualificationTable.SetRange("Job ID", JobsAvailableTable."Job ID");
                    if AcademicsQualificationTable.Find('-') then begin
                        Clear(academicsarr);
                        repeat
                            Clear(academicsobj);
                            academicsobj.Add('type', Format(AcademicsQualificationTable."Education Level"));
                            academicsobj.Add('description', AcademicsQualificationTable."Qualification Name");
                            academicsarr.Add(academicsobj);
                        until AcademicsQualificationTable.Next() = 0;
                    end;
                    appsjsonobj.Add('acadquals', academicsarr);

                    //Experience Needed
                    ExperienceTable.Reset();
                    ExperienceTable.SetRange("Job ID", JobsAvailableTable."Job ID");
                    if ExperienceTable.Find('-') then begin
                        Clear(exparr);
                        repeat
                            Clear(expobj);
                            expobj.Add('hlevel', Format(ExperienceTable."Hierarchy Level"));
                            expobj.Add('iname', ExperienceTable."Industry Name");
                            expobj.Add('minyears', ExperienceTable."No. of Years");
                            exparr.Add(expobj);
                        until ExperienceTable.Next() = 0;
                    end;
                    appsjsonobj.Add('experience', exparr);

                    //Academic Qualifications
                    AcademicsQualificationTable.Reset();
                    AcademicsQualificationTable.SetRange("Job ID", JobsAvailableTable."Job ID");
                    AcademicsQualificationTable.SetRange("Education Level", AcademicsQualificationTable."Education Level"::Professional);
                    if AcademicsQualificationTable.Find('-') then begin
                        Clear(profcoursearr);
                        repeat
                            Clear(profcourseobj);
                            profcourseobj.Add('description', AcademicsQualificationTable."Qualification Name");
                            profcourseobj.Add('level', AcademicsQualificationTable."Section/Level");
                            profcoursearr.Add(profcourseobj);
                        until AcademicsQualificationTable.Next() = 0;
                    end;
                    appsjsonobj.Add('profquals', profcoursearr);

                    //Professional Membership
                    ProfessionalMembTable.Reset();
                    ProfessionalMembTable.SetRange("Job ID", JobsAvailableTable."Job ID");
                    if ProfessionalMembTable.Find('-') then begin
                        Clear(profmembarr);
                        repeat
                            Clear(profcourseobj);
                            profmembobj.Add('description', ProfessionalMembTable.Description);
                            profmembarr.Add(profmembobj);
                        until ProfessionalMembTable.Next() = 0;
                    end;
                    appsjsonobj.Add('profmembs', profmembarr);
                end;
            end;
        end;
        exit(Format(appsjsonobj));
    end;

    procedure GetCountries(): Text
    var
        jsoncobj: JsonObject;
        jsoncarr: JsonArray;
        Countries: Record "Country/Region";

    begin
        Countries.Reset();
        //Countries.SetAscending(Name, true);
        if Countries.FindSet() then begin
            Clear(jsoncarr);
            repeat
                Clear(jsoncobj);
                jsoncobj.Add('code', Countries.Code);
                jsoncobj.Add('name', Countries.Name);
                jsoncarr.Add(jsoncobj);
            until Countries.Next() = 0;
        end;
        exit(Format(jsoncarr));
    end;

    procedure ModifyJobApplication(args: Text): Text
    var
        done: Boolean;
    begin
        Clear(lJObject);
        Clear(lJObject1);
        lJObject := lJObject.Parse(args);

        if (Format(lJObject.GetValue('applicationnumber')) <> '') then begin
            JobApplicationsTable.SetRange("Application No", Format(lJObject.GetValue('applicationnumber')));
            if JobApplicationsTable.FindFirst() then begin
                if (Format(lJObject.GetValue('modify_type')) = 'user_details') then begin
                    lJObject1 := lJObject.Parse(Format(lJObject.GetValue('application_details')));
                    done := AmendUserDetails(lJObject1);
                end;
                if (Format(lJObject.GetValue('modify_type')) = 'academic_details') then begin
                    lJObject1 := lJObject.Parse(Format(lJObject.GetValue('application_details')));
                    done := AmendAcademicDetails(lJObject1);
                end;
                if (Format(lJObject.GetValue('modify_type')) = 'experience_details') then begin
                    lJObject1 := lJObject.Parse(Format(lJObject.SelectToken('application_details')));
                    done := AmendExperienceDetails(lJObject1);
                end;
                if (Format(lJObject.GetValue('modify_type')) = 'prof_course_details') then begin
                    lJObject1 := lJObject.Parse(Format(lJObject.SelectToken('application_details')));
                    done := AmendProfCourseDetails(lJObject1);
                end;
                if (Format(lJObject.GetValue('modify_type')) = 'prof_memb_details') then begin
                    lJObject1 := lJObject.Parse(Format(lJObject.SelectToken('application_details')));
                    done := AmendProfMembershipDetails(lJObject1);
                end;
                if (Format(lJObject.GetValue('modify_type')) = 'referee_details') then begin
                    lJObject1 := lJObject.Parse(Format(lJObject.SelectToken('application_details')));
                    done := AmendRefereeDetails(lJObject1);
                end;
                if (Format(lJObject.GetValue('modify_type')) = 'attachment') then begin
                    lJObject1 := lJObject.Parse(Format(lJObject.SelectToken('application_details')));
                    done := AmendAttachmentDetails(lJObject1);
                end;
                if (Format(lJObject.GetValue('modify_type')) = 'submission') then begin
                    JobApplicationsTable.Status := JobApplicationsTable.Status::Submitted;
                    JobApplicationsTable.Modify(true);
                end;

                Commit();
                exit(RetrieveJobApplication(args));
            end;
        end;
    end;

    procedure AmendUserDetails(JsonInput: DotNet JObject): Boolean
    var
    //JsonInput: DotNet JObject;
    begin
        // Clear(JsonInput);
        // JsonInput := JsonInput.Parse(JsonTextInput);
        if (Format(JsonInput.GetValue('personalinfo')) <> '') then begin
            Clear(lJObject2);
            lJObject2 := lJObject2.Parse(Format(JsonInput.GetValue('personalinfo')));
            //exit(true);
            JobApplicationsTable."First Name" := Format(lJObject2.GetValue('firstname'));
            JobApplicationsTable."Middle Name" := Format(lJObject2.GetValue('middlename'));
            JobApplicationsTable."Last Name" := Format(lJObject2.GetValue('lastname'));
            JobApplicationsTable."Home Phone Number" := Format(lJObject2.GetValue('telephone'));
            JobApplicationsTable.Citizenship := Format(lJObject2.GetValue('citizenship'));
            JobApplicationsTable."E-Mail" := Format(lJObject2.GetValue('email'));
            if (Format(lJObject2.GetValue('gender')) = 'Male') then
                JobApplicationsTable.Gender := JobApplicationsTable.Gender::Male;
            if (Format(lJObject2.GetValue('gender')) = 'Female') then
                JobApplicationsTable.Gender := JobApplicationsTable.Gender::Female;
            if (Format(lJObject2.GetValue('specialneeds')) = 'No') then
                JobApplicationsTable.Disabled := JobApplicationsTable.Disabled::No;
            if (Format(lJObject2.GetValue('specialneeds')) = 'Yes') then begin
                JobApplicationsTable.Disabled := JobApplicationsTable.Disabled::Yes;
                JobApplicationsTable."Disabling Details" := Format(lJObject2.GetValue('disabilitydetails'));
            end;

            exit(JobApplicationsTable.Modify(true));
        end;
    end;

    procedure AmendAcademicDetails(JsonInput: dotnet JObject): Boolean
    var
        AcademicsTable: Record "Applicant Job Education";
        EducationTypes: Enum "Education Types";

        ParsedStartDate: DateTime;
        ParsedEndDate: DateTime;
    begin
        if (Format(JsonInput.SelectToken('academicqualifications')) <> '') then begin
            clear(lJsonArray);
            lJsonArray := lJsonArray.Parse(Format(JsonInput.SelectToken('academicqualifications')));
            Clear(lJObject2);
            foreach ljobject2 in lJsonArray do begin
                AcademicsTable.Init();
                AcademicsTable."Applicant No." := JobApplicationsTable."Application No";
                AcademicsTable."Qualification Name" := Format(lJObject2.GetValue('coursename'));
                AcademicsTable."Field of Study" := Format(lJObject2.GetValue('fieldofstudy'));
                AcademicsTable."Institution Name" := Format(lJObject2.GetValue('institutionname'));
                AcademicsTable.Country := Format(lJObject2.GetValue('country'));
                AcademicsTable.Grade := Format(lJObject2.GetValue('grade'));

                if Format(lJObject2.GetValue('educationtype')) = 'Primary' then
                    AcademicsTable."Education Type" := AcademicsTable."Education Type"::Primary;
                if Format(lJObject2.GetValue('educationtype')) = 'High School' then
                    AcademicsTable."Education Type" := AcademicsTable."Education Type"::"High School";
                if Format(lJObject2.GetValue('educationtype')) = 'Professional' then
                    AcademicsTable."Education Type" := AcademicsTable."Education Type"::Professional;
                if Format(lJObject2.GetValue('educationtype')) = 'Vocational' then
                    AcademicsTable."Education Type" := AcademicsTable."Education Type"::Vocational;
                if Format(lJObject2.GetValue('educationtype')) = 'College' then
                    AcademicsTable."Education Type" := AcademicsTable."Education Type"::College;
                if Format(lJObject2.GetValue('educationtype')) = 'University' then
                    AcademicsTable."Education Type" := AcademicsTable."Education Type"::University;
                if Format(lJObject2.GetValue('educationlevel')) = 'Certificate' then
                    AcademicsTable."Education Level" := AcademicsTable."Education Level"::Certificate;
                if Format(lJObject2.GetValue('educationlevel')) = 'Diploma' then
                    AcademicsTable."Education Level" := AcademicsTable."Education Level"::Diploma;
                if Format(lJObject2.GetValue('educationlevel')) = 'Higher/Post Graduate Diploma' then
                    AcademicsTable."Education Level" := AcademicsTable."Education Level"::"Higher/Post Graduate Diploma";
                if Format(lJObject2.GetValue('educationlevel')) = 'Bachelors Degree' then
                    AcademicsTable."Education Level" := AcademicsTable."Education Level"::"Bachelors Degree";
                if Format(lJObject2.GetValue('educationlevel')) = 'Masters Degree' then
                    AcademicsTable."Education Level" := AcademicsTable."Education Level"::"Masters Degree";
                if Format(lJObject2.GetValue('educationlevel')) = 'Doctorate' then
                    AcademicsTable."Education Level" := AcademicsTable."Education Level"::Doctorate;

                if Format(lJObject2.GetValue('startdate')) <> '' then begin
                    Evaluate(ParsedStartDate, Format(lJObject2.GetValue('startdate')));
                    AcademicsTable."Start Date" := DT2Date(ParsedStartDate);
                end;
                if Format(lJObject2.GetValue('enddate')) <> '' then begin
                    Evaluate(ParsedEndDate, Format(lJObject2.GetValue('enddate')));
                    AcademicsTable."End Date" := DT2Date(ParsedEndDate);
                end;
                exit(AcademicsTable.Insert(true));
            end;
        end;
    end;

    procedure AmendExperienceDetails(JsonInput: dotnet JObject): Boolean
    var
        ExperienceTable: Record "Applicant Job Experience";
        ParsedStartDate: DateTime;
        ParsedEndDate: DateTime;
    begin
        if (Format(JsonInput.SelectToken('experiences')) <> '') then begin
            clear(lJsonArray);
            lJsonArray := lJsonArray.Parse(Format(JsonInput.SelectToken('experiences')));
            Clear(lJObject2);
            foreach ljobject2 in lJsonArray do begin
                ExperienceTable.Init();
                ExperienceTable."Applicant No." := JobApplicationsTable."Application No";
                ExperienceTable."Job Title" := Format(lJObject2.GetValue('jobtitle'));
                ExperienceTable.Employer := Format(lJObject2.GetValue('employer'));
                ExperienceTable.Industry := Format(lJObject2.GetValue('industry'));
                ExperienceTable.Country := Format(lJObject2.GetValue('country'));
                ExperienceTable.Description := Format(lJObject2.GetValue('summaryresponsibilities'));

                if Format(lJObject2.GetValue('hierarchylevel')) = 'Consultant' then
                    ExperienceTable."Hierarchy Level" := ExperienceTable."Hierarchy Level"::Consultant;
                if Format(lJObject2.GetValue('hierarchylevel')) = 'Executive/Director' then
                    ExperienceTable."Hierarchy Level" := ExperienceTable."Hierarchy Level"::"Executive/Director";
                if Format(lJObject2.GetValue('hierarchylevel')) = 'First-Level Manager' then
                    ExperienceTable."Hierarchy Level" := ExperienceTable."Hierarchy Level"::"First-Level Manager";
                if Format(lJObject2.GetValue('hierarchylevel')) = 'Intern' then
                    ExperienceTable."Hierarchy Level" := ExperienceTable."Hierarchy Level"::Intern;
                if Format(lJObject2.GetValue('hierarchylevel')) = 'Middle-Level Manager' then
                    ExperienceTable."Hierarchy Level" := ExperienceTable."Hierarchy Level"::"Middle-Level Manager";
                if Format(lJObject2.GetValue('hierarchylevel')) = 'Supervisor' then
                    ExperienceTable."Hierarchy Level" := ExperienceTable."Hierarchy Level"::Supervisor;
                if Format(lJObject2.GetValue('hierarchylevel')) = 'Support Staff' then
                    ExperienceTable."Hierarchy Level" := ExperienceTable."Hierarchy Level"::"Support Staff";
                if Format(lJObject2.GetValue('hierarchylevel')) = 'Top-Level Manager' then
                    ExperienceTable."Hierarchy Level" := ExperienceTable."Hierarchy Level"::"Top-Level Manager";
                if Format(lJObject2.GetValue('hierarchylevel')) = 'Trainee/Attachee' then
                    ExperienceTable."Hierarchy Level" := ExperienceTable."Hierarchy Level"::"Trainee/Attachee";
                if Format(lJObject2.GetValue('hierarchylevel')) = 'Officer' then
                    ExperienceTable."Hierarchy Level" := ExperienceTable."Hierarchy Level"::Officer;

                if Format(lJObject2.GetValue('startdate')) <> '' then begin
                    Evaluate(ParsedStartDate, Format(lJObject2.GetValue('startdate')));
                    ExperienceTable."Start Date" := DT2Date(ParsedStartDate);
                end;
                if Format(lJObject2.GetValue('presentemployer')) = 'Yes' then begin
                    ExperienceTable."Present Employment" := true;
                end;
                if Format(lJObject2.GetValue('presentemployer')) = 'No' then begin
                    ExperienceTable."Present Employment" := false;
                    if Format(lJObject2.GetValue('enddate')) <> '' then begin
                        Evaluate(ParsedEndDate, Format(lJObject2.GetValue('enddate')));
                        ExperienceTable."End Date" := DT2Date(ParsedEndDate);
                    end;
                end;

                exit(ExperienceTable.insert(true));
            end;
        end;
    end;

    procedure AmendProfMembershipDetails(JsonInput: dotnet JObject): Boolean
    var
        ProfMemberTable: Record "Applicant Prof Membership";
    begin
        if (Format(JsonInput.SelectToken('profmembership')) <> '') then begin
            clear(lJsonArray);
            lJsonArray := lJsonArray.Parse(Format(JsonInput.SelectToken('profmembership')));
            Clear(lJObject2);
            foreach ljobject2 in lJsonArray do begin
                ProfMemberTable.Init();
                ProfMemberTable."Applicant No." := JobApplicationsTable."Application No";
                ProfMemberTable."Professional Body" := Format(lJObject2.GetValue('profbody'));
                ProfMemberTable.MembershipNo := Format(lJObject2.GetValue('memberno'));
                exit(ProfMemberTable.insert(true));
            end;
        end;
    end;


    procedure AmendProfCourseDetails(JsonInput: dotnet JObject): Boolean
    var
        AcademicsTable: Record "Applicant Job Education";
        SectionLevel: Integer;
    begin
        if (Format(JsonInput.SelectToken('profqualifications')) <> '') then begin
            clear(lJsonArray);
            lJsonArray := lJsonArray.Parse(Format(JsonInput.SelectToken('profqualifications')));
            Clear(lJObject2);
            foreach ljobject2 in lJsonArray do begin
                AcademicsTable.Init();
                AcademicsTable."Applicant No." := JobApplicationsTable."Application No";
                AcademicsTable."Education Level" := AcademicsTable."Education Level"::Professional;
                AcademicsTable.Description := Format(lJObject2.GetValue('description'));
                Evaluate(SectionLevel, Format(lJObject2.GetValue('level')));
                AcademicsTable."Section/Level" := SectionLevel;
                exit(AcademicsTable.insert(true));
            end;
        end;
    end;

    procedure AmendRefereeDetails(JsonInput: dotnet JObject): Boolean
    var
        RefereesTable: Record "HR Applicant Referees";
        SectionLevel: Integer;
    begin
        if (Format(JsonInput.SelectToken('referees')) <> '') then begin
            clear(lJsonArray);
            lJsonArray := lJsonArray.Parse(Format(JsonInput.SelectToken('referees')));
            Clear(lJObject2);
            foreach ljobject2 in lJsonArray do begin
                RefereesTable.Init();
                RefereesTable."Application No." := JobApplicationsTable."Application No";
                RefereesTable."Job Application No" := JobApplicationsTable."Application No";
                RefereesTable.Names := Format(lJObject2.GetValue('names'));
                RefereesTable.Designation := Format(lJObject2.GetValue('designation'));
                RefereesTable.Institution := Format(lJObject2.GetValue('company'));
                RefereesTable.Address := Format(lJObject2.GetValue('address'));
                RefereesTable."Telephone No" := Format(lJObject2.GetValue('telephone'));
                RefereesTable."E-Mail" := Format(lJObject2.GetValue('email'));
                exit(RefereesTable.insert(true));
            end;
        end;
    end;

    procedure AmendAttachmentDetails(JsonInput: dotnet JObject): Boolean
    var
        AttachmentsTable: Record "Job Attachments";
    begin
        if (Format(JsonInput.SelectToken('attachments')) <> '') then begin
            clear(lJsonArray);
            lJsonArray := lJsonArray.Parse(Format(JsonInput.SelectToken('attachments')));
            Clear(lJObject2);
            foreach ljobject2 in lJsonArray do begin
                AttachmentsTable.reset();
                AttachmentsTable.SetRange("Job ID", JobApplicationsTable."Application No");
                AttachmentsTable.SetRange(Description, Format(lJObject2.GetValue('description')))
            end;
        end;
    end;

    procedure GenerateJobSummary(No: Code[40]; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        JobReport: Report 50109;
        Base64Convert: Codeunit "Base64 Convert";
        JobApplication: Record "HR Job Applications";
    begin
        Filename := FilePath.GetTempPath() + FilePath.GetRandomFileName();
        JobApplication.Reset;
        JobApplication.SetRange(JobApplication."Application No", No);
        if JobApplication.Find('-') then begin
            JobReport.SetTableView(JobApplication);
            TempBlob.CreateOutStream(StatementOutstream);
            if JobReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream);
            end;
        end;
    end;


}