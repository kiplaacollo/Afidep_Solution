//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172921 "Case Assigned  solved"
{
    CardPageID = "Cases solved card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Cases Management";
    SourceTableView = where(Status = filter(Resolved));

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
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
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
                field("Case Resolution Details"; Rec."Case Resolution Details")
                {
                    ApplicationArea = Basic;
                }
                field("Date To Settle Case"; Rec."Date To Settle Case")
                {
                    ApplicationArea = Basic;
                }
                field(Recomendations; Rec.Recomendations)
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
            // part(Control6; "Member Statistics FactBox")
            // {
            //     Caption = 'BOSA Statistics FactBox';
            //     SubPageLink = "No." = field("Member No");
            // }
            // part(Control5; "FOSA Statistics FactBox")
            // {
            //     SubPageLink = "No." = field("FOSA Account.");
            // }
            // part(Control4; "Loans Sub-Page List")
            // {
            //     Caption = 'Loans Details';
            //     SubPageLink = "Client Code" = field("Member No");
            // }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        //SETRANGE("Resource Assigned",USERID);
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("Resource Assigned",USERID);
    end;
}




