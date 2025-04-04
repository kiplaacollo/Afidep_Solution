report 50108 "Workflow Report"
{
    Caption = 'orkflow Report';
    UsageCategory = Administration;
    ApplicationArea = All;

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Workflow.rdlc';

    dataset
    {
        dataitem("Workflow User Group"; "Workflow User Group")
        {
            column(Code; Code)
            {

            }
            column(Description; Description) { }
            dataitem("Workflow User Group Member"; "Workflow User Group Member")
            {
                DataItemLink = "Workflow User Group Code" = FIELD(Code);
                RequestFilterFields = "User Name";
                column(Workflow_User_Group_Code; "Workflow User Group Code") { }
                column(User_Name; "User Name") { }
                column(Sequence_No_; "Sequence No.") { }
            }
        }
    }


}