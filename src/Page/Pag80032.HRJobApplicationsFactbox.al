Page 80032 "HR Job Applications Factbox"
{
    PageType = ListPart;
    SourceTable = "HR Job Applications";

    layout
    {
        area(content)
        {
            field(GeneralInfo; GeneralInfo)
            {
                ApplicationArea = Basic;
                Style = Strong;
                StyleExpr = true;
            }
            field("Application No"; Rec."Application No")
            {
                ApplicationArea = Basic;
            }
            field("Date Applied"; Rec."Date Applied")
            {
                ApplicationArea = Basic;
            }
            field("First Name"; Rec."First Name")
            {
                ApplicationArea = Basic;
            }
            field("Middle Name"; Rec."Middle Name")
            {
                ApplicationArea = Basic;
            }
            field("Last Name"; Rec."Last Name")
            {
                ApplicationArea = Basic;
            }
            field(Qualified; Rec.Qualified)
            {
                ApplicationArea = Basic;
            }
            field("Interview Invitation Sent"; Rec."Interview Invitation Sent")
            {
                ApplicationArea = Basic;
            }
            field("ID Number"; Rec."ID Number")
            {
                ApplicationArea = Basic;
            }
            field(PersonalInfo; PersonalInfo)
            {
                ApplicationArea = Basic;
                Style = Strong;
                StyleExpr = true;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
            field(Age; Rec.Age)
            {
                ApplicationArea = Basic;
            }
            field("Marital Status"; Rec."Marital Status")
            {
                ApplicationArea = Basic;
            }
            field(CommunicationInfo; CommunicationInfo)
            {
                ApplicationArea = Basic;
                Style = Strong;
                StyleExpr = true;
            }
            field("Cell Phone Number"; Rec."Cell Phone Number")
            {
                ApplicationArea = Basic;
                ExtendedDatatype = PhoneNo;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = Basic;
                ExtendedDatatype = EMail;
            }
            field("Work Phone Number"; Rec."Work Phone Number")
            {
                ApplicationArea = Basic;
                ExtendedDatatype = PhoneNo;
            }
        }
    }

    actions
    {
    }

    var
        GeneralInfo: label 'General Applicant Information';
        PersonalInfo: label 'Personal Infomation';
        CommunicationInfo: label 'Communication Information';
}

