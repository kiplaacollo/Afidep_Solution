page 80147 "PV Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Quote));

    layout
    {
        area(content)
        {
            repeater(c)
            {
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies a description of the entry, depending on what you chose in the Type field.';

                    trigger OnValidate()
                    begin
                        // ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;

                        IF xRec."No." <> '' THEN
                            RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = Advanced;
                    BlankZero = true;
                    Caption = 'Amount';
                    ShowMandatory = TypeChosen AND (Rec."No." <> '');
                    ToolTip = 'Specifies the cost of one unit of the selected item or resource.';

                    trigger OnValidate()
                    begin

                        RedistributeTotalsOnAfterValidate;
                    end;
                }
                field(Amount; Rec.Amount)
                {

                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = basic;


                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = basic;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("E&xplode BOM")
                {
                    AccessByPermission = TableData 90 = R;
                    ApplicationArea = Advanced;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    ToolTip = 'Insert new lines for the components on the bill of materials, for example to sell the parent item as a kit. CAUTION: The line for the parent item will be deleted and represented by a description only. To undo, you must delete the component lines and add a line the parent item again.';

                    trigger OnAction()
                    begin
                        ExplodeBOM;
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    AccessByPermission = TableData 279 = R;
                    ApplicationArea = Advanced;
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;
                    ToolTip = 'Insert the extended item description that is set up for the item that is being processed on the line.';

                    trigger OnAction()
                    begin
                        InsertExtendedText(TRUE);
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Event';
                        Image = "Event";
                        ToolTip = 'View how the actual and the projected available balance of an item will develop over time according to supply and demand events.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Period';
                        Image = Period;
                        ToolTip = 'View the projected quantity of the item over time according to time periods, such as day, week, or month.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData 14 = R;
                        ApplicationArea = Advanced;
                        Caption = 'Location';
                        Image = Warehouse;
                        ToolTip = 'View the actual and projected quantity of the item per location.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        ApplicationArea = Advanced;
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ToolTip = 'View availability figures for items on bills of materials that show how many units of a parent item you can make based on the availability of child items.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        //  ShowDimensions;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';

                    trigger OnAction()
                    begin
                        // ShowLineComments;
                    end;
                }
                action("Item Charge &Assignment")
                {
                    AccessByPermission = TableData 5800 = R;
                    ApplicationArea = ItemCharges;
                    Caption = 'Item Charge &Assignment';
                    Image = ItemCosts;
                    ToolTip = 'Assign additional direct costs, for example for freight, to the item on the line.';

                    trigger OnAction()
                    begin
                        ItemChargeAssgnt;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.';

                    trigger OnAction()
                    begin
                        OpenItemTrackingLines;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        // TypeChosen := HasTypeToFillMandatoryFields;
        UpdateEditableOnRow;
        IF PurchHeader.GET(Rec."Document Type", Rec."Document No.") THEN;

        DocumentTotals.PurchaseUpdateTotalsControls(Rec, TotalPurchaseHeader, TotalPurchaseLine, RefreshMessageEnabled,
          TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, VATAmount);

        UpdateCurrency;
    end;

    trigger OnAfterGetRecord()
    begin
        // ShowShortcutDimCode(ShortcutDimCode);
        CLEAR(DocumentTotals);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit "99000834";
    begin
        //IF (Rec.Quantity <> 0) AND ItemExists("No.") THEN BEGIN
        COMMIT;
        IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
            EXIT(FALSE);
        ReservePurchLine.DeleteLine(Rec);
    END;
    //end;

    trigger OnInit()
    begin
        Currency.InitRoundingPrecision;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // InitType;
        CLEAR(ShortcutDimCode);
        Rec.Type := Rec.Type::"G/L Account";
    end;

    trigger OnOpenPage()
    begin
        Rec.Type := Rec.Type::"G/L Account";
    end;

    var
        TotalPurchaseHeader: Record "38";
        TotalPurchaseLine: Record "39";
        PurchHeader: Record "38";
        Currency: Record "4";
        PurchCalcDiscByType: Codeunit "66";
        DocumentTotals: Codeunit "57";
        TransferExtendedText: Codeunit "378";
        ItemAvailFormsMgt: Codeunit "353";
        ShortcutDimCode: array[8] of Code[20];
        VATAmount: Decimal;
        InvDiscAmountEditable: Boolean;
        TotalAmountStyle: Text;
        RefreshMessageEnabled: Boolean;
        RefreshMessageText: Text;
        UnitofMeasureCodeIsChangeable: Boolean;
        TypeChosen: Boolean;
        GLBudgetName: Record "95";
        GLBudgetEntry: Record "96";

    [Scope('Personalization')]
    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    local procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    local procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;

    local procedure ItemChargeAssgnt()
    begin
        //ShowItemChargeAssgnt;
    end;

    local procedure OpenItemTrackingLines()
    begin
        OpenItemTrackingLines;
    end;

    [Scope('Personalization')]
    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    local procedure NoOnAfterValidate()
    begin
        UpdateEditableOnRow;
        InsertExtendedText(FALSE);
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(FALSE);
    end;

    local procedure RedistributeTotalsOnAfterValidate()
    begin
        CurrPage.SAVERECORD;

        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        IF DocumentTotals.PurchaseCheckNumberOfLinesLimit(PurchHeader) THEN
            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
        CurrPage.UPDATE;
    end;

    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        // ValidateShortcutDimCode(FieldNumber,ShortcutDimCode);
        CurrPage.SAVERECORD;
    end;

    local procedure UpdateEditableOnRow()
    begin
        // UnitofMeasureCodeIsChangeable := CanEditUnitOfMeasureCode;
    end;

    local procedure UpdateCurrency()
    begin
        IF Currency.Code <> TotalPurchaseHeader."Currency Code" THEN
            IF NOT Currency.GET(TotalPurchaseHeader."Currency Code") THEN BEGIN
                CLEAR(Currency);
                Currency.InitRoundingPrecision;
            END
    end;
}

