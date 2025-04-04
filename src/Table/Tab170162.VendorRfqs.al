table 170162 "Vendor Rfqs"
{
    Caption = 'Purchase Quote Line';

    PasteIsValid = false;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quotation Request,Open Tender,Restricted Tender';
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            Editable = false;
            TableRelation = Vendor;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item),Other';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)",Other;
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Item)) Item;

            trigger OnValidate()
            var

            begin
                //,G/L Account,Item,,Fixed Asset,Charge (Item)

            end;
        }
        field(16; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(17; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';
            DecimalPlaces = 0 : 5;
        }
        field(18; "Qty. to Receive"; Decimal)
        {
            Caption = 'Qty. to Receive';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Direct Unit Cost"; Decimal)
        {

        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
        }
        field(25; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(27; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(28; "Line Discount Amount"; Decimal)
        {

        }
        field(29; Amount; Decimal)
        {

        }
        field(30; "Amount Including VAT"; Decimal)
        {

        }
        field(31; "Unit Price (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(37; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            Caption = 'Appl.-to Item Entry';
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';

        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {

        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            var
                Job: Record "167";
            begin
            end;
        }
        field(54; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(57; "Outstanding Amount"; Decimal)
        {

            trigger OnValidate()
            var
                Currency2: Record "4";
            begin
            end;
        }
        field(58; "Qty. Rcd. Not Invoiced"; Decimal)
        {
            Caption = 'Qty. Rcd. Not Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(59; "Amt. Rcd. Not Invoiced"; Decimal)
        {


        }
        field(60; "Quantity Received"; Decimal)
        {
            Caption = 'Quantity Received';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(63; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            Editable = false;
        }
        field(64; "Receipt Line No."; Integer)
        {
            Caption = 'Receipt Line No.';
            Editable = false;
        }
        field(67; "Profit %"; Decimal)
        {
            Caption = 'Profit %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(68; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            Editable = false;
            TableRelation = Vendor;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
        }
        field(70; "Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
        }
        field(71; "Sales Order No."; Code[20])
        {

        }
        field(72; "Sales Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            Editable = false;

        }
        field(73; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
            Editable = false;
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(75; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(77; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(78; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(79; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(80; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            Editable = false;

        }
        field(81; "Entry Point"; Code[10])
        {
            Caption = 'Entry Point';
            TableRelation = "Entry/Exit Point";
        }
        field(82; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(85; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(86; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(87; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(88; "Use Tax"; Boolean)
        {
            Caption = 'Use Tax';
        }
        field(89; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(90; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(91; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY)';
            Editable = false;
        }
        field(93; "Amt. Rcd. Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. Rcd. Not Invoiced (LCY)';
            Editable = false;
        }
        field(95; "Reserved Quantity"; Decimal)
        {

            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(97; "Blanket Order No."; Code[20])
        {

        }
        field(98; "Blanket Order Line No."; Integer)
        {

        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Amount';
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice';
            Editable = false;
        }
        field(106; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            Editable = false;
        }
        field(107; "IC Partner Ref. Type"; Option)
        {
            Caption = 'IC Partner Ref. Type';
            OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.,Vendor Item No.';
            OptionMembers = " ","G/L Account",Item,,,"Charge (Item)","Cross Reference","Common Item No.","Vendor Item No.";
        }
        field(108; "IC Partner Reference"; Code[20])
        {

        }
        field(109; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                GenPostingSetup: Record "252";
                GLAcc: Record "15";
            begin
            end;
        }
        field(110; "Prepmt. Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Line Amount';
            MinValue = 0;
        }
        field(111; "Prepmt. Amt. Inv."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amt. Inv.';
            Editable = false;
        }
        field(112; "Prepmt. Amt. Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amt. Incl. VAT';
            Editable = false;
        }
        field(113; "Prepayment Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment Amount';
            Editable = false;
        }
        field(114; "Prepmt. VAT Base Amt."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. VAT Base Amt.';
            Editable = false;
        }
        field(115; "Prepayment VAT %"; Decimal)
        {
            Caption = 'Prepayment VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(116; "Prepmt. VAT Calc. Type"; Option)
        {
            Caption = 'Prepmt. VAT Calc. Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(117; "Prepayment VAT Identifier"; Code[10])
        {
            Caption = 'Prepayment VAT Identifier';
            Editable = false;
        }
        field(118; "Prepayment Tax Area Code"; Code[20])
        {
            Caption = 'Prepayment Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(119; "Prepayment Tax Liable"; Boolean)
        {
            Caption = 'Prepayment Tax Liable';
        }
        field(120; "Prepayment Tax Group Code"; Code[10])
        {
            Caption = 'Prepayment Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(121; "Prepmt Amt to Deduct"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt Amt to Deduct';
            MinValue = 0;
        }
        field(122; "Prepmt Amt Deducted"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt Amt Deducted';
            Editable = false;
        }
        field(123; "Prepayment Line"; Boolean)
        {
            Caption = 'Prepayment Line';
            Editable = false;
        }
        field(124; "Prepmt. Amount Inv. Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. Incl. VAT';
            Editable = false;
        }
        field(129; "Prepmt. Amount Inv. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. (LCY)';
            Editable = false;
        }
        field(130; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
        }
        field(135; "Prepayment VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment VAT Difference';
            Editable = false;
        }
        field(136; "Prepmt VAT Diff. to Deduct"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt VAT Diff. to Deduct';
            Editable = false;
        }
        field(137; "Prepmt VAT Diff. Deducted"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt VAT Diff. Deducted';
            Editable = false;
        }
        field(1001; "Job Task No."; Code[20])
        {

        }
        field(1002; "Job Line Type"; Option)
        {
            Caption = 'Job Line Type';
            OptionCaption = ' ,Schedule,Contract,Both Schedule and Contract';
            OptionMembers = " ",Schedule,Contract,"Both Schedule and Contract";
        }
        field(1003; "Job Unit Price"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Unit Price';
        }
        field(1004; "Job Total Price"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Total Price';
            Editable = false;
        }
        field(1005; "Job Line Amount"; Decimal)
        {
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Amount';
        }
        field(1006; "Job Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Discount Amount';
        }
        field(1007; "Job Line Discount %"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(1008; "Job Unit Price (LCY)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Unit Price (LCY)';
            Editable = false;
        }
        field(1009; "Job Total Price (LCY)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Total Price (LCY)';
            Editable = false;
        }
        field(1010; "Job Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Amount (LCY)';
            Editable = false;
        }
        field(1011; "Job Line Disc. Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Disc. Amount (LCY)';
            Editable = false;
        }
        field(1012; "Job Currency Factor"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Currency Factor';
        }
        field(1013; "Job Currency Code"; Code[20])
        {
            Caption = 'Job Currency Code';
        }
        field(5401; "Prod. Order No."; Code[20])
        {

        }
        field(5402; "Variant Code"; Code[10])
        {

        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';

            trigger OnLookup()
            var

            begin
            end;

            trigger OnValidate()
            var

            begin
            end;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {

        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5416; "Outstanding Qty. (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5417; "Qty. to Invoice (Base)"; Decimal)
        {
            Caption = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5418; "Qty. to Receive (Base)"; Decimal)
        {
            Caption = 'Qty. to Receive (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5458; "Qty. Rcd. Not Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Rcd. Not Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5460; "Qty. Received (Base)"; Decimal)
        {
            Caption = 'Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5495; "Reserved Qty. (Base)"; Decimal)
        {

        }
        field(5600; "FA Posting Date"; Date)
        {
            Caption = 'FA Posting Date';
        }
        field(5601; "FA Posting Type"; Option)
        {
            Caption = 'FA Posting Type';
            OptionCaption = ' ,Acquisition Cost,Maintenance';
            OptionMembers = " ","Acquisition Cost",Maintenance;
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";
        }
        field(5603; "Salvage Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Salvage Value';
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            Caption = 'Depr. until FA Posting Date';
        }
        field(5606; "Depr. Acquisition Cost"; Boolean)
        {
            Caption = 'Depr. Acquisition Cost';
        }
        field(5609; "Maintenance Code"; Code[10])
        {
            Caption = 'Maintenance Code';
            TableRelation = Maintenance;
        }
        field(5610; "Insurance No."; Code[20])
        {
            Caption = 'Insurance No.';
            TableRelation = Insurance;
        }
        field(5611; "Budgeted FA No."; Code[20])
        {
            Caption = 'Budgeted FA No.';
            TableRelation = "Fixed Asset";
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book';
            TableRelation = "Depreciation Book";
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            Caption = 'Use Duplication List';
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
           
        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
           
        }
        field(5707;"Cross-Reference Type";Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
        }
        field(5708;"Cross-Reference Type No.";Code[30])
        {
            Caption = 'Cross-Reference Type No.';
        }
        field(5709;"Item Category Code";Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(5710;Nonstock;Boolean)
        {
            Caption = 'Nonstock';
        }
        field(5711;"Purchasing Code";Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
        }
        field(5712;"Product Group Code";Code[10])
        {
          
        }
        field(5713;"Special Order";Boolean)
        {
            Caption = 'Special Order';
        }
        field(5714;"Special Order Sales No.";Code[20])
        {
          
        }
        field(5715;"Special Order Sales Line No.";Integer)
        {
          
        }
        field(5750;"Whse. Outstanding Qty. (Base)";Decimal)
        {
                  }
        field(5752;"Completely Received";Boolean)
        {
            Caption = 'Completely Received';
            Editable = false;
        }
        field(5790;"Requested Receipt Date";Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(5791;"Promised Receipt Date";Date)
        {
            Caption = 'Promised Receipt Date';
        }
        field(5792;"Lead Time Calculation";DateFormula)
        {
            Caption = 'Lead Time Calculation';
        }
        field(5793;"Inbound Whse. Handling Time";DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
        }
        field(5794;"Planned Receipt Date";Date)
        {
            Caption = 'Planned Receipt Date';
        }
        field(5795;"Order Date";Date)
        {
            Caption = 'Order Date';
        }
        field(5800;"Allow Item Charge Assignment";Boolean)
        {
            Caption = 'Allow Item Charge Assignment';
            InitValue = true;
        }
        field(5801;"Qty. to Assign";Decimal)
        {
           
        }
        field(5802;"Qty. Assigned";Decimal)
        {
           
        }
        field(5803;"Return Qty. to Ship";Decimal)
        {
            Caption = 'Return Qty. to Ship';
            DecimalPlaces = 0:5;
        }
        field(5804;"Return Qty. to Ship (Base)";Decimal)
        {
            Caption = 'Return Qty. to Ship (Base)';
            DecimalPlaces = 0:5;
        }
        field(5805;"Return Qty. Shipped Not Invd.";Decimal)
        {
            Caption = 'Return Qty. Shipped Not Invd.';
            DecimalPlaces = 0:5;
            Editable = false;
        }
        field(5806;"Ret. Qty. Shpd Not Invd.(Base)";Decimal)
        {
            Caption = 'Ret. Qty. Shpd Not Invd.(Base)';
            DecimalPlaces = 0:5;
            Editable = false;
        }
        field(5807;"Return Shpd. Not Invd.";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Return Shpd. Not Invd.';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record "4";
            begin
            end;
        }
        field(5808;"Return Shpd. Not Invd. (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Return Shpd. Not Invd. (LCY)';
            Editable = false;
        }
        field(5809;"Return Qty. Shipped";Decimal)
        {
            Caption = 'Return Qty. Shipped';
            DecimalPlaces = 0:5;
            Editable = false;
        }
        field(5810;"Return Qty. Shipped (Base)";Decimal)
        {
            Caption = 'Return Qty. Shipped (Base)';
            DecimalPlaces = 0:5;
            Editable = false;
        }
        field(6600;"Return Shipment No.";Code[20])
        {
            Caption = 'Return Shipment No.';
            Editable = false;
        }
        field(6601;"Return Shipment Line No.";Integer)
        {
            Caption = 'Return Shipment Line No.';
            Editable = false;
        }
        field(6608;"Return Reason Code";Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
        }
        field(54240;Committed;Boolean)
        {
        }
        field(54241;"Expense Code";Code[10])
        {
        }
        field(54242;"Asset No.";Code[10])
        {
          
        }
        field(54243;Specifications;Integer)
        {
        }
        field(54244;"PRF No";Code[20])
        {
        }
        field(54245;"PRF Line No.";Integer)
        {
        }
        field(54246;"Qty Received";Decimal)
        {
           
        }
        field(54353;"Extended Order Description";Text[150])
        {
        }
       
        field(37001053;"Shortcut Dimension 3 Code";Code[10])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
          
        }
        field(37001054;"Shortcut Dimension 4 Code";Code[10])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
          
        }
        field(37001055;"Shortcut Dimension 5 Code";Code[10])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            
        }
        field(37001056;"Shortcut Dimension 6 Code";Code[10])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            
        }
        field(37001057;"Shortcut Dimension 7 Code";Code[10])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            
        }
        field(37001058;"Shortcut Dimension 8 Code";Code[10])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
           
        }
        field(37001059;"Dimension Speedkey Code";Code[10])
        {
            Caption = 'Dimension Speedkey Code';
            
        }
        field(99000750;"Routing No.";Code[20])
        {
            Caption = 'Routing No.';
            TableRelation = "Routing Header";
        }
        field(99000751;"Operation No.";Code[10])
        {
           
        }
        field(99000752;"Work Center No.";Code[20])
        {
            Caption = 'Work Center No.';
            TableRelation = "Work Center";
        }
        field(99000753;Finished;Boolean)
        {
            Caption = 'Finished';
        }
        field(99000754;"Prod. Order Line No.";Integer)
        {
           
        }
        field(99000755;"Overhead Rate";Decimal)
        {
            Caption = 'Overhead Rate';
            DecimalPlaces = 0:5;
        }
        field(99000756;"MPS Order";Boolean)
        {
            Caption = 'MPS Order';
        }
        field(99000757;"Planning Flexibility";Option)
        {
            Caption = 'Planning Flexibility';
            OptionCaption = 'Unlimited,None';
            OptionMembers = Unlimited,"None";
        }
        field(99000758;"Safety Lead Time";DateFormula)
        {
            Caption = 'Safety Lead Time';
        }
        field(99000759;"Routing Reference No.";Integer)
        {
            Caption = 'Routing Reference No.';
        }
        field(99000760;"Vendor No";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(99000761;int;Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(99000762;Selected;Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Document Type","Document No.",int)
        {
            MaintainSIFTIndex = false;
            SumIndexFields = Amount,"Amount Including VAT";
        }
        key(Key2;"Document No.","Line No.","Document Type")
        {
        }
       
        key(Key4;"Document Type","Pay-to Vendor No.","Currency Code")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Outstanding Amount","Amt. Rcd. Not Invoiced","Outstanding Amount (LCY)","Amt. Rcd. Not Invoiced (LCY)";
        }
        key(Key5;"Document Type","Blanket Order No.","Blanket Order Line No.")
        {
        }
        key(Key6;"Document Type",Type,"Prod. Order No.","Prod. Order Line No.","Routing No.","Operation No.")
        {
        }
       
        key(Key8;"Document Type","Receipt No.","Receipt Line No.")
        {
        }
        
        key(Key10;"Document Type","Buy-from Vendor No.")
        {
        }
        key(Key11;"Document Type","Job No.","Job Task No.")
        {
            SumIndexFields = "Outstanding Amount (LCY)","Amt. Rcd. Not Invoiced (LCY)";
        }
       
        key(Key13;"Document No.",Type,"No.","Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        PurchCommentLine: Record "43";
    begin
    end;

    var
        Text000: Label 'You cannot rename a %1.';
        Text001: Label 'You cannot change %1 because the order line is associated with sales order %2.';
        Text002: Label 'Prices including VAT cannot be calculated when %1 is %2.';
        Text003: Label 'You cannot purchase resources.';
        Text004: Label 'must not be less than %1';
        Text006: Label 'You cannot invoice more than %1 units.';
        Text007: Label 'You cannot invoice more than %1 base units.';
        Text008: Label 'You cannot receive more than %1 units.';
        Text009: Label 'You cannot receive more than %1 base units.';
        Text010: Label 'You cannot change %1 when %2 is %3.';
        Text011: Label ' must be 0 when %1 is %2';
        Text012: Label 'must not be specified when %1 = %2';
        Text014: Label 'Change %1 from %2 to %3?';
        Text016: Label '%1 is required for %2 = %3.';
        Text017: Label '\The entered information will be disregarded by warehouse operations.';
        Text018: Label '%1 %2 is earlier than the work date %3.';
        Text020: Label 'You cannot return more than %1 units.';
        Text021: Label 'You cannot return more than %1 base units.';
        Text022: Label 'You cannot change %1, if item charge is already posted.';
        Text023: Label 'You cannot change the %1 when the %2 has been filled in.';
        Text029: Label 'must be positive.';
        Text030: Label 'must be negative.';
        Text031: Label 'You cannot define item tracking on this line because it is linked to production order %1.';
        Text032: Label '%1 must not be greater than %2.';
        Text033: Label 'Warehouse ';
        Text034: Label 'Inventory ';
        Text035: Label '%1 units for %2 %3 have already been returned or transferred. Therefore, only %4 units can be returned.';
        Text036: Label 'You must cancel the existing approval for this document to be able to change the %1 field.';
        Text037: Label 'cannot be %1.';
        Text038: Label 'cannot be less than %1.';
        Text039: Label 'cannot be more than %1.';
        Text99000000: Label 'You cannot change %1 when the purchase order is associated to a production order.';
        Text042: Label 'You cannot return more than the %1 units that you have received for %2 %3.';
        Text043: Label 'must be positive when %1 is not 0.';
        Text044: Label 'You cannot change %1 because this purchase order is associated with %2 %3.';
        GLAcc: Record "15";
        Item: Record "27";
        FA: Record "5600";
        CItem: Record "5800";
}

