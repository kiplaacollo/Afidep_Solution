page 172241 "Meeting tracker card "
{
    ApplicationArea = All;
    Caption = 'Meetings card ';
    PageType = Card;
    SourceTable = "Meeting tracker";
    //SourceTableView = where(Converted = const(false));

    layout
    {
        area(content)
        {

            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Organisation; Rec.Organisation)
                {
                    ToolTip = 'Specifies the value of the Organisation field.';
                    TableRelation = Contact."No.";

                    trigger OnValidate()

                    var
                        conts: record Contact;
                    begin

                        conts.Get(Rec.Organisation);
                        //  rec.Designation:=conts.pa

                    end;

                }
                field("Priority level"; Rec."Priority level")
                {
                    ToolTip = 'Specifies the value of the Priority level field.';
                }
                field(Agenda; Rec.Agenda)
                {
                    ToolTip = 'Specifies the value of the Agenda field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
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

            group(Staffs)
            {
                part(Staff; "Staff ")
                {
                    SubPageLink = Code = field(No);
                }

            }
            group(Partner)
            {
                part("Partner Contacts"; "Partner contacts")
                {
                    SubPageLink = Code = field(No);
                }
            }





            group("Action item Staff")
            {
                part("Action items Staff"; "Action items ")
                {
                    SubPageLink = Code = field(No);
                }
            }

            group("Action item Patner")
            {
                part("Action items Patner"; "Action items Patner")
                {
                    SubPageLink = Code = field(No);
                }
            }





            group("Status update_")
            {
                part("Status update"; "Status update")
                {
                    SubPageLink = Code = field(No);
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


                trigger OnAction()
                var

                    gonogo: Record GonoGoDecision;
                begin
                    gonogo.reset;
                    gonogo.SetRange(Engagement, Rec.no);
                    if not gonogo.FindFirst() then begin
                        gonogo.init;
                        gonogo.Donor := Rec.Organisation;
                        gonogo.Engagement := rec.no;
                        gonogo."Objective/goal" := Rec.Agenda;
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


                trigger OnAction()
                var

                    gonogo: Record "Personal development Tracker";
                begin
                    gonogo.reset;
                    gonogo.SetRange(Engagement, Rec.no);
                    if not gonogo.FindFirst() then begin
                        gonogo.init;
                        gonogo.Funder := Rec.Organisation;
                        gonogo.Engagement := rec.no;

                        // gonogo.Converted := true;
                        // gonogo."Year first submitted" := rec."Year first submitted";
                        // gonogo."Year of decision" := rec."Year of decision";
                        // gonogo."Engagement + deadline" := rec."Engagement + deadline";
                        // gonogo.Funder := rec.Funder;
                        // gonogo."About funder" := rec."About funder";
                        // gonogo.Duration := rec.Duration;
                        // gonogo."Focus area" := rec."Focus area";
                        // gonogo."Success likelihood" := rec."Success likelihood";
                        // gonogo.Role := rec.Role;
                        // gonogo."Oportunity value" := rec."Oportunity value";

                        gonogo.Insert(true);
                        //Rec.Converted := true;
                        Message('Rec has been converted to Proposal deevelopment successfully');
                    end else
                        Error('Go / no go decision already exist for this engagement plan');


                end;

            }


        }
    }


}
