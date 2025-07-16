page 172251 "Proposal development trac card"
{
    ApplicationArea = All;
    Caption = 'Proposal development tracker card';
    PageType = Card;
    SourceTable = "Personal development Tracker";



    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    Editable = false;
                }
                field(Engagement; Rec.Engagement)
                {
                    // Editable = false;
                    // Caption = 'GoNoGo No:';
                }
                field(Funder; Rec.Funder)
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Code field.';
                    Caption = 'Organisation';
                }
                field("Funder Name"; Rec."Funder Name")
                {
                    Editable = false;
                    Caption = 'Organisation Name';
                }
                field("Partner Type"; Rec."Partner Type")
                {
                    Caption = 'Organisation Type';
                }
                field("Donor Type"; Rec."Donor Type")
                {
                    Editable = true;
                }
                field("About funder"; Rec."About funder")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Code field.';
                    MultiLine = true;
                    RowSpan = 10;
                    Caption = 'Organisation Brief';
                }
                field("focus area code"; Rec."focus area code")
                {

                }
                field("Focus area"; Rec."Focus area")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Code field.';
                    Caption = 'Focus area fit';
                }
                field("Value (US$)"; Rec."Value (US$)")
                {
                    Caption = 'Opportunity Budget (US$)';

                }
                field("AFIDEP Budget"; Rec."AFIDEP Budget")
                {
                    Caption = 'AFIDEP Budget (US$)';
                }

                field("Likelihood of gift"; Rec."Likelihood of gift")
                {
                    Editable = true;
                    Caption = 'Success Likehood';
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Duration; Rec.Duration)
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Code field.';
                    Caption = 'Duration - (Months)';
                }


                field("Year first submitted"; Rec."Year first submitted")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Decision Status"; Rec."Decision Status")
                {
                    Editable = true;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }

                field("Year of decision"; Rec."Year of decision")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Code field.';
                }

                field("Engagement + deadline"; Rec."Engagement + deadline")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Code field.';
                    MultiLine = true;
                    RowSpan = 8;
                    Caption = 'Deadline';
                }


                field(Role; Rec.Role)
                {
                    Visible = false;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Afidep Role"; Rec."Afidep Role")
                {

                }
                field("Lead source"; Rec."Lead source")
                {

                }
                field(Notes; Rec.Notes)
                {
                    MultiLine = true;
                    RowSpan = 10;
                }

                field("Oportunity value"; Rec."Oportunity value")
                {
                    Visible = false;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Code field.';
                }




            }
            group(Allocations)
            {
                part(Subform; PropposaldevelopmentSubform)
                {
                    SubPageLink = Code = field(code);
                }

            }


            group(Actionitems)
            {
                part(ActionitemsC; "Action items Proposal developm")
                {
                    SubPageLink = Code = field(Code);
                }
            }

        }
    }

    actions
    {
        area(processing)
        {
            action("Send approval request")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    customapprovals: Codeunit "Custom Approvals Codeunit";
                    recvar: Variant;
                begin
                    recvar := Rec;
                    if customapprovals.CheckApprovalsWorkflowEnabled(recvar) then
                        customapprovals.OnSendDocForApproval(recvar);


                end;

            }


            action("Cancel approval request")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    customapprovals: Codeunit "Custom Approvals Codeunit";
                    recvar: Variant;
                begin
                    recvar := Rec;
                    if customapprovals.CheckApprovalsWorkflowEnabled(recvar) then
                        customapprovals.OnCancelDocApprovalRequest(recvar);


                end;

            }


            action("Convert to Project award")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    Award: Record 170430;
                // customapprovals: Codeunit "Custom Approvals Codeunit";
                // recvar: Variant;
                begin
                    // recvar := Rec;
                    // if customapprovals.CheckApprovalsWorkflowEnabled(recvar) then
                    //      customapprovals.OnCancelDocApprovalRequest(recvar);
                    if rec.Status = rec.Status::Approved then begin

                        Award."No." := rec.Code;
                        Award.Name := rec.funder;
                        // award.sta
                        Award."Fund No." := rec.Partner;
                        Award.Insert(true);
                        rec.Status := rec.Status::Converted;
                        rec.Modify();
                        Message('Proporsal has been converted to award no ' + rec.code);

                    end
                    else
                        Error('Proporsal development must be approved first');


                end;

            }

        }
    }

}
