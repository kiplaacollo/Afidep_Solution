Table 170152 "Tender Notice"
{
    // DrillDownPageID = UnknownPage51516014;
    // LookupPageID = UnknownPage51516014;

    fields
    {
        field(1; "Tender No"; Code[200])
        {

            trigger OnValidate()
            begin
                if "Tender No" = '' then begin
                    PurchasesPayablesSetup.Get;
                    PurchasesPayablesSetup.TestField("Tender Nos");
                    NoSeriesManagement.InitSeries(PurchasesPayablesSetup."Tender Nos", xRec."No. Series", 0D, "Tender No", "No. Series");
                end;
            end;
        }
        field(2; "Tender Title"; Text[100])
        {
        }
        field(3; "Tender Ref No"; Code[30])
        {
        }
        field(4; "Tender Publication Date"; Date)
        {

            trigger OnValidate()
            begin
                /*IF "Tender Publication Date"<TODAY THEN
                  ERROR('Check the tender publication date');*/

            end;
        }
        field(5; "Tender Opening Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Tender Opening Date" < "Tender Publication Date" then
                    Error('Tender Opening Date should not be before Tender Publication Date');
            end;
        }
        field(6; "Tender Closing Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Tender Closing Date" < "Tender Opening Date" then
                    Error('Tender Closing Date should not be before Tender Opening Date');
            end;
        }
        field(7; "Tender Opening Time"; Time)
        {
        }
        field(8; "Application Fee"; Decimal)
        {
        }
        field(9; "Tender Description"; Text[250])
        {
        }
        field(10; "Tender Category"; Code[30])
        {
            TableRelation = "Tender Category";
        }
        field(11; "Tender Opening Venue"; Text[100])
        {
        }
        field(12; "Procurement Type Code"; Code[20])
        {
            TableRelation = "Procurement Methods";
        }
        field(13; "Purchase Req"; Code[20])
        {
            TableRelation = "Purchase Header"."No." where(Requisition = const(true),
                                                           Status = const(Released));
        }
        field(14; Status; Option)
        {
            OptionCaption = ',Open,Closed';
            OptionMembers = ,Open,Closed;
        }
        field(15; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(16; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(17; Instructions; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Tender No", "Purchase Req")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Tender No" = '' then begin
            PurchasesPayablesSetup.Get();
            PurchasesPayablesSetup.TestField(PurchasesPayablesSetup."Tender Nos");
            NoSeriesManagement.InitSeries(PurchasesPayablesSetup."Tender Nos", xRec."No. Series", Today, "Tender No", "No. Series");
        end;
    end;
    //
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
}

