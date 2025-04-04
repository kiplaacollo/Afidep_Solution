page 17411 "Approved RFQ List"
{
    CardPageID = "RFQ Header";
    PageType = List;
    SourceTable = "Purchase Quote Header";
    SourceTableView = WHERE("Approval Status" = FILTER(Approved),
                           Converted = const(true));

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
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
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
                }
                field(Status; Rec.Status)
                {
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
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

