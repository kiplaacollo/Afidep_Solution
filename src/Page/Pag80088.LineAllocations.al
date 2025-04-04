Page 80088 "Line Allocations"
{
    CardPageID = "Line Allocation Card";
    PageType = List;
    SourceTable = "Allocation Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Allocation No";Rec."Allocation No")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount";Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked;Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Generate")
            {
                Caption = '&Generate';
                Image = Quote;
              
            }
        }
    }

    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then begin
          if not UserSetup."View Payroll" then
            Error('You do not have the permissions to access the Allocations');
         end else begin
          Error('User Account not set up');
         end;
    end;

    var
        UserSetup: Record "User Setup";
}

