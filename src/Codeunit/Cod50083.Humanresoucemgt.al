codeunit 50083 "Human resouce mgt"
{


    trigger OnRun()
    begin

    end;

    procedure SuggestShortlistApplicants(RecNeeds: Record "HR Employee Requisitions")
    var
        JobsApplied: Record "HR Job Applications";
        Applicants: Record "HR Job Applications";
        ApplicantShortlist: Record "HR Shortlisted Applicants";
        JobApplications: Record "HR Job Applications";
    begin
        ApplicantShortlist.SetRange("Employee Requisition No", RecNeeds."Requisition No.");
        ApplicantShortlist.DeleteAll();

        JobsApplied.Reset();
        JobsApplied.SetRange("Employee Requisition No", RecNeeds."Requisition No.");
        JobsApplied.SetRange("Applicant Type", JobsApplied."Applicant Type"::External);
        if JobsApplied.FindSet() then
            repeat
                Applicants.Get(JobsApplied."Application No");

                ApplicantShortlist.Init();
                ApplicantShortlist."Employee Requisition No" := RecNeeds."Requisition No.";
                ApplicantShortlist."Job Application No" := Applicants."Application No";
                ApplicantShortlist."First Name" := Applicants."First Name";
                ApplicantShortlist."Middle Name" := Applicants."Middle Name";
                ApplicantShortlist."Last Name" := Applicants."Last Name";
                ApplicantShortlist."ID No" := Applicants."ID Number";
                ApplicantShortlist.Qualified := false;
                if not ApplicantShortlist.Get(RecNeeds."Requisition No.", Applicants."Application No") then
                    ApplicantShortlist.Insert();


            until JobsApplied.Next() = 0;
    end;

    procedure ShortlistApplicants(RecruitmentNeeds: Record "HR Employee Requisitions")
    var
        Academics: Record "Applicant Job Education";
        Experience: Record "Applicant Job Experience";
        Prof: Record "Applicant Prof Membership";
        ApplicantsShortlist: Record "HR Job Applications";
        JobApplications: Record "HR Job Applications";
        Qualified: Boolean;
        ApplicantEdLevelIndex, ShortlistEdLevelIndex : Integer;
        ApplicantEdTypeIndex, ShortlistEdTypeIndex : Integer;
        ApplicantProfLevelIndex, ShortlistProfLevelIndex : Integer;
        NoYears: Integer;
    begin
        //come back here to fix shortlisting
        //Suggest Applicants First
        SuggestShortlistApplicants(RecruitmentNeeds);

        ApplicantsShortlist.Reset();
        ApplicantsShortlist.SetRange(ApplicantsShortlist."Employee Requisition No", RecruitmentNeeds."Requisition No.");
        if ApplicantsShortlist.FindSet() then
            repeat
                Qualified := false;
                //Message('home %1', ApplicantsShortlist."Employee Requisition No");
                ApplicantEdLevelIndex := 0;
                ShortlistEdLevelIndex := 0;
                ApplicantEdTypeIndex := 0;
                ShortlistEdTypeIndex := 0;
                ApplicantProfLevelIndex := 0;
                ShortlistProfLevelIndex := 0;

                //Shortlist By Field of Study
                if RecruitmentNeeds."Field of Study" <> '' then begin
                    Academics.Reset();
                    Academics.SetRange("Applicant No.", ApplicantsShortlist."Application No");
                    Academics.SetFilter("Field of Study", '=%1', RecruitmentNeeds."Field of Study");
                    if Academics.FindFirst() then
                        Qualified := true
                    else
                        Qualified := false;
                end;

                //Shortlist By Education Level
                //if Qualified then begin
                if RecruitmentNeeds."Education Level" <> RecruitmentNeeds."Education Level"::" " then begin
                    //Get Shortlist Index
                    ShortlistEdLevelIndex := RecruitmentNeeds."Education Level".Ordinals.IndexOf(RecruitmentNeeds."Education Level".AsInteger());

                    Academics.Reset();
                    Academics.SetRange("Applicant No.", ApplicantsShortlist."Application No");
                    if RecruitmentNeeds."Field of Study" <> '' then
                        Academics.SetRange("Field of Study", RecruitmentNeeds."Field of Study");
                    //Academics.SetRange("Education Level", RecruitmentNeeds."Education Level");
                    if Academics.FindFirst() then begin
                        //Get Applicant Index
                        ApplicantEdLevelIndex := Academics."Education Level".Ordinals.IndexOf(Academics."Education Level".AsInteger());

                        if ApplicantEdLevelIndex >= ShortlistEdLevelIndex then
                            Qualified := true
                        else
                            Qualified := false;
                    end else
                        Qualified := false;
                end;
                //end;

                //Shortlist By Education Type
                //if Qualified then begin
                if RecruitmentNeeds."Education Type" <> RecruitmentNeeds."Education Type"::" " then begin
                    //Get Shortlist Index
                    ShortlistEdTypeIndex := RecruitmentNeeds."Education Type".Ordinals.IndexOf(RecruitmentNeeds."Education Type".AsInteger());

                    Academics.Reset();
                    Academics.SetRange("Applicant No.", ApplicantsShortlist."Application No");
                    if RecruitmentNeeds."Field of Study" <> '' then
                        Academics.SetRange("Field of Study", RecruitmentNeeds."Field of Study");
                    if Academics.FindFirst() then begin
                        //Get Applicant Index
                        ApplicantEdTypeIndex := Academics."Education Type".Ordinals.IndexOf(Academics."Education Type".AsInteger());

                        if ApplicantEdTypeIndex >= ShortlistEdTypeIndex then
                            Qualified := true
                        else
                            Qualified := false;
                    end else
                        Qualified := false;
                end;
                //end;

                //Shortlist By Proficiency Level
                //if Qualified then begin
                if RecruitmentNeeds."Proficiency Level" <> RecruitmentNeeds."Proficiency Level"::" " then begin
                    //Get Shortlist Index
                    ShortlistProfLevelIndex := RecruitmentNeeds."Education Type".Ordinals.IndexOf(RecruitmentNeeds."Proficiency Level".AsInteger());

                    Academics.Reset();
                    Academics.SetRange("Applicant No.", ApplicantsShortlist."Application No");
                    if Academics.FindFirst() then begin
                        ApplicantProfLevelIndex := Academics."Proficiency Level".Ordinals.IndexOf(Academics."Proficiency Level".AsInteger());
                        if ApplicantProfLevelIndex >= ShortlistProfLevelIndex then
                            Qualified := true
                        else
                            Qualified := false;
                    end else
                        Qualified := false;
                end;
                //end;

                //Shortlist by Professional Course
                //if Qualified then begin
                if RecruitmentNeeds."Professional Course" <> '' then begin
                    Academics.Reset();
                    Academics.SetRange("Applicant No.", ApplicantsShortlist."Application No");
                    Academics.SetRange("Qualification Code", RecruitmentNeeds."Professional Course");
                    if Academics.FindFirst() then
                        Qualified := true
                    else
                        Qualified := false;
                end;
                //end;

                //Shortlist by Professional Membership
                //if Qualified then begin
                if RecruitmentNeeds."Professional Membership" <> '' then begin
                    Prof.Reset();
                    Prof.SetRange("Applicant No.", ApplicantsShortlist."Application No");
                    Prof.SetRange("Professional Body", RecruitmentNeeds."Professional Membership");
                    if Prof.FindFirst() then
                        Qualified := true
                    else
                        Qualified := false;
                end;
                //end;

                //Shortlist by Experience Industry
                //if Qualified then begin
                if RecruitmentNeeds."Experience industry" <> '' then begin
                    Experience.Reset();
                    Experience.SetRange("Applicant No.", ApplicantsShortlist."Application No");
                    Experience.SetRange(Industry, RecruitmentNeeds."Experience industry");
                    if Experience.FindFirst() then
                        Qualified := true
                    else
                        Qualified := false;
                end;
                //end;

                //Shortlist by years of experience
                //if Qualified then begin
                if (RecruitmentNeeds."Minimum years of experience" <> 0) and (RecruitmentNeeds."Maximum years of experience" <> 0) then begin
                    Experience.Reset();
                    Experience.SetRange("Applicant No.", ApplicantsShortlist."Application No");
                    if RecruitmentNeeds."Experience industry" <> '' then
                        Experience.SetRange(Industry, RecruitmentNeeds."Experience industry");
                    if Experience.Find('-') then begin
                        Experience.CalcSums("No. of Years");
                        NoYears := Round(Experience."No. of Years", 1, '=');

                        if (NoYears >= RecruitmentNeeds."Minimum years of experience") and (NoYears <= RecruitmentNeeds."Maximum years of experience") then
                            Qualified := true
                        else
                            Qualified := false;

                    end else
                        Qualified := false;
                end else
                    if (RecruitmentNeeds."Minimum years of experience" <> 0) and (RecruitmentNeeds."Maximum years of experience" = 0) then begin
                        Experience.Reset();
                        Experience.SetRange("Applicant No.", ApplicantsShortlist."Application No");
                        if RecruitmentNeeds."Experience industry" <> '' then
                            Experience.SetRange(Industry, RecruitmentNeeds."Experience industry");

                        if Experience.Find('-') then begin
                            Experience.CalcSums("No. of Years");
                            NoYears := Round(Experience."No. of Years", 1, '=');
                            if NoYears >= RecruitmentNeeds."Minimum years of experience" then
                                Qualified := true
                            else
                                Qualified := false;
                        end else
                            Qualified := false;
                    end else
                        if (RecruitmentNeeds."Maximum years of experience" <> 0) and (RecruitmentNeeds."Minimum years of experience" = 0) then begin
                            Experience.Reset();
                            Experience.SetRange("Applicant No.", ApplicantsShortlist."Application No");
                            if RecruitmentNeeds."Experience industry" <> '' then
                                Experience.SetRange(Industry, RecruitmentNeeds."Experience industry");

                            if Experience.Find('-') then begin
                                Experience.CalcSums("No. of Years");
                                NoYears := Round(Experience."No. of Years", 1, '=');
                                if NoYears <= RecruitmentNeeds."Maximum years of experience" then
                                    Qualified := true
                                else
                                    Qualified := false;
                            end else
                                Qualified := false;
                        end;
                //end;

                JobApplications.Get(ApplicantsShortlist."Application No");

                if Qualified then begin

                    ApplicantsShortlist.Validate(Qualified, true);
                    ApplicantsShortlist."Qualification Status" := ApplicantsShortlist."Qualification Status"::Qualified
                end
                else
                    ApplicantsShortlist.Validate(Qualified, false);
                ApplicantsShortlist."Qualification Status" := ApplicantsShortlist."Qualification Status"::UnQualified;

                ApplicantsShortlist.Modify();

            until ApplicantsShortlist.Next() = 0;
    end;


    procedure MailQualifiedShortlistApplicants(RecNeeds: Record "HR Employee Requisitions")
    var
        ShortlistApplicants: Record "HR Job Applications";
        CompanyInfo: Record "Company Information";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        NewBody: Label '<p>Dear %1,</p> <br><p>This is to invite you for an Interview for the job Position of <Strong>%2</Strong>.</p><p>The Interview will be conducted at <Strong>%3</Strong> on <Strong>%5</Strong> at <Strong>%6</Strong> .<br></p><br>Kind Regards, <br><br><Strong>%4 </Strong>.  ';
        Receipient: List of [Text];
        FormattedBody: Text;
        Subject: Text;
        TimeNow: Text;
    begin
        CompanyInfo.Get();
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("E-Mail");

        ShortlistApplicants.Reset();
        ShortlistApplicants.SetRange("Employee Requisition No", RecNeeds."Requisition No.");
        ShortlistApplicants.SetFilter("E-Mail", '<>%1', '');
        ShortlistApplicants.SetRange(Qualified, true);
        ShortlistApplicants.SetRange(Notified, false);
        if ShortlistApplicants.FindSet() then begin
            repeat
                ShortlistApplicants.TestField("Date of Interview");
                ShortlistApplicants.TestField("From Time");
                Clear(Receipient);
                Receipient.Add(ShortlistApplicants."E-Mail");
                Subject := 'Interview Invitation';
                TimeNow := (Format(Time));
                FormattedBody := StrSubstNo(NewBody, ShortlistApplicants."First Name" + ' ' + ShortlistApplicants."Last Name", RecNeeds."Job Description", ShortlistApplicants.Venue, 'Human Resource Manager', Format(ShortlistApplicants."Date of Interview", 0, '<Weekday Text> <Day> <Month Text> <Year4>'), ShortlistApplicants."From Time");
                EmailMessage.Create(Receipient, Subject, FormattedBody, true);
                Email.Send(EmailMessage);

                ShortlistApplicants.Notified := true;
                ShortlistApplicants.Modify();
                Commit();

            until ShortlistApplicants.Next() = 0;
        end;
    end;

    procedure MailUnQualifiedShortlistApplicants(RecNeeds: Record "HR Employee Requisitions")
    var
        ShortlistApplicants: Record "HR Job Applications";
        CompanyInfo: Record "Company Information";
        JobApplication: Record "HR Job Applications";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        NewBody: Text;
        EmailTextBuilder: TextBuilder;
        DearCandidateLbl: Label 'Dear %1,';
        ThankYouLbl: Label '<p>Thank you for taking the time to submit your resume for consideration for the <Strong>%2</Strong> position with %3</p>';
        WeRegretLbl: Label '<p>We regret to inform you that we will not be pursuing your candidacy for this position. Though your qualifications are impressive, the selection process was highly competitive, and we have decided to move forward with other candidates whose qualifications better meet our needs at this time.</p>';
        WeThankYouLbl: Label '<p>We thank you for your interest and wish you all the best in your future endeavors.</p>';
        KindRegardsLbl: Label '<p>Kind Regards</p><br> %3 <br> Human Resources Recruitment';
        Receipient: List of [Text];
        FormattedBody: Text;
        Subject: Text;
        TimeNow: Text;
    begin
        CompanyInfo.Get();
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("E-Mail");

        ShortlistApplicants.Reset();
        ShortlistApplicants.SetRange("Employee Requisition No", RecNeeds."Requisition No.");
        ShortlistApplicants.SetRange(Qualified, false);
        //ShortlistApplicants.SetRange(Notified, false);
        if ShortlistApplicants.FindSet() then begin
            repeat


                Clear(Receipient);
                Receipient.Add(ShortlistApplicants."E-Mail");
                Subject := 'Job Application - Regret';
                TimeNow := (Format(Time));

                EmailTextBuilder.Clear();
                EmailTextBuilder.Append(DearCandidateLbl);
                EmailTextBuilder.Append(ThankYouLbl);
                EmailTextBuilder.Append(WeRegretLbl);
                EmailTextBuilder.Append(WeThankYouLbl);
                EmailTextBuilder.Append(KindRegardsLbl);


                NewBody := EmailTextBuilder.ToText();

                FormattedBody := StrSubstNo(NewBody, ShortlistApplicants."First Name" + ' ' + ShortlistApplicants."Last Name", RecNeeds."Job Description", CompanyInfo.Name);
                EmailMessage.Create(Receipient, Subject, FormattedBody, true);
                Email.Send(EmailMessage);

                ShortlistApplicants.Notified := true;
                ShortlistApplicants.Modify();
                Commit();
            until ShortlistApplicants.Next() = 0;
        end;
    end;

    procedure UploadApplicantToEmployeeList(RecNeed: Record "HR Employee Requisitions")
    var
        JobApplication: Record "HR Job Applications";
        Applicants: Record "HR Job Applications";
        Employee: Record "HR Employees";
        Jobs: Record "HR Jobss";
        EmployeeQualifications: Record "HR Employee Qualifications";
        ApplicantQualifications: Record "Applicant Job Education";
        EmployementHistory: Record "HR Employment History";
        ApplicantJobHistory: Record "Applicant Job Experience";
        Noseries: Codeunit NoSeriesManagement;
        ApplicantHiredSuccessMsg: Label 'Job Applicant %1 has been successfully hired';
        CannotSelectMoreCandidatesErr: Label 'You cannot hire %1 candidates since %2 position only requires %3 candidate(s)';
    begin
        Jobs.Get(RecNeed."Job ID");

        JobApplication.Reset();
        JobApplication.SetRange(JobApplication."Employee Requisition No", RecNeed."Requisition No.");
        JobApplication.SetRange("Select To Hire", true);
        JobApplication.SetRange(Hired, false);
        if JobApplication.Find('-') then begin
            if JobApplication.Count > RecNeed."Vacant Positions" then
                Error(CannotSelectMoreCandidatesErr, JobApplication.Count, RecNeed."Job Description", RecNeed."Vacant Positions");
            repeat




                Applicants.Get(JobApplication."Application No");

                //Insert Employee Record
                Employee.Init();
                Employee."No." := Noseries.GetNextNo('EMPLOYEE', 0D, true);
                //Employee.Insert(true);
                Employee.Validate("First Name", Applicants."First Name");
                Employee.Validate("Middle Name", Applicants."Middle Name");
                Employee.Validate("Last Name", Applicants."Last Name");
                Employee.Validate("Search Name", Employee.FullName());
                Employee.Validate("ID Number", Applicants."ID Number");
                Employee.Validate(Gender, Applicants.Gender);
                Employee.Validate(Employee.Citizenship, Applicants.Citizenship);
                Employee.Validate(Status, Employee.Status::Active);
                Employee.Validate("Date Of Birth", Applicants."Date Of Birth");
                Employee.Validate("Marital Status", Applicants."Marital Status");
                Employee.Validate("Ethnic Origin", Applicants."Ethnic Origin");
                Employee.Validate("Home Phone Number", Applicants."Home Phone Number");
                Employee.Validate("Cell Phone Number", Applicants."Home Phone Number");
                Employee.Validate(Disabled, Applicants.Disabled);
                Employee.Validate("E-Mail", Applicants."E-Mail");
                Employee.Validate("Postal Address", Applicants."Postal Address");
                Employee.Validate("Post Code", Applicants."Post Code");
                Employee.Validate(Employee."Job Specification", Applicants."Job Applied For");

                Employee.Insert(true);


                //Insert Qualifications
                ApplicantQualifications.Reset();
                ApplicantQualifications.SetRange("Applicant No.", Applicants."Application No");
                if ApplicantQualifications.FindSet() then begin
                    repeat
                        EmployeeQualifications."Employee No." := Employee."No.";
                        EmployeeQualifications."Line No." := ApplicantQualifications."Line No.";
                        EmployeeQualifications.Validate("Institution Type", ApplicantQualifications."Institution Type");
                        EmployeeQualifications.Validate("From Date", ApplicantQualifications."Start Date");
                        EmployeeQualifications.Validate("To Date", ApplicantQualifications."End Date");
                        EmployeeQualifications.Validate("Field of Study", EmployeeQualifications."Field of Study");
                        EmployeeQualifications.Validate("Education Level", EmployeeQualifications."Education Level");
                        if ApplicantQualifications."Qualification Code" <> '' then begin
                            EmployeeQualifications.Validate("Qualification Code", ApplicantQualifications."Qualification Code");
                        end
                        else
                            if ApplicantQualifications."Qualification Code Prof" <> '' then begin
                                EmployeeQualifications.Validate("Qualification Code", ApplicantQualifications."Qualification Code");
                            end;
                        EmployeeQualifications.Validate("Qualification Description", ApplicantQualifications."Qualification Name");
                        EmployeeQualifications.Validate("Institution/Company", ApplicantQualifications."Institution Name");
                        EmployeeQualifications.Validate(Score, ApplicantQualifications.Score);
                        EmployeeQualifications.Validate("Course Grade", ApplicantQualifications.Grade);
                        EmployeeQualifications.Validate(Country, ApplicantQualifications.Country);
                        EmployeeQualifications.Validate("Proficiency Level", ApplicantQualifications."Proficiency Level");
                        EmployeeQualifications.Insert();
                    until ApplicantQualifications.Next() = 0;
                end;

                //Insert Employment history
                ApplicantJobHistory.Reset();
                ApplicantJobHistory.SetRange("Applicant No.", Applicants."Application No");
                if ApplicantJobHistory.FindSet() then begin
                    repeat
                        EmployementHistory."Employee No." := Employee."No.";
                        EmployementHistory.From := ApplicantJobHistory."Start Date";
                        EmployementHistory."To Date" := ApplicantJobHistory."End Date";
                        EmployementHistory.Validate("Company Name", ApplicantJobHistory.Employer);
                        EmployementHistory.Validate(Industry, ApplicantJobHistory.Industry);
                        EmployementHistory.Validate("Hierarchy Level", ApplicantJobHistory."Hierarchy Level");
                        EmployementHistory.Validate("No. of Years", ApplicantJobHistory."No. of Years");
                        EmployementHistory.Validate("Job Title", ApplicantJobHistory."Job Title");
                        EmployementHistory.Insert();
                    until ApplicantJobHistory.Next() = 0;
                end;
                JobApplication.Hired := true;
                JobApplication.Modify(true);
            until JobApplication.Next() = 0;
            Message(ApplicantHiredSuccessMsg, JobApplication.FullName());
        end;
    end;


}
