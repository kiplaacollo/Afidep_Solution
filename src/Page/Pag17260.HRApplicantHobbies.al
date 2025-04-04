//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17260 "HR Applicant Hobbies"
{
    PageType = ListPart;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Applicant Hobbies";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Hobby"; Rec.Hobby)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Hobbies field';
                }
                field("Job Application No"; Rec."Job Application No")
                {
                    Visible = false;
                }
                field("Line No"; Rec."Line No")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}




