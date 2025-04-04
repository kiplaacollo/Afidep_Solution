codeunit 50121 "Cust. Purchase Line Validation"
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Unit Cost (LCY)', true, false)]
    local procedure OnAfterValidateUnitCostLCY(var Rec: Record "Purchase Line"; xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        Item: Record Item;
        UnitCostCurrency: Decimal;
        PurchHeader: Record "Purchase Header";
        GLSetup: Record "General Ledger Setup";
    //CurrExchRate: Codeunit "Currency Exchange Rate";
    begin
        // Custom validation logic here
        Rec.TestField("No.");
        //Rec.TestFieldQuantity(Rec.FieldNo("Unit Cost (LCY)"));

        if Rec."Prod. Order No." <> '' then
            Error(
              // Text99000000,
              Rec.FieldCaption("Unit Cost (LCY)"));

        if CurrFieldNo = Rec.FieldNo("Unit Cost (LCY)") then
            if Rec.Type = Rec.Type::Item then begin
                //     Rec.GetItem(Item);
                if Item."Costing Method" = Item."Costing Method"::Standard then
                    Error(
                      //             Text010,
                      Rec.FieldCaption("Unit Cost (LCY)"), Item.FieldCaption("Costing Method"), Item."Costing Method");
            end;

        UnitCostCurrency := Rec."Unit Cost (LCY)";
        Rec.GetPurchHeader();
        if PurchHeader."Currency Code" <> '' then begin
            // PurchHeader.TestField("Currency Factor");
            // Rec.GetGLSetup();
            // UnitCostCurrency :=
            //   Round(
            //     CurrExchRate.ExchangeAmtLCYToFCY(
            //       Rec.GetDate(), Rec."Currency Code",
            //       Rec."Unit Cost (LCY)", PurchHeader."Currency Factor"),
            //     GLSetup."Unit-Amount Rounding Precision");
        end;

        // Rec.OnValidateUnitCostLCYOnAfterUpdateUnitCostCurrency(Rec, UnitCostCurrency);

        Rec."Indirect Cost %" := 0;
        // Rec.CalcIndirectCostPercent();

        // Rec.UpdateSalesCostFromUnitCostLCY();

        if Rec.JobTaskIsSet() then begin
            Rec.CreateTempJobJnlLine(false);
            //  Rec.TempJobJnlLine.Validate("Unit Cost (LCY)", Rec."Unit Cost (LCY)");
            Rec.UpdateJobPrices();
        end;
    end;
}
