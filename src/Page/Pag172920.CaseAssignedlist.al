//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172920 "Case Assigned  list"
{
    CardPageID = "Cases Assigned card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Cases Management";
    SourceTableView = where(Status = filter(Escalated));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = Basic;
                }

                field("Date of Complaint"; Rec."Date of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Recommended Action"; Rec."Recommended Action")
                {

                    ApplicationArea = Basic;
                }
                field("Case Description"; Rec."Case Description")
                {
                    ApplicationArea = Basic;
                }
                field("Action Taken"; Rec."Action Taken")
                {
                    ApplicationArea = Basic;
                }
                field("Date To Settle Case"; Rec."Date To Settle Case")
                {
                    ApplicationArea = Basic;
                }
                field("Document Link"; Rec."Document Link")
                {
                    ApplicationArea = Basic;
                }
                field("Solution Remarks"; Rec."Solution Remarks")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Body Handling The Complaint"; Rec."Body Handling The Complaint")
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
                field("Support Documents"; Rec."Support Documents")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Resource Assigned"; Rec."Resource Assigned")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
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
            // part(Control5;"Loans Sub-Page List")
            // {
            //     Caption = 'Loans Details';
            //     SubPageLink = "Client Code" = field("Member No");
            // }
        }
    }

    actions
    {
        area(creation)
        {

        }
    }

    trigger OnInit()
    begin
        //     Rec.SetRange("Resource Assigned", UserId);
    end;

    trigger OnOpenPage()
    begin
        //   Rec.SetRange("Resource Assigned", UserId);
    end;
}




