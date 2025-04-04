//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172913 "Case list"
{
    CardPageID = "Cases Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Cases Management";
    SourceTableView = where(Status = filter(Open));

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
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID No";Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
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
                field("Caller Reffered To";Rec."Caller Reffered To")
                {
                    ApplicationArea = Basic;
                    Caption = 'Case Escalated to:';
                }
                field("Action Taken";Rec."Action Taken")
                {
                    ApplicationArea = Basic;
                }
                field("Date To Settle Case";Rec."Date To Settle Case")
                {
                    ApplicationArea = Basic;
                }
                field("Document Link";Rec."Document Link")
                {
                    ApplicationArea = Basic;
                }
                field("Solution Remarks";Rec."Solution Remarks")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Case Solved";Rec."Case Solved")
                {
                    ApplicationArea = Basic;
                }
                field("Body Handling The Complaint";Rec."Body Handling The Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(Recomendations; Rec.Recomendations)
                {
                    ApplicationArea = Basic;
                }
                field(Implications; Rec.Implications)
                {
                    ApplicationArea = Basic;
                }
                field("Support Documents";Rec."Support Documents")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Lodging the Complaint";Rec."Mode of Lodging the Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Resource Assigned";Rec."Resource Assigned")
                {
                    ApplicationArea = Basic;
                }
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = Basic;
                }
                field("Closed By";Rec."Closed By")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No";Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            // part(Control7;"Member Statistics FactBox")
            // {
            //     Caption = 'BOSA Statistics FactBox';
            //     SubPageLink = "No." = field("Member No");
            // }
            // part(Control6;"FOSA Statistics FactBox")
            // {
            //     SubPageLink = "No." = field("FOSA Account.");
            // }
        }
    }

    actions
    {
        area(creation)
        {
            action("Recall Case")
            {
                ApplicationArea = Basic;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField("Recall Reason");
                    if ObjGenEnquiry.Get(Rec."Initiated Enquiry No") then begin
                        if ObjGenEnquiry."Captured By" <> UserId then begin
                            Error('You can only recall an issue you have initiated');
                        end;
                    end;

                    if Confirm('Confirm you want to recall this case', false) = true then begin
                        ObjCaseManagement.Reset;
                        ObjCaseManagement.SetRange(ObjCaseManagement."Case Number", Rec."Case Number");
                        if ObjCaseManagement.FindSet then begin
                            ObjCaseManagement.Status := ObjCaseManagement.Status::Recalled;
                            ObjCaseManagement.Modify;
                        end;

                        if ObjGenEnquiry.Get(Rec."Initiated Enquiry No") then begin
                            ObjGenEnquiry.Status := ObjGenEnquiry.Status::New;
                            ObjGenEnquiry.Send := false;
                            ObjGenEnquiry.Modify;
                        end;
                    end;
                end;
            }
        }
    }

    var
        ObjCaseManagement: Record "Cases Management";
        ObjGenEnquiry: Record "General Equiries.";
}




