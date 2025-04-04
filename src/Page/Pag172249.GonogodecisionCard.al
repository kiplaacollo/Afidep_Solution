page 172249 GonogodecisionCard
{
    ApplicationArea = All;
    Caption = 'GonogodecisionCard';
    PageType = Card;
    SourceTable = GonoGoDecision;

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
                    // TableRelation = EngagementsPlanner;
                }

                field(Donor; Rec.Donor)
                {
                    ToolTip = 'Specifies the value of the Donor field.';
                    Caption = 'Organisation';
                }
                field("Donor Name"; Rec."Donor Name")
                {
                    Editable = false;
                    Caption = 'Organisation Name';
                }
                field("Partner Type"; Rec."Partner Type")
                {
                    Caption = 'Organisation Type';

                }
                field("About funder"; Rec."About funder")
                {
                    Caption = 'Organisation Brief';

                }
                field("focus area code"; Rec."focus area code")
                {

                }
                field("Strategic fit "; Rec."Strategic fit")
                {
                    ToolTip = 'Specifies the value of the Strategic fit  field.';
                    Caption = 'Focus area fit';
                }
                field("Value (US$)"; Rec."Value (US$)")
                {
                    Caption = 'Opportunity Budget (US$)';

                }
                field("Likelihood of gift"; Rec."Likelihood of gift")
                {
                    Editable = true;
                    Visible = true;
                    Caption = 'Success Likelihood';
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                    Caption = 'Duration - (Months)';

                }

                field("What is it"; Rec.type)
                {
                    caption = 'What is it?';
                }

                field("Objective/goal"; Rec."Objective/goal")
                {
                    ToolTip = 'Specifies the value of the Objective/goal field.';
                    caption = 'Goal';
                }


                field("Focus countries"; Rec."Focus countries")
                {
                    ToolTip = 'Specifies the value of the Focus countries field.';
                    caption = 'Focust country/ies';
                }
                field("Submission deadline date"; Rec."Submission deadline date")
                {
                    ToolTip = 'Specifies the value of the Submission deadline date field.';

                }
                field("Submission deadline time"; Rec."Submission deadline time")
                {
                    ToolTip = 'Specifies the value of the Submission deadline time field.';
                    Caption = 'Date Feedback Expected';
                }
                field("Afidep Role"; Rec."Afidep Role")
                {

                }
                field(Budget; Rec.Budget)
                {
                    ToolTip = 'Specifies the value of the Budget field.';
                    Caption = 'Afidep Budget ($)';
                }

                field("Technical skills required"; Rec."Technical skills")
                {
                    ToolTip = 'Specifies the value of the Technical skills field.';
                    Caption = 'Technical skills required';
                    Visible = false;
                }

                field("Need Partners"; Rec."Need Partners")
                {
                    ToolTip = 'Specifies the value of the Partners field.';
                    Caption = 'Do we need partners?';
                }
                field(Partners; Rec.Partners)
                {
                    // ToolTip = 'Specifies the value of the Partners field.';
                    Caption = 'If yes Propose Patners?';
                }
                field("Do we have proposal development"; Rec."Proposal development")
                {
                    caption = 'Do we have proposal development capability';
                }

                field(Probability; Rec.Probability)
                {
                    ToolTip = 'Specifies the value of the Probability field.';
                    caption = 'Probability of success';
                    Visible = false;
                }


                field("Prospect type"; Rec."Prospect type")
                {
                    ToolTip = 'Specifies the value of the Prospect type field.';
                }
                field("Conflict of interest"; rec."Conflict of interest")
                {
                    caption = 'Is there any potential conflict of interest?';
                }
                field("Explain interest"; Rec."Explain interest")
                {
                    caption = 'If there any potential conflict of interest, Explain?';
                }
                field("Is There Risk"; Rec."Is There Risk")
                {

                }
                field("Level of Risk"; Rec."Level of Risk")
                {
                    Caption = 'If Yes, What level of Risk?';
                }
                field("Proposed Mitigation"; Rec."Proposed Mitigation")
                {
                    Caption = 'What is the Proposed Mitigation?';
                }
                field("Current,Previous,Incumbents"; Rec."Current,Previous,Incumbents")
                {
                    Caption = 'List any Current, Previous grantees or other Incumbents';
                    RowSpan = 10;
                    MultiLine = true;
                }
                field("Additional information"; rec."Additional information")
                {
                    caption = 'Additional information';
                }
                field("Important links"; Rec."Important links")
                {
                    ToolTip = 'Specifies the value of the Important links field.';
                }
                field(Quarter; Rec.Quarter)
                {
                    ToolTip = 'Specifies the value of the Quarter field.';
                    visible = false;
                }
                field("Donor contact"; Rec."Donor contact")
                {
                    ToolTip = 'Specifies the value of the Donor contact field.';
                }

                field(News; Rec.News)
                {
                    ToolTip = 'Specifies the value of the News field.';
                    Visible = false;
                }
                field("Lead source "; Rec."Lead source")
                {
                    ToolTip = 'Specifies the value of the Lead source  field.';
                    //caption = 'How did we hear about the opportunity?';
                }
                field(Decision; Rec.Decision)
                {
                    ToolTip = 'Specifies the value of the Decision field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Visible = false;
                }
                field("Decision narration"; Rec."Decision narration")
                {
                    ToolTip = 'Specifies the value of the Decision narration field.';
                    MultiLine = true;
                    caption = 'Status';
                    Visible = false;
                }
                field("Feed back"; Rec."Feed back")
                {
                    ToolTip = 'Specifies the value of the Feed back field.';
                    Visible = false;
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

                Enabled = EnableAction;
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
                Enabled = ActionCancel;

                trigger OnAction()
                var
                    customapprovals: Codeunit "Custom Approvals Codeunit";
                    recvar: Variant;
                begin
                    recvar := Rec;
                    if customapprovals.CheckApprovalsWorkflowEnabled(recvar) then
                        customapprovals.OnCancelDocApprovalRequest(recvar);
                    // if Rec.Decision = Rec.Decision::"Pending approval" then
                    //     Rec.Decision := Rec.Decision::Open;


                end;

            }

            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    RecI: RecordId;
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    RecI := Rec.RecordId;
                    ApprovalsMgmt.OpenApprovalEntriesPage(RecI);
                end;
            }

            action("Convert to Proposal development")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                // Visible = false;



                trigger OnAction()
                var

                    proposal: Record "Personal development Tracker";
                begin
                    if Rec.Decision <> Rec.Decision::Go then Error('Please make sure that the decision has been approved to Go');
                    proposal.reset;
                    proposal.SetRange(Engagement, Rec.Code);
                    if not proposal.FindFirst() then begin
                        proposal.init;
                        proposal.Funder := Rec.Donor;
                        proposal."Funder Name" := Rec."Donor Name";
                        proposal.Engagement := rec.Code;
                        proposal."Partner Type" := Rec."Partner Type";
                        proposal."About funder" := Rec."About funder";
                        proposal."Value (US$)" := Rec."Value (US$)";
                        proposal."Likelihood of gift" := Rec."Likelihood of gift";
                        proposal."Focus area" := rec."Strategic fit";
                        proposal.Duration := Rec.Duration;

                        proposal.Insert(true);
                        rec.Converted := true;
                    end else
                        Error('Proposal already decision already exist for this engagement plan');


                end;

            }
        }
    }

    trigger OnOpenPage()
    begin
        EnableAction := false;
        ActionCancel := false;
        if Rec.Decision = Rec.Decision::Open then begin
            EnableAction := true;
        end else begin
            EnableAction := false;
        end;
        if Rec.Decision = Rec.Decision::"Pending approval" then begin
            ActionCancel := true
        end else begin
            ActionCancel := false;
        end;
    end;

    var
        EnableAction: Boolean;
        ActionCancel: Boolean;
}
