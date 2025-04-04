//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17289 "Posted Funds Transfer Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Funds Transfer Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
  
                field("Document Date";Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Posting Date";Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Bank Account";Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Paying Bank Name";Rec."Paying Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Balance";Rec."Bank Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No.";Rec."Bank Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Currency Code";Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Amount to Transfer";Rec."Amount to Transfer")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount to Transfer(LCY)";Rec."Amount to Transfer(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Total Line Amount";Rec."Total Line Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Line Amount(LCY)";Rec."Total Line Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque/Doc. No";Rec."Cheque/Doc. No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By";Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created";Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Time Created";Rec."Time Created")
                {
                    ApplicationArea = Basic;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control24;"Funds Transfer Lines")
            {
                SubPageLink = "Document No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
          
            action(Print)
            {
                ApplicationArea = Basic;
                Caption = 'Reprint';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                 

                    FHeader.Reset;
                    FHeader.SetRange(FHeader."No.", rec."No.");
                    if FHeader.FindFirst then
                        Report.run(50076, true, true, FHeader);

                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Pay Mode":="Pay Mode"::Cash;
        rec."Transfer Type" := rec."transfer type"::InterBank;
    end;

    var
        // FundsManager: Codeunit "Funds Management";
        // FundsUser: Record "Funds User Setup";
        JTemplate: Code[50];
        JBatch: Code[50];
        FHeader: Record "Funds Transfer Header";
        FLine: Record "Funds Transfer Line";

    local procedure CheckRequiredItems()
    begin
        rec.TestField("Posting Date");
       rec. TestField("Paying Bank Account");
        rec.TestField("Amount to Transfer");
        if rec."Pay Mode" = rec."pay mode"::Cheque then
            rec.TestField("Cheque/Doc. No");
        rec.TestField(Description);
        //TESTFIELD("Transfer To");

        FLine.Reset;
        FLine.SetRange(FLine."Document No", rec."No.");
        FLine.SetFilter(FLine."Amount to Receive", '<>%1', 0);
        if FLine.FindSet then begin
            repeat
                FLine.TestField(FLine."Receiving Bank Account");
            until FLine.Next = 0;
        end;
    end;
}




