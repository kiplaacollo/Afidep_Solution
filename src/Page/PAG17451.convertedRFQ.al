page 17451 "RFQ List Converted"
{
    CardPageID = "RFQ Header";
    PageType = List;
    SourceTable = "Purchase Quote Header";
    SourceTableView = WHERE("Approval Status" = FILTER(New | "Pending Approval" | Approved), Converted = const(true));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Posting Description"; Rec."Posting Description")
                {
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Visible = false;
                }
                field("Expected Closing Date"; Rec."Expected Closing Date")
                {

                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;

                }
                field(StatusRec; Rec.Status)
                {
                    Visible = false;
                    Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                field(Converted; Rec.Converted)
                {
                }
            }
        }
    }

    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        // //   Rec.Reset();
        //if (rec."Approval Status" <> Rec."Approval Status"::Approved) then
        //  repeat
        rec."Approval Status" := Rec."Approval Status"::Approved;
        Rec.Status := Rec.Status::Approved;
        Rec.Modify(true);
        //until Rec.Next = 0;
    end;

    procedure GetSelectionFilter(): Text
    var
        RFQ: Record "170160";
        SelectionFilterManagement: Codeunit "46";
    begin
        CurrPage.SETSELECTIONFILTER(RFQ);
        //EXIT(SelectionFilterManagement.GetSelectionFilterForItem(Item));
        EXIT(RFQ."No.");
    end;

    procedure SetSelection(var RFQ: Record "170160")
    begin
        CurrPage.SETSELECTIONFILTER(RFQ);
    end;
}

