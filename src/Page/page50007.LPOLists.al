page 50007 "LPO Lists"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchase Header";
    CardPageId = "LPO Card";
    SourceTableView = where("Document Type" = const(Order)
                           );

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.") { ApplicationArea = ALL; }
                field("Buy-from Vendor Name";Rec."Buy-from Vendor Name"){}
                field("Buy-from Address";Rec."Buy-from Address"){}
                field("Buy-from Address 2";Rec."Buy-from Address 2"){}
                field("Posting Description";Rec."Posting Description"){Caption='Memo';}
                field("Net Amount";Rec."Net Amount"){}
                field("Amount Including VAT";Rec."Amount Including VAT"){}
                field("Shortcut Dimension 4 Code";Rec."Shortcut Dimension 4 Code"){}
                field(Status;Rec.Status){}
                
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        //Rec.SetRange("User ID", UserId);
    end;
}