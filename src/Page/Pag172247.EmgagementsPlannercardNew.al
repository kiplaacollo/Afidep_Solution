page 172247 EmgagementsPlannercard
{
    ApplicationArea = All;
    Caption = 'Engagements planner';
    PageType = Card;
    SourceTable = EngagementsPlanner;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';


                field("Code"; Rec."Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    Editable = true;
                    Caption = 'Opportunity Name';
                }

                field(Funder; Rec.Funder)
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Code field.';
                    caption = 'Organisation';
                    trigger OnValidate()
                    begin

                    end;
                }
                field("Funder Name"; Rec."Funder Name")
                {
                    Editable = false;
                    Caption = 'Organisation Name';
                }
                field("Partner Type"; Rec."Partner Type")
                {
                    Editable = true;
                    Caption = 'Organisation Type';
                }

                field("About funder"; Rec."About funder")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                    MultiLine = true;
                    caption = 'Organisation Brief';
                    RowSpan = 10;
                }
                field("focus area code"; Rec."focus area code")
                {
                    Editable = true;
                }
                field("AFIDEP Focus area fit"; Rec."Focus area")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                    Caption = 'Focus area fit';
                }
                field("Value (US$)"; Rec."Value (US$)")
                {
                    Editable = true;

                }
                field("Likelihood of gift"; Rec."Likelihood of gift")
                {
                    Editable = true;
                    Visible = true;
                    Caption = 'Probability of success';
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;

                }

                field("Target type"; Rec."Target type")
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Target type field.';
                    Visible = false;
                }
                field(Location; Rec.Location)
                {
                    Visible = true;
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field(Interest; Rec.Interest)
                {
                    Caption = 'Interest';
                }
                field(Influence; Rec.Influence)
                {
                    Caption = 'Influence';

                }




                field("Level of giving"; Rec."Level of giving")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Code field.';
                    Caption = 'Level of giving';
                }
                field("Funding history with similar / other organisations"; Rec."Funding history")
                {
                    Editable = false;
                    MultiLine = true;
                    RowSpan = 10;
                    Caption = 'Funding history with similar / other organisations';

                }
                field("Assigned priority level"; Rec.Priority)
                {
                    Caption = 'Assigned priority level';

                }
                field("Funding hisotry with afidep"; Rec."Funding history with afidep")
                {
                    MultiLine = true;
                    RowSpan = 10;
                    Editable = false;
                    Caption = 'Funding hisotry with afidep';

                }
                field("Key decision makers"; Rec."Key decision makers")
                {
                    MultiLine = true;
                    RowSpan = 10;
                    Editable = true;
                    Caption = 'Key decision makers';
                }
                field("Afidep interest"; Rec."Afidep interest")
                {
                    MultiLine = true;
                    RowSpan = 10;
                    Editable = true;
                    Caption = 'Afidep interest';
                }

                field("Fundraising method"; Rec."Fundraising method")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Code field.';
                    Caption = 'Fundraising method';
                }


                field("Stage in process"; Rec."Stage of process")
                {
                    caption = 'Stage in process';

                }


                field("Amount asked"; Rec."Amount asked")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Ask date"; Rec."Ask date")
                {
                    ToolTip = 'Specifies the value of the Ask date field.';
                    Visible = true;
                }

                field(Role; Rec.Role)
                {
                    Editable = false;
                    visible = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }



                // field(Name; Rec.name)
                // {
                //     Visible = false;
                //     caption = 'Name';
                //     TableRelation = Contact where(type = filter("Contact Type"::Company));
                // }


                field("Description of target"; Rec.Description)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }


                field("Website "; Rec."Website ")
                {
                    ToolTip = 'Specifies the value of the Website  field.';
                    Visible = false;
                }










                field("Likelihood of funding"; Rec."Likelihood of gift")
                {
                    ToolTip = 'Specifies the value of the Likelihood of gift field.';
                    Visible = false;
                    Caption = 'Likelihood of funding';
                }

                field("Estimated funding"; Rec."Timing of gift completion")
                {
                    ToolTip = 'Specifies the value of the Timing of gift completion field.';
                    Visible = false;
                    Caption = 'Estimated funding';

                }

                field("Estimated Timing Funding Likely to be received - Quarter and year"; Rec."Estimated funds")
                {
                    ToolTip = 'Specifies the value of the Estimated funds field.';
                    Visible = true;
                    caption = 'Estimated Timing Funding Likely to be received - Quarter and year';
                }

                field("Actions"; Rec."Actions")
                {
                    ToolTip = 'Specifies the value of the Estimated funds field.';
                    Visible = true;
                    caption = 'Actions';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    Caption = 'Meeting Date:';
                }
                field(Agenda; Rec.Agenda)
                {
                    Caption = 'Meeting Agenda:';
                }
                field("Key items"; Rec."Key items")
                {
                    ToolTip = 'Specifies the value of the Key items field.';
                    MultiLine = true;
                }


                field("Other notes"; Rec."Other notes")
                {
                    ToolTip = 'Specifies the value of the Other notes field.';
                }








            }

            group(Contacts)
            {
                part(Staff; "Staff ")
                {
                    SubPageLink = Code = field(Code);
                }
            }



            group(Partners)
            {
                part("Partner Contacts"; "Partner contacts")
                {
                    SubPageLink = Code = field(Code);
                }
            }

            group("Quartely updates_")
            {
                Visible = false;
                part(Updates; "Engagement plan quartely upda")
                {
                    SubPageLink = Code = field(Code);
                }
            }
            group("Action item Staff")
            {
                part("Action items Staff"; "Action items ")
                {
                    SubPageLink = Code = field(Code);
                }
            }

            group("Action item Patner")
            {
                part("Action items Patner"; "Action items Patner")
                {
                    SubPageLink = Code = field(Code);
                }
            }





            group("Status update_")
            {
                part("Status update"; "Status update")
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

            action("Convert to go no go decision")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;


                trigger OnAction()
                var

                    gonogo: Record GonoGoDecision;
                begin
                    gonogo.reset;
                    gonogo.SetRange(Engagement, Rec.Code);
                    if not gonogo.FindFirst() then begin
                        gonogo.init;
                        gonogo.Donor := Rec.Funder;
                        gonogo.Engagement := rec.Code;
                        gonogo."Partner Type" := Rec."Partner Type";
                        gonogo."About funder" := Rec."About funder";
                        gonogo."Value (US$)" := Rec."Value (US$)";
                        gonogo."Likelihood of gift" := Rec."Likelihood of gift";
                        gonogo."Strategic fit" := rec."Focus area";
                        gonogo.Duration := Rec.Duration;
                        // gonogo.Converted := true;

                        gonogo.Insert(true);
                        Rec.Converted := true;
                        Message('Rec has been converted to Go / no go decision successfully');
                    end else
                        Error('Go / no go decision already exist for this engagement plan');


                end;

            }


            action("Convert to Proposal development")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;


                trigger OnAction()
                var

                    proposal: Record "Personal development Tracker";
                begin
                    proposal.reset;
                    proposal.SetRange(Engagement, Rec.Code);
                    if not proposal.FindFirst() then begin
                        proposal.init;
                        proposal.Funder := Rec.Funder;
                        proposal.Engagement := rec.Code;
                        proposal."Partner Type" := Rec."Partner Type";
                        proposal."About funder" := Rec."About funder";
                        proposal."Value (US$)" := Rec."Value (US$)";
                        proposal."Likelihood of gift" := Rec."Likelihood of gift";
                        proposal."Focus area" := rec."Focus area";
                        proposal.Duration := Rec.Duration;
                        proposal.Insert(true);
                        rec.Converted := true;
                    end else
                        Error('Proposal already decision already exist for this engagement plan');


                end;

            }


        }
    }


}
