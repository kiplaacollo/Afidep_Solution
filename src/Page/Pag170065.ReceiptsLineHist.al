Page 170065 "Receipts Line Hist"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Receipt Lines";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Receipt Transaction Type";Rec."Receipt Transaction Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Type";Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Customer Transaction type";Rec."Customer Transaction type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Applies-to Doc. Type";Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = Basic;
                }
                field("Applies to Doc. No";Rec."Applies to Doc. No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount";Rec."Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

