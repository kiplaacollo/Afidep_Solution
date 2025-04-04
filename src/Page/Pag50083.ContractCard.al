page 50083 "Contract Card"
{
    SourceTable = 172774;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                }
                field("Company Name"; Rec."Company Name")
                {
                }
                field("Serial No."; Rec."Serial No.")
                {
                    Visible = false;
                }
                field(Parties; Rec.Parties)
                {
                }
                field("Record Type"; Rec."Record Type")
                {
                    LookupPageID = "Record Type List";
                    TableRelation = "Record Type";
                    Visible = false;
                }
                field("Internal Contract Owner"; Rec."Internal Contract Owner")
                {
                }
                field("Contract type"; Rec."Contract type")
                {
                    LookupPageID = "Contract type list";
                    TableRelation = "Contract Type";
                }
                field(Status; Rec.Status)
                {
                    editable = false;
                }
                field("Contract Amount"; Rec."Contract Amount")
                {
                }
            }
            group("Contract Information")
            {
                field("Contract Title"; Rec."Contract Title")
                {
                    Caption = 'Contract Title';
                    Enabled = true;
                    Visible = true;
                }
                field("Commencement date"; Rec."Commencement date")
                {
                }
                field(Term; Rec.Term)
                {

                    trigger OnValidate()
                    begin
                        Rec."Expiry Date" := (CALCDATE('<' + (Rec.Term) + '>', Rec."Commencement date")) - 1;
                    end;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    Editable = false;
                }
                field("Notify period"; Rec."Notify period")
                {
                }
                field(Notify; Rec.Notify)
                {
                }
                field(Comments; Rec.Comments)
                {
                    Caption = 'Remarks';
                }
                field("Renewal type"; Rec."Renewal type")
                {
                    LookupPageID = "Contract type list";
                    TableRelation = "Renewal Type";
                    Visible = false;
                }
                field("Contract Description"; Rec."Contract Description")
                {
                    Caption = 'Contract Description';
                }
            }
            part("Contract Party List"; 50088)
            {
                SubPageLink = No = FIELD(No);
            }
            part(Milestones; Milestones1)
            {
                SubPageLink = Contract = field(no);
            }
            part(Updates; "L_Updates List")
            {
                SubPageLink = No = field(No);
            }


        }
    }

    actions
    {
        area(creation)
        {
            action(Archive)
            {

                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure you want to archive') THEN BEGIN

                        Rec."Expiry Date" := TODAY;
                        Rec.Status := Rec.Status::Closed;
                        Rec.MODIFY;
                        MESSAGE('Archived');
                    END;
                end;
            }
            action("Attach Contract")
            {
                Enabled = true;
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    HYPERLINK('http://192.168.4.52/Loans%20%20External/');
                end;
            }



            action("Change status to pending")
            {
                Enabled = true;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    Rec.Status := rec.Status::Pending;
                    Rec.Modify;
                end;
            }

            action("Change status to Active")
            {
                Enabled = true;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    Rec.Status := rec.Status::Active;
                    Rec.Modify;
                end;
            }
            action("Change status to Expired")
            {
                Enabled = true;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    Rec.Status := rec.Status::Expired;
                    Rec.Modify;
                end;
            }



        }
    }
}

