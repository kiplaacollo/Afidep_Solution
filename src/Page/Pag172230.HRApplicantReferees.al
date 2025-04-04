//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17310 "HR Applicant Referees"
{
    PageType = ListPart;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Applicant Referees";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
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




