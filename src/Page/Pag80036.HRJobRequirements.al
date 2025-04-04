Page 80036 "HR Job Requirements"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            group("Job Specification")
            {
                Caption = 'Job Details';
                field("Job ID";Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Job Description";Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
            }
            group("Job Requirements")
            {
                part("Job Req";"HR Job Requirement Lines")
                {
                    SubPageLink = "Job Id"=field("Job ID");
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008;Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Job Requirements")
            {
                ApplicationArea = Basic;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    HRJobReq.Reset;
                    HRJobReq.SetRange(HRJobReq."Job ID",Rec."Job ID");
                    if HRJobReq.Find('-') then
                    begin
                      Report.Run(55591,true,true,HRJobReq);
                    end;
                end;
            }
        }
    }

    var
        HRJobReq: Record "HR Jobss";
}

