Page 50074 "Imprest Requisition Lines"
{
    AutoSplitKey = true;
    Caption = 'Imprest Requisition Lines';
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


                field("Expense Category"; Rec."Expense Category")
                {
                    Caption = 'Advance Type';
                    trigger
                    OnValidate()
                    begin
                        PurchHeader.Reset();
                        PurchHeader.SetRange("No.", Rec."Document No.");
                        if PurchHeader.FindFirst() then begin

                            Rec."Imprest Account No" := PurchHeader."Employee Imprest Account No";
                            Rec.Validate("Imprest Account No");
                        end;
                    end;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Advanced;
                    Editable = false;
                    Enabled = false;
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

                field("Account No New"; Rec."Account No New") { Caption = 'Account No'; Visible = false; }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Advanced;

                    Enabled = false;
                    ToolTip = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.';

                    trigger OnValidate()
                    begin
                        //"Budget Amount":=0;
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
                    Editable = false;


                }
                field("Imprest Description"; Rec."Description 2")
                {

                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    //Visible = ;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    // Visible = false;


                }
                field("Shortcut Dimension 4 Code"; Rec."ShortcutDimCode[4]")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Shortcut Dimension 3 Code"; Rec."ShortcutDimCode[3]")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                }

                field("Imprest Account No"; Rec."Imprest Account No")
                {

                    Visible = false;
                    trigger OnValidate()
                    begin
                        Customer.Reset();
                        Customer.SetRange(Customer."No.", Rec."Imprest Account No");
                        if Customer.FindFirst() then begin
                            Rec."Imprest Account Name" := Customer.Name;
                        end;
                    end;
                }
                field("Imprest Account Name"; Rec."Imprest Account Name") { Visible = false; }

                field("Budget Amount"; Rec."Budget Amount") { Editable = false; Visible = false; }
                field("Committed Amount"; Rec."Committed Amount") { Editable = false; Visible = false; }
                field("Budget Balance"; Rec."Budget Balance") { Editable = false; Visible = false; }
                field("Currency Code for Accounting"; Rec."Currency Code")
                {
                    ApplicationArea = basic;
                    Editable = true;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic;
                    caption = 'No of days';
                    Visible = true;
                    trigger OnValidate()
                    BEGIN
                        // Rec."Amount Including VAT" := Rec."Direct Unit Cost" * Rec.Rate * Rec.Quantity;
                        // rec.Quantity := rec."No of days" * rec."No of pax";
                        //rec.Validate(Quantity);
                    END;
                }
                field(Rate; Rec.Rate)
                {
                    Caption = 'No of days';
                    Visible = false;
                    trigger OnValidate()
                    BEGIN
                        //  Rec."Amount Including VAT" := Rec."Direct Unit Cost" * Rec.Rate * Rec.Quantity;
                        //rec.Quantity := rec."No of days" * rec."No of pax";
                        //rec.Validate(Quantity);
                        //    Rec."Amount New" := Rec."Unit Cost (LCY) New" * Rec.Quantity;
                        //  Rec.Modify();
                        // Rec."Line Amount New" := Rec."Direct Unit Cost" * Rec.Quantity;
                        // Rec.Modify();
                    END;
                }

                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = Basic;
                    CaptionClass = 'Rate';
                    Caption = 'Rate';
                    trigger OnValidate()

                    begin
                        // Rec.Amount := Rec."Direct Unit Cost" * Rec.Quantity;
                        Rec."Amount New" := Rec."Unit Cost (LCY) New" * Rec.Quantity;
                        Rec.Modify();// 
                        Rec."Line Amount New" := Rec."Direct Unit Cost" * Rec.Quantity;
                        Rec.Modify();
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Visible = false;

                }
                field("Line Amount New"; Rec."Line Amount New")
                {

                }


                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = Basic;
                    // Visible = false;
                }
                field("Unit Cost (LCY) New"; Rec."Unit Cost (LCY) New")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Amount New"; Rec."Amount New")
                {
                    ApplicationArea = Basic;
                }

                field(Amount11; Rec."Outstanding Amount (LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        //Rec."Net Amount" := Rec.Amount;
                    end;
                }
                // field("Unit Cost (LCY)"; Rec."Outstanding Amount (LCY)")
                // {
                //     Caption = 'Amount (LCY)';
                //     Visible = false;
                // }

                field("Amount Including vat "; Rec."Amount Including VAT")
                {
                    Caption = 'Amount including vat';
                    Visible = false;
                }

                field("Line amount  "; Rec."Line Amount")
                {
                    Caption = 'Line amount';
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

    trigger OnAfterGetCurrRecord()
    begin
        TypeChosen := Rec.HasTypeToFillMandatoryFields;
        UpdateEditableOnRow;
        if PurchHeader.Get(Rec."Document Type", Rec."Document No.") then;

        DocumentTotals.PurchaseUpdateTotalsControls(Rec, TotalPurchaseHeader, TotalPurchaseLine, RefreshMessageEnabled,
          TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, VATAmount);

        UpdateCurrency;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        Clear(DocumentTotals);
        if (Rec."Amount New" = 0) then begin
            rec."Amount New" := rec.Quantity * rec.Rate * rec."Direct Unit Cost";
            // Rec.Amount := Rec.Quantity * 
            CurrPage.Update();
            rec.Modify;
        end;
        if (Rec.Amount = 0) then begin
            rec.Amount := Rec."Amount New";
            Rec."Line Amount" := Rec."Line Amount New";
            CurrPage.Update();
            rec.Modify;
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

    end;

    trigger OnOpenPage()
    begin
        Rec.Type := Rec.Type::"G/L Account";
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
        InvDiscAmountEditable: Boolean;
        bank: Record "Bank Account";
        TotalAmountStyle: Text;
        RefreshMessageEnabled: Boolean;
        RefreshMessageText: Text;
        Customer: Record Customer;
        UnitofMeasureCodeIsChangeable: Boolean;
        TypeChosen: Boolean;
        GLBudgetName: Record "G/L Budget Name";
        GLBudgetEntry: Record "G/L Budget Entry";
        WithholdingTaxSetup: Record "Withholding Tax Setup";
        dimensionvalues: Record 349;


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

