Page 80111 "Petty Cash Lines"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {

                field("Claim Type"; Rec."Claim Type")
                {
                    Caption = 'Type';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Advanced;
                    Editable = Editable;
                    Visible = false;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the line type.';



                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                        TypeChosen := Rec.HasTypeToFillMandatoryFields;
                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate;
                    end;
                }


                field("Account No New"; Rec."Account No New")
                {
                    Caption = 'Account No';
                    trigger OnValidate()
                    begin

                        PurchHeader.Reset();
                        PurchHeader.SetRange("No.", Rec."Document No.");
                        if PurchHeader.FindSet() then begin
                            Rec."Currency Factor" := PurchHeader."Currency Factor";
                            Rec."Shortcut Dimension 1 Code" := PurchHeader."Shortcut Dimension 1 Code";
                            Rec."Shortcut Dimension 2 Code" := PurchHeader."Shortcut Dimension 2 Code";
                        end;
                        Rec.Quantity := 1;
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;


                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate;
                    end;

                }

                field("No."; Rec."No.")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.';
                    Editable = Editable;
                    Visible = false;
                    trigger OnValidate()
                    begin

                        PurchHeader.Reset();
                        PurchHeader.SetRange("No.", Rec."Document No.");
                        if PurchHeader.FindSet() then begin
                            Rec."Currency Factor" := PurchHeader."Currency Factor";
                        end;
                        Rec.Quantity := 1;
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;


                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate;
                    end;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies a description of the entry, depending on what you chose in the Type field.';
                    Editable = Editable;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Item Specification';
                    ShowMandatory = true;
                    Editable = true;

                }


                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    //Visible = ;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Editable = false;
                    trigger OnValidate()
                    var
                        budgetmatrix: Record "Donors Budget Matrix line";
                        Lines: Record "Purchase Line";
                        GLBudget: Record "G/L Budget Entry";

                    begin

                        budgetmatrix.Reset();
                        budgetmatrix.SetFilter(budgetmatrix."Fund No Code", Rec."Shortcut Dimension 1 Code");
                        budgetmatrix.SetFilter(budgetmatrix."Budget Code2", Rec."Shortcut Dimension 2 Code");
                        if budgetmatrix.FindSet() then begin


                            Rec."Budget Line description" := budgetmatrix."Budget Line Description";


                        end;
                    end;
                }

                field("Shortcut Dimension 4 Code"; Rec."ShortcutDimCode[4]")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = Editable;
                }
                field("Shortcut Dimension 3 Code"; Rec."ShortcutDimCode[3]")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = Editable;

                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = Editable;

                }

                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ApplicationArea = Basic;

                    Editable = Editable;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = all;
                    Editable = Editable;
                }


                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = Basic;
                    Editable = Editable;
                    trigger OnValidate()
                    begin
                        //Rec."Net Amount" := Rec.Amount;
                        Rec.Amount := Rec."Direct Unit Cost" * Rec.Quantity;
                        Rec."Net Amount" := Rec."Unit Cost (LCY)" * Rec.Quantity;
                        Rec.Modify();

                    end;
                }


                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = Editable;
                    trigger OnValidate()
                    begin

                        //  Rec."Net Amount" := Rec.Amount;
                        //Rec.Modify(true)
                    end;
                }

                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = true;
                    ApplicationArea = Basic;
                    Editable = Editable;
                    //Caption = 'Amount in Local Currency';
                }

                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Editable = Editable;
                    trigger OnValidate()
                    begin
                        WithholdingTaxSetup.Reset;
                        WithholdingTaxSetup.SetRange(WithholdingTaxSetup.Code, Rec."Withholding Tax Code");

                        if WithholdingTaxSetup.FindFirst() then begin
                            Rec."Withholding Tax Rate %" := WithholdingTaxSetup."Rate %";

                            Rec."Withholding Tax Amount" := Rec."Direct Unit Cost" * (Rec."Withholding Tax Rate %") / 100;
                            Rec."Consultancy Fee" := Rec."Direct Unit Cost" * WithholdingTaxSetup."Consultancy Rate" / 100;
                            Rec."Withholdingg Tax(Consultancy/Professional)" := WithholdingTaxSetup."Consultancy Rate";
                            // Rec.Amount := (Rec."Direct Unit Cost" - (Rec."Withholding Tax Amount" + Rec."Consultancy Fee")) / Rec."Currency Factor";
                            // Rec."Net Amount" := Rec.Amount;


                            //  Rec."Line Discount Amount" := Rec."Withholding Tax Amount" + Rec."Consultancy Fee";
                            //  Rec.Validate("Line Discount Amount");
                            // Rec.UpdateUnitCost();
                            //Rec.Modify(true);
                        end;
                    end;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                }

                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = basic;
                    Visible = false;


                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = basic;
                    Visible = false;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = basic;
                    Visible = false;
                }


                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Consultancy Fee"; Rec."Consultancy Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Withholding Tax Amount';
                    Visible = false;
                }


                field("Remaining Budget Amount"; Rec."Remaining Budget Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Actual Incurred Amount"; Rec."Actual Incurred Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Difference; Rec.Difference)
                {
                    ApplicationArea = Basic;
                    Visible = false;
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
                    AccessByPermission = TableData "BOM Component" = R;
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
                    AccessByPermission = TableData "Extended Text Header" = R;
                    ApplicationArea = Advanced;
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;
                    ToolTip = 'Insert the extended item description that is set up for the item that is being processed on the line.';

                    trigger OnAction()
                    begin
                        InsertExtendedText(true);
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
                        AccessByPermission = TableData Location = R;
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
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
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
                        Rec.ShowLineComments;
                    end;
                }
                action("Item Charge &Assignment")
                {
                    AccessByPermission = TableData "Item Charge" = R;
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

    trigger OnAfterGetRecord()
    begin
        Editable := false;

        PurchHeader.Reset();
        PurchHeader.SetRange("No.", Rec."Document No.");
        if PurchHeader.FindFirst() then begin
            if PurchHeader.Status = PurchHeader.Status::Released then begin
                Editable := false;
            end else
                Editable := true;
        end;

    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        if (Rec.Quantity <> 0) and Rec.ItemExists(Rec."No.") then begin
            Commit;
            if not ReservePurchLine.DeleteLineConfirm(Rec) then
                exit(false);
            ReservePurchLine.DeleteLine(Rec);
        end;
    end;

    trigger OnInit()
    begin
        Currency.InitRoundingPrecision;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitType;
        Clear(ShortcutDimCode);
        Rec.Type := Rec.Type::"G/L Account";
        PurchHeader.Reset();
        PurchHeader.SetRange("No.", Rec."Document No.");
        if PurchHeader.FindSet() then begin
            Rec."Currency Factor" := PurchHeader."Currency Factor";
        end;
    end;

    trigger OnOpenPage()
    begin


    end;

    var
        TotalPurchaseHeader: Record "Purchase Header";
        TotalPurchaseLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        Currency: Record Currency;
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        DocumentTotals: Codeunit "Document Totals";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        ShortcutDimCode: array[8] of Code[20];
        VATAmount: Decimal;
        NetAmount: Decimal;
        InvDiscAmountEditable: Boolean;
        TotalAmountStyle: Text;
        RefreshMessageEnabled: Boolean;
        RefreshMessageText: Text;
        UnitofMeasureCodeIsChangeable: Boolean;
        TypeChosen: Boolean;
        GLBudgetName: Record "G/L Budget Name";
        GLBudgetEntry: Record "G/L Budget Entry";
        WithholdingTaxSetup: Record "Withholding Tax Setup";
        Editable: Boolean;

    procedure ApproveCalcInvDisc()
    begin
        Codeunit.Run(Codeunit::"Purch.-Disc. (Yes/No)", Rec);
    end;

    local procedure ExplodeBOM()
    begin
        Codeunit.Run(Codeunit::"Purch.-Explode BOM", Rec);
    end;

    local procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SaveRecord;
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then
            UpdateForm(true);
    end;

    local procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;

    local procedure OpenItemTrackingLines()
    begin
        OpenItemTrackingLines;
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
    end;

    local procedure NoOnAfterValidate()
    begin
        UpdateEditableOnRow;
        InsertExtendedText(false);
        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SaveRecord;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(false);
    end;

    local procedure RedistributeTotalsOnAfterValidate()
    begin
        CurrPage.SaveRecord;

        PurchHeader.Get(Rec."Document Type", Rec."Document No.");
        if DocumentTotals.PurchaseCheckNumberOfLinesLimit(PurchHeader) then
            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
        CurrPage.Update;
    end;

    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SaveRecord;
    end;

    local procedure UpdateEditableOnRow()
    begin
        UnitofMeasureCodeIsChangeable := Rec.CanEditUnitOfMeasureCode;
    end;

    local procedure UpdateCurrency()
    begin
        if Currency.Code <> TotalPurchaseHeader."Currency Code" then
            if not Currency.Get(TotalPurchaseHeader."Currency Code") then begin
                Clear(Currency);
                Currency.InitRoundingPrecision;
            end
    end;
}

