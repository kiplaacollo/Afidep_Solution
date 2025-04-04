page 50082 "RFQ Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Purchase Line";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {

                field("Document No."; Rec."Document No.") { ApplicationArea = all; Visible = false; }
                field("Document Type"; Rec."Document Type") { ApplicationArea = all; Visible = false; }
                field("Line No."; Rec."Line No.") { ApplicationArea = all; Visible = false; }
                field(Type; Rec.Type) { ApplicationArea = all; Enabled = false; Visible = false; }
                field("No."; Rec."No.") { ApplicationArea = all; Enabled = false; Visible = false; }
                field(Description; Rec.Description) { ApplicationArea = all; Caption = 'GL Account '; Enabled = false; Visible = false; }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Caption = 'Item Description';


                }
                field(Quantity; Rec.Quantity) { ApplicationArea = all; }
                field("Direct Unit Cost"; Rec."Direct Unit Cost") { ApplicationArea = all; }
                field(Amount; Rec.Amount) { ApplicationArea = all; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = all; Editable = true; Visible = true; }

                
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendApprovalWorkflow)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
                end;
            }
        }
    }

    var
        myInt: Integer;
        ApprovalMgt: Codeunit "Approvals Mgmt.";
}