page 172242 "Partner contacts"
{
    ApplicationArea = All;
    Caption = 'Partner contacts';
    PageType = ListPart;
    SourceTable = PrtnerMeetingtracker;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Partner staff code"; Rec."Partner staff code")
                {
                    ToolTip = 'Specifies the value of the Partner staff code field.';
                    TableRelation = Contact."No." where(Type = filter("Contact Type"::Person));


                    trigger OnValidate()
                    var
                        cntacts: Record Contact;
                    begin
                        cntacts.get(Rec."Partner staff code");
                        Rec."Partner email" := cntacts."E-Mail";
                        rec."Partner phone" := cntacts."Phone No.";
                        rec."Partner staff name" := cntacts.Name;
                        rec."Partner title" := cntacts."Job Title";

                    end;
                }
                field("Partner staff name"; Rec."Partner staff name")
                {
                    ToolTip = 'Specifies the value of the Partner staff name field.';
                }
                field("Partner email"; Rec."Partner email")
                {
                    ToolTip = 'Specifies the value of the Partner email field.';
                }
                field("Partner phone"; Rec."Partner phone")
                {
                    ToolTip = 'Specifies the value of the Partner phone field.';
                }

                field("Partner title"; Rec."Partner title")
                {
                    ToolTip = 'Specifies the value of the Partner title field.';
                }
            }
        }
    }
}
