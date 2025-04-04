page 17393 "RFQ List"
{
    CardPageID = "RFQ Header";
    PageType = List;
    SourceTable = "Purchase Quote Header";
    SourceTableView = WHERE("Approval Status" = FILTER(New | "Pending Approval" | Approved), Converted = const(false));
    DeleteAllowed = false;
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
                field(Amount; Rec.Amount)
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
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;
                    Visible = true;
                }
                field(StatusRec; Rec.Status)
                {
                    Visible = false;
                    Editable = true;
                }
                field("Currency Code"; Rec."Currency Code")
                {
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

