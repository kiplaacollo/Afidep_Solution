Page 50038 "Project Card"
{
    PageType = Card;
    SourceTable = Projects;
    UsageCategory = Lists;
    ApplicationArea = ALL;
    layout
    {
        //
        area(content)
        {
            group(General)
            {
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = Basic;
                    //Caption = 'Short Title';
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Project Title:';
                    Editable = false;
                }
                field("Project Short Name"; Rec."Project Short Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Short Title';
                    Editable = false;
                }
                field("Thematic Programme"; Rec."Thematic Programme")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field("Project Manager & SMT Lead "; Rec."Project Manager & SMT Lead ")
                {
                    ApplicationArea = Basic;
                }

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Project start date';
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Project end date';
                    Editable = false;
                }
                field("Completed by"; Rec."Completed by")
                {
                    ApplicationArea = Basic;
                }
                field(Partner; Rec.Partner)
                {
                    ApplicationArea = Basic;
                    // Visible = false;
                    Caption = 'Funder(s)';
                    Editable = false;
                }
                field(Donor; Rec.Donor)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Funder(s)';
                }
            }
            part(Control9; "Project Funding")
            {
                SubPageLink = No = field("Project Code");
            }
            group("Project rationale:")
            {
                field("Project rationale"; Rec."Project rationale")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Project Goals:")
            {
                field("Goal Summary"; Rec."Goal Summary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Overall goal of the project / Impact';
                }
                field(Indicator; Rec.Indicator)
                {
                    ApplicationArea = Basic;
                    Caption = 'How will you know that you have succeded? (Key Performance Indicators)';
                }
            }
            part(Control15; "Project Goals")
            {
                SubPageLink = "Project Code" = field("Project Code");
                Visible = false;
            }
            part(Control16; "Project Outcomes")
            {
                SubPageLink = "Project Code" = field("Project Code");
            }
            part("Objective 1"; "Objective 1")
            {
                Caption = 'INSTITUTIONAL STRATEGIC OBJECTIVE 1: Generate policy-relevant research and other types of evidence, and support African governments and other development actors to apply evidence in decision-making';
                SubPageLink = "Project Code" = field("Project Code");
            }
            part("Objective 2"; "Objective 2")
            {
                Caption = 'INSTITUTIONAL STRATEGIC OBJECTIVE 2: Strengthen technical and institutional capacities needed to enable sustained use of evidence in decision-making';
                SubPageLink = "Project Code" = field("Project Code");
            }
            part("Objective 3"; "Objective 3")
            {
                Caption = 'INSTITUTIONAL STRATEGIC OBJECTIVE 3: Deepen engagement with African governments, and expand strategic partnerships and networks to enhance evidence use and impact.';
                SubPageLink = "Project Code" = field("Project Code");
            }
            part("Objective 4"; "Objective 4")
            {
                Caption = 'INSTITUTIONAL STRATEGIC OBJECTIVE 4: Optimise our internal capacity by establishing robust financial and operations management systems, strengthening talent management, strengthening project management and delivery, deepening policy engagement and communications capabilities, and harnessing technology to optimise internal processes and decision-making';
                SubPageLink = "Project Code" = field("Project Code");
            }

            group("")
            {
                field("Anticipated Risks "; Rec."Anticipated Risks ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Anticipated Risks';
                    MultiLine = true;
                    RowSpan = 10;
                }
                field("Risk Mitigation "; Rec."Risk Mitigation ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Risk Mitigation and control measures';
                    MultiLine = true;
                    RowSpan = 10;
                }
                field("Opportunities "; Rec."Opportunities ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Opportunities for the project';
                    MultiLine = true;
                    RowSpan = 10;
                }
            }
            part(Control17; "Report Q1")
            {
                SubPageLink = "Project Code" = field("Project Code");
                Caption = 'Report_Q1';
            }
            part(Control18; "Report Q2")
            {
                SubPageLink = "Project Code" = field("Project Code");
                Caption = 'Report_Q2';
            }
            part(Control19; "Report Q3")
            {
                SubPageLink = "Project Code" = field("Project Code");
                Caption = 'Report_Q3';
            }
            part(Control20; "Report Q4")
            {
                SubPageLink = "Project Code" = field("Project Code");
                Caption = 'Report_Q4';
            }
            part(Control21; "Quantitative Indicators")
            {
                SubPageLink = "Project Code" = field("Project Code");
                Caption = 'Quantitative Indicators';
            }
            part(Control22; "Qualitative Indicators")
            {
                SubPageLink = "Project Code" = field("Project Code");
                Caption = 'Qualitative Indicators';
            }
            part(Control23; "Project Impact")
            {
                SubPageLink = "Project Code" = field("Project Code");
                Caption = 'Project Impact';
            }
            part(Control24; "Peer Review")
            {
                SubPageLink = "Project Code" = field("Project Code");
                Caption = 'Project Peer Review';
                
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Project Work Plan")
            {
                ApplicationArea = Basic;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Project Work Plan";
            }
            action("Project Budget")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Project Budget";
                RunPageLink = "Project Code" = field("Project Code");
            }
        }
    }
}

