page 50090 "L_Updates List"
{
    PageType = ListPart;
    SourceTable = 172778;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec. No)
                {
                    Visible = false;
                }
                field(Date; Rec. Date)
                {
                }
                field(User;  Rec.User)
                {
                    Caption = 'Owner';
                }
                field(Name; Rec. Name)
                {
                }
                field(Update;  Rec.Update)
                {
                    Caption = 'Update';
                }
                 field(Status;  Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
         Rec.Date := TODAY;
    end;
}

