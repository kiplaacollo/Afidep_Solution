report 50077 "Appraisal Form"
{
    ApplicationArea = All;
    Caption = 'Appraisal Form';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;//
    WordLayout = 'Layouts/Performance Appraisal.docx';

    // DefaultLayout = RDLC;
    // RDLCLayout = 'Layouts/HR Appraisal Form.rdlc';

    dataset
    {
        dataitem("HR Appraisal Header"; "HR Appraisal Header")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(AppraisalNo_HRAppraisalHeader; "HR Appraisal Header"."No.")
            {
            }
            column(AppraisalPeriod_HRAppraisalHeader; "HR Appraisal Header"."Appraisal Period")
            {
            }
            column(SupervisorJobTitle_HRAppraisalHeader; "HR Appraisal Header"."Supervisor No.")
            {
            }
            column(SupervisorID_HRAppraisalHeader; "HR Appraisal Header"."Supervisor User ID")
            {
            }
            column(Date_of_First_Appointment; "HR Appraisal Header"."Date of First Appointment") { }
            column(EvaluationPeriodStart_HRAppraisalHeader; "HR Appraisal Header"."Evaluation Period Start Date")
            {
            }
            column(Evaluation_Period_End_Date; "HR Appraisal Header"."Evaluation Period End Date")
            {
            }
            column(Goal_Setting__31_Jan_; "HR Appraisal Header"."Goal Setting (31 Jan)") { }
            column(Mid_Term_Review__31_Jul_; "HR Appraisal Header"."Mid Term Review (31 Jul)") { }
            column(Annual_Review__31_Dec_; "HR Appraisal Header"."Annual Review (31 Dec)") { }
            column(AppraisalDate_HRAppraisalHeader; "HR Appraisal Header"."Document Date")
            {
            }
            column(EvaluationPeriodEnd_HRAppraisalHeader; "HR Appraisal Header"."Evaluation Period End Date")
            {
            }
            column(CommentsAppraisee_HRAppraisalHeader; "HR Appraisal Header"."Comments Appraisee")
            {
            }
            column(CommentsAppraiser_HRAppraisalHeader; "HR Appraisal Header"."Comments Appraiser")
            {
            }
            column(Department_HRAppraisalHeader; "HR Appraisal Header"."Department Name")
            {
            }

            column(EmployeeNo_HRAppraisalHeader; "HR Appraisal Header"."Employee No.")
            {
            }
            column(Job_Title; "HR Appraisal Header"."Job Title")
            {
            }

            column(DateSend; DateSend)
            {
            }
            column(Sender; Sender)
            {
            }
            column(approver; approver)
            {
            }
            column(SupervisorJobId; SupervisorJobId)
            {
            }
            column(SupervisorName; SupervisorName)
            {
            }
            column(Jobtitle; Jobtitle)
            {
            }
            column(CompanInfoPic; CompanInfo.Picture) { }
            column(CompanInfoName; CompanInfo.Name) { }

            column(EmployeeName_HRAppraisalHeader; "HR Appraisal Header"."Employee Name")
            {
            }
            dataitem("Projects Work Load"; "Projects Work Load")
            {
                DataItemLink = "Header No" = field("No.");
                column(Header_No; "Header No") { }
                column(Project_Code; "Project Code") { }
                column(Project_Name; "Project Name") { }
                column(Weight; Weight) { }
                column(SNP; SN)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SN := SN + 1;
                end;

            }
            dataitem(KPI; "Appraissal Lines WP")
            {
                DataItemLink = "Header No" = field("No.");
                column(KPI_Header_No; "Header No") { }
                column(KPI_Project_Code; "Project Code") { }
                column(KPI_Objectives; Objectives) { }
                column(Key_Performance_Indicator; "Key Performance Indicator") { }
                column(Agreed_Performance_Targets; "Agreed Performance Targets") { }
                column(SNKPI; SNKPI)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SNKPI := SNKPI + 1;
                end;

            }
            dataitem("Resources Required "; "Resources Required ")
            {
                DataItemLink = "Header No" = field("No.");
                column(Project_CodeR; "Project Code") { }
                column(Project_NameR; "Project Name") { }
                column(Resources_RequiredR; "Resources Required") { }
                column(Person_ResponsibleR; "Person Responsible") { }
                column(InterventionR; Intervention) { }
                column(Targets_and_timelinesR; "Targets and timelines") { }
                column(SNR; SNR)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SNR := SNR + 1;
                end;
            }
            dataitem(Confirmation; Confirmation)
            {
                DataItemLink = "Header No" = field("No.");
            }
            dataitem(Assessment; Assessment)
            {
                DataItemLink = "Appraisal No" = field("No."), "Employee No" = field("Employee No.");
                column(Employee_s_self_assessment; "Employee’s self-assessment") { }
                column(Appraiser_s_assessment; "Appraiser’s assessment") { }
            }
            dataitem("HR Appraisal Lines"; "HR Appraisal Lines")
            {
                DataItemLink = "Appraisal No" = field("No.");
                column(ReportForNavId_1000000054; 1000000054)
                {
                }
                column(LineNo_HRAppraisalLines; "HR Appraisal Lines"."Line No")
                {
                }
                column(PerfomanceGoalsandTargets_HRAppraisalLines; "HR Appraisal Lines"."Perfomance Goals and Targets")
                {
                }
                column(KeyOutputAreas_HRAppraisalLines; "HR Appraisal Lines"."Key Output Areas")
                {
                }
                column(KeyPerformanceIndicators_HRAppraisalLines; "HR Appraisal Lines"."Key Performance Indicators")
                {
                }
                column(CourseName_HRAppraisalLines; "HR Appraisal Lines"."Course Name")
                {
                }
                column(KeyPerformanceAreas_HRAppraisalLines; "HR Appraisal Lines"."Key Performance Areas")
                {
                }
                column(SN; SN)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SN := SN + 1;
                end;
            }
            dataitem("Appraissal Lines WP"; "Appraissal Lines WP")
            {
                DataItemLink = "Header No" = field("No.");
                column(ObjectivesA; Objectives) { }
                column(Key_Performance_Indicator_A; "Key Performance Indicator") { }
                column(Actual_Achievement_A; "Actual Achievement") { }
                column(Appraisee_Rating; "Appraisee Rating") { }
                column(Appraiser_Rating; "Appraiser Rating") { }
                column(Project_Code_A; "Project Code") { }
                column(projectWeight; projectWeight) { }
                column(total; total) { }
                column(grandTotal; grandTotal) { }
                column(Totals; "Appraiser Rating" * "Projects Work Load".Weight / 100) { }
                column(SNA; SNA) { }
                trigger OnAfterGetRecord()
                var

                begin

                    SNA := SNA + 1;

                    ProjectWorkload.Reset();
                    ;
                    ProjectWorkload.SetRange(ProjectWorkload."Header No", "Header No");
                    ProjectWorkload.SetRange("Project Code", "Project Code");
                    if ProjectWorkload.Find('-') then begin
                        projectWeight := ProjectWorkload.Weight;
                        Message('Weight: %1', projectWeight);
                        total := "Appraiser Rating" * projectWeight / 100;
                        Message('Weight: %1 * Rating: %2 = total: %3', projectWeight, "Appraiser Rating", total);

                        grandTotal += total;
                        Message('grand: %1', grandTotal);
                    end;

                    // Totals := Weight * "Appraiser Rating";
                end;

            }
            trigger OnPreDataItem()
            begin
                CompanInfo.Get;
                CompanInfo.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."User ID", UserId);
                if HREmp.FindFirst then
                    Jobtitle := HREmp."Job Title";

                HREmp.Reset;
                HREmp.SetRange(HREmp."User ID", "HR Appraisal Header"."Supervisor User ID");
                if HREmp.FindFirst then begin
                    SupervisorName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    SupervisorJobId := HREmp."Job Title";
                end;

                HRAppraisalH.Reset;
                HRAppraisalH.SetRange(HRAppraisalH."No.", "HR Appraisal Lines"."Appraisal No");
                if HRAppraisalH.FindFirst then begin
                    UserSetup.Reset;
                    UserSetup.SetRange(UserSetup."User ID", "User ID");
                    if UserSetup.FindFirst then begin
                        Sender := HRAppraisalH."User ID";

                    end;
                end;
                UserSetup1.Reset;
                UserSetup1.SetRange(UserSetup1."User ID", HRAppraisalH."Supervisor User ID");
                if UserSetup1.FindFirst then begin
                    approver := HRAppraisalH."Supervisor User ID";

                end;
                Totals := "Projects Work Load".Weight * "Appraissal Lines WP"."Appraiser Rating";

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        HRAppraisalH: Record "HR Appraisal Header";
        UserSetup: Record "User Setup";
        Sender: Code[30];
        DateSend: Text;
        UserSetup1: Record "User Setup";
        approver: Code[30];
        SN: Integer;
        SNA: Integer;
        Totals: Decimal;
        SNKPI: Integer;
        SNR: Integer;
        HREmp: Record "HR Employees";
        SupervisorName: Text;
        SupervisorJobId: Text;
        Jobtitle: Text[100];
        CompanInfo: Record "Company Information";
        ProjectWorkload: Record "Projects Work Load";
        projectWeight: Decimal;
        grandTotal: Decimal;
        total: Decimal;
}

