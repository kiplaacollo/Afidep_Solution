Page 50104 Confirmation
{
    PageType = ListPart;
    SourceTable = Confirmation;
    UsageCategory = Tasks;
    ApplicationArea = ALL;
    Editable = true;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group1)
            {
                field("Header No"; Rec."Header No")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                }
                field(Signature1; Rec."Employee’s Signature")
                {
                    TableRelation = "HR Employees".Signature;
                    ApplicationArea = Basic;
                    Visible = true;
                    Caption = 'Employee’s Signature';
                }
                field(Date1; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }

            }
            repeater(Group2)
            {

                field(Signature2; Rec."Appraiser’s Signature")
                {
                    TableRelation = "HR Employees".Signature;
                    ApplicationArea = Basic;
                    Visible = true;
                    Caption = 'Appraiser’s Signature';
                }
                field(Date2; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }

            }
        }
    }
}