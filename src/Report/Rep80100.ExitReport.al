report 80100 "Exit Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Exit Form.rdlc';

    dataset
    {
        dataitem("Exit Interviews"; "Exit Interviews")
        {
            RequestFilterFields = "Employee No";
            column(CompanyInformation_Pic; CompanyInformation.Picture) { }
            column(CompanyInformation_address; CompanyInformation.Address) { }
            column(CompanyInformation_Phone; CompanyInformation."Phone No.") { }
            column(CompanyInformation_name; CompanyInformation.Name) { }
            column(CompanyInformation_Address2; CompanyInformation."Address 2") { }
            column(CompanyInformation_homepage; CompanyInformation."Home Page") { }
            column(CompanyInformation_Email; CompanyInformation."E-Mail") { }
            column(Employee_No; "Employee No")
            {
            }
            column(Employee_Name; "Employee Name")
            {
            }
            column(Application_Code; "Application Code")
            {
            }
            column(Department; Department) { }
            column(Position; Position) { }
            column(Start_date; "Start date") { }
            column(Termination_date; "Termination date") { }
            column(Salary__per_annum_; "Salary (per annum)") { }
            column(Line_Manager; "Line Manager") { }
            column(Reason_1_For_leaving; "Reason 1 For leaving") { }
            column(Reason_1_Remarks; "Reason 1 Remarks") { }
            column(Reason_2_For_leaving; "Reason 2 For leaving") { }
            column(Reason_2_Remarks; "Reason 2 Remarks") { }
            column(Reason_3_For_leaving; "Reason 3 For leaving") { }
            column(Reason_3_Remarks; "Reason 3 Remarks") { }
            column(Organization; Organization) { }
            column(New_Position; "New Position") { }
            column(Other_Remarks; "Other Remarks") { }
            column(The_work_I_was_doing_on_the_whole_was_approximately_what_I_was_originally_expected_to_be_doing_; "The work I was doing on the whole was approximately what I was originally expected to be doing.") { }
            column(I_had__ample_opportunities_to_use_initiative; "I had  ample opportunities to use initiative") { }
            column(The_work_I_was_doing_was_interesting_and_challenging; "The work I was doing was interesting and challenging") { }
            column(Overall__I_was_satisfied_with_the_general_conditions; "Overall, I was satisfied with the general conditions") { }
            column(I_was_able_to_make_full_use_of_my_skills_and_abilities; "I was able to make full use of my skills and abilities") { }
            column(There_was_team_spirit_in_the_organisation; "There was team spirit in the organisation") { }
            column(There_was_too_much_pressure_on_my_job; "There was too much pressure on my job") { }
            column(I_had_ample_opportunities_for_personal_training_and_development; "I had ample opportunities for personal training and development") { }
            column(I_received_adequate_support_from_my_line_manager; "I received adequate support from my line manager") { }
            column(I_was_satisfied_with_my_salary; "I was satisfied with my salary") { }
            column(I_found_the_policies_and_procedures_fair_; "I found the policies and procedures fair.") { }
            column(I_had_the_necessary_freedom_to_make_my_own_decisions; "I had the necessary freedom to make my own decisions") { }
            column(I_had_opportunities_to_discuss_my_performance_with_my_line_manager_; "I had opportunities to discuss my performance with my line manager.") { }
            column(I_received_communication_to_enable_me_know_what_was_going_on_in_other_parts_of_the_organisation_; "I received communication to enable me know what was going on in other parts of the organisation.") { }
            column(Overall__I_felt_involved_in_the_work_of__AFIDEP; "Overall, I felt involved in the work of  AFIDEP") { }
            column(Other_Reasons_for_Leaving; "Other Reasons for Leaving") { }
            column(State_Reason_For_Leaving; "State Reason For Leaving") { }
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }

        }
    }



    var
        CompanyInformation: Record "Company Information";
}