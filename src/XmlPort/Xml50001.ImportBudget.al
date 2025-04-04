xmlport 50001 "Import Budget"
{
    Caption = 'Import Budget';
    Direction = Both;
    Format = VariableText;


    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Budget Import")
            {
                XmlName = 'ImportJV';
                // fieldelement(A; "Gen. Journal Line"."Thematic Code")
                // {
                // }
                // fieldelement(B; "Gen. Journal Line"."Thematic Name")
                // {
                // }
                fieldelement(C; "Gen. Journal Line"."Project Code")
                {
                }
                fieldelement(D; "Gen. Journal Line"."Expense Category")
                {
                }
                fieldelement(E; "Gen. Journal Line"."Expense Category Name")
                {
                }
                fieldelement(F; "Gen. Journal Line"."Budget Line")
                {
                }
                fieldelement(G; "Gen. Journal Line"."BudgetLine Name")
                {
                }
                fieldelement(H; "Gen. Journal Line".Standard)
                {
                }
                fieldelement(I; "Gen. Journal Line"."GL Account")
                {
                }
                fieldelement(J; "Gen. Journal Line"."Budget Amount")
                {

                }


                trigger OnBeforeInsertRecord()
                begin



                end;

                trigger OnAfterInsertRecord()
                begin

                    // Dimension2.Reset();
                    // Dimension2.SetRange("Dimension Code", 'THEMATIC');
                    // Dimension2.SetRange(Code, "Gen. Journal Line"."Expense Category");
                    // if Dimension2.Find('-') = false then begin

                    //     Dimension32.Init();
                    //     Dimension32."Dimension Code" := 'THEMATIC';
                    //     Dimension32.Code := "Gen. Journal Line"."Thematic Code";
                    //     Dimension32.Name := "Gen. Journal Line"."Thematic Name";
                    //     Dimension32.Insert(true);
                    // end;

                    Dimension2.Reset();
                    Dimension2.SetRange("Dimension Code", 'EXPCATEGORIES');
                    Dimension2.SetRange(Code, "Gen. Journal Line"."Expense Category");
                    if Dimension2.Find('-')/* = false*/ then begin

                        Dimension32.Init();
                        Dimension32."Dimension Code" := 'EXPCATEGORIES';
                        Dimension32.Code := "Gen. Journal Line"."Expense Category";
                        Dimension32.Name := "Gen. Journal Line"."Expense Category Name";
                        Dimension32.Insert(true);
                    end;

                    Dimension3.Reset();
                    Dimension3.SetRange("Dimension Code", 'BUDGETLINES');
                    Dimension3.SetRange(Code, "Gen. Journal Line"."Budget Line");
                    if Dimension3.Find('-') = false then begin

                        Dimension34.Init();
                        Dimension34."Dimension Code" := 'BUDGETLINES';
                        Dimension34.Code := "Gen. Journal Line"."Budget Line";
                        Dimension34.Name := "Gen. Journal Line"."BudgetLine Name";
                        Dimension34.Insert(true);
                    end;

                    Dimension.Reset();
                    Dimension.SetRange("Dimension Code", 'BUDGETLINES');
                    Dimension.SetRange(Code, "Gen. Journal Line"."Budget Line");
                    if Dimension.Find('-') then begin

                        Dimension33.Init();
                        Dimension33."Dimension Code" := 'BUDGETLINES';
                        Dimension33.Code := Dimension.Code;
                        Dimension33.Name := Dimension.Name;
                        Dimension33."Dimension Value ID" := Dimension."Dimension Value ID";
                        Dimension33."Project Code" := "Gen. Journal Line"."Project Code";
                        Dimension33."Budget Amount" := "Gen. Journal Line"."Budget Amount";
                        Dimension33."Outcome Code" := "Gen. Journal Line"."Expense Category";
                        Dimension33."Thematic Code" := "Gen. Journal Line"."Thematic Code";
                        Dimension33."Dimension Value Type" := "Gen. Journal Line".Standard;
                        Dimension33."G/L Account" := "Gen. Journal Line"."GL Account";
                        Dimension33.Modify(true);
                    end;
                    Message('Budgets uploaded successfully');
                end;
            }
        }

    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }



    trigger OnInitXmlPort()
    begin
        I := 0;
    end;

    var
        I: Integer;
        Dimension: Record "Dimension Value";
        Dimension2: Record "Dimension Value";
        Dimension3: Record "Dimension Value";
        Dimension34: Record "Dimension Value";
        Dimension32: Record "Dimension Value";
        Dimension33: Record "Dimension Value";
}

