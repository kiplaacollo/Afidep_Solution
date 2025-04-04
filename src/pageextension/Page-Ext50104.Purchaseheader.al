pageextension 50104 "Purchase headers" extends "Purchase List"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Bank No Series";Rec."Bank No Series")
            {
                ApplicationArea = all;

            }
            field("AU Form Type";Rec."AU Form Type")
            {
                ApplicationArea = all;
                
            }
            field("Type of Payment";Rec."Type of Payment2")
            {
                ApplicationArea = all;
                
            }
             field("Mission Proposal No";Rec."Mission Proposal No")
            {
                ApplicationArea = all;
                Caption='Expense Requisition No';
                
            }
             field("Imprest Requisition No";Rec."Imprest Requisition No")
            {
                ApplicationArea = all;
                
            }
            field("CashBook Naration";Rec."CashBook Naration")
            {
                ApplicationArea = all;
                
            }
            field("Payee Naration";Rec."Payee Naration")
            {
                ApplicationArea = all;
                Caption='Payee';
                
            }
            field("Employee Name";Rec."Employee Name")
            {
                ApplicationArea = all;
                
            }
            field("Account No";Rec."Account No")
            {
                ApplicationArea = all;
                
            }
            field("Posting Dates";Rec."Posting Date")
            {
                ApplicationArea = all;
                
            }
            field("CurrencyCode";Rec."Currency Code")
            {
                ApplicationArea = all;
                
            }
            field(Amounts;Rec.Amount)
            {
                ApplicationArea = all;
                
            }
            field("Mission Naration";Rec."Mission Naration")
            {
                ApplicationArea = all;
                
            }
            
            
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}