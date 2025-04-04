//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172886 "Member Case History"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Cases Management";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case Number";Rec."Case Number")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Complaint";Rec."Date of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Type of cases";Rec."Type of cases")
                {
                    ApplicationArea = Basic;
                }
                field("Recommended Action";Rec."Recommended Action")
                {
                    ApplicationArea = Basic;
                }
                field("Case Description";Rec."Case Description")
                {
                    ApplicationArea = Basic;
                }
                field("Action Taken";Rec."Action Taken")
                {
                    ApplicationArea = Basic;
                }
                field("Solution Remarks";Rec."Solution Remarks")
                {
                    ApplicationArea = Basic;
                }
                field("Case Resolution Details";Rec."Case Resolution Details")
                {
                    ApplicationArea = Basic;
                }
                field("Caller Reffered To";Rec."Caller Reffered To")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Resolved User";Rec."Resolved User")
                {
                    ApplicationArea = Basic;
                    Caption = 'Resolved By';
                }
                field("Date Resolved";Rec."Date Resolved")
                {
                    ApplicationArea = Basic;
                }
                field("Time Resolved";Rec."Time Resolved")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}




